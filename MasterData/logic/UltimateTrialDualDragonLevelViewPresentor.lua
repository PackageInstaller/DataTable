-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/view/UltimateTrialDualDragonLevelViewPresentor.lua

module("logic.extensions.divinedualdragonclg.view.UltimateTrialDualDragonLevelViewPresentor", package.seeall)

local UltimateTrialDualDragonLevelViewPresentor = class("UltimateTrialDualDragonLevelViewPresentor", ViewPresentor)

function UltimateTrialDualDragonLevelViewPresentor:ctor()
	UltimateTrialDualDragonLevelViewPresentor.super.ctor(self)
end

function UltimateTrialDualDragonLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateTrialDualDragonLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedualdragonclg/divinedualdragonclglevelview.prefab"
	}
end

function UltimateTrialDualDragonLevelViewPresentor:buildViews()
	return {
		UltimateTrialDualDragonLevelView.New()
	}
end

return UltimateTrialDualDragonLevelViewPresentor
