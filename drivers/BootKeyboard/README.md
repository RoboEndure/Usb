# Boot Keyboard Driver Example #

This class is an example of how to extend the USB Devices Framework [USB.Driver](../../docs/DriverDevelopmentGuide.md#usbdriver-class-usage) implementation. It exposes a very simple API that allows it to work with any device that implements the [Boot Keyboard Protocol](https://www.usb.org/sites/default/files/documents/hid1_11.pdf).

**Note** Please use this driver for reference only. It was tested with a limited number of devices and may not support all devices of that type.

## Include The Driver And Its Dependencies ##

The driver depends on constants and classes within the [USB Drivers Framework](../../docs/DriverDevelopmentGuide.md#usb-drivers-framework-api-specification).

To add the Boot Keyboard driver into your project, add `#require "USB.device.lib.nut:1.1.0"` top of you application code and then either include the Boot Keyboard driver in your application by pasting its code into yours or by using [Builder's @include statement](https://github.com/electricimp/builder#include):

```squirrel
#require "USB.device.lib.nut:1.1.0"
@include "github:electricimp/usb/drivers/BootKeyboard/BootKeyboard.device.nut"
```

## Custom Matching Procedure ##

This driver matches only devices [interfaces](../../docs/DriverDevelopmentGuide.md#interface-descriptor) of *class* 3 (HID), *subclass* 1 (Boot) and *protocol* 1 (keyboard).

## Driver Class Custom API ##

This driver exposes following API for application usage.

### getKeyStatusAsync(*callback*) ###

This method sends a request through an Interrupt In endpoint that gets data and notifies the caller asynchronously.

#### Parameters ####

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| *callback* | Function | Yes | A function to receive the keyboard status |

#### Callback Parameters ####

| Parameter | Type | Description |
| --- | --- | --- |
| *status* | Table | A [Keyboard Status Table](#keyboard-status-table) |

#### Return Value ####

Nothing.

### getKeyStatus() ###

A synchronous method that reads the keyboard's report through the control endpoint 0. It throws a runtime error if an error occurs during transfer.

#### Return Value ####

[Table](#keyboard-status-table) &mdash; the keyboard status record.

#### Keyboard Status Table ####

Both [*getKeyStatusAsync()*](#getkeystatusasynccallback) and [*getKeyStatus()*](#getkeystatus) return the keyboard state as a table containing some or all of the following keys:

| Table Key | Type | Description |
| --- | --- | --- |
| *error* | String | The field is present if any error occurred |
| *LEFT_CTRL* | Integer | Left Ctrl status (1/0) |
| *LEFT_SHIFT* | Integer | Left Shift status (1/0) |
| *LEFT_ALT* | Integer| Left Alt status (1/0) |
| *LEFT_GUI* | Integer| Left Gui status (1/0) |
| *RIGHT_CTRL* | Integer| Right Ctrl status (1/0) |
| *RIGHT_SHIFT* | Integer| Right Shift status (1/0) |
| *RIGHT_ALT* | Integer | Right Alt status (1/0) |
| *RIGHT_GUI* | Integer | Right Gui status (1/0) |
| *Key0* | Integer | First scan code or 0 |
| *Key1* | Integer | Second scan code or 0 |
| *Key2* | Integer | Third scan code or 0 |
| *Key3* | Integer | Fourth scan code or 0 |
| *Key4* | Integer | Fifth scan code or 0 |
| *Key5* | Integer | Sixth scan code or 0 |

### setIdleTimeMs(*timeout*) ###

This method is used to limit the reporting frequency.

#### Parameters ####

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| *timeout* | Integer | Yes | Poll duration in milliseconds, range: 0 (indefinite)-1020 |

#### Return Value ####

Nothing.

### setLeds(*leds*) ###

This method changes the keyboard LED status.

#### Parameters ####

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| *leds* | Integer Bitfield | Yes | 8-bit field:</br>bit 0 - NUM LOCK</br>bit 1 - CAPS LOCK</br>bit 2 - SCROLL LOCK</br>bit 3 - COMPOSE</br>bit 4 - KANA |

#### Return Value ####

Nothing, or an error description if an error occurred.
