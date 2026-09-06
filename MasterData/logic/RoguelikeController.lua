-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/controller/RoguelikeController.lua

module("logic.extensions.roguelike.controller.RoguelikeController", package.seeall)

local RoguelikeController = class("RoguelikeController", BaseController)

function RoguelikeController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.RoguelikeNotifyFightResultRes, self._onNotifyFightResultRes, self)
	GlobalDispatcher:addListener(GlobalNotify.RoguelikeReShuffleDropBuffRes, self._onReShuffleDropBuffRes, self)
end

function RoguelikeController:_onNotifyFightResultRes(msg, activityId, phaseId)
	local isCanContinue = RoguelikeModel.instance:isCanContinueFight(activityId, phaseId)

	if not isCanContinue then
		UIJumper.instance:pushOneStack(ViewName.RoguelikemainView, true)
		UIJumper.instance:pushOneStack(ViewName.RoguelikelevelView, true, activityId, phaseId)

		local isNormalFight = RoguelikeModel.instance:isNormalFight(activityId, phaseId)

		if isNormalFight then
			local var_2_0 = RoguelikeModel.instance:isPassAllNormalLevel(activityId, phaseId)

			if not var_2_0 then
				var_2_0 = RoguelikeModel.instance:isPassAllExtraLevel(activityId, phaseId)

				local isPassed = var_2_0

				if not isPassed then
					if isNormalFight then
						RoguelikeController.instance:openNormalMissionView(activityId, phaseId, true)
						printInfo("test _onNotifyFightResultRes", activityId, phaseId, RoguelikeModel.instance:isNeedSelectBuff(activityId, phaseId))

						if RoguelikeModel.instance:isNeedSelectBuff(activityId, phaseId) then
							UIJumper.instance:pushOneStack(ViewName.RoguelikeselectbuffView, true, activityId, phaseId, isNormalFight)
						end
					else
						RoguelikeController.instance:openExtraMissionView(activityId, phaseId, true)
					end
				end
			end
		end
	end
end

function RoguelikeController:_onReShuffleDropBuffRes(activityId, phaseId)
	local isNormal = not RoguelikeModel.instance:isPassAllNormalLevel(activityId, phaseId)
	local isRefresh = true

	UIStateManager.instance:push(ViewName.RoguelikeselectbuffView, activityId, phaseId, isNormal, isRefresh)
end

function RoguelikeController:openNormalMissionView(activityId, phaseId, isUiJumper)
	local fmtMo = RoguelikeModel.instance:getNormalFmtMo(activityId)

	fmtMo:initParams(activityId, phaseId)

	if isUiJumper then
		UIJumper.instance:pushOneStack(ViewName.CustomMissionView, true, fmtMo)
	else
		CustomFmtController.instance:showMissionView(fmtMo)

		if RoguelikeModel.instance:isNeedSelectBuff(activityId, phaseId) then
			local isNormal = true

			UIStateManager.instance:push(ViewName.RoguelikeselectbuffView, activityId, phaseId, isNormal)
		end
	end
end

function RoguelikeController:openExtraMissionView(activityId, phaseId, isUiJumper)
	local fmtMo = RoguelikeModel.instance:getExtraFmtMo(activityId)

	fmtMo:initParams(activityId, phaseId)

	if isUiJumper then
		UIJumper.instance:pushOneStack(ViewName.CustomMissionView, true, fmtMo)
	else
		CustomFmtController.instance:showMissionView(fmtMo)

		if RoguelikeModel.instance:isNeedSelectBuff(activityId, phaseId) then
			local isNormal = false

			UIStateManager.instance:push(ViewName.RoguelikeselectbuffView, activityId, phaseId, isNormal)
		end
	end
end

function RoguelikeController:startBattle(activityId, phaseId, form)
	self._battleCount = 0
	self._activityId = activityId
	self._phaseId = phaseId

	BattleFacade.instance:startRoguelikeBattle()
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Roguelike)
	RoguelikeAgent.instance:sendPM_RoguelikeStartFightReq(activityId, phaseId, form)
end

function RoguelikeController:tryNextBattle()
	local isCanContinue = RoguelikeModel.instance:isCanContinueFight(self._activityId, self._phaseId)

	if isCanContinue then
		self:reqNextBattle()

		return true
	end

	return false
