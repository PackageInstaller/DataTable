-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/Xjlevels3ViewPresentor.lua

module("logic.extensions.xingjiang.view.Xjlevels3ViewPresentor", package.seeall)

local Xjlevels3ViewPresentor = class("Xjlevels3ViewPresentor", ViewPresentor)

function Xjlevels3ViewPresentor:ctor()
	Xjlevels3ViewPresentor.super.ctor(self)
end

function Xjlevels3ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Xjlevels3ViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingjiang/xjlevels3view.prefab"
	}
end

function Xjlevels3ViewPresentor:buildViews()
	return {
		Xjlevels3View.New()
	}
end

return Xjlevels3ViewPresentor
