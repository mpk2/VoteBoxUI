/* This file has been generated from usb.idl - do not edit */

/**
 * Use the `chrome.usb` API to interact with connected USB devices. This API
 * provides access to USB operations from within the context of an app. Using
 * this API, apps can function as drivers for hardware devices.
 * 
 * Errors generated by this API are reported by setting [runtime.lastError] and
 * executing the function's regular callback. The callback's regular parameters
 * will be undefined in this case.
 */
library chrome.usb;

import '../src/common.dart';

/**
 * Accessor for the `chrome.usb` namespace.
 */
final ChromeUsb usb = new ChromeUsb._();

class ChromeUsb extends ChromeApi {
  JsObject get _usb => chrome['usb'];

  Stream<Device> get onDeviceAdded => _onDeviceAdded.stream;
  ChromeStreamController<Device> _onDeviceAdded;

  Stream<Device> get onDeviceRemoved => _onDeviceRemoved.stream;
  ChromeStreamController<Device> _onDeviceRemoved;

  ChromeUsb._() {
    var getApi = () => _usb;
    _onDeviceAdded = new ChromeStreamController<Device>.oneArg(getApi, 'onDeviceAdded', _createDevice);
    _onDeviceRemoved = new ChromeStreamController<Device>.oneArg(getApi, 'onDeviceRemoved', _createDevice);
  }

  bool get available => _usb != null;

  /**
   * Enumerates connected USB devices.
   * [options]: The properties to search for on target devices.
   */
  Future<List<Device>> getDevices(EnumerateDevicesOptions options) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Device>>.oneArg((e) => listify(e, _createDevice));
    _usb.callMethod('getDevices', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Presents a device picker to the user and returns the [Device]s selected. If
   * the user cancels the picker devices will be empty. A user gesture is
   * required for the dialog to display. Without a user gesture, the callback
   * will run as though the user cancelled.
   * [options]: Configuration of the device picker dialog box.
   * [callback]: Invoked with a list of chosen [Device]s.
   */
  Future<List<Device>> getUserSelectedDevices(DevicePromptOptions options) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Device>>.oneArg((e) => listify(e, _createDevice));
    _usb.callMethod('getUserSelectedDevices', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Requests access from the permission broker to a device claimed by Chrome OS
   * if the given interface on the device is not claimed.
   * 
   * [device]: The [Device] to request access to.
   * [interfaceId]: The particular interface requested.
   */
  Future<bool> requestAccess(Device device, int interfaceId) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _usb.callMethod('requestAccess', [jsify(device), interfaceId, completer.callback]);
    return completer.future;
  }

  /**
   * Opens a USB device returned by [getDevices].
   * [device]: The [Device] to open.
   */
  Future<ConnectionHandle> openDevice(Device device) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ConnectionHandle>.oneArg(_createConnectionHandle);
    _usb.callMethod('openDevice', [jsify(device), completer.callback]);
    return completer.future;
  }

  /**
   * Finds USB devices specified by the vendor, product and (optionally)
   * interface IDs and if permissions allow opens them for use.
   * 
   * If the access request is rejected or the device fails to be opened a
   * connection handle will not be created or returned.
   * 
   * Calling this method is equivalent to calling [getDevices] followed by
   * [openDevice] for each device.
   * 
   * [options]: The properties to search for on target devices.
   */
  Future<List<ConnectionHandle>> findDevices(EnumerateDevicesAndRequestAccessOptions options) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<ConnectionHandle>>.oneArg((e) => listify(e, _createConnectionHandle));
    _usb.callMethod('findDevices', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Closes a connection handle. Invoking operations on a handle after it has
   * been closed is a safe operation but causes no action to be taken.
   * [handle]: The [ConnectionHandle] to close.
   */
  Future closeDevice(ConnectionHandle handle) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _usb.callMethod('closeDevice', [jsify(handle), completer.callback]);
    return completer.future;
  }

