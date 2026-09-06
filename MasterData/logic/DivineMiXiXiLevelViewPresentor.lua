-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemixixi/view/DivineMiXiXiLevelViewPresentor.lua

module("logic.extensions.divinemixixi.view.DivineMiXiXiLevelViewPresentor", package.seeall)

local DivineMiXiXiLevelViewPresentor = class("DivineMiXiXiLevelViewPresentor", ViewPresentor)

function DivineMiXiXiLevelViewPresentor:ctor()
	DivineMiXiXiLevelViewPresentor.super.ctor(self)
end

function DivineMiXiXiLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiXiXiLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemixixi/divinemixixilevelview.prefab"
	}
end

function DivineMiXiXiLevelViewPresentor:buildViews()
	return {
		DivineMiXiXiLevelView.New()
	}
end

return DivineMiXiXiLevelViewPresentor
