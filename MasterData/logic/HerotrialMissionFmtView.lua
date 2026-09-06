-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialMissionFmtView.lua

module("logic.extensions.herotrial.view.HerotrialMissionFmtView", package.seeall)

local HerotrialMissionFmtView = class("HerotrialMissionFmtView", MissionFmtView)

function HerotrialMissionFmtView:onEnter()
	HerotrialMissionFmtView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HeroTrialGetInfo, self._refreshFromation, self)
end

function HerotrialMissionFmtView:onExit()
	HerotrialMissionFmtView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HeroTrialGetInfo, self._refreshFromation, self)
end

function HerotrialMissionFmtView:_getCreepCos()
	local activityId = HerotrialModel.instance:getActivityId()
	local bossId = HerotrialConfig.instance:getHeroTrialActivity(activityId).bossId
	local bossCfg = HerotrialConfig.instance:getBossCfgById(bossId)

	return (HerotrialConfig.instance:getBossCreepsById(bossCfg.creepsMasterId))
end

function HerotrialMissionFmtView:_getMonsterCo()
	local activityId = HerotrialModel.instance:getActivityId()
	local bossId = HerotrialConfig.instance:getHeroTrialActivity(activityId).bossId

	return (HerotrialConfig.instance:getBossCfgById(bossId))
end

function HerotrialMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return HerotrialMissionFmtView
