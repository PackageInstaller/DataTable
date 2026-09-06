-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/Xjlevels2ViewPresentor.lua

module("logic.extensions.xingjiang.view.Xjlevels2ViewPresentor", package.seeall)

local Xjlevels2ViewPresentor = class("Xjlevels2ViewPresentor", ViewPresentor)

function Xjlevels2ViewPresentor:ctor()
	Xjlevels2ViewPresentor.super.ctor(self)
end

function Xjlevels2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Xjlevels2ViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingjiang/xjlevels2view.prefab"
	}
end

function Xjlevels2ViewPresentor:buildViews()
	return {
		Xjlevels2View.New()
	}
end

return Xjlevels2ViewPresentor
