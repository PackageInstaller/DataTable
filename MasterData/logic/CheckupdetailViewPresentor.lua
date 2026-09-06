-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/CheckupdetailViewPresentor.lua

module("logic.extensions.handbook.view.CheckupdetailViewPresentor", package.seeall)

local CheckupdetailViewPresentor = class("CheckupdetailViewPresentor", ViewPresentor)

function CheckupdetailViewPresentor:ctor()
	CheckupdetailViewPresentor.super.ctor(self)
end

function CheckupdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CheckupdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/powercheck/checkupdetailview.prefab"
	}
end

function CheckupdetailViewPresentor:buildViews()
	return {
		CheckupdetailView.New()
	}
end

return CheckupdetailViewPresentor
