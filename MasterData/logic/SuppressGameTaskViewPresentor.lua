-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/SuppressGameTaskViewPresentor.lua

module("logic.extensions.suppressgame.view.PowerLandTaskViewPresentor", package.seeall)

local PowerLandTaskViewPresentor = class("PowerLandTaskViewPresentor", ViewPresentor)

function PowerLandTaskViewPresentor:ctor()
	PowerLandTaskViewPresentor.super.ctor(self)
end

function PowerLandTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PowerLandTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/suppressgame/suppressgametaskview.prefab"
	}
end

function PowerLandTaskViewPresentor:buildViews()
	return {
		SuppressGameTaskView.New()
	}
end

return PowerLandTaskViewPresentor
