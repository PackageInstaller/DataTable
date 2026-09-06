-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/TianmanKingController.lua

module("logic.extensions.timelimitedchallenge.controller.TianmanKingController", package.seeall)

local TianmanKingController = class("TianmanKingController", BaseController)

TianmanKingController.PM_TMWCGetSummonsInfoRes = "TianmanKingController.PM_TMWCGetSummonsInfoRes"
TianmanKingController.PM_TMWCGetChallengeInfoRes = "TianmanKingController.PM_TMWCGetChallengeInfoRes"
TianmanKingController.PM_TMWCGetSingleChallengeInfoRes = "TianmanKingController.PM_TMWCGetSingleChallengeInfoRes"
TianmanKingController.PM_TMWCSetFormRes = "TianmanKingController.PM_TMWCSetFormRes"
TianmanKingController.PM_TMWCBuyChallengeTimesRes = "TianmanKingController.PM_TMWCBuyChallengeTimesRes"
TianmanKingController.PM_TMWCSelectSummonRes = "TianmanKingController.PM_TMWCSelectSummonRes"
TianmanKingController.PM_TMWCGainProgressPrizeRes = "TianmanKingController.PM_TMWCGainProgressPrizeRes"

function TianmanKingController:onInit()
	TianmanKingController.super.onInit(self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self)
end

function TianmanKingController:onReset()
	TianmanKingController.super.onReset(self)

	self._battleType = nil
end

function TianmanKingController:handlePM_TMWCGetSummonsInfoRes(msg)
	TianmanKingModel.instance:setTimeOpenPassedStage(msg.timeOpenPassedStage)
	TianmanKingModel.instance:setCurSummon(msg.curSummon)
	GlobalDispatcher:dispatch(TianmanKingController.PM_TMWCGetSummonsInfoRes, msg)
end

function TianmanKingController:handlePM_TMWCGetChallengeInfoRes(msg)
	TianmanKingModel.instance:setTimeOpenPassedStage(msg.timeOpenPassedStage)
	TianmanKingModel.instance:setCurSummon(msg.curSummon)
	TianmanKingModel.instance:setLinearPassedStage(msg.linearPassedStage)
	GlobalDispatcher:dispatch(TianmanKingController.PM_TMWCGetChallengeInfoRes, msg)
end

function TianmanKingController:handlePM_TMWCGetSingleChallengeInfoRes(msg)
	TianmanKingModel.instance:setTimeOpenPassedStage(msg.timeOpenPassedStage)
	GlobalDispatcher:dispatch(TianmanKingController.PM_TMWCGetSingleChallengeInfoRes, msg)
end

function TianmanKingController:sendPM_TMWCChallengeStageReq(challengeType, challengeId)
	self._sendChallengeType = challengeType
	self._sendChallengeId = challengeId
	self._battleType = challengeType

	TianManWangChallengeAgent.instance:sendPM_TMWCChallengeStageReq(challengeType, challengeId)
end

function TianmanKingController:handlePM_TMWCChallengeStageRes()
	TianmanKingModel.instance:setBattleChallengeTypeAndId(self._sendChallengeType, self._sendChallengeId)

	self._sendChallengeType = nil
	self._sendChallengeId = nil
end

function TianmanKingController:handlePM_TMWCGainProgressPrizeRes()
	GlobalDispatcher:dispatch(TianmanKingController.PM_TMWCGainProgressPrizeRes)
end

function TianmanKingController:_onSceneLoadedFinish()
	if self._battleType and SceneMgr.instance:getCurSceneType() ~= SceneType.Battle then
		UIStateManager.instance:push(ViewName.TianmankingmainView)
		UIStateManager.instance:push(ViewName.TianmankingView)

		if self._battleType == 1 then
			UIStateManager.instance:push(ViewName.CangmuqianyeView)
		elseif self._battleType == 2 then
			UIStateManager.instance:push(ViewName.SenluowanxiangView)
		elseif self._battleType == 3 then
			UIStateManager.instance:push(ViewName.ZhanjuebahuangView)
		end

		self._battleType = nil
	end
end

function TianmanKingController:sendPM_TMWCSelectSummonReq(summonId)
	self._sendSummonId = summonId

	TianManWangChallengeAgent.instance:sendPM_TMWCSelectSummonReq(summonId)
end

function TianmanKingController:handlePM_TMWCSelectSummonRes()
	TianmanKingModel.instance:setCurSummon(self._sendSummonId)
	GlobalDispatcher:dispatch(TianmanKingController.PM_TMWCSelectSummonRes)
end

function TianmanKingController:handlePM_TMWCGetFormRes(msg)
	local formMo = FormationMO.New(function(id)
		return BagPetsController.instance:getPet(id) or TianmanKingModel.instance:getPetMo(id)
	end)

	formMo:SetData(msg.form)
	TianmanKingModel.instance:saveForm(formMo)
end

function TianmanKingController:handlePM_TMWCSetForm(msg)
	local formMo = FormationMO.New(function(id)
		return BagPetsController.instance:getPet(id) or TianmanKingModel.instance:getPetMo(id)
	end)

	formMo:SetData(msg.form)
	TianmanKingModel.instance:saveForm(formMo)
	GlobalDispatcher:dispatch(TianmanKingController.PM_TMWCSetFormRes)
end

function TianmanKingController:getText(key, ...)
	local params = {
		...
	}

	if #params == 0 then
		return TianmanKingConfig.instance:getTextByKey(key)
	else
		return string.format(TianmanKingConfig.instance:getTextByKey(key), ...)
	end
end

function TianmanKingController:getProgressInfo(progress)
	local progressPrize = TianmanKingConfig.instance:getProgressPrize()

	for i = #progressPrize, 1, -1 do
		local value = progressPrize[i]

		if progress <= value.hpPercent / 100 then
			local info = clone(value)

			if info.prizeId ~= 4 then
				info.bubble = self:getText("TEXT_" .. 19 + info.prizeId)
			end

			return info
		end
	end
end

function TianmanKingController:onSenluoFightFinish(msg)
	TianmanKingModel.instance:setIsWin(msg.isWin)

	if msg.isWin then
		TianmanKingModel.instance:setLinearPassedStage(msg.stage)
	end
end

TianmanKingController.instance = TianmanKingController.New()

return TianmanKingController
