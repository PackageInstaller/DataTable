-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syxixi/view/SyXiXi2ViewPresentor.lua

module("logic.extensions.SyXiXi.view.SyXiXi2ViewPresentor", package.seeall)

local SyXiXi2ViewPresentor = class("SyXiXi2ViewPresentor", ViewPresentor)

function SyXiXi2ViewPresentor:ctor()
	SyXiXi2ViewPresentor.super.ctor(self)
end

function SyXiXi2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SyXiXi2ViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/syxixi/syxxlevels2view.prefab"
	}
end

function SyXiXi2ViewPresentor:buildViews()
	return {
		SyXiXi2View.New()
	}
end

return SyXiXi2ViewPresentor
