-- chunkname: @modules/logic/versionactivity3_3/arcade/rpc/ArcadeOutSideRpc.lua

module("modules.logic.versionactivity3_3.arcade.rpc.ArcadeOutSideRpc", package.seeall)

local ArcadeOutSideRpc = class("ArcadeOutSideRpc", BaseRpc)

function ArcadeOutSideRpc:sendArcadeGetOutSideInfoRequest(callback, callbackObj)
	local req = ArcadeOutSideModule_pb.ArcadeGetOutSideInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeOutSideRpc:onReceiveArcadeGetOutSideInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	ArcadeOutSizeModel.instance:refreshInfo(info)
end

function ArcadeOutSideRpc:sendArcadeGamePlayerMOveRequest(x, y, callback, callbackObj)
	local req = ArcadeOutSideModule_pb.ArcadePlayerMoveRequest()

	if self._saveHeroGridX and self._saveHeroGridX == x and self._saveHeroGridY == y then
		return
	end

	self._saveHeroGridX = x
	self._saveHeroGridY = y
	req.x = x
	req.y = y

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeOutSideRpc:onReceiveArcadePlayerMoveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function ArcadeOutSideRpc:sendArcadeSwitchCharacterRequest(characterId, callback, callbackObj)
	local req = ArcadeOutSideModule_pb.ArcadeSwitchCharacterRequest()

	req.characterId = characterId

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeOutSideRpc:onReceiveArcadeSwitchCharacterReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local characterId = msg.characterId

	ArcadeController.instance:dispatchEvent(ArcadeEvent.OnEquipHero, characterId)
end

function ArcadeOutSideRpc:sendArcadeTalentUpgradeRequest(talentId, level, callback, callbackObj)
	local req = ArcadeOutSideModule_pb.ArcadeTalentUpgradeRequest()

	req.talentId = talentId
	req.level = level

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeOutSideRpc:onReceiveArcadeTalentUpgradeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local talentId = msg.talentId
	local level = msg.level

	ArcadeHeroModel.instance:setTalentLevel(talentId, level)
	ArcadeController.instance:dispatchEvent(ArcadeEvent.UpLevelTalent, talentId, level)
	ArcadeStatHelper.instance:sendTalentUpgrade(talentId, level)
end

function ArcadeOutSideRpc:sendArcadeGainRewardRequest(rewardId, callback, callbackObj)
	local req = ArcadeOutSideModule_pb.ArcadeGainRewardRequest()

	req.rewardId = rewardId

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeOutSideRpc:onReceiveArcadeGainRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ArcadeOutSizeModel.instance:onFinishReward()
	ArcadeController.instance:dispatchEvent(ArcadeEvent.OnGainReward)
end

function ArcadeOutSideRpc:sendArcadeInteractionRequest(interactionUid, option, callback, callbackObj)
	local req = ArcadeOutSideModule_pb.ArcadeInteractionRequest()

	req.interactionUid = interactionUid
	req.option = option

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeOutSideRpc:onReceiveArcadeInteractionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function ArcadeOutSideRpc:onReceiveArcadeAttrChangePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local attr = msg.attr

	ArcadeOutSizeModel.instance:refreshAttribute(attr)
	ArcadeController.instance:dispatchEvent(ArcadeEvent.OnReceiveArcadeAttrChangePush)
end

function ArcadeOutSideRpc:sendArcadeCloseRewardPanelRequest()
	local req = ArcadeOutSideModule_pb.ArcadeCloseRewardPanelRequest()

	self:sendMsg(req)
end

function ArcadeOutSideRpc:onReceiveArcadeCloseRewardPanelReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

ArcadeOutSideRpc.instance = ArcadeOutSideRpc.New()

return ArcadeOutSideRpc
