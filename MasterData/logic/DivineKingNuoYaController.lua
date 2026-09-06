-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/controller/DivineKingNuoYaController.lua

module("logic.extensions.divinekingnuoya.controller.DivineKingNuoYaController", package.seeall)

local DivineKingNuoYaController = class("DivineKingNuoYaController", BaseController)

function DivineKingNuoYaController:ctor()
	return
end

function DivineKingNuoYaController:onInit()
	self:onReset()
end

function DivineKingNuoYaController:onReset()
	return
end

function DivineKingNuoYaController:getSkinId(activityId)
	return DivineKingNuoYaConfig.instance:getSkinId(activityId)
end

function DivineKingNuoYaController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function DivineKingNuoYaController:sendPM_DivineKingNoahClgGetInfoReq(activityId)
	DivineKingNuoYaAgent.instance:sendPM_DivineKingNoahClgGetInfoReq(activityId)
end

function DivineKingNuoYaController:handlePM_DivineKingNoahClgGetInfoRes(msg)
	DivineKingNuoYaModel.instance:handlePM_DivineKingNoahClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineKingNoahClgGetInfoRes)
end

function DivineKingNuoYaController:sendPM_DivineKingNoahClgSetBanItemsReq(activityId, banItemPosIds)
	DivineKingNuoYaAgent.instance:sendPM_DivineKingNoahClgSetBanItemsReq(activityId, banItemPosIds)
end

function DivineKingNuoYaController:handlePM_DivineKingNoahClgSetBanItemsRes(msg)
	DivineKingNuoYaModel.instance:handlePM_DivineKingNoahClgSetBanItemsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineKingNoahClgSetBanItemsRes)
end

function DivineKingNuoYaController:sendPM_DivineKingNoahClgFightReq(activityId, stageId, form)
	DivineKingNuoYaAgent.instance:sendPM_DivineKingNoahClgFightReq(activityId, stageId, form)
end

function DivineKingNuoYaController:handlePM_DivineKingNoahClgNotifyFightRes(msg)
	DivineKingNuoYaModel.instance:handlePM_DivineKingNoahClgNotifyFightRes(msg)
end

function DivineKingNuoYaController:enterBattleClg(activityId, stageId)
	local customFmtMo = DivineKingNuoYaModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineKingNuoYaController:getBuffProgress(activityId)
	local actCfg = DivineKingNuoYaConfig.instance:getActCfg(activityId)
	local planId = actCfg and actCfg.activityPlanId
	local planCfg = DivineKingNuoYaConfig.instance:getActPlanCfg(planId)
	local lightLineAddNum = planCfg and planCfg.lightLineBuffAddNum
	local darkLineAddNum = planCfg and planCfg.darkLineBuffAddNum
	local lightNum, darkNum = DivineKingNuoYaModel.instance:getLineCount(activityId)
	local value = lightNum * lightLineAddNum + darkNum * darkLineAddNum

	return Mathf.Min(value, DivineKingNuoYaModel.MaxBuffProgress)
end

function DivineKingNuoYaController:getBanData(activityId)
	local actCfg = DivineKingNuoYaConfig.instance:getActCfg(activityId)
	local actPlanId = actCfg and actCfg.activityPlanId
	local actPlanCfg = DivineKingNuoYaConfig.instance:getActPlanCfg(actPlanId)
	local banItemCount = actPlanCfg.banItemCount
	local info = DivineKingNuoYaModel.instance:getInfo(activityId)
	local banNum = checknumber(#info.banItemPosIds)
	local banItems = {}

	for idx = 1, banItemCount - banNum do
		table.insert(banItems, true)
	end

	for i = 1, banNum do
		table.insert(banItems, false)
	end

	return banItems
end

function DivineKingNuoYaController:getTotalBuffHistoryValue(activityId)
	local info = DivineKingNuoYaModel.instance:getInfo(activityId)
	local totalNum = 0

	for k, stageInfo in pairs(info.stageLists) do
		totalNum = totalNum + stageInfo.historyMaxVlaue
	end

	return totalNum
end

DivineKingNuoYaController.instance = DivineKingNuoYaController.New()

return DivineKingNuoYaController
