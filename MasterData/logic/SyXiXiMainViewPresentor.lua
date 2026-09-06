-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syxixi/view/SyXiXiMainViewPresentor.lua

module("logic.extensions.SyXiXi.view.SyXiXiMainViewPresentor", package.seeall)

local SyXiXiMainViewPresentor = class("SyXiXiMainViewPresentor", ViewPresentor)

function SyXiXiMainViewPresentor:ctor()
	SyXiXiMainViewPresentor.super.ctor(self)
end

function SyXiXiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SyXiXiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/syxixi/syxiximainview.prefab"
	}
end

function SyXiXiMainViewPresentor:buildViews()
	return {
		SyXiXiMainView.New()
	}
end

return SyXiXiMainViewPresentor
