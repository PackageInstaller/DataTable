-- chunkname: @modules/logic/tower/rpc/TowerDeepRpc.lua

module("modules.logic.tower.rpc.TowerDeepRpc", package.seeall)

local TowerDeepRpc = class("TowerDeepRpc", BaseRpc)

function TowerDeepRpc:onInit()
	return
end

function TowerDeepRpc:reInit()
	return
end

function TowerDeepRpc:sendTowerDeepGetInfoRequest(callback, callbackObj)
	local req = TowerDeepModule_pb.TowerDeepGetInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function TowerDeepRpc:onReceiveTowerDeepGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		TowerPermanentDeepModel.instance:onReceiveTowerDeepGetInfoReply(msg.info)
	end
end

function TowerDeepRpc:sendTowerDeepSaveArchiveRequest(archiveNo)
	local req = TowerDeepModule_pb.TowerDeepSaveArchiveRequest()

	req.archiveNo = archiveNo

	return self:sendMsg(req)
end

function TowerDeepRpc:onReceiveTowerDeepSaveArchiveReply(resultCode, msg)
	if resultCode == 0 then
		TowerPermanentDeepModel.instance:updateSaveGroupMo(msg.archive)
		TowerController.instance:dispatchEvent(TowerEvent.OnSaveTeamSuccess, msg.archive)
	end
end

function TowerDeepRpc:sendTowerDeepLoadArchiveRequest(archiveNo)
	local req = TowerDeepModule_pb.TowerDeepLoadArchiveRequest()

	req.archiveNo = archiveNo

	return self:sendMsg(req)
end

function TowerDeepRpc:onReceiveTowerDeepLoadArchiveReply(resultCode, msg)
	if resultCode == 0 then
		TowerPermanentDeepModel.instance:updateSaveGroupMo(msg.archive)
		TowerPermanentDeepModel.instance:updateCurGroupMo(msg.archive.group)
		TowerController.instance:dispatchEvent(TowerEvent.OnLoadTeamSuccess, msg.archive)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end
end

function TowerDeepRpc:sendTowerDeepResetRequest()
	local req = TowerDeepModule_pb.TowerDeepResetRequest()

	return self:sendMsg(req)
end

function TowerDeepRpc:onReceiveTowerDeepResetReply(resultCode, msg)
	if resultCode == 0 then
		TowerPermanentDeepModel.instance:updateCurGroupMo(msg.group)
		TowerController.instance:dispatchEvent(TowerEvent.OnTowerDeepReset)
	end
end

function TowerDeepRpc:onReceiveTowerDeepFightSettlePush(resultCode, msg)
	if resultCode == 0 then
		TowerPermanentDeepModel.instance:updateFightResult(msg)
	end
end

TowerDeepRpc.instance = TowerDeepRpc.New()

return TowerDeepRpc
