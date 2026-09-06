-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerRecordViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerRecordViewPresentor", package.seeall)

local UltimateWarTowerRecordViewPresentor = class("UltimateWarTowerRecordViewPresentor", ViewPresentor)

function UltimateWarTowerRecordViewPresentor:ctor()
	UltimateWarTowerRecordViewPresentor.super.ctor(self)
end

function UltimateWarTowerRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarTowerRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewartowerrecordview.prefab"
	}
end

function UltimateWarTowerRecordViewPresentor:buildViews()
	return {
		UltimateWarTowerRecordView.New()
	}
end

return UltimateWarTowerRecordViewPresentor
