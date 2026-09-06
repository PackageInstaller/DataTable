-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longhuang/LonghuanggameViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longhuang.LonghuanggameViewPresentor", package.seeall)

local LonghuanggameViewPresentor = class("LonghuanggameViewPresentor", ViewPresentor)

function LonghuanggameViewPresentor:ctor()
	LonghuanggameViewPresentor.super.ctor(self)
end

function LonghuanggameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LonghuanggameViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longhuanggameview.prefab"
	}
end

function LonghuanggameViewPresentor:buildViews()
	return {
		LonghuanggameView.New()
	}
end

return LonghuanggameViewPresentor
