-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WarriormaintowerPresentor.lua

module("logic.extensions.warriortower.view.WarriormaintowerPresentor", package.seeall)

local WarriormaintowerPresentor = class("WarriormaintowerPresentor", ViewPresentor)

function WarriormaintowerPresentor:ctor()
	WarriormaintowerPresentor.super.ctor(self)
end

function WarriormaintowerPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WarriormaintowerPresentor:dependWhatResources()
	return {
		"ui/views/warriortower/warriormaintowerview.prefab"
	}
end

function WarriormaintowerPresentor:buildViews()
	return {
		WarriormaintowerView.New()
	}
end

return WarriormaintowerPresentor
