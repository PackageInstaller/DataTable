-- chunkname: @/tmp/or_script/lua_compile/cocos/extension/DeprecatedExtensionClass.lua

if cc.Control == nil then
	return
end

DeprecatedExtensionClass = {} or DeprecatedExtensionClass

local function deprecatedTip(old_name, new_name)
	print("\n********** \n" .. old_name .. " was deprecated please use " .. new_name .. " instead.\n**********")
end

function DeprecatedExtensionClass.CCControl()
	deprecatedTip("CCControl", "cc.Control")

	return cc.Control
end

_G.CCControl = DeprecatedExtensionClass.CCControl()

function DeprecatedExtensionClass.CCScrollView()
	deprecatedTip("CCScrollView", "cc.ScrollView")

	return cc.ScrollView
end

_G.CCScrollView = DeprecatedExtensionClass.CCScrollView()

function DeprecatedExtensionClass.CCTableView()
	deprecatedTip("CCTableView", "cc.TableView")

	return cc.TableView
end

_G.CCTableView = DeprecatedExtensionClass.CCTableView()

function DeprecatedExtensionClass.CCControlPotentiometer()
	deprecatedTip("CCControlPotentiometer", "cc.ControlPotentiometer")

	return cc.ControlPotentiometer
end

_G.CCControlPotentiometer = DeprecatedExtensionClass.CCControlPotentiometer()

function DeprecatedExtensionClass.CCControlStepper()
	deprecatedTip("CCControlStepper", "cc.ControlStepper")

	return cc.ControlStepper
end

_G.CCControlStepper = DeprecatedExtensionClass.CCControlStepper()

function DeprecatedExtensionClass.CCControlHuePicker()
	deprecatedTip("CCControlHuePicker", "cc.ControlHuePicker")

	return cc.ControlHuePicker
end

_G.CCControlHuePicker = DeprecatedExtensionClass.CCControlHuePicker()

function DeprecatedExtensionClass.CCControlSlider()
	deprecatedTip("CCControlSlider", "cc.ControlSlider")

	return cc.ControlSlider
end

_G.CCControlSlider = DeprecatedExtensionClass.CCControlSlider()

function DeprecatedExtensionClass.CCControlSaturationBrightnessPicker()
	deprecatedTip("CCControlSaturationBrightnessPicker", "cc.ControlSaturationBrightnessPicker")

	return cc.ControlSaturationBrightnessPicker
end

_G.CCControlSaturationBrightnessPicker = DeprecatedExtensionClass.CCControlSaturationBrightnessPicker()

function DeprecatedExtensionClass.CCControlSwitch()
	deprecatedTip("CCControlSwitch", "cc.ControlSwitch")

	return cc.ControlSwitch
end

_G.CCControlSwitch = DeprecatedExtensionClass.CCControlSwitch()

function DeprecatedExtensionClass.CCControlButton()
	deprecatedTip("CCControlButton", "cc.ControlButton")

	return cc.ControlButton
end

_G.CCControlButton = DeprecatedExtensionClass.CCControlButton()

function DeprecatedExtensionClass.CCControlColourPicker()
	deprecatedTip("CCControlColourPicker", "cc.ControlColourPicker")

	return cc.ControlColourPicker
end

_G.CCControlColourPicker = DeprecatedExtensionClass.CCControlColourPicker()

if ccui == nil then
	return
end

function DeprecatedExtensionClass.CCEditBox()
	deprecatedTip("CCEditBox", "ccui.EditBox")

	return ccui.EditBox
end

_G.CCEditBox = DeprecatedExtensionClass.CCEditBox()

function DeprecatedExtensionClass.CCUIEditBox()
	deprecatedTip("cc.EditBox", "ccui.EditBox")

	return ccui.EditBox
end

_G.cc.EditBox = DeprecatedExtensionClass.CCUIEditBox()

function DeprecatedExtensionClass.CCScale9Sprite()
	deprecatedTip("CCScale9Sprite", "ccui.Scale9Sprite")

	return ccui.Scale9Sprite
end

_G.CCScale9Sprite = DeprecatedExtensionClass.CCScale9Sprite()

function DeprecatedExtensionClass.UIScale9Sprite()
	deprecatedTip("cc.Scale9Sprite", "ccui.Scale9Sprite")

	return ccui.Scale9Sprite
end

_G.cc.Scale9Sprite = DeprecatedExtensionClass.UIScale9Sprite()
