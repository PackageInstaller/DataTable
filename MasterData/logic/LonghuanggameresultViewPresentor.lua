-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longhuang/LonghuanggameresultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longhuang.LonghuanggameresultViewPresentor", package.seeall)

local LonghuanggameresultViewPresentor = class("LonghuanggameresultViewPresentor", ViewPresentor)

function LonghuanggameresultViewPresentor:ctor()
	LonghuanggameresultViewPresentor.super.ctor(self)
end

function LonghuanggameresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LonghuanggameresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longhuanggameresultview.prefab"
	}
end

function LonghuanggameresultViewPresentor:buildViews()
	return {
		LonghuanggameresultView.New()
	}
end

return LonghuanggameresultViewPresentor
