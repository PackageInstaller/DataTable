-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/controller/FemalePsychicController.lua

module("logic.extensions.femalepsychic.controller.FemalePsychicController", package.seeall)

local FemalePsychicController = class("FemalePsychicController", BaseController)

function FemalePsychicController:onInit()
	self:onReset()
end

function FemalePsychicController:onReset()
	return
end

function FemalePsychicController:sendPM_FemalePsychicChallengeInfoReq(activityId)
	FemalePsychicChallengeAgent.instance:sendPM_FemalePsychicChallengeInfoReq(activityId)
end

function FemalePsychicController:handlePM_FemalePsychicChallengeInfoRes(status, msg)
	FemalePsychicModel.instance:setChallengeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FemalePsychicChallengeInfoRes)
end

function FemalePsychicController:isUnLockLevel(layerId, levelId)
	if levelId <= 1 then
		return true
	end

	local score = FemalePsychicModel.instance:getCurLevelScore(layerId, levelId)

	return self:isPassLevel(layerId, levelId - 1) and score == 0
end

function FemalePsychicController:isPassLevel(layerId, levelId)
	if levelId <= 1 then
		return FemalePsychicModel.instance:getCurLevelScore(layerId, levelId) > 0
	end

	return FemalePsychicModel.instance:getCurLevelScore(layerId, levelId) > FemalePsychicModel.instance:getCurLevelScore(layerId, levelId - 1)
end

function FemalePsychicController:levelState(layerId, levelId)
	if self:isPassLevel(layerId, levelId) then
		return 4
	elseif not self:isUnLockLevel(layerId, levelId) then
		return 1
	elseif self:isUnLockLevel(layerId, levelId) then
		return 2
	end

	return 1
end

function FemalePsychicController:sendPM_FemalePsychicChallengeReq(activityId, challengeId, stageId, form)
	FemalePsychicChallengeAgent.instance:sendPM_FemalePsychicChallengeReq(activityId, challengeId, stageId, form)
end

function FemalePsychicController:handlePM_FemalePsychicChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FemalePsychicChallengeRes)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function FemalePsychicController:sendPM_FemalePsychicChallengeConformResultReq(activityId, conform)
	FemalePsychicChallengeAgent.instance:sendPM_FemalePsychicChallengeConformResultReq(activityId, conform)
end

function FemalePsychicController:handlePM_FemalePsychicChallengeConformResultRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.FemalePsychicChallengeConformResultRes)
end

function FemalePsychicController:handlePM_NotifyFemalePsychicChallengeFinishRes(status, msg)
	FemalePsychicModel.instance:setBatleResult(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
end

function FemalePsychicController:openFemalePsychicChallengeForm(activityId, challengeId, stageId)
	CustomFmtController.instance:showMissionView(FemalePsychicModel.instance:getChallengeFmtMo(activityId, challengeId, stageId))
end

function FemalePsychicController:openFantianChallengeForm(activityId, challengeId, stageId)
	local mo = FemalePsychicModel.instance:getChallengeFmtMo(activityId, challengeId, stageId)

	CustomFmtController.instance:showMissionView(mo)
end

function FemalePsychicController:fightResult(challengeId)
	local function handleBattleEnd()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local function comFunc()
			local battleInfo = FemalePsychicModel.instance:getBattleInfo()
			local battleResult = FemalePsychicModel.instance:getChallengeResult()

			if battleInfo.levelId == 1 then
				local nextLevelScore = FemalePsychicModel.instance:getCurLevelScore(battleInfo.layerId, battleInfo.levelId + 1)

				if nextLevelScore > 0 then
					if battleInfo.activityId == 253002 then
						UIJumper.instance:pushOneStack(ViewName.DivinefantianresultView, true)
					else
						UIJumper.instance:pushOneStack(ViewName.FemalePsychicResultView, true)
					end
				elseif battleResult.result == 4 then
					self:sendPM_FemalePsychicChallengeConformResultReq(battleInfo.activityId, true)
				end
			elseif battleInfo.levelId == #FemalePsychicModel:getCurLayerInfo(battleInfo.layerId) then
				if battleResult.result == 4 then
					self:sendPM_FemalePsychicChallengeConformResultReq(battleInfo.activityId, true)
				end
			elseif FemalePsychicModel.instance:isChallengeWin() and battleResult.result ~= 3 then
				if battleInfo.activityId == 253002 then
					UIJumper.instance:pushOneStack(ViewName.DivinefantianresultView, true)
				else
					UIJumper.instance:pushOneStack(ViewName.FemalePsychicResultView, true)
				end
			end

			if battleInfo.activityId == 253002 then
				UIJumper.instance:pushOneStack(ViewName.DivinefantianlevelView, true, battleInfo.activityId)
			else
				UIJumper.instance:pushOneStack(ViewName.FemalePsychicLevelView, true)
			end
		end

		local function succHandler()
			ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
			comFunc()
		end

		local function failHandler()
			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
			comFunc()
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

FemalePsychicController.instance = FemalePsychicController.New()

return FemalePsychicController
