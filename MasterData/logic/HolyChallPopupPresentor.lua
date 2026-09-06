-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/HolyChallPopupPresentor.lua

module("logic.extensions.kingway.view.HolyChallPopupPresentor", package.seeall)

local HolyChallPopupPresentor = class("HolyChallPopupPresentor", ViewPresentor)

function HolyChallPopupPresentor:ctor()
	HolyChallPopupPresentor.super.ctor(self)
end

function HolyChallPopupPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyChallPopupPresentor:dependWhatResources()
	return {
		"ui/views/kingway/holychallpopup.prefab"
	}
end

function HolyChallPopupPresentor:buildViews()
	return {
		HolyChallPopup.New()
	}
end

return HolyChallPopupPresentor