  /**
   * Select a device configuration.
   * 
   * This function effectively resets the device by selecting one of the
   * device's available configurations. Only configuration values greater than
   * `0` are valid however some buggy devices have a working configuration `0`
   * and so this value is allowed.
   * [handle]: An open connection to the device.
   */
  Future setConfiguration(ConnectionHandle handle, int configurationValue) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _usb.callMethod('setConfiguration', [jsify(handle), configurationValue, completer.callback]);
    return completer.future;
  }

  /**
   * Gets the configuration descriptor for the currently selected configuration.
   * [handle]: An open connection to the device.
   */
  Future<ConfigDescriptor> getConfiguration(ConnectionHandle handle) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ConfigDescriptor>.oneArg(_createConfigDescriptor);
    _usb.callMethod('getConfiguration', [jsify(handle), completer.callback]);
    return completer.future;
  }

  /**
   * Lists all interfaces on a USB device.
   * [handle]: An open connection to the device.
   */
  Future<List<InterfaceDescriptor>> listInterfaces(ConnectionHandle handle) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<InterfaceDescriptor>>.oneArg((e) => listify(e, _createInterfaceDescriptor));
    _usb.callMethod('listInterfaces', [jsify(handle), completer.callback]);
    return completer.future;
  }

  /**
   * Claims an interface on a USB device. Before data can be transfered to an
   * interface or associated endpoints the interface must be claimed. Only one
   * connection handle can claim an interface at any given time. If the
   * interface is already claimed, this call will fail.
   * 
   * [releaseInterface] should be called when the interface is no longer needed.
   * 
   * [handle]: An open connection to the device.
   * [interfaceNumber]: The interface to be claimed.
   */
  Future claimInterface(ConnectionHandle handle, int interfaceNumber) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _usb.callMethod('claimInterface', [jsify(handle), interfaceNumber, completer.callback]);
    return completer.future;
  }

  /**
   * Releases a claimed interface.
   * [handle]: An open connection to the device.
   * [interfaceNumber]: The interface to be released.
   */
  Future releaseInterface(ConnectionHandle handle, int interfaceNumber) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _usb.callMethod('releaseInterface', [jsify(handle), interfaceNumber, completer.callback]);
    return completer.future;
  }

  /**
   * Selects an alternate setting on a previously claimed interface.
   * [handle]: An open connection to the device where this interface has been
   * claimed.
   * [interfaceNumber]: The interface to configure.
   * [alternateSetting]: The alternate setting to configure.
   */
  Future setInterfaceAlternateSetting(ConnectionHandle handle, int interfaceNumber, int alternateSetting) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _usb.callMethod('setInterfaceAlternateSetting', [jsify(handle), interfaceNumber, alternateSetting, completer.callback]);
    return completer.future;
  }

  /**
   * Performs a control transfer on the specified device.
   * 
   * Control transfers refer to either the device, an interface or an endpoint.
   * Transfers to an interface or endpoint require the interface to be claimed.
   * 
   * [handle]: An open connection to the device.
   */
  Future<TransferResultInfo> controlTransfer(ConnectionHandle handle, ControlTransferInfo transferInfo) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<TransferResultInfo>.oneArg(_createTransferResultInfo);
    _usb.callMethod('controlTransfer', [jsify(handle), jsify(transferInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Performs a bulk transfer on the specified device.
   * [handle]: An open connection to the device.
   * [transferInfo]: The transfer parameters.
   */
  Future<TransferResultInfo> bulkTransfer(ConnectionHandle handle, GenericTransferInfo transferInfo) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<TransferResultInfo>.oneArg(_createTransferResultInfo);
    _usb.callMethod('bulkTransfer', [jsify(handle), jsify(transferInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Performs an interrupt transfer on the specified device.
   * [handle]: An open connection to the device.
   * [transferInfo]: The transfer parameters.
   */
  Future<TransferResultInfo> interruptTransfer(ConnectionHandle handle, GenericTransferInfo transferInfo) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<TransferResultInfo>.oneArg(_createTransferResultInfo);
    _usb.callMethod('interruptTransfer', [jsify(handle), jsify(transferInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Performs an isochronous transfer on the specific device.
   * [handle]: An open connection to the device.
   */
  Future<TransferResultInfo> isochronousTransfer(ConnectionHandle handle, IsochronousTransferInfo transferInfo) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<TransferResultInfo>.oneArg(_createTransferResultInfo);
    _usb.callMethod('isochronousTransfer', [jsify(handle), jsify(transferInfo), completer.callback]);
    return completer.future;
  }

  /**
   * Tries to reset the USB device. If the reset fails, the given connection
   * handle will be closed and the USB device will appear to be disconnected
   * then reconnected. In this case [getDevices] or [findDevices] must be called
   * again to acquire the device.
   * 
   * [handle]: A connection handle to reset.
   */
  Future<bool> resetDevice(ConnectionHandle handle) {
    if (_usb == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _usb.callMethod('resetDevice', [jsify(handle), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.usb' is not available");
  }
}

/**
 * Direction, Recipient, RequestType, and TransferType all map to their
 * namesakes within the USB specification.
 */
class Direction extends ChromeEnum {
  static const Direction IN = const Direction._('in');
  static const Direction OUT = const Direction._('out');

  static const List<Direction> VALUES = const[IN, OUT];

  const Direction._(String str): super(str);
}

class Recipient extends ChromeEnum {
  static const Recipient DEVICE = const Recipient._('device');
  static const Recipient INTERFACE = const Recipient._('interface');
  static const Recipient ENDPOINT = const Recipient._('endpoint');
  static const Recipient OTHER = const Recipient._('other');

  static const List<Recipient> VALUES = const[DEVICE, INTERFACE, ENDPOINT, OTHER];

  const Recipient._(String str): super(str);
}

class RequestType extends ChromeEnum {
  static const RequestType STANDARD = const RequestType._('standard');
  static const RequestType CLASS = const RequestType._('class');
  static const RequestType VENDOR = const RequestType._('vendor');
  static const RequestType RESERVED = const RequestType._('reserved');

  static const List<RequestType> VALUES = const[STANDARD, CLASS, VENDOR, RESERVED];

  const RequestType._(String str): super(str);
}

class TransferType extends ChromeEnum {
  static const TransferType CONTROL = const TransferType._('control');
  static const TransferType INTERRUPT = const TransferType._('interrupt');
  static const TransferType ISOCHRONOUS = const TransferType._('isochronous');
  static const TransferType BULK = const TransferType._('bulk');

  static const List<TransferType> VALUES = const[CONTROL, INTERRUPT, ISOCHRONOUS, BULK];

  const TransferType._(String str): super(str);
}

/**
 * For isochronous mode, SynchronizationType and UsageType map to their
 * namesakes within the USB specification.
 */
class SynchronizationType extends ChromeEnum {
  static const SynchronizationType ASYNCHRONOUS = const SynchronizationType._('asynchronous');
  static const SynchronizationType ADAPTIVE = const SynchronizationType._('adaptive');
  static const SynchronizationType SYNCHRONOUS = const SynchronizationType._('synchronous');

  static const List<SynchronizationType> VALUES = const[ASYNCHRONOUS, ADAPTIVE, SYNCHRONOUS];

  const SynchronizationType._(String str): super(str);
}

class UsageType extends ChromeEnum {
  static const UsageType DATA = const UsageType._('data');
  static const UsageType FEEDBACK = const UsageType._('feedback');
  static const UsageType EXPLICIT_FEEDBACK = const UsageType._('explicitFeedback');

  static const List<UsageType> VALUES = const[DATA, FEEDBACK, EXPLICIT_FEEDBACK];

  const UsageType._(String str): super(str);
}

class Device extends ChromeObject {
  Device({int device, int vendorId, int productId}) {
    if (device != null) this.device = device;
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
  }
  Device.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get device => jsProxy['device'];
  set device(int value) => jsProxy['device'] = value;

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;
}

class ConnectionHandle extends ChromeObject {
  ConnectionHandle({int handle, int vendorId, int productId}) {
    if (handle != null) this.handle = handle;
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
  }
  ConnectionHandle.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get handle => jsProxy['handle'];
  set handle(int value) => jsProxy['handle'] = value;

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;
}

class EndpointDescriptor extends ChromeObject {
  EndpointDescriptor({int address, TransferType type, Direction direction, int maximumPacketSize, SynchronizationType synchronization, UsageType usage, int pollingInterval, ArrayBuffer extra_data}) {
    if (address != null) this.address = address;
    if (type != null) this.type = type;
    if (direction != null) this.direction = direction;
    if (maximumPacketSize != null) this.maximumPacketSize = maximumPacketSize;
    if (synchronization != null) this.synchronization = synchronization;
    if (usage != null) this.usage = usage;
    if (pollingInterval != null) this.pollingInterval = pollingInterval;
    if (extra_data != null) this.extra_data = extra_data;
  }
  EndpointDescriptor.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get address => jsProxy['address'];
  set address(int value) => jsProxy['address'] = value;

  TransferType get type => _createTransferType(jsProxy['type']);
  set type(TransferType value) => jsProxy['type'] = jsify(value);

  Direction get direction => _createDirection(jsProxy['direction']);
  set direction(Direction value) => jsProxy['direction'] = jsify(value);

  int get maximumPacketSize => jsProxy['maximumPacketSize'];
  set maximumPacketSize(int value) => jsProxy['maximumPacketSize'] = value;

  SynchronizationType get synchronization => _createSynchronizationType(jsProxy['synchronization']);
  set synchronization(SynchronizationType value) => jsProxy['synchronization'] = jsify(value);

  UsageType get usage => _createUsageType(jsProxy['usage']);
  set usage(UsageType value) => jsProxy['usage'] = jsify(value);

  int get pollingInterval => jsProxy['pollingInterval'];
  set pollingInterval(int value) => jsProxy['pollingInterval'] = value;

  ArrayBuffer get extra_data => _createArrayBuffer(jsProxy['extra_data']);
  set extra_data(ArrayBuffer value) => jsProxy['extra_data'] = jsify(value);
}

class InterfaceDescriptor extends ChromeObject {
  InterfaceDescriptor({int interfaceNumber, int alternateSetting, int interfaceClass, int interfaceSubclass, int interfaceProtocol, String description, List<EndpointDescriptor> endpoints, ArrayBuffer extra_data}) {
    if (interfaceNumber != null) this.interfaceNumber = interfaceNumber;
    if (alternateSetting != null) this.alternateSetting = alternateSetting;
    if (interfaceClass != null) this.interfaceClass = interfaceClass;
    if (interfaceSubclass != null) this.interfaceSubclass = interfaceSubclass;
    if (interfaceProtocol != null) this.interfaceProtocol = interfaceProtocol;
    if (description != null) this.description = description;
    if (endpoints != null) this.endpoints = endpoints;
    if (extra_data != null) this.extra_data = extra_data;
  }
  InterfaceDescriptor.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get interfaceNumber => jsProxy['interfaceNumber'];
  set interfaceNumber(int value) => jsProxy['interfaceNumber'] = value;

  int get alternateSetting => jsProxy['alternateSetting'];
  set alternateSetting(int value) => jsProxy['alternateSetting'] = value;

  int get interfaceClass => jsProxy['interfaceClass'];
  set interfaceClass(int value) => jsProxy['interfaceClass'] = value;

  int get interfaceSubclass => jsProxy['interfaceSubclass'];
  set interfaceSubclass(int value) => jsProxy['interfaceSubclass'] = value;

  int get interfaceProtocol => jsProxy['interfaceProtocol'];
  set interfaceProtocol(int value) => jsProxy['interfaceProtocol'] = value;

  String get description => jsProxy['description'];
  set description(String value) => jsProxy['description'] = value;

  List<EndpointDescriptor> get endpoints => listify(jsProxy['endpoints'], _createEndpointDescriptor);
  set endpoints(List<EndpointDescriptor> value) => jsProxy['endpoints'] = jsify(value);

  ArrayBuffer get extra_data => _createArrayBuffer(jsProxy['extra_data']);
  set extra_data(ArrayBuffer value) => jsProxy['extra_data'] = jsify(value);
}

class ConfigDescriptor extends ChromeObject {
  ConfigDescriptor({int configurationValue, String description, bool selfPowered, bool remoteWakeup, int maxPower, List<InterfaceDescriptor> interfaces, ArrayBuffer extra_data}) {
    if (configurationValue != null) this.configurationValue = configurationValue;
    if (description != null) this.description = description;
    if (selfPowered != null) this.selfPowered = selfPowered;
    if (remoteWakeup != null) this.remoteWakeup = remoteWakeup;
    if (maxPower != null) this.maxPower = maxPower;
    if (interfaces != null) this.interfaces = interfaces;
    if (extra_data != null) this.extra_data = extra_data;
  }
  ConfigDescriptor.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get configurationValue => jsProxy['configurationValue'];
  set configurationValue(int value) => jsProxy['configurationValue'] = value;

  String get description => jsProxy['description'];
  set description(String value) => jsProxy['description'] = value;

  bool get selfPowered => jsProxy['selfPowered'];
  set selfPowered(bool value) => jsProxy['selfPowered'] = value;

  bool get remoteWakeup => jsProxy['remoteWakeup'];
  set remoteWakeup(bool value) => jsProxy['remoteWakeup'] = value;

  int get maxPower => jsProxy['maxPower'];
  set maxPower(int value) => jsProxy['maxPower'] = value;

  List<InterfaceDescriptor> get interfaces => listify(jsProxy['interfaces'], _createInterfaceDescriptor);
  set interfaces(List<InterfaceDescriptor> value) => jsProxy['interfaces'] = jsify(value);

  ArrayBuffer get extra_data => _createArrayBuffer(jsProxy['extra_data']);
  set extra_data(ArrayBuffer value) => jsProxy['extra_data'] = jsify(value);
}

class ControlTransferInfo extends ChromeObject {
  ControlTransferInfo({Direction direction, Recipient recipient, RequestType requestType, int request, int value, int index, int length, ArrayBuffer data, int timeout}) {
    if (direction != null) this.direction = direction;
    if (recipient != null) this.recipient = recipient;
    if (requestType != null) this.requestType = requestType;
    if (request != null) this.request = request;
    if (value != null) this.value = value;
    if (index != null) this.index = index;
    if (length != null) this.length = length;
    if (data != null) this.data = data;
    if (timeout != null) this.timeout = timeout;
  }
  ControlTransferInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Direction get direction => _createDirection(jsProxy['direction']);
  set direction(Direction value) => jsProxy['direction'] = jsify(value);

  Recipient get recipient => _createRecipient(jsProxy['recipient']);
  set recipient(Recipient value) => jsProxy['recipient'] = jsify(value);

  RequestType get requestType => _createRequestType(jsProxy['requestType']);
  set requestType(RequestType value) => jsProxy['requestType'] = jsify(value);

  int get request => jsProxy['request'];
  set request(int value) => jsProxy['request'] = value;

  int get value => jsProxy['value'];
  set value(int value) => jsProxy['value'] = value;

  int get index => jsProxy['index'];
  set index(int value) => jsProxy['index'] = value;

  int get length => jsProxy['length'];
  set length(int value) => jsProxy['length'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);

  int get timeout => jsProxy['timeout'];
  set timeout(int value) => jsProxy['timeout'] = value;
}

class GenericTransferInfo extends ChromeObject {
  GenericTransferInfo({Direction direction, int endpoint, int length, ArrayBuffer data, int timeout}) {
    if (direction != null) this.direction = direction;
    if (endpoint != null) this.endpoint = endpoint;
    if (length != null) this.length = length;
    if (data != null) this.data = data;
    if (timeout != null) this.timeout = timeout;
  }
  GenericTransferInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Direction get direction => _createDirection(jsProxy['direction']);
  set direction(Direction value) => jsProxy['direction'] = jsify(value);

  int get endpoint => jsProxy['endpoint'];
  set endpoint(int value) => jsProxy['endpoint'] = value;

  int get length => jsProxy['length'];
  set length(int value) => jsProxy['length'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);

  int get timeout => jsProxy['timeout'];
  set timeout(int value) => jsProxy['timeout'] = value;
}

class IsochronousTransferInfo extends ChromeObject {
  IsochronousTransferInfo({GenericTransferInfo transferInfo, int packets, int packetLength}) {
    if (transferInfo != null) this.transferInfo = transferInfo;
    if (packets != null) this.packets = packets;
    if (packetLength != null) this.packetLength = packetLength;
  }
  IsochronousTransferInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  GenericTransferInfo get transferInfo => _createGenericTransferInfo(jsProxy['transferInfo']);
  set transferInfo(GenericTransferInfo value) => jsProxy['transferInfo'] = jsify(value);

  int get packets => jsProxy['packets'];
  set packets(int value) => jsProxy['packets'] = value;

  int get packetLength => jsProxy['packetLength'];
  set packetLength(int value) => jsProxy['packetLength'] = value;
}

class TransferResultInfo extends ChromeObject {
  TransferResultInfo({int resultCode, ArrayBuffer data}) {
    if (resultCode != null) this.resultCode = resultCode;
    if (data != null) this.data = data;
  }
  TransferResultInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get resultCode => jsProxy['resultCode'];
  set resultCode(int value) => jsProxy['resultCode'] = value;

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);
  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);
}

class UsbDeviceFilter extends ChromeObject {
  UsbDeviceFilter({int vendorId, int productId, int interfaceClass, int interfaceSubclass, int interfaceProtocol}) {
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
    if (interfaceClass != null) this.interfaceClass = interfaceClass;
    if (interfaceSubclass != null) this.interfaceSubclass = interfaceSubclass;
    if (interfaceProtocol != null) this.interfaceProtocol = interfaceProtocol;
  }
  UsbDeviceFilter.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;

  int get interfaceClass => jsProxy['interfaceClass'];
  set interfaceClass(int value) => jsProxy['interfaceClass'] = value;

  int get interfaceSubclass => jsProxy['interfaceSubclass'];
  set interfaceSubclass(int value) => jsProxy['interfaceSubclass'] = value;

  int get interfaceProtocol => jsProxy['interfaceProtocol'];
  set interfaceProtocol(int value) => jsProxy['interfaceProtocol'] = value;
}

class EnumerateDevicesOptions extends ChromeObject {
  EnumerateDevicesOptions({int vendorId, int productId, List<UsbDeviceFilter> filters}) {
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
    if (filters != null) this.filters = filters;
  }
  EnumerateDevicesOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;

  List<UsbDeviceFilter> get filters => listify(jsProxy['filters'], _createDeviceFilter);
  set filters(List<UsbDeviceFilter> value) => jsProxy['filters'] = jsify(value);
}

class EnumerateDevicesAndRequestAccessOptions extends ChromeObject {
  EnumerateDevicesAndRequestAccessOptions({int vendorId, int productId, int interfaceId}) {
    if (vendorId != null) this.vendorId = vendorId;
    if (productId != null) this.productId = productId;
    if (interfaceId != null) this.interfaceId = interfaceId;
  }
  EnumerateDevicesAndRequestAccessOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get vendorId => jsProxy['vendorId'];
  set vendorId(int value) => jsProxy['vendorId'] = value;

  int get productId => jsProxy['productId'];
  set productId(int value) => jsProxy['productId'] = value;

  int get interfaceId => jsProxy['interfaceId'];
  set interfaceId(int value) => jsProxy['interfaceId'] = value;
}

class DevicePromptOptions extends ChromeObject {
  DevicePromptOptions({bool multiple, List<UsbDeviceFilter> filters}) {
    if (multiple != null) this.multiple = multiple;
    if (filters != null) this.filters = filters;
  }
  DevicePromptOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get multiple => jsProxy['multiple'];
  set multiple(bool value) => jsProxy['multiple'] = value;

  List<UsbDeviceFilter> get filters => listify(jsProxy['filters'], _createDeviceFilter);
  set filters(List<UsbDeviceFilter> value) => jsProxy['filters'] = jsify(value);
}

Device _createDevice(JsObject jsProxy) => jsProxy == null ? null : new Device.fromProxy(jsProxy);
ConnectionHandle _createConnectionHandle(JsObject jsProxy) => jsProxy == null ? null : new ConnectionHandle.fromProxy(jsProxy);
ConfigDescriptor _createConfigDescriptor(JsObject jsProxy) => jsProxy == null ? null : new ConfigDescriptor.fromProxy(jsProxy);
InterfaceDescriptor _createInterfaceDescriptor(JsObject jsProxy) => jsProxy == null ? null : new InterfaceDescriptor.fromProxy(jsProxy);
TransferResultInfo _createTransferResultInfo(JsObject jsProxy) => jsProxy == null ? null : new TransferResultInfo.fromProxy(jsProxy);
TransferType _createTransferType(String value) => TransferType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
Direction _createDirection(String value) => Direction.VALUES.singleWhere((ChromeEnum e) => e.value == value);
SynchronizationType _createSynchronizationType(String value) => SynchronizationType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
UsageType _createUsageType(String value) => UsageType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
EndpointDescriptor _createEndpointDescriptor(JsObject jsProxy) => jsProxy == null ? null : new EndpointDescriptor.fromProxy(jsProxy);
Recipient _createRecipient(String value) => Recipient.VALUES.singleWhere((ChromeEnum e) => e.value == value);
RequestType _createRequestType(String value) => RequestType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
GenericTransferInfo _createGenericTransferInfo(JsObject jsProxy) => jsProxy == null ? null : new GenericTransferInfo.fromProxy(jsProxy);
UsbDeviceFilter _createDeviceFilter(JsObject jsProxy) => jsProxy == null ? null : new UsbDeviceFilter.fromProxy(jsProxy);
