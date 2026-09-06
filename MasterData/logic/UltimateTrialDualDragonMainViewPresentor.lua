-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/view/UltimateTrialDualDragonMainViewPresentor.lua

module("logic.extensions.divinedualdragonclg.view.UltimateTrialDualDragonMainViewPresentor", package.seeall)

local UltimateTrialDualDragonMainViewPresentor = class("UltimateTrialDualDragonMainViewPresentor", ViewPresentor)

function UltimateTrialDualDragonMainViewPresentor:ctor()
	UltimateTrialDualDragonMainViewPresentor.super.ctor(self)
end

function UltimateTrialDualDragonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateTrialDualDragonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedualdragonclg/divinedualdragonclgmainview.prefab"
	}
end

function UltimateTrialDualDragonMainViewPresentor:buildViews()
	return {
		UltimateTrialDualDragonMainView.New()
	}
end

return UltimateTrialDualDragonMainViewPresentor
