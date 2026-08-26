-- chunkname: @modules/logic/bgmswitch/rpc/BgmRpc.lua

module("modules.logic.bgmswitch.rpc.BgmRpc", package.seeall)

local BgmRpc = class("BgmRpc", BaseRpc)

function BgmRpc:sendGetBgmInfoRequest(callback, callbackObj)
	local req = BgmModule_pb.GetBgmInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function BgmRpc:onReceiveGetBgmInfoReply(resultCode, msg)
	if resultCode == 0 then
		BGMSwitchModel.instance:setBgmInfos(msg.bgmInfos)
		BGMSwitchModel.instance:setUsedBgmIdFromServer(msg.useBgmId)
		BGMSwitchModel.instance:setCurBgm(msg.useBgmId)
	end
end

function BgmRpc:onReceiveUpdateBgmPush(resultCode, msg)
	if resultCode == 0 then
		BGMSwitchModel.instance:updateBgmInfos(msg.bgmInfos)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmUpdated)
	end
end

function BgmRpc:sendSetUseBgmRequest(bgmId, callback, callbackObj)
	local req = BgmModule_pb.SetUseBgmRequest()

	req.bgmId = bgmId

	BGMSwitchModel.instance:recordInfoByType(BGMSwitchEnum.RecordInfoType.ListType, BGMSwitchModel.instance:getBGMSelectType(), true)
	self:sendMsg(req, callback, callbackObj)
end

function BgmRpc:onReceiveSetUseBgmReply(resultCode, msg)
	if resultCode == 0 then
		BGMSwitchModel.instance:setUsedBgmIdFromServer(msg.bgmId)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmSwitched)
	end
end

function BgmRpc:sendSetFavoriteBgmRequest(bgmId, favorite, callback, callbackObj)
	local req = BgmModule_pb.SetFavoriteBgmRequest()

	req.bgmId = bgmId
	req.favorite = favorite

	local co = BGMSwitchConfig.instance:getBGMSwitchCO(bgmId)

	if co then
		StatController.instance:track(StatEnum.EventName.SetPreferenceBgm, {
			[StatEnum.EventProperties.AudioId] = tostring(bgmId),
			[StatEnum.EventProperties.AudioName] = co.audioName,
			[StatEnum.EventProperties.OperationType] = favorite and "setLove" or "setUnlove",
			[StatEnum.EventProperties.FavoriteAudio] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted())
		})
	end

	self:sendMsg(req, callback, callbackObj)
end

function BgmRpc:onReceiveSetFavoriteBgmReply(resultCode, msg)
	if resultCode == 0 then
		BGMSwitchModel.instance:setBgmFavorite(msg.bgmId, msg.favorite)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmFavorite, msg.bgmId)
	end
end

function BgmRpc:sendReadBgmRequest(bgmId)
	local req = BgmModule_pb.ReadBgmRequest()

	req.bgmId = bgmId

	self:sendMsg(req)
end

function BgmRpc:onReceiveReadBgmReply(resultCode, msg)
	if resultCode == 0 then
		BGMSwitchModel.instance:markRead(msg.bgmId)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmMarkRead, msg.bgmId)
	end
end

BgmRpc.instance = BgmRpc.New()

return BgmRpc
