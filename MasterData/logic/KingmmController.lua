-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/controller/KingmmController.lua

module("logic.extensions.kingmengmeng.controller.KingmmController", package.seeall)

local KingmmController = class("KingmmController", BaseController)

function KingmmController:onInit()
	GlobalDispatcher:addListener("enterkingmmchallenge", self._enterKingmmChallenge, self)
end

function KingmmController:_enterKingmmChallenge(params)
	self:enterKingmmChallenge(checknumber(params[1]))
end

function KingmmController:enterKingmmChallenge(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.KingmmMainView, activityId)
end

function KingmmController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function KingmmController:getActivityType()
	return GameEnum.ActivityType.KingmmChallenge
end

function KingmmController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function KingmmController:regFightResultInExt(activityId)
	local function handleBattleEnd()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = self:getActivityType()

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end

		return false
	end

	BattleFacade.instance:registerResultHandler(GameUtil.handler(handleBattleEnd), self)
end

function KingmmController:getLevelDesc(activityId)
	local buffId = KingmmModel.instance:getBuffId()
	local formId = KingmmModel.instance:getFormCheckId()
	local conditionId = KingmmModel.instance:getConditionId()
	local strList = {}
	local cfgBuff = KingmmConfig.instance:getBuffCfg(activityId, buffId)

	if cfgBuff then
		table.insert(strList, "战场加成：" .. cfgBuff.des)
	end

	local cfgForm = FormationValidatorConfig.instance:getFormationValidatorCfg(formId)

	if cfgForm then
		table.insert(strList, "上阵要求：" .. cfgForm.desc)
	end

	local cfgCondition = KingmmConfig.instance:getConditionCfg(activityId, conditionId)

	if cfgCondition then
		table.insert(strList, "通关条件：" .. cfgCondition.passDesc)
	end

	local str = ""

	for i, v in ipairs(strList) do
		str = i < #strList and str .. v .. "\n" or str .. v
	end

	return str
end

function KingmmController:getMaxFeelNum(activityId)
	local cfgs = KingmmConfig.instance:getResetCfgList(activityId)

	return #cfgs
end

function KingmmController:openFeelView(activityId)
	local maxFeelNum = KingmmController.instance:getMaxFeelNum(activityId)
	local curTime = KingmmModel.instance:getTodayResetTimes()

	if maxFeelNum <= curTime then
		FloatWordMgr.instance:show(string.format("每天最多感知%d次", maxFeelNum))

		return
	end

	local cfg = KingmmConfig.instance:getResetCfg(activityId, curTime + 1)

	if not cfg then
		FloatWordMgr.instance:show("配置不存在 times =", curTime + 1)

		return
	end

	local matType, id, matNum = MaterialMgr.getMatParams(cfg.cost)
	local leftNum = maxFeelNum - curTime
	local content = string.format("是否花费%d%s重新感知一次\n今日剩余%d次", matNum, MaterialMgr.getMaterialsName(matType, id), leftNum)

	local function successCallBack()
		KingmmAgent.instance:sendPM_KMMChallengeResetRandomInfoReq(activityId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, id, matNum, content, successCallBack)
end

function KingmmController:openMissionView(activityId, formId, conditionId, formCheckId)
	local customFmtMo = KingmmModel.instance:getCustomFmtMo()

	customFmtMo:initParams(activityId, formId, conditionId, formCheckId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function KingmmController:openExtremeMissionView(activityId, challengeType, stageId, creepsMasterId)
	local customFmtMo = KingmmModel.instance:getExtremeCustomFmtMo()

	customFmtMo:initParams(activityId, challengeType, stageId, creepsMasterId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function KingmmController:getChallengeBuffTitle(challengeType)
	if challengeType == KingmmModel.ElementChallenge then
		return "元素加成"
	else
		return "王者加成"
	end
end

function KingmmController:getLevelTitle(challengeType)
	if challengeType == KingmmModel.ElementChallenge then
		return "元素集结"
	else
		return "王者守卫"
	end
end

function KingmmController:getChallengeBuffDesc(challengeType)
	if challengeType == KingmmModel.ElementChallenge then
		return "通关后我方在后续的战斗中将获得<color=#ffe14a>元素加成</color>"
	else
		return "通关可<color=#ffe14a>削弱</color>王者挑战中<color=#ffe14a>敌阵</color>的效果加成"
	end
end

KingmmController.instance = KingmmController.New()

return KingmmController
