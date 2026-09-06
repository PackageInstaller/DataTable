-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupWindowDiamondViewPresentor.lua

module("logic.extensions.tips.view.PopupWindowDiamondViewPresentor", package.seeall)

local PopupWindowDiamondViewPresentor = class("PopupWindowDiamondViewPresentor", ViewPresentor)

function PopupWindowDiamondViewPresentor:ctor()
	PopupWindowDiamondViewPresentor.super.ctor(self)
end

function PopupWindowDiamondViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PopupWindowDiamondViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupwindowdiamond.prefab"
	}
end

function PopupWindowDiamondViewPresentor:buildViews()
	return {
		PopupWindowDiamondView.New()
	}
end

return PopupWindowDiamondViewPresentor
