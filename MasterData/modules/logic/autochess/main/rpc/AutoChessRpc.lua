-- chunkname: @modules/logic/autochess/main/rpc/AutoChessRpc.lua

module("modules.logic.autochess.main.rpc.AutoChessRpc", package.seeall)

local AutoChessRpc = class("AutoChessRpc", BaseRpc)

function AutoChessRpc:sendAutoChessGetSceneRequest(moduleId)
	local req = AutoChessModule_pb.AutoChessGetSceneRequest()

	req.moduleId = moduleId

	self:sendMsg(req)
end

function AutoChessRpc:onReceiveAutoChessGetSceneReply(resultCode, msg)
	return
end

function AutoChessRpc:sendAutoChessEnterSceneRequest(activityId, moduleId, episodeId, masterId)
	self.episodeId = episodeId

	local req = AutoChessModule_pb.AutoChessEnterSceneRequest()

	req.activityId = activityId
	req.moduleId = moduleId
	req.episodeId = episodeId
	req.masterId = masterId

	self:sendMsg(req)
end

function AutoChessRpc:onReceiveAutoChessEnterSceneReply(resultCode, msg)
	if resultCode == 0 then
		AutoChessModel.instance:onEnterScene(msg.moduleId, msg.scene, msg.activityId)
		AutoChessController.instance:enterGame(self.episodeId)
	end

	self.episodeId = nil
end

function AutoChessRpc:sendAutoChessEnterFightRequest(moduleId)
	local req = AutoChessModule_pb.AutoChessEnterFightRequest()

	req.moduleId = moduleId

	self:sendMsg(req)
end

function AutoChessRpc:onReceiveAutoChessEnterFightReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo()

	mo:cacheSvrFight()
	mo:updateSvrTurn(msg.turn)
	mo:updateSvrMall(msg.mall)
	mo:updateSvrBaseInfo(msg.baseInfo)
	AutoChessController.instance:playStep(AutoChessEnum.ActionType.EndBuy)
end

function AutoChessRpc:sendAutoChessBuyChessRequest(moduleId, mallId, itemUid, warZoneId, position)
	local req = AutoChessModule_pb.AutoChessBuyChessRequest()

	req.moduleId = moduleId
	req.mallId = mallId
	req.itemUid = itemUid
	req.warZoneId = warZoneId
	req.position = position

	self:sendMsg(req)
end

function AutoChessRpc:onReceiveAutoChessBuyChessReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo()

	mo:updateSvrTurn(msg.turn)
	mo:updateSvrMall(msg.mall)
	mo:updateSvrBaseInfo(msg.baseInfo)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.BuyChessReply)
end

function AutoChessRpc:sendAutoChessBuildRequest(moduleId, type, fromWarZoneId, fromPosition, fromUid, toWarZoneId, toPosition, toUid, extraParam)
	local req = AutoChessModule_pb.AutoChessBuildRequest()

	req.moduleId = moduleId
	req.type = type
	req.fromWarZoneId = fromWarZoneId
	req.fromPosition = fromPosition
	req.fromUid = fromUid
	req.toWarZoneId = toWarZoneId or 0
	req.toPosition = toPosition or 0
	req.toUid = toUid or 0
	req.extraParam = extraParam or 0

	self:sendMsg(req)
end

function AutoChessRpc:onReceiveAutoChessBuildReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo()

	mo:updateSvrTurn(msg.turn)
	mo:updateSvrMall(msg.mall)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.BuildReply)
end

function AutoChessRpc:sendAutoChessRefreshMallRequest(moduleId, callback, callbackObj)
	local req = AutoChessModule_pb.AutoChessRefreshMallRequest()

	req.moduleId = moduleId

	self:sendMsg(req, callback, callbackObj)
end

function AutoChessRpc:onReceiveAutoChessRefreshMallReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo()

	mo:updateSvrMall(msg.mall)
	mo:updateSvrTurn(msg.turn)
end

