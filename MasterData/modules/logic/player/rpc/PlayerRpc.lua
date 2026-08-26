-- chunkname: @modules/logic/player/rpc/PlayerRpc.lua

module("modules.logic.player.rpc.PlayerRpc", package.seeall)

local PlayerRpc = class("PlayerRpc", BaseRpc)

function PlayerRpc:sendGetPlayerInfoRequest(callback, callbackObj)
	local req = PlayerModule_pb.GetPlayerInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerRpc:onReceiveGetPlayerInfoReply(resultCode, msg)
	if resultCode == 0 then
		local playerinfo = msg.playerInfo

		PlayerModel.instance:setMainThumbnail(msg.mainThumbnail)
		PlayerModel.instance:GMSetMainThumbnail()
		PlayerModel.instance:setCanRename(msg.canRename)
		PlayerModel.instance:setExtraRename(msg.extRename)
		PlayerModel.instance:setPlayerinfo(playerinfo)
		CrashSightAgent.SetUserId(playerinfo.userId)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.PlayerLevel, playerinfo.level)
		PlayerPrefsHelper.setString(PlayerPrefsKey.PlayerUid, tostring(playerinfo.userId))

		local openinfo = msg.openinfos

		OpenModel.instance:setOpenInfo(openinfo)
		OpenController.instance:dispatchEvent(OpenEvent.GetOpenInfoSuccess)
	end
end

function PlayerRpc:sendCreatePlayerRequest(name)
	local req = PlayerModule_pb.CreatePlayerRequest()

	req.name = name

	self:sendMsg(req)
end

function PlayerRpc:onReceiveCreatePlayerReply(resultCode, msg)
	if resultCode == 0 then
		local playerInfo = msg.playerInfo

		PlayerModel.instance:setPlayerinfo(playerInfo)
		CrashSightAgent.SetUserId(playerInfo.userId)
		PlayerPrefsHelper.setString(PlayerPrefsKey.PlayerUid, tostring(playerInfo.userId))
	end
end

function PlayerRpc:sendRenameRequest(name, guideId, stepId)
	local req = PlayerModule_pb.RenameRequest()

	req.name = name

	if guideId ~= nil then
		req.guideId = guideId
	end

	if stepId ~= nil then
		req.stepId = stepId
	end

	self._name = name

	self:sendMsg(req)
end

function PlayerRpc:onReceiveRenameReply(resultCode, msg)
	if resultCode == 0 then
		PlayerModel.instance:setPlayerName(self._name)
		PlayerModel.instance:setCanRename(msg.canRename)
		PlayerModel.instance:setExtraRename(msg.extRename)
	else
		PlayerController.instance:dispatchEvent(PlayerEvent.RenameReplyFail)
	end
end

function PlayerRpc:sendSetSignatureRequest(signature, callback, callbackObj)
	local req = PlayerModule_pb.SetSignatureRequest()

	req.signature = signature
	self._signature = signature

	self:sendMsg(req, callback, callbackObj)
end

function PlayerRpc:onReceiveSetSignatureReply(resultCode, msg)
	if resultCode == 0 then
		PlayerModel.instance:setPlayerSignature(self._signature)
	end
end

function PlayerRpc:sendSetBirthdayRequest(birthday)
	local req = PlayerModule_pb.SetBirthdayRequest()

	req.birthday = birthday
	self._birthday = birthday

	self:sendMsg(req)
end

function PlayerRpc:onReceiveSetBirthdayReply(resultCode, msg)
	if resultCode == 0 then
		PlayerModel.instance:setPlayerBirthday(self._birthday)
	end
end

function PlayerRpc:sendSetPortraitRequest(portrait)
	local req = PlayerModule_pb.SetPortraitRequest()

	req.portrait = portrait
	self._portrait = portrait

	self:sendMsg(req)
end

function PlayerRpc:onReceiveSetPortraitReply(resultCode, msg)
	if resultCode == 0 then
		PlayerModel.instance:setPlayerPortrait(self._portrait)
	end
end

function PlayerRpc:onReceivePlayerInfoPush(resultCode, msg)
	if resultCode == 0 then
		SocialModel.instance:clearSelfPlayerMO()
		DungeonModel.instance:startCheckUnlockChapter()

		local oldLevel = PlayerModel.instance:getPlayerLevel()
		local playerinfo = msg.playerInfo

		PlayerModel.instance:setPlayerinfo(playerinfo)

		if oldLevel ~= PlayerModel.instance:getPlayerLevel() then
			DungeonModel.instance:endCheckUnlockChapter()
		end
	end
end

