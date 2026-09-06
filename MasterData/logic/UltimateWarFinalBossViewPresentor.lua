-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarFinalBossViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarFinalBossViewPresentor", package.seeall)

local UltimateWarFinalBossViewPresentor = class("UltimateWarFinalBossViewPresentor", ViewPresentor)

function UltimateWarFinalBossViewPresentor:ctor()
	UltimateWarFinalBossViewPresentor.super.ctor(self)
end

function UltimateWarFinalBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarFinalBossViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewarfinalbossview.prefab"
	}
end

function UltimateWarFinalBossViewPresentor:buildViews()
	return {
		UltimateWarFinalBossView.New()
	}
end

return UltimateWarFinalBossViewPresentor
