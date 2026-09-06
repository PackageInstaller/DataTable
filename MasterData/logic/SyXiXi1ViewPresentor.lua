-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syxixi/view/SyXiXi1ViewPresentor.lua

module("logic.extensions.SyXiXi.view.SyXiXi1ViewPresentor", package.seeall)

local SyXiXi1ViewPresentor = class("SyXiXi1ViewPresentor", ViewPresentor)

function SyXiXi1ViewPresentor:ctor()
	SyXiXi1ViewPresentor.super.ctor(self)
end

function SyXiXi1ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SyXiXi1ViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/syxixi/syxxlevels1view.prefab"
	}
end

function SyXiXi1ViewPresentor:buildViews()
	return {
		SyXiXi1View.New()
	}
end

return SyXiXi1ViewPresentor
