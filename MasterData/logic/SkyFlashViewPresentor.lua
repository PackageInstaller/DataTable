-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/SkyFlashViewPresentor.lua

module("logic.extensions.lottery.view.paladin.SkyFlashViewPresentor", package.seeall)

local SkyFlashViewPresentor = class("SkyFlashViewPresentor", ViewPresentor)

function SkyFlashViewPresentor:ctor()
	SkyFlashViewPresentor.super.ctor(self)
end

function SkyFlashViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkyFlashViewPresentor:dependWhatResources()
	return {
		"ui/views/paladinlottery/skyflashview.prefab"
	}
end

function SkyFlashViewPresentor:buildViews()
	return {
		SkyFlashView.New()
	}
end

return SkyFlashViewPresentor
