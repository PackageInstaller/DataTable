-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookViewPresentor.lua

module("logic.extensions.handbook.view.HandbookViewPresentor", package.seeall)

local HandbookViewPresentor = class("HandbookViewPresentor", ViewWithGuidePresentor)

function HandbookViewPresentor:ctor()
	HandbookViewPresentor.super.ctor(self)
end

function HandbookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HandbookViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/handbookview.prefab"
	}
end

function HandbookViewPresentor:buildViews()
	return {
		HandbookView.New()
	}
end

return HandbookViewPresentor
