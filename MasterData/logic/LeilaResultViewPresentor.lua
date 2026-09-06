-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/leila/LeilaResultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.leila.LeilaResultViewPresentor", package.seeall)

local LeilaResultViewPresentor = class("LeilaResultViewPresentor", ViewPresentor)

function LeilaResultViewPresentor:ctor()
	LeilaResultViewPresentor.super.ctor(self)
end

function LeilaResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LeilaResultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/anheimm/anheimmresultview.prefab"
	}
end

function LeilaResultViewPresentor:buildViews()
	return {
		LeilaResultView.New()
	}
end

return LeilaResultViewPresentor
