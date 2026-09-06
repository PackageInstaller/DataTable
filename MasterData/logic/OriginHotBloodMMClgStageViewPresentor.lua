-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/view/OriginHotBloodMMClgStageViewPresentor.lua

module("logic.extensions.originhotbloodmmclg.view.OriginHotBloodMMClgStageViewPresentor", package.seeall)

local OriginHotBloodMMClgStageViewPresentor = class("OriginHotBloodMMClgStageViewPresentor", ViewPresentor)

function OriginHotBloodMMClgStageViewPresentor:ctor()
	OriginHotBloodMMClgStageViewPresentor.super.ctor(self)
end

function OriginHotBloodMMClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginHotBloodMMClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originhotbloodmmclg/originhotbloodmmclgstageview.prefab"
	}
end

function OriginHotBloodMMClgStageViewPresentor:buildViews()
	return {
		OriginHotBloodMMClgStageView.New()
	}
end

return OriginHotBloodMMClgStageViewPresentor
