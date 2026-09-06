-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/guangyuansushi/GuangYuanSuShiDifficultyViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.guangyuansushi.GuangYuanSuShiDifficultyViewPresentor", package.seeall)

local GuangYuanSuShiDifficultyViewPresentor = class("GuangYuanSuShiDifficultyViewPresentor", ViewPresentor)

function GuangYuanSuShiDifficultyViewPresentor:ctor()
	GuangYuanSuShiDifficultyViewPresentor.super.ctor(self)
end

function GuangYuanSuShiDifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuangYuanSuShiDifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/guangyuansushi/guangyuansushidifficultyview.prefab"
	}
end

function GuangYuanSuShiDifficultyViewPresentor:buildViews()
	return {
		GuangYuanSuShiDifficultyView.New()
	}
end

return GuangYuanSuShiDifficultyViewPresentor
