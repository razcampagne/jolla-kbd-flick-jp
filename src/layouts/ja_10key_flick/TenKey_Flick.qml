/*
 * Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies). All rights reserved.
 * Copyright (C) 2012-2013 Jolla Ltd.
 *
 * Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Nokia Corporation nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

import QtQuick 2.0
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0
import ".."
import "../.."

KeyBase {
    id: aCharKey

    implicitHeight: portraitMode == false ? geometry.keyHeightLandscape
                     :  geometry.keyHeightPortrait
    implicitWidth: portraitMode == false ? geometry.keyboardWidthLandscape / 5
                     : geometry.keyboardWidthPortrait / 5

    property string flickerText
    property string captionShifted
    property string captionShifted2: captionShifted
    property string symView
    property string symView2
    property int separator: SeparatorState.AutomaticSeparator
    property bool implicitSeparator: true // set by layouting
    property bool showHighlight: true
    property string accents
    property string accentsShifted
    property bool fixedWidth
    property alias useBoldFont: keyText.font.bold
    property alias  _keyText: keyText.text
    property string currentText: flickerText

    property int flickerIndex: 0
    property bool enableFlicker: true
    property bool symbolOnly: false

    Connections {
        target: attributes
        onIsShiftedChanged: updateKeyString()
        onInSymViewChanged: updateKeyString()
    }

    Connections {
        target: main
        onTextCaptStateChanged: updateKeyString()
    }

    ConfigurationValue {
        id: flickPopperConfig

        key: "/sailfish/text_input/flick_popper_enabled"
        defaultValue: false
    }

    ConfigurationValue {
        id: flickAssistConfig

        key: "/sailfish/text_input/flick_assist_label_enabled"
        defaultValue: false
    }

    showPopper: flickPopperConfig.value ? false : true
    keyType: KeyType.CharacterKey
    text: currentText.charAt(flickerIndex) === ""
        ? currentText.charAt(0)
        : currentText.charAt(flickerIndex)
    caption: text

    Column {
        id: mainLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: keyText
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: Theme.fontFamily
            font.pixelSize: !pressed && symbolOnly
                ? Theme.fontSizeExtraSmall
                : !portraitMode || !flickAssistConfig.value
                    ? Theme.fontSizeLarge
                    : flickerIndex > 0
                        ? Theme.fontSizeExtraLarge
                        : !pressed
                            ? Theme.fontSizeMedium
                            : Theme.fontSizeHuge
            font.letterSpacing: (portraitMode === true && !attributes.isShifted && !attributes.inSymView && symbolOnly && flickerText.length > 3) ? -10 : 0
            color: !pressed || (flickerIndex == 0 || currentText.charAt(flickerIndex) == "")
                ? Theme.primaryColor
                : Theme.highlightColor
            text: pressed && flickPopperConfig.value
                ? currentText.charAt(0)
                : (currentText.charAt(0) == " "
                    ? ""
                    : (symbolOnly && attributes.inSymView && !flickAssistConfig.value
                        ? symView
                        : (!portraitMode || !flickAssistConfig.value
                            ? ((attributes.isShifted && !attributes.inSymView
                            && !pressed) || symbolOnly
                                ? currentText
                                : currentText.charAt(flickerIndex) === ""
                                    ? currentText.charAt(0)
                                    : currentText.charAt(flickerIndex))
                            : currentText.charAt(0))))

        }
        Text {
            id: secondaryLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: (leftPadding - rightPadding) / 2
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: Theme.fontFamily
            font.pixelSize: !symbolOnly ? Theme.fontSizeExtraSmall : Theme.fontSizeSmall
            color: pressed ? Theme.highlightColor : Theme.primaryColor
            opacity: (!pressed && attributes.isShifted && captionShifted === " ") ? .8 : .6
            text: !pressed && attributes.inSymView && symView.length > 0
                ? (flickAssistConfig.value || symbolOnly
                    ? ""
                    : symView.slice(1))
                : (!pressed && attributes.isShifted && captionShifted === " "
                    ? "Space"
                    : "")
        }
    }

    Repeater {
        model: 4
        AssistLabel {
            visible: portraitMode && !pressed && flickAssistConfig.value
            keyIndex: index + 1
            labelText: currentText
        }
    }

    Image {
        source: "../../graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
        visible: (separator === SeparatorState.AutomaticSeparator && implicitSeparator)
                 || separator === SeparatorState.VisibleSeparator
    }

    Rectangle {
        anchors.fill: parent
        z: -1
        color: Theme.highlightBackgroundColor
        opacity: 0.5
        visible: pressed && showHighlight
    }

    onPressedChanged: {
        if (!pressed){
            flickerIndex = 0
            textCaptState = (!shiftShifted || !attributes.isShifted ? false : true)
        } else if (pressed) {
            if (attributes.isShifted && aCharKey.text === "\u2191" && !textCaptState) {
                shiftShifted = true
            } else if (attributes.isShifted && aCharKey.text !== "\u2191" || aCharKey.text === "\u2191" && shiftShifted) {
                shiftShifted = false
            }
        }
    }

    function updateKeyString() {
        if (attributes.inSymView) {
            currentText = symView
            return
        }

        if (attributes.isShifted) {
            if (textCaptState) {
                currentText = captionShifted2
            } else {
                currentText = captionShifted
            }
            return
        }

        currentText = flickerText
    }
}
