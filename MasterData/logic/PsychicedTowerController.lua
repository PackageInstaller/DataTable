-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/controller/PsychicedTowerController.lua

module("logic.extensions.psychicedtower.controller.PsychicedTowerController", package.seeall)

local PsychicedTowerController = class("PsychicedTowerController", BaseController)

function PsychicedTowerController:onInit()
	self:onReset()
end

function PsychicedTowerController:onReset()
	return
end

function PsychicedTowerController:handlePM_PsychicedTowerInfoRes(msg)
	PsychicedTowerModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PsychicedTowerInfoRes)
end

function PsychicedTowerController:sendPM_PsychicedTowerChallengeReq(activityId, towerId, stageId, form)
	local chooseData = PsychicedTowerModel.instance:getChooseBuff()
	local buffs = {}

	for i, v in ipairs(chooseData) do
		local buff = PsychicedTowerExtension_pb.PsychicedTowerBuff()

		buff.buffType = v.buffType
		buff.level = v.buffLevel

		table.insert(buffs, buff)
	end

	PsychicedTowerAgent.instance:sendPM_PsychicedTowerChallengeReq(activityId, towerId, stageId, buffs, form)
end

function PsychicedTowerController:handlePM_NotifyPsychicedTowerChallengeFinishRes(msg)
	if msg.isWin == true then
		PsychicedTowerModel.instance:saveStageInfo(msg)
	end

	if msg.changeSetId ~= nil then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyPsychicedTowerChallengeFinishRes)
end

function PsychicedTowerController:handlePM_PsychicedTowerGainBuffRes(msg)
	PsychicedTowerModel.instance:saveGainDailyBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PsychicedTowerGainBuffRes)
end

function PsychicedTowerController:handlePM_PsychicedTowerRankInfoRes(msg)
	PsychicedTowerModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PsychicedTowerRankInfoRes)
end

function PsychicedTowerController:handlePM_PsychicedTowerTotalRankInfoRes(msg)
	PsychicedTowerModel.instance:saveTotalRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PsychicedTowerRankInfoRes)
end

PsychicedTowerController.instance = PsychicedTowerController.New()

return PsychicedTowerController
