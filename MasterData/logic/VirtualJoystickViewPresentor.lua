-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/joystick/view/VirtualJoystickViewPresentor.lua

module("logic.extensions.joystick.view.VirtualJoystickViewPresentor", package.seeall)

local VirtualJoystickViewPresentor = class("VirtualJoystickViewPresentor", ViewPresentor)

VirtualJoystickViewPresentor.Url_View = "ui/views/joystick/joystickview.prefab"

function VirtualJoystickViewPresentor:ctor()
	VirtualJoystickViewPresentor.super.ctor(self)
end

function VirtualJoystickViewPresentor:dependWhatResources()
	return {
		VirtualJoystickViewPresentor.Url_View
	}
end

function VirtualJoystickViewPresentor:buildViews()
	local views = {}
	local mainView = VirtualJoystickView.New()

	table.insert(views, mainView)

	return views
end

function VirtualJoystickViewPresentor:attachToWhichRoot()
	return ViewRootType.Hud
end

return VirtualJoystickViewPresentor