function AutoChessRpc:sendAutoChessFreezeItemRequest(moduleId, mallId, itemUid, type, callback, callbackObj)
	local req = AutoChessModule_pb.AutoChessFreezeItemRequest()

	req.moduleId = moduleId
	req.mallId = mallId
	req.itemUid = itemUid
	req.type = type

	self:sendMsg(req, callback, callbackObj)
end

function AutoChessRpc:onReceiveAutoChessFreezeItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo()

	mo.mall:fixLockStatus(msg.mallId, msg.type)
end

function AutoChessRpc:sendAutoChessMallRegionSelectItemRequest(moduleId, itemId)
	self.select = itemId ~= 0

	local req = AutoChessModule_pb.AutoChessMallRegionSelectItemRequest()

	req.moduleId = moduleId
	req.itemId = itemId

	self:sendMsg(req)
end

function AutoChessRpc:onReceiveAutoChessMallRegionSelectItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo()

	mo.mall:updateSvrMallRegion(msg.region)

	if self.select then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ForcePickReply)

		self.select = nil
	end
end

function AutoChessRpc:sendAutoChessUseMasterSkillRequest(moduleId, skillId, chessUid)
	local req = AutoChessModule_pb.AutoChessUseMasterSkillRequest()

	req.moduleId = moduleId
	req.skillId = skillId
	req.targetUid = chessUid or 0

	self:sendMsg(req)
end

function AutoChessRpc:onReceiveAutoChessUseMasterSkillReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo()

	mo:updateSvrTurn(msg.turn)
	mo.fight.mySideMaster:updateMasterSkill(msg.skill)
end

function AutoChessRpc:sendAutoChessPreviewFightRequest(moduleId, callback, callbackObj)
	local req = AutoChessModule_pb.AutoChessPreviewFightRequest()

	req.moduleId = moduleId

	self:sendMsg(req, callback, callbackObj)
end

function AutoChessRpc:onReceiveAutoChessPreviewFightReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo()

	mo:previewChange()
end

function AutoChessRpc:sendAutoChessGiveUpRequest(moduleId, callback, callbackObj)
	local req = AutoChessModule_pb.AutoChessGiveUpRequest()

	req.moduleId = moduleId

	self:sendMsg(req, callback, callbackObj)
end

function AutoChessRpc:onReceiveAutoChessGiveUpReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo(true)

	if mo then
		mo:clearData()
	end
end

function AutoChessRpc:onReceiveAutoChessScenePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo()

	mo:init(msg.scene)
end

function AutoChessRpc:onReceiveAutoChessRoundSettlePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AutoChessModel.instance:svrResultData(msg)
end

function AutoChessRpc:onReceiveAutoChessSettlePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AutoChessModel.instance:svrSettleData(msg)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.SettlePush)
end

function AutoChessRpc:sendAutoChessEnterFriendFightSceneRequest(activityId, moduleId, userId)
	local req = AutoChessModule_pb.AutoChessEnterFriendFightSceneRequest()

	req.activityId = activityId
	req.moduleId = moduleId
	req.userId = userId

	self:sendMsg(req)
end

function AutoChessRpc:onReceiveAutoChessEnterFriendFightSceneReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AutoChessModel.instance:onEnterScene(msg.moduleId, msg.scene, msg.activityId)

	local mo = AutoChessModel.instance:getSceneMo()

	if mo then
		mo:updateSvrTurn(msg.turn)
		mo:cacheSvrFight()
		AutoChessController.instance:enterSingleGame()
	end
end

function AutoChessRpc:sendAutoChessUseSkillRequest(moduleId, chessUid)
	local req = AutoChessModule_pb.AutoChessUseSkillRequest()

	req.moduleId = moduleId
	req.chessUid = chessUid

	self:sendMsg(req)
end

function AutoChessRpc:onReceiveAutoChessUseSkillReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = AutoChessModel.instance:getSceneMo()

	if mo then
		mo:updateSvrTurn(msg.turn)
	end
end

AutoChessRpc.instance = AutoChessRpc.New()

return AutoChessRpc
