-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syxixi/view/SyXiXi3ViewPresentor.lua

module("logic.extensions.SyXiXi.view.SyXiXi3ViewPresentor", package.seeall)

local SyXiXi3ViewPresentor = class("SyXiXi3ViewPresentor", ViewPresentor)

function SyXiXi3ViewPresentor:ctor()
	SyXiXi3ViewPresentor.super.ctor(self)
end

function SyXiXi3ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SyXiXi3ViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/syxixi/syxxlevels3view.prefab"
	}
end

function SyXiXi3ViewPresentor:buildViews()
	return {
		SyXiXi3View.New()
	}
end

return SyXiXi3ViewPresentor
