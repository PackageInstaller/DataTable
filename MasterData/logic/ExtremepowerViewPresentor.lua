-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/ExtremepowerViewPresentor.lua

module("logic.extensions.handbook.view.ExtremepowerViewPresentor", package.seeall)

local ExtremepowerViewPresentor = class("ExtremepowerViewPresentor", ViewPresentor)

function ExtremepowerViewPresentor:ctor()
	ExtremepowerViewPresentor.super.ctor(self)
end

function ExtremepowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExtremepowerViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/extremepowerview.prefab"
	}
end

function ExtremepowerViewPresentor:buildViews()
	return {
		ExtremepowerView.New()
	}
end

return ExtremepowerViewPresentor
