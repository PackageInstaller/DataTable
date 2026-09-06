-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/Xjlevels1ViewPresentor.lua

module("logic.extensions.xingjiang.view.Xjlevels1ViewPresentor", package.seeall)

local Xjlevels1ViewPresentor = class("Xjlevels1ViewPresentor", ViewPresentor)

function Xjlevels1ViewPresentor:ctor()
	Xjlevels1ViewPresentor.super.ctor(self)
end

function Xjlevels1ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Xjlevels1ViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingjiang/xjlevels1view.prefab"
	}
end

function Xjlevels1ViewPresentor:buildViews()
	return {
		Xjlevels1View.New()
	}
end

return Xjlevels1ViewPresentor
