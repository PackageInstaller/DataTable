-- chunkname: @modules/logic/towercompose/rpc/TowerComposeRpc.lua

module("modules.logic.towercompose.rpc.TowerComposeRpc", package.seeall)

local TowerComposeRpc = class("TowerComposeRpc", BaseRpc)

function TowerComposeRpc:onInit()
	return
end

function TowerComposeRpc:reInit()
	return
end

function TowerComposeRpc:sendTowerComposeGetInfoRequest(reset, callback, callbackObj)
	local req = TowerComposeModule_pb.TowerComposeGetInfoRequest()

	req.reset = reset or false

	return self:sendMsg(req, callback, callbackObj)
end

function TowerComposeRpc:onReceiveTowerComposeGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		TowerComposeModel.instance:onReceiveTowerComposeGetInfoReply(msg.info)
	end
end

function TowerComposeRpc:sendTowerComposeSetModsRequest(themeId, allModInfoList, callback, callbackObj)
	local req = TowerComposeModule_pb.TowerComposeSetModsRequest()

	req.themeId = themeId

	for planeId, modInfoList in ipairs(allModInfoList) do
		local planeMods = TowerComposeModule_pb.TowerComposePlaneMods()

		planeMods.planeId = planeId

		for modType, modDataList in ipairs(modInfoList) do
			local modsList = TowerComposeModule_pb.TowerComposeMods()

			modsList.type = modType

			for _, modData in ipairs(modDataList) do
				local modSlotData = TowerComposeModule_pb.TowerComposeMod()

				modSlotData.slot = modData.slot
				modSlotData.modId = modData.modId

				table.insert(modsList.mods, modSlotData)
			end

			table.insert(planeMods.mods, modsList)
		end

		table.insert(req.planeMods, planeMods)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function TowerComposeRpc:onReceiveTowerComposeSetModsReply(resultCode, msg)
	if resultCode == 0 then
		TowerComposeModel.instance:onReceiveTowerComposeSetModsReply(msg)
	end

	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.SetPlaneMods)
end

function TowerComposeRpc:onReceiveTowerComposeResearchProgressUpdatePush(resultCode, msg)
	if resultCode == 0 then
		TowerComposeModel.instance:updateThemeProgress(msg.themeId, msg.progress)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.ResearchProgressUpdate)
	end
end

function TowerComposeRpc:onReceiveTowerComposeUnlockModsPush(resultCode, msg)
	if resultCode == 0 then
		TowerComposeModel.instance:updateUnlockModIds(msg)
	end
end

function TowerComposeRpc:onReceiveTowerComposeFightSettlePush(resultCode, msg)
	if resultCode == 0 then
		TowerComposeModel.instance:onReceiveTowerBattleFinishPush(msg)
		TowerComposeModel.instance:onReceiveTowerComposeFightSettlePush(msg)
	end
end

function TowerComposeRpc:sendTowerComposeUpdateRecordRequest(themeId, isUpdate)
	local req = TowerComposeModule_pb.TowerComposeUpdateRecordRequest()

	req.themeId = themeId
	req.update = isUpdate

	return self:sendMsg(req)
end

function TowerComposeRpc:onReceiveTowerComposeUpdateRecordReply(resultCode, msg)
	if resultCode == 0 then
		TowerComposeModel.instance:updateTowercomposeRecordBossData(msg.themeId, msg.record)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.UpdateRecordReply, msg)
	end
end

function TowerComposeRpc:sendTowerComposeLoadRecordRequest(themeId)
	local req = TowerComposeModule_pb.TowerComposeLoadRecordRequest()

	req.themeId = themeId

	return self:sendMsg(req)
end

function TowerComposeRpc:onReceiveTowerComposeLoadRecordReply(resultCode, msg)
	if resultCode == 0 then
		TowerComposeModel.instance:updateTowercomposeRecordBossData(msg.themeId, msg.record)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.LoadRecordReply)
	end
end

function TowerComposeRpc:sendTowerComposeReChallengeRequest(themeId, planeId)
	local req = TowerComposeModule_pb.TowerComposeReChallengeRequest()

	req.themeId = themeId
	req.planeId = planeId

	return self:sendMsg(req)
end

function TowerComposeRpc:onReceiveTowerComposeReChallengeReply(resultCode, msg)
	if resultCode == 0 then
		TowerComposeModel.instance:updateTowerComposeBossData(msg.themeId, msg.boss)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.RefreshLoadState)
	end
end

function TowerComposeRpc:sendTowerComposeCancelReChallengeRequest(themeId)
	local req = TowerComposeModule_pb.TowerComposeCancelReChallengeRequest()

	req.themeId = themeId

	return self:sendMsg(req)
end

function TowerComposeRpc:onReceiveTowerComposeCancelReChallengeReply(resultCode, msg)
	if resultCode == 0 then
		TowerComposeModel.instance:updateTowerComposeBossData(msg.themeId, msg.boss)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.RefreshLoadState)
		GameFacade.showToast(ToastEnum.TowerComposeExitRecord)
	end
end

TowerComposeRpc.instance = TowerComposeRpc.New()

return TowerComposeRpc
