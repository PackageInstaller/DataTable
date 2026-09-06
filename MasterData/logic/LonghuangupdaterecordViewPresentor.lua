-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longhuang/LonghuangupdaterecordViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longhuang.LonghuangupdaterecordViewPresentor", package.seeall)

local LonghuangupdaterecordViewPresentor = class("LonghuangupdaterecordViewPresentor", ViewPresentor)

function LonghuangupdaterecordViewPresentor:ctor()
	LonghuangupdaterecordViewPresentor.super.ctor(self)
end

function LonghuangupdaterecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LonghuangupdaterecordViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longhuangupdaterecordview.prefab"
	}
end

function LonghuangupdaterecordViewPresentor:buildViews()
	return {
		LonghuangupdaterecordView.New()
	}
end

return LonghuangupdaterecordViewPresentor
