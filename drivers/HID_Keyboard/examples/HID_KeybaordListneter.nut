// MIT License
//
// Copyright 2017 Electric Imp
//
// SPDX-License-Identifier: MIT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//

// This is an example of keyboard control application

@include "../../../../USB.device.lib.nut"
@include "../../../../USB.HID.device.lib.nut"
@include "../../US-ASCII.table.nut"
@include "../../HIDKeyboard.nut"

log <- server.log.bindenv(server);

kbdDrv <- null;

function kdbEventListener(keys) {
    local txt = "Keys received: ";
    foreach (key in keys) {
        txt += key.tochar() + " ";
    }

    log (txt);
}

function usbEventListener(event, data) {
    log("USB event: " + event);

    if (event == "started") {
        kbdDrv = data;

        log("Start polling");
        kbdDrv.startPoll(0, kdbEventListener);
    }
}

usbHost <- USB.Host([HIDKeyboard]);
log("USB.Host setup complete");

usbHost.setEventListener(usbEventListener);
log("USB.Host setEventListener complete");

log("Waiting for attach event");