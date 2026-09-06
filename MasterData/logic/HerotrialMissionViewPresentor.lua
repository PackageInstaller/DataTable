-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialMissionViewPresentor.lua

module("logic.extensions.herotrial.view.HerotrialMissionViewPresentor", package.seeall)

local HerotrialMissionViewPresentor = class("HerotrialMissionViewPresentor", MissionViewPresentor)

HerotrialMissionViewPresentor.itemExpPet = "ui/views/herotrial/item_herotrial.prefab"

function HerotrialMissionViewPresentor:ctor()
	HerotrialMissionViewPresentor.super.ctor(self)
end

function HerotrialMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HerotrialMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		HerotrialMissionViewPresentor.itemExpPet,
		self:_addCommonRes()
	}
end

function HerotrialMissionViewPresentor:buildViews()
	return {
		HerotrialMissionView.New(),
		HerotrialFmtRightView.New(),
		HerotrialFmtLeftView.New(),
		HerotrialMissionFmtView.New()
	}
end

function HerotrialMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HerotrialMissionViewPresentor
