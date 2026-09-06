-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/GiftRecordsPopupPresentor.lua

module("logic.extensions.birthdaywishes.view.GiftRecordsPopupPresentor", package.seeall)

local GiftRecordsPopupPresentor = class("GiftRecordsPopupPresentor", ViewWithGuidePresentor)

function GiftRecordsPopupPresentor:ctor()
	GiftRecordsPopupPresentor.super.ctor(self)
end

function GiftRecordsPopupPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GiftRecordsPopupPresentor:dependWhatResources()
	return {
		"ui/views/birthdaywishes/giftrecordspopup.prefab"
	}
end

function GiftRecordsPopupPresentor:buildViews()
	return {
		GiftRecordsPopup.New()
	}
end

return GiftRecordsPopupPresentor
