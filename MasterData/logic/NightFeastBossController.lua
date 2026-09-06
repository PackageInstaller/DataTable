-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/controller/NightFeastBossController.lua

module("logic.extensions.nightfeastbosschallenge.controller.NightFeastBossController", package.seeall)

local NightFeastBossController = class("NightFeastBossController", BaseController)

function NightFeastBossController:onReset()
	self._lastActivityId = 0
	self._lastBossId = 0
end

function NightFeastBossController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.NightFeastBossClgFight4BuffRes, self._onFightNormalRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NightFeastBossClgFightBossRes, self._onFightBossRes, self)
	self:onReset()
end

function NightFeastBossController:_onFightNormalRes()
	local activityId = self._lastActivityId

	UIJumper.instance:pushOneStack(ViewName.NightFeastBossSwitchView, true, activityId)
	UIJumper.instance:pushOneStack(ViewName.NightFeastBossLevelView, true, activityId)

	self._lastActivityId = 0
end

function NightFeastBossController:_onFightBossRes(activityId)
	local activityId = self._lastActivityId

	UIJumper.instance:pushOneStack(ViewName.NightFeastBossSwitchView, true, activityId)

	local params = {}

	params.curFightDamage = NightFeastBossModel.instance:getCurFightDamage(activityId)
	params.curTotalDamage = NightFeastBossModel.instance:getTotalDamage(activityId)
	params.maxBossHp = self:getMaxBossHp(activityId)
	params.maxBossHp = self:getMaxBossHp(activityId, self._lastBossId)
	params.conditionStr = "累计伤害："

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.NightFeastBoss, params)

	self._lastActivityId = 0
	self._lastBossId = 0
end

function NightFeastBossController:getMaxBossHp(activityId, bossId)
	local bossCfg = NightFeastBossConfig.instance:getBossCfg(activityId, bossId)
	local maxBossHp = 0

	if bossCfg then
		local cfgs = NightFeastBossConfig.instance:getProgressList(bossCfg.prizePlanId)

		maxBossHp = checknumber(cfgs[#cfgs].progress)
	end

	return maxBossHp
end

function NightFeastBossController:playStoryOnce(storyId)
	local key = ViewName.NightFeastBossMainView .. storyId

	GameUtil.getUserData(key, function(value)
		if checknumber(value) == 0 then
			if storyId > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
			end

			GameUtil.saveUserData(key, 1)
		end
	end)
end

function NightFeastBossController:playStory(storyId)
	GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
end

function NightFeastBossController:openCommonMissionView(activityId, stageId)
	local customFmtMo = NightFeastBossModel.instance:getNormalCustomFmtMo(activityId)

	customFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function NightFeastBossController:openBossMissionView(activityId, bossId)
	local customFmtMo = NightFeastBossModel.instance:getBossCustomFmtMo(activityId)

	customFmtMo:initParams(activityId, bossId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function NightFeastBossController:openResultView(activityId)
	UIStateManager.instance:push(ViewName.NightFeastBossResultView, activityId)
end

function NightFeastBossController:getCurrentBossId(activityId)
	local bossId = 1
	local cfgs = NightFeastBossConfig.instance:getBossCfgsList(activityId)

	if cfgs then
		for _, cfg in ipairs(cfgs) do
			if GameUtil.checkIsInTimePeriod(cfg.openTime, cfg.endTime) then
				bossId = cfg.bossId

				break
			end
		end
	end

	return bossId
end

function NightFeastBossController:saveLastActivityId(activityId)
	self._lastActivityId = activityId
end

function NightFeastBossController:saveLastBossId(bossId)
	self._lastBossId = bossId
end

NightFeastBossController.instance = NightFeastBossController.New()

return NightFeastBossController