function PlayerRpc:sendSetShowHeroUniqueIdsRequest(showHeroUniqueIds)
	local req = PlayerModule_pb.SetShowHeroUniqueIdsRequest()

	for i = 1, #showHeroUniqueIds do
		table.insert(req.showHeroUniqueIds, showHeroUniqueIds[i])
	end

	self:sendMsg(req)
end

function PlayerRpc:onReceiveSetShowHeroUniqueIdsReply(resultCode, msg)
	if resultCode == 0 then
		PlayerModel.instance:setShowHeroUniqueIds()
	end
end

function PlayerRpc:sendGetSimplePropertyRequest(callback, callbackObj)
	local req = PlayerModule_pb.GetSimplePropertyRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerRpc:onReceiveGetSimplePropertyReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local simpleProperties = msg.simpleProperties

	PlayerModel.instance:updateSimpleProperties(simpleProperties)
	HelpModel.instance:updateShowedHelpId()
end

function PlayerRpc:sendSetSimplePropertyRequest(id, property)
	local req = PlayerModule_pb.SetSimplePropertyRequest()

	req.id = id
	req.property = property

	self:sendMsg(req)
end

function PlayerRpc:onReceiveSetSimplePropertyReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function PlayerRpc:onReceiveSimplePropertyPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local simpleProperty = msg.simpleProperty

	PlayerModel.instance:updateSimpleProperty(simpleProperty)

	if simpleProperty.id == PlayerEnum.SimpleProperty.ShowHelpIds then
		HelpModel.instance:updateShowedHelpId()
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.UpdateSimpleProperty, simpleProperty.id)
end

function PlayerRpc:sendGetClothInfoRequest(callback, callbackObj)
	local req = PlayerModule_pb.GetClothInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerRpc:onReceiveGetClothInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerClothModel.instance:onGetInfo(msg.clothInfos.clothes)
end

function PlayerRpc:onReceiveClothUpdatePush(resultCode, msg)
	PlayerClothModel.instance:onPushInfo(msg.updateInfos.clothes)
end

function PlayerRpc:onReceiveServerResultCodePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if not msg.resultCode then
		local tipsCode = 0

		if tipsCode ~= 0 then
			GameFacade.showToast(tipsCode)
		end
	end
end

function PlayerRpc:sendGetOtherPlayerInfoRequest(userId, callback, callbackObj)
	local req = PlayerModule_pb.GetOtherPlayerInfoRequest()

	req.userId = userId

	self:sendMsg(req, callback, callbackObj)
end

function PlayerRpc:onReceiveGetOtherPlayerInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function PlayerRpc:sendUseCdKeyRequset(cdKey)
	local req = PlayerModule_pb.UseCdKeyRequset()

	req.giftCode = cdKey

	self:sendMsg(req)
end

function PlayerRpc:onReceiveUseCdKeyReply(resultCode)
	if resultCode == 0 then
		SettingsController.instance:dispatchEvent(SettingsEvent.OnUseCdkReplay)
	end
end

function PlayerRpc:sendSetPlayerBgRequest(bgId)
	local req = PlayerModule_pb.SetPlayerBgRequest()

	req.bgId = bgId

	self:sendMsg(req)
end

function PlayerRpc:onReceiveSetPlayerBgReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function PlayerRpc:sendMarkMainThumbnailRequest()
	local req = PlayerModule_pb.MarkMainThumbnailRequest()

	self:sendMsg(req)
end

function PlayerRpc:onReceiveMarkMainThumbnailReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerModel.instance:setMainThumbnail(true)
end

function PlayerRpc:sendGetAssistBonusRequest()
	local req = PlayerModule_pb.GetAssistBonusRequest()

	self:sendMsg(req)
end

function PlayerRpc:onReceiveGetAssistBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerModel.instance:updateAssistRewardCountData(msg.assistBonus, msg.hasReceiveAssistBonus)
end

function PlayerRpc:sendReceiveAssistBonusRequest()
	local req = PlayerModule_pb.ReceiveAssistBonusRequest()

	self:sendMsg(req)
end

function PlayerRpc:onReceiveReceiveAssistBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerModel.instance:updateAssistRewardCountData(msg.assistBonus, msg.hasReceiveAssistBonus)
end

function PlayerRpc:sendSetMainSceneSkinRequest(itemId, callback, callbackObj)
	local req = PlayerModule_pb.SetMainSceneSkinRequest()

	req.itemId = itemId

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerRpc:onReceiveSetMainSceneSkinReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function PlayerRpc:sendSetUiStyleSkinRequest(itemId, callback, callbackObj)
	local req = PlayerModule_pb.SetUiStyleSkinRequest()

	req.itemId = itemId

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerRpc:onReceiveSetUiStyleSkinReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.MainUISwitchSuccess)
end

PlayerRpc.instance = PlayerRpc.New()

return PlayerRpc
