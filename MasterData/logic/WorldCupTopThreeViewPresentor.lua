-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupTopThreeViewPresentor.lua

module("logic.extensions.worldcup.view.WorldCupTopThreeViewPresentor", package.seeall)

local WorldCupTopThreeViewPresentor = class("WorldCupTopThreeViewPresentor", ViewPresentor)

function WorldCupTopThreeViewPresentor:ctor()
	WorldCupTopThreeViewPresentor.super.ctor(self)
end

function WorldCupTopThreeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldCupTopThreeViewPresentor:dependWhatResources()
	return {
		"ui/views/worldcup/worldcuptopthreeview.prefab"
	}
end

function WorldCupTopThreeViewPresentor:buildViews()
	return {
		WorldCupTopThreeView.New()
	}
end

return WorldCupTopThreeViewPresentor