end

function RoguelikeController:isCanNextBattle()
	return self._battleCount > 0
end

function RoguelikeController:reqNextBattle()
	self._battleCount = self._battleCount + 1

	RoguelikeAgent.instance:sendPM_RoguelikeContunieFightReq(self._activityId, self._phaseId)
end

function RoguelikeController:getTargetBuffCount(activityId, phaseId, stageId, isNormal)
	local buffCount = 0

	if isNormal then
		local cfgNormalStages = RoguelikeConfig.instance:getNormalStageList(activityId, phaseId)

		for i, v in ipairs(cfgNormalStages) do
			if stageId > v.stageId and v.dropBuffPlanId > 0 then
				buffCount = buffCount + 1
			end
		end
	else
		local cfgExtraStages = RoguelikeConfig.instance:getExtStageList(activityId, phaseId)

		for i, v in ipairs(cfgExtraStages) do
			if v.dropBuffPlanId > 0 then
				buffCount = buffCount + 1
			end
		end
	end

	return buffCount
end

function RoguelikeController:onClickRefreshBuff(activityId, phaseId)
	local isNormal = not RoguelikeModel.instance:isPassAllNormalLevel(activityId, phaseId)

	if isNormal then
		local var_11_0 = RoguelikeModel.instance:getNormalPassNum(activityId, phaseId)

		if not var_11_0 then
			var_11_0 = RoguelikeModel.instance:getExtraPassNum(activityId, phaseId)

			local maxStageId = var_11_0
			local buffCount = RoguelikeController.instance:getTargetBuffCount(activityId, phaseId, maxStageId + 1, isNormal)

			printInfo("test RoguelikebufflookView:_onClickRefresh", buffCount, activityId, phaseId, maxStageId + 1, isNormal)

			if buffCount > 0 then
				local cfgPhase = RoguelikeConfig.instance:getPhaseCfg(activityId, phaseId)

				if isNormal then
					local matType, id, matNum = MaterialMgr.getMatParams(cfgPhase.normalResetDropBuffCost or cfgPhase.extResetDropBuffCost)
					local content = string.format("确定要花费%d%s洗牌么？", matNum, MaterialMgr.getMaterialsName(matType, id))

					TipsFacade.instance:openPopupCostMatViewNew(matType, id, matNum, content, function()
						RoguelikeAgent.instance:sendPM_RoguelikeReShuffleDropBuffReq(activityId, phaseId)
					end)
				end
			else
				FloatWordMgr.instance:show("无掉落buff")
			end
		end
	end
end

function RoguelikeController:getGlobalBuffDegradeReturn(activityId, buffId, buffLv)
	local list = RoguelikeConfig.instance:getGlobalBuffLvList(activityId, buffId)
	local matType, id, matNum = 0, 0, 0

	if list then
		for i, v in ipairs(list) do
			if not string.nilorempty(v.degradeReturn) and buffLv >= v.buffLvl then
				local var_13_0, var_13_1, var_13_2 = MaterialMgr.getMatParams(v.degradeReturn)

				id = var_13_1
				matType = var_13_0
				matNum = matNum + var_13_2
			end
		end
	end

	return matType, id, matNum
end

function RoguelikeController:getNormalStartStageId(activityId, phaseId, curStageId)
	local stageList = RoguelikeConfig.instance:getNormalStageList(activityId, phaseId)
	local targetStageId = 1
	local isRefresh = false

	for i, v in ipairs(stageList) do
		if isRefresh then
			isRefresh = false
			targetStageId = v.stageId
		end

		if curStageId > v.stageId and v.dropBuffPlanId > 0 then
			isRefresh = true
		end
	end

	return targetStageId
end

function RoguelikeController:getExtremeStartStageId(activityId, phaseId, curStageId)
	local stageList = RoguelikeConfig.instance:getExtStageList(activityId, phaseId)
	local targetStageId = 1
	local isRefresh = false

	for i, v in ipairs(stageList) do
		if isRefresh then
			isRefresh = false
			targetStageId = v.stageId
		end

		if curStageId > v.stageId and v.dropBuffPlanId > 0 then
			isRefresh = true
		end
	end

	return targetStageId
end

RoguelikeController.instance = RoguelikeController.New()

return RoguelikeController
