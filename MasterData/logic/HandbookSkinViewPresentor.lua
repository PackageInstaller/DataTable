-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookSkinViewPresentor.lua

module("logic.extensions.handbook.view.HandbookSkinViewPresentor", package.seeall)

local HandbookSkinViewPresentor = class("HandbookSkinViewPresentor", ViewPresentor)

function HandbookSkinViewPresentor:ctor()
	HandbookSkinViewPresentor.super.ctor(self)
end

function HandbookSkinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HandbookSkinViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/handbookskinview.prefab"
	}
end

function HandbookSkinViewPresentor:buildViews()
	return {
		HandbookSkinView.New()
	}
end

return HandbookSkinViewPresentor
