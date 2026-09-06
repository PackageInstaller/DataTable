-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/SendBlessPopupPresentor.lua

module("logic.extensions.birthdaywishes.view.SendBlessPopupPresentor", package.seeall)

local SendBlessPopupPresentor = class("SendBlessPopupPresentor", ViewWithGuidePresentor)

function SendBlessPopupPresentor:ctor()
	SendBlessPopupPresentor.super.ctor(self)
end

function SendBlessPopupPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SendBlessPopupPresentor:dependWhatResources()
	return {
		"ui/views/birthdaywishes/sendblesspopup.prefab"
	}
end

function SendBlessPopupPresentor:buildViews()
	return {
		SendBlessPopup.New()
	}
end

return SendBlessPopupPresentor
