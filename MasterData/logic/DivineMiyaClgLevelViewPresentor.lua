-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/view/DivineMiyaClgLevelViewPresentor.lua

module("logic.extensions.divinemiyaclg.view.DivineMiyaClgLevelViewPresentor", package.seeall)

local DivineMiyaClgLevelViewPresentor = class("DivineMiyaClgLevelViewPresentor", ViewPresentor)

function DivineMiyaClgLevelViewPresentor:ctor()
	DivineMiyaClgLevelViewPresentor.super.ctor(self)
end

function DivineMiyaClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiyaClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemiyaclg/divinemiyaclglevelview.prefab"
	}
end

function DivineMiyaClgLevelViewPresentor:buildViews()
	return {
		DivineMiyaClgLevelView.New()
	}
end

return DivineMiyaClgLevelViewPresentor
