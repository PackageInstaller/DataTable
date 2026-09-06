-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/controller/SwordStormController.lua

module("logic.extensions.swordstorm.controller.SwordStormController", package.seeall)

local SwordStormController = class("SwordStormController", BaseController)

function SwordStormController:onInit()
	self:onReset()
end

function SwordStormController:onReset()
	return
end

function SwordStormController:openNormalMissionView(activityId, phaseId, stageId)
	local fmtMo = SwordStormModel.instance:getFmtMo()

	fmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function SwordStormController:handlePM_SwordStormGetInfoRes(msg)
	SwordStormModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SwordStormGetInfoRes)
end

function SwordStormController:handlePM_Notify_SwordStormChallengeResultRes(msg)
	if checknumber(msg.changeSetId) > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	local stageCfg = SwordStormConfig.instance:getStageCfg(msg.activityId, msg.phaseId, msg.stageId)
	local conditionCfgs = SwordStormConfig.instance:getConditionPlanCfgs(stageCfg.conditionPlanId)
	local hasAddCondition = false
	local reachCache = {}

	for i, v in ipairs(conditionCfgs) do
		local content = self:getConditionDesc(v.conditionPlanId, v.conditionId)
		local isReachBefore = SwordStormModel.instance:getConditionComplete(msg.activityId, msg.phaseId, msg.stageId, v.conditionId)
		local isReach = false
		local score = 0

		for j, conditionInfo in ipairs(msg.curReachConditions) do
			if conditionInfo.conditionId == v.conditionId then
				isReach = conditionInfo.reach
				score = checknumber(conditionInfo.score)
			end
		end

		content = langPara("%s(实际伤害：%s)", content, score)

		if not isReachBefore then
			BattleSettlementController.instance:addConditionElement(content, isReach)

			hasAddCondition = true
		else
			table.insert(reachCache, {
				content = content,
				isReach = isReach
			})
		end
	end

	if not hasAddCondition then
		for i, v in ipairs(reachCache) do
			BattleSettlementController.instance:addConditionElement(v.content, v.isReach)
		end

		BattleSettlementController.instance:addConditionElement(reachCache[1].content, reachCache[1].isReach)
	end

	BattleFacade.instance:registerResultHandler(function()
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)

		return true
	end)
end

function SwordStormController:getConditionDesc(conditionPlanId, conditionId)
	local conditionCfg = SwordStormConfig.instance:getConditionCfg(conditionPlanId, conditionId)
	local targetPetCfg = CharacterConfig.instance:getPetCo(conditionCfg.enemyRaceId)
	local scoreArr = string.split(conditionCfg.scoreRange, "-")
	local downLimit = checknumber(scoreArr[1])
	local upLimit = checknumber(scoreArr[2])

	return (langPara("%s回合内，对%s造成伤害%s到%s之间", conditionCfg.circleLimit, targetPetCfg.name, MmUtil.formatNumber(downLimit, MmUtil.Units_CN, 1), MmUtil.formatNumber(upLimit, MmUtil.Units_CN, 1)))
end

SwordStormController.instance = SwordStormController.New()

return SwordStormController
