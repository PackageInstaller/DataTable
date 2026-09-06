-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/controller/GodXiuerChallengeController.lua

module("logic.extensions.godxiuerchallenge.controller.GodXiuerChallengeController", package.seeall)

local GodXiuerChallengeController = class("GodXiuerChallengeController", BaseController)

function GodXiuerChallengeController:ctor()
	return
end

function GodXiuerChallengeController:onInit()
	return
end

function GodXiuerChallengeController:openTrueOrFalseChallengeForm(challengeId, id, stage, form)
	CustomFmtController.instance:showMissionView(GodXiuerChallengeModel.instance:getCustomTrueOrFalseFmtMo(challengeId, id, stage, form))
end

function GodXiuerChallengeController:openGoodOrEvilChallengeForm(challengeId, id)
	CustomFmtController.instance:showMissionView(GodXiuerChallengeModel.instance:getCustomGoodOrEvilFmtMo(challengeId, id))
end

function GodXiuerChallengeController:reqBuyOneKeyPass(challengeId)
	GodHyurChallengeAgent.instance:sendPM_GodHyurChallengeOneKeyPassReq(challengeId)
end

function GodXiuerChallengeController:isFinishLimitChallenge(challengeId)
	local limitChallengeInfos = GodXiuerChallengeModel.instance:getLimitChallengeInfos(challengeId)

	if not limitChallengeInfos then
		return false
	end

	local count = #limitChallengeInfos
	local maxLevel = 10

	if count < maxLevel then
		return false
	end

	local happyNum = 0
	local cryNum = 0

	for i, v in ipairs(limitChallengeInfos) do
		if v.num <= 0 then
			return false
		end

		if v.id >= 1 and v.id <= 5 then
			happyNum = happyNum + v.num
		end

		if v.id >= 6 and v.id <= 10 then
			cryNum = cryNum + v.num
		end
	end

	return Mathf.Abs(happyNum - cryNum) <= 1e-06
end

function GodXiuerChallengeController:isFinishWholePeopleChallenge(challengeId)
	local curScore = GodXiuerChallengeModel.instance:getScore(challengeId)
	local maxScore = GodXiuerChallengeModel.instance:getMaxScore(challengeId)

	return maxScore ~= 0 and maxScore <= curScore
end

function GodXiuerChallengeController:isFinishChallenge(challengeId)
	return self:isFinishWholePeopleChallenge(challengeId) or self:isFinishLimitChallenge(challengeId)
end

function GodXiuerChallengeController:showOneKeyReward(challengeId)
	local changeSetId = GodXiuerChallengeModel.instance:getOneKeyChangeSetId(challengeId)

	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

function GodXiuerChallengeController:_reductionView(challengeId)
	local cfg = GoodOrEvilChallengeConfig.instance:getCfgById(challengeId)

	UIJumper.instance:pushOneStack(ViewName.DivineEvolveEnterView, true)
	UIJumper.instance:pushOneStack(ViewName.DivineEvolveMainView, true, cfg.raceId)
	UIJumper.instance:pushOneStack(ViewName.GodXiuerMainView, true, challengeId)
end

function GodXiuerChallengeController:_addListener()
	GlobalDispatcher:addListener(GlobalNotify.GodHyurLimitChallengeOverlapRes, self._endBattle, self)
end

function GodXiuerChallengeController:_removeListener()
	GlobalDispatcher:removeListener(GlobalNotify.GodHyurLimitChallengeOverlapRes, self._endBattle, self)
end

function GodXiuerChallengeController:_endBattle()
	self:_removeListener()
	BattleController.instance:endBattle()
end

function GodXiuerChallengeController:fightResult(challengeId, viewName)
	local function handleBattleEnd()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local function succHandler()
			local isNotOpenConverWindow, oldNum, newNum, id = GodXiuerChallengeModel.instance:isLimitChallengeInfoSame(challengeId)

			self:_reductionView(challengeId)

			if isNotOpenConverWindow then
				GodXiuerChallengeModel.instance:updateDeltaLimitChallengeInfos(challengeId)
			end

			if viewName == ViewName.GodXiuerGoodOrEvilView and not self:isFinishLimitChallenge(challengeId) or viewName == ViewName.GodXiuerRightWrongView and not self:isFinishWholePeopleChallenge(challengeId) then
				UIJumper.instance:pushOneStack(viewName, true, challengeId)
			end

			if isNotOpenConverWindow or viewName ~= ViewName.GodXiuerGoodOrEvilView then
				ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
			else
				local title = lang("战斗结果")
				local text = string.format(langPara("godxiuer_1", oldNum, newNum))

				local function okFunc()
					GodHyurChallengeAgent.instance:sendPM_GodHyurLimitChallengeOverlapReq(challengeId, id, true)
					GodXiuerChallengeModel.instance:updateDeltaLimitChallengeInfos(challengeId)

					if self:isFinishLimitChallenge(challengeId) then
						UIJumper.instance:removeTopState(viewName)
					end

					self:_endBattle()
				end

				local function cencelFunc()
					GodHyurChallengeAgent.instance:sendPM_GodHyurLimitChallengeOverlapReq(challengeId, id, false)
					self:_endBattle()
				end

				TipsFacade.instance:openPopupWindow(title, text, okFunc, cencelFunc, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
			end
		end

		local function failHandler()
			self:_reductionView(challengeId)

			if viewName == ViewName.GodXiuerGoodOrEvilView and not self:isFinishLimitChallenge(challengeId) or viewName == ViewName.GodXiuerRightWrongView and not self:isFinishWholePeopleChallenge(challengeId) then
				UIJumper.instance:pushOneStack(viewName, true, challengeId)
			end

			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
		end

		if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
			succHandler()
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
			succHandler()
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
			failHandler()
		elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
			failHandler()
		end

		return true
	end

	BattleFacade.instance:registerResultHandler(GameUtil.handler(handleBattleEnd), self)
end

function GodXiuerChallengeController:getAvailableChallengeId()
	local challengeId = GodXiuerChallengeModel.EvolveChallengeId
	local cfg = GoodOrEvilChallengeConfig.instance:getCfgById(challengeId)
	local isFinishEvolveChallenge = DivineEvolveModel.instance:isFinishEvolveChallenge(challengeId)

	return (isFinishEvolveChallenge or nil) and (GodXiuerChallengeModel.NormalChallengeId or GodXiuerChallengeModel.EvolveChallengeId)
end

GodXiuerChallengeController.instance = GodXiuerChallengeController.New()

return GodXiuerChallengeController
