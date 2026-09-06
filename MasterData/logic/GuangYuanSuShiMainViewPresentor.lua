-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/guangyuansushi/GuangYuanSuShiMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.guangyuansushi.GuangYuanSuShiMainViewPresentor", package.seeall)

local GuangYuanSuShiMainViewPresentor = class("GuangYuanSuShiMainViewPresentor", ViewPresentor)

function GuangYuanSuShiMainViewPresentor:ctor()
	GuangYuanSuShiMainViewPresentor.super.ctor(self)
end

function GuangYuanSuShiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuangYuanSuShiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/guangyuansushi/guangyuansushimainview.prefab"
	}
end

function GuangYuanSuShiMainViewPresentor:buildViews()
	return {
		GuangYuanSuShiMainView.New()
	}
end

return GuangYuanSuShiMainViewPresentor
