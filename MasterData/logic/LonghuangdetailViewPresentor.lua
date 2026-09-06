-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longhuang/LonghuangdetailViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longhuang.LonghuangdetailViewPresentor", package.seeall)

local LonghuangdetailViewPresentor = class("LonghuangdetailViewPresentor", ViewPresentor)

function LonghuangdetailViewPresentor:ctor()
	LonghuangdetailViewPresentor.super.ctor(self)
end

function LonghuangdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LonghuangdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longhuangdetailview.prefab"
	}
end

function LonghuangdetailViewPresentor:buildViews()
	return {
		LonghuangdetailView.New()
	}
end

return LonghuangdetailViewPresentor
