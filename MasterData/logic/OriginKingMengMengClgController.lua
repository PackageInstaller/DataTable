-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/controller/OriginKingMengMengClgController.lua

module("logic.extensions.originkingmengmengclg.controller.OriginKingMengMengClgController", package.seeall)

local OriginKingMengMengClgController = class("OriginKingMengMengClgController", BaseController)

function OriginKingMengMengClgController:onInit()
	return
end

function OriginKingMengMengClgController:onReset()
	return
end

function OriginKingMengMengClgController:sendPM_OriginKingMengMengClgGetInfoReq(activityId)
	OriginKingMengMengClgAgent.instance:sendPM_OriginKingMengMengClgGetInfoReq(activityId)
end

function OriginKingMengMengClgController:handlePM_OriginKingMengMengClgGetInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginKingMengMengClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingMengMengClgGetInfoRes)
end

function OriginKingMengMengClgController:sendPM_OriginKingMengMengClgExtremeFightReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local mo = self:getSubMo(activityId)
		local msg = mo:getExtremeFightResult()

		if msg and msg.isWin then
			local fmtMo = OriginKingMengMengClgModel.instance:getExtremeFmtMo(activityId)

			UIStateManager.instance:push(ViewName.OriginKingMengMengClgExtremeResultView, msg, fmtMo)

			return true
		end

		return false
	end)
	OriginKingMengMengClgAgent.instance:sendPM_OriginKingMengMengClgExtremeFightReq(activityId, stageId, form)
end

function OriginKingMengMengClgController:handlePM_OriginKingMengMengClgExtremeFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingMengMengClgExtremeFightRes, msg)
end

function OriginKingMengMengClgController:handlePM_OriginKingMengMengClgExtremeFightNotifyRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginKingMengMengClgExtremeFightNotifyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingMengMengClgExtremeFightNotifyRes, msg)
end

function OriginKingMengMengClgController:sendPM_OriginKingMengMengClgBossFightReq(activityId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local mo = self:getSubMo(activityId)
		local msg = mo:getBossFightResult()

		if msg then
			local fmtMo = OriginKingMengMengClgModel.instance:getBossFmtMo(activityId)

			UIStateManager.instance:push(ViewName.OriginKingMengMengClgNormalResultView, msg, fmtMo)

			return true
		end

		return false
	end)
	OriginKingMengMengClgAgent.instance:sendPM_OriginKingMengMengClgBossFightReq(activityId, form)
end

function OriginKingMengMengClgController:handlePM_OriginKingMengMengClgBossFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingMengMengClgBossFightRes, msg)
end

function OriginKingMengMengClgController:handlePM_OriginKingMengMengClgBossFightNotifyRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginKingMengMengClgBossFightNotifyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingMengMengClgBossFightNotifyRes, msg)
end

function OriginKingMengMengClgController:sendPM_OriginKingMengMengClgConfirmReq(activityId, stageId, save)
	OriginKingMengMengClgAgent.instance:sendPM_OriginKingMengMengClgConfirmReq(activityId, stageId, save)
end

function OriginKingMengMengClgController:handlePM_OriginKingMengMengClgConfirmRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_OriginKingMengMengClgConfirmRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingMengMengClgConfirmRes, status, msg)
end

function OriginKingMengMengClgController:sendPM_OriginKingMengMengClgNormalFightReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local mo = self:getSubMo(activityId)
		local msg = mo:getNormalFightResult()

		if msg and msg.isWin then
			local fmtMo = self:_getNormalResultFmtMo(activityId, msg)

			UIStateManager.instance:push(ViewName.OriginKingMengMengClgNormalResultView, msg, fmtMo)

			return true
		end

		return false
	end)
	OriginKingMengMengClgAgent.instance:sendPM_OriginKingMengMengClgNormalFightReq(activityId, stageId, form)
end

function OriginKingMengMengClgController:handlePM_OriginKingMengMengClgNormalFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingMengMengClgNormalFightRes, msg)
end

function OriginKingMengMengClgController:handlePM_OriginKingMengMengClgNormalFightNotifyRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginKingMengMengClgNormalFightNotifyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingMengMengClgNormalFightNotifyRes, msg)
end

function OriginKingMengMengClgController:sendPM_OriginKingMengMengClgResetReq(activityId, stageId)
	OriginKingMengMengClgAgent.instance:sendPM_OriginKingMengMengClgResetReq(activityId, stageId)
end

function OriginKingMengMengClgController:handlePM_OriginKingMengMengClgResetRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginKingMengMengClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingMengMengClgResetRes, msg)
end

function OriginKingMengMengClgController:getSubMo(activityId)
	return OriginKingMengMengClgModel.instance:getSubMo(activityId)
end

function OriginKingMengMengClgController:_getNormalResultFmtMo(activityId, msg)
	if msg.stageId == -1 then
		return OriginKingMengMengClgModel.instance:getNormalBossFmtMo(activityId)
	end

	return OriginKingMengMengClgModel.instance:getNormalFmtMo(activityId)
end

function OriginKingMengMengClgController:getStageRecommendRaceIdList(activityId, stageId)
	local stageData = OriginKingMengMengClgConfig.instance:getStageData(activityId, stageId)
	local strs = string.split(stageData.mustOnFormPetFilter, "$")
	local result = {}

	if strs[1] == OriginKingMengMengClgEnum.StageRecommendPetFilter.Signs then
		local petList = PetbookModel.instance:getAllPetList()

		for _, petData in ipairs(petList) do
			local raceId = petData.raceId

			if self:checkPetIsValidStageRecommendPet(raceId) and self:checkPetHasStageRecommendSigns(raceId, strs[2]) then
				table.insert(result, raceId)
			end
		end
	end

	return result
end

function OriginKingMengMengClgController:checkPetIsValidStageRecommendPet(raceId)
	local petCfg = CharacterConfig.instance:getPetCo(raceId)

	return petCfg and PetbookModel.instance:getIsHandBookPet(petCfg)
end

function OriginKingMengMengClgController:checkPetHasStageRecommendSigns(raceId, sign)
	return CharacterConfig.instance:checkHasSigns(raceId, sign)
end

function OriginKingMengMengClgController:enterBattleNormal(activityId, stageId)
	local fmtMo = OriginKingMengMengClgModel.instance:getNormalFmtMo(activityId)

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginKingMengMengClgController:enterBattleNormalBoss(activityId)
	local fmtMo = OriginKingMengMengClgModel.instance:getNormalBossFmtMo(activityId)

	fmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginKingMengMengClgController:enterBattleExtreme(activityId, stageId)
	local fmtMo = OriginKingMengMengClgModel.instance:getExtremeFmtMo(activityId)

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginKingMengMengClgController:enterBattleBoss(activityId)
	local fmtMo = OriginKingMengMengClgModel.instance:getBossFmtMo(activityId)

	fmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

OriginKingMengMengClgController.instance = OriginKingMengMengClgController.New()

return OriginKingMengMengClgController
