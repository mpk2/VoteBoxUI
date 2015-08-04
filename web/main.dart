/**
 *
 */

import 'dart:html' hide File, XmlDocument;
import 'dart:io';
import 'package:xml/xml.dart';
import 'package:chrome/chrome_app.dart' as chrome;

void main() {

  Election election = loadElection("election.xml");

  if (election == null) {
    return;
  }

  querySelector('#ID').onClick.listen(getID);
  querySelector('#button_begin').onClick.listen(gotoFirstInstructions);

  querySelector('#Back').onClick.listen(gotoInfo);
  querySelector('#Begin').onClick.listen((MouseEvent e) => display(e, 0, election));

  querySelector('#Previous').onClick.listen((MouseEvent e) => update(e, -1, election));
  querySelector('#Next').onClick.listen((MouseEvent e) => update(e, 1, election));

  querySelector('#Review').onClick.listen((MouseEvent e) => gotoReview(e, election));


}

/**
 *
 */
void getID(MouseEvent event) {
  String ID = querySelector('#idText').text;

  if(ID==""){
        // this should actually be a popup or something
        window.alert("You must enter correctly your 5-digit authentication number.");
    }
    else{

    querySelector("#IDArea").text = ID + " STAR-Vote";
    querySelector("#info").style.visibility="visible"; //shows election information page or start
    querySelector("#ID").style.display="none"; //hides the elements on the authentication page
    querySelector("#enterID").style.display="none";
    querySelector("#idText").style.display="none";
  }

}

/**
 *
 */
void gotoFirstInstructions(MouseEvent event) {
  querySelector("#first_instructions").style.display="block"; //de-invisibles
  querySelector("#first_instructions").style.visibility="visible"; //displays instructions
  querySelector("#Back").style.visibility="visible"; //shows the back button that takes you to the election info page
  querySelector("#Begin").style.visibility="visible"; //shows the button that is pressed to start voting
  querySelector("#info").style.display="none"; //makes the instructions invisible
}

/**
 *
 */
void gotoInfo(MouseEvent event) {
  querySelector("#Begin").style.visibility="hidden"; //hides the begin and back buttons shown on the instructions page
  querySelector("#Back").style.visibility="hidden";
  querySelector("#first_instructions").style.display="none"; //makes the instructions invisible
  querySelector("#info").style.display="block"; //shows election information page or start

}

/**
 *
 */
void gotoReview(MouseEvent event, Election e) {
  update(event, e.getCurrentPage(), e.size()-e.getCurrentPage(), e);
}

void update(MouseEvent event, int delta, Election e) {

  /* Record information on currentPage */
  record(e);

  display(event, e.getCurrentPage()+delta, e);
}

/**
 *
 */
void display(MouseEvent event, int pageToDisplay, Election e) {

  if (pageToDisplay < 0) pageToDisplay = 0;

  if(pageToDisplay >= e.size()) {
    displayReviewPage(e);
    e.updateCurrentPage(e.size());
  } else {
    displayRace(e.getRace(pageToDisplay));
    e.updateCurrentPage(pageToDisplay);
  }
}

/**
 *
 */
void displayRace(Race race) {

}

/**
 *
 */
void displayReviewPage(Election e) {

}

/**
 *
 */
Election loadElection(String path) {

  String electionXML;

  /* Parse this file into a String */
  new File(path).readAsString().then((xmlStr) {
    electionXML = xmlStr;
  });

  if (electionXML == null) {
    window.alert("The file was not loaded properly!");
    return null;
  }

  XmlDocument xmlDoc = parse(electionXML);

  Election election = new Election();
  election.loadFromXML(xmlDoc);

  return election;
}

/**
 *
 */
class Election {

  List<Race> _races;
  int _currentPage=0;

  Election() {
    _races = new List<Race>();
  }

  int size() {
    return _races.length;
  }

  Race getRace(int index) {
    return _races.elementAt(index);
  }

  int getCurrentPage() {
    return _currentPage;
  }

  void updateCurrentPage(int newPage) {
    _currentPage = newPage;
  }

  void loadFromXML(XmlDocument xml) {

    List<XmlElement> raceList = xml.findElements("race");

    for (XmlElement race in raceList) {

      String title = race.getAttribute("title");
      List<XmlElement> XMLcandidates = race.findElements("candidate");
      List<Option> candidates = new List<Option>();

      for (XmlElement element in XMLcandidates) {
        candidates.add(new Option(element.getAttribute("name"), groupAssociation: element.getAttribute("party")));
      }

      Race currentRace = new Race(title, candidates);
      _races.add(currentRace);

    }

    List<XmlElement> propList = xml.findElements("proposition");

    for (XmlElement prop in propList) {

      String title = prop.getAttribute("title");
      String text = prop.getAttribute("propositionText");
      List<XmlElement> XMLresponses = prop.findElements("response");
      List<Option> responses = new List<Option>();

      for (XmlElement element in XMLresponses) {
        responses.add(new Option(XMLresponses.indexOf(element) == 0 ? "Yes" : "No"));
      }

      Race currentRace = new Race(title, responses, text: text);
      _races.add(currentRace);

    }

  }

}

/**
 *
 */
class Race {

  String _title;
  List<Option> _options;
  String text;
  bool _voted=false;

  Race(this._title, this._options, {this.text});

  bool hasVoted() {
    return _voted;
  }

  void markSelection(Option o) {
    _voted = true;
    o.mark();
  }

}

/**
 *
 */
class Option {
  String _identifier;
  String groupAssociation;
  bool _voted=false;

  Option(this._identifier, {this.groupAssociation});

  bool wasSelected(){
    return _voted;
  }

  void mark() {
    _voted = true;
  }

}