-- chunkname: @modules/logic/rouge2/outside/rpc/Rouge2OutsideRpc.lua

module("modules.logic.rouge2.outside.rpc.Rouge2OutsideRpc", package.seeall)

local Rouge2OutsideRpc = class("Rouge2OutsideRpc", BaseRpc)

function Rouge2OutsideRpc:sendGetRouge2OutsideInfoRequest(callback, callbackObj)
	local req = Rouge2OutsideModule_pb.GetRouge2OutsideInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2OutsideRpc:onReceiveGetRouge2OutsideInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local outsideInfo = msg.outsideInfo

	Rouge2_OutsideModel.instance:updateRougeOutsideInfo(outsideInfo)
	Rouge2_TalentModel.instance:updateInfo(outsideInfo)
	Rouge2_StoreModel.instance:updateInfo(outsideInfo)
	Rouge2_AlchemyModel.instance:updateInfo(outsideInfo.alchemyInfo)
end

function Rouge2OutsideRpc:sendRouge2ActiveGeniusRequest(geniusId, callback, callbackObj)
	local req = Rouge2OutsideModule_pb.Rouge2ActiveGeniusRequest()

	req.geniusId = geniusId

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2OutsideRpc:onReceiveRouge2ActiveGeniusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local geniusId = msg.geniusId
	local geniusIds = msg.geniusIds

	Rouge2_TalentModel.instance:onActiveTalentNode(geniusId, geniusIds)
	Rouge2_StatController.instance:statUpgradeOutsideTalent(geniusId)
end

function Rouge2OutsideRpc:sendRouge2RewardRequest(id, num, callback, callbackObj)
	local req = Rouge2OutsideModule_pb.Rouge2RewardRequest()

	req.id = id
	req.num = num

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2OutsideRpc:onReceiveRouge2RewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local goodsInfo = msg.goodsInfo
	local num = msg.num

	Rouge2_StoreModel.instance:onBuyGoodsSuccess(goodsInfo, num)
end

function Rouge2OutsideRpc:onReceiveRouge2UpdateRewardPointPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rewardPoint = msg.rewardPoint

	Rouge2_StoreModel.instance:refreshPoint(rewardPoint)
end

function Rouge2OutsideRpc:sendRouge2AlchemyRequest(formula, subMaterial, callback, callbackObj)
	local req = Rouge2OutsideModule_pb.Rouge2AlchemyRequest()

	req.formula = formula

	tabletool.addValues(req.subMaterial, subMaterial)
	self:sendMsg(req, callback, callbackObj)
end

function Rouge2OutsideRpc:onReceiveRouge2AlchemyReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local alchemyInfo = msg.alchemyInfo
	local spEventNum = msg.spEventNum
	local returnMaterial = msg.returnMaterial
	local subExtraEffect = msg.subExtraEffect
	local mainUpdateEffect = msg.mainUpdateEffect

	Rouge2_OutsideController.instance:onAlchemySuccess(alchemyInfo, spEventNum, returnMaterial, subExtraEffect, mainUpdateEffect)
end

function Rouge2OutsideRpc:sendRouge2CancelAlchemyRequest(callback, callbackObj)
	local req = Rouge2OutsideModule_pb.Rouge2CancelAlchemyRequest()

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2OutsideRpc:onReceiveRouge2CancelAlchemyReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local alchemyInfo = msg.alchemyInfo

	Rouge2_OutsideController.instance:onAlchemyCancelReply(alchemyInfo)
end

function Rouge2OutsideRpc:sendRouge2GetUnlockCollectionsRequest(callback, callbackObj)
	local req = Rouge2OutsideModule_pb.Rouge2GetUnlockCollectionsRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2OutsideRpc:onReceiveRouge2GetUnlockCollectionsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local unlockRelicsIds = msg.unlockRelicsIds
	local unlockBuffIds = msg.unlockBuffIds
	local unlockActiveSkillIds = msg.unlockActiveSkillIds

	Rouge2_OutsideModel.instance:onGetCollectionInfo(unlockRelicsIds, unlockBuffIds, unlockActiveSkillIds)
end

function Rouge2OutsideRpc:onReceiveRouge2UpdateGeniusPointPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local geniusPoint = msg.geniusPoint

	Rouge2_TalentModel.instance:updateTalentUpdatePoint(geniusPoint)
end

function Rouge2OutsideRpc:sendRouge2SaveContextRequest(index)
	local req = Rouge2OutsideModule_pb.Rouge2SaveContextRequest()

	req.index = index

	return self:sendMsg(req)
end

function Rouge2OutsideRpc:onReceiveRouge2SaveContextReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_OutsideModel.instance:updateBossBattleInfo(msg.bossBattleInfo)
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnSaveRecordDone)
end

function Rouge2OutsideRpc:sendRouge2BossRewardRequest(bossId)
	local req = Rouge2OutsideModule_pb.Rouge2BossRewardRequest()

	req.bossId = bossId

	return self:sendMsg(req)
end

function Rouge2OutsideRpc:onReceiveRouge2BossRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_OutsideModel.instance:updateBossBattleInfo(msg.bossBattleInfo)
end

function Rouge2OutsideRpc:sendRouge2ChoiceSaveRequest(index)
	local req = Rouge2OutsideModule_pb.Rouge2ChoiceSaveRequest()

	req.index = index

	return self:sendMsg(req)
end

function Rouge2OutsideRpc:onReceiveRouge2ChoiceSaveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_OutsideModel.instance:updateBossBattleInfo(msg.bossBattleInfo)
end

Rouge2OutsideRpc.instance = Rouge2OutsideRpc.New()

return Rouge2OutsideRpc
