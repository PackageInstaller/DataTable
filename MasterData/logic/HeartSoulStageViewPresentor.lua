-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/heartsoul/HeartSoulStageViewPresentor.lua

module("logic.extensions.scenariocopy.view.heartsoul.HeartSoulStageViewPresentor", package.seeall)

local HeartSoulStageViewPresentor = class("HeartSoulStageViewPresentor", ViewPresentor)

function HeartSoulStageViewPresentor:ctor()
	HeartSoulStageViewPresentor.super.ctor(self)
end

function HeartSoulStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HeartSoulStageViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/xinxinniannian/xxnnstageview.prefab"
	}
end

function HeartSoulStageViewPresentor:buildViews()
	return {
		HeartSoulStageView.New()
	}
end

return HeartSoulStageViewPresentor
