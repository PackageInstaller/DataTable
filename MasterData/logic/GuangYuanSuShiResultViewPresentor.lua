-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/guangyuansushi/GuangYuanSuShiResultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.guangyuansushi.GuangYuanSuShiResultViewPresentor", package.seeall)

local GuangYuanSuShiResultViewPresentor = class("GuangYuanSuShiResultViewPresentor", ViewPresentor)

function GuangYuanSuShiResultViewPresentor:ctor()
	GuangYuanSuShiResultViewPresentor.super.ctor(self)
end

function GuangYuanSuShiResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuangYuanSuShiResultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/guangyuansushi/guangyuansushiresultview.prefab"
	}
end

function GuangYuanSuShiResultViewPresentor:buildViews()
	return {
		GuangYuanSuShiResultView.New()
	}
end

return GuangYuanSuShiResultViewPresentor
