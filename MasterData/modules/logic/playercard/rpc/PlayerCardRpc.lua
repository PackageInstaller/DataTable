-- chunkname: @modules/logic/playercard/rpc/PlayerCardRpc.lua

module("modules.logic.playercard.rpc.PlayerCardRpc", package.seeall)

local PlayerCardRpc = class("PlayerCardRpc", BaseRpc)

function PlayerCardRpc:sendGetPlayerCardInfoRequest(callback, callbackObj)
	local req = PlayerCardModule_pb.GetPlayerCardInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerCardRpc:onReceiveGetPlayerCardInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerCardModel.instance:updateCardInfo(msg.playerCardInfo)
end

function PlayerCardRpc:onReceivePlayerCardInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerCardModel.instance:updateCardInfo(msg.playerCardInfo)
end

function PlayerCardRpc:sendGetOtherPlayerCardInfoRequest(userId, callback, callbackObj)
	local req = PlayerCardModule_pb.GetOtherPlayerCardInfoRequest()

	req.userId = userId

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerCardRpc:onReceiveGetOtherPlayerCardInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerCardModel.instance:updateCardInfo(msg.playerCardInfo, msg.playerInfo)
end

function PlayerCardRpc:sendSetPlayerCardShowSettingRequest(showSettings, callback, callbackObj)
	local req = PlayerCardModule_pb.SetPlayerCardShowSettingRequest()

	for key, value in pairs(showSettings) do
		local setting = string.format("%s#%s", key, value)

		req.showSettings:append(setting)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerCardRpc:onReceiveSetPlayerCardShowSettingReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerCardModel.instance:updateSetting(msg.showSettings)
end

function PlayerCardRpc:sendSetPlayerCardHeroCoverRequest(heroCover, callback, callbackObj)
	local req = PlayerCardModule_pb.SetPlayerCardHeroCoverRequest()

	req.heroCover = heroCover

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerCardRpc:onReceiveSetPlayerCardHeroCoverReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerCardModel.instance:updateHeroCover(msg.heroCover)
end

function PlayerCardRpc:sendSetPlayerCardThemeRequest(themeId, callback, callbackObj)
	local req = PlayerCardModule_pb.SetPlayerCardThemeRequest()

	req.themeId = themeId

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerCardRpc:onReceiveSetPlayerCardThemeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerCardModel.instance:updateThemeId(msg.themeId)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ChangeSkin, msg.themeId)
end

function PlayerCardRpc:sendSetPlayerCardShowAchievementRequest(idList, groupId, callback, callbackObj)
	local req = PlayerCardModule_pb.SetPlayerCardShowAchievementRequest()

	for i, id in ipairs(idList) do
		req.ids:append(id)
	end

	req.groupId = groupId

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerCardRpc:onReceiveSetPlayerCardShowAchievementReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.AchievementSaveSucc)
	PlayerCardController.instance:statSetAchievement()
	AchievementController.instance:dispatchEvent(AchievementEvent.AchievementSaveSucc)
end

function PlayerCardRpc:sendSetPlayerCardProgressSettingRequest(progressSetting, callback, callbackObj)
	local req = PlayerCardModule_pb.SetPlayerCardProgressSettingRequest()

	req.progressSetting = progressSetting

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerCardRpc:onReceiveSetPlayerCardProgressSettingReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerCardModel.instance:updateProgressSetting(msg.progressSetting)
	PlayerCardController.instance:statSetProgress()
end

function PlayerCardRpc:sendSetPlayerCardBaseInfoSettingRequest(setting, callback, callbackObj)
	local req = PlayerCardModule_pb.SetPlayerCardBaseSettingRequest()

	req.baseSetting = setting

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerCardRpc:onReceiveSetPlayerCardBaseSettingReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerCardModel.instance:updateBaseInfoSetting(msg.baseSetting)
	PlayerCardController.instance:statSetBaseInfo()
end

function PlayerCardRpc:sendSetPlayerCardCritterRequest(critterUid, callback, callbackObj)
	local req = PlayerCardModule_pb.SetPlayerCardCritterRequest()

	req.critterUid = tonumber(critterUid)

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerCardRpc:onReceiveSetPlayerCardCritterReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = CritterModel.instance:getCritterMOByUid(msg.critterUid)

	PlayerCardModel.instance:setSelectCritterUid(msg.critterUid)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectCritter, {
		uid = msg.critterUid
	})
end

function PlayerCardRpc:sendSetPlayerCardBadgeRequest(badgeIds, callback, callbackObj)
	local req = PlayerCardModule_pb.SetPlayerCardBadgeRequest()

	for _, id in ipairs(badgeIds) do
		req.badgeIds:append(id)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function PlayerCardRpc:onReceiveSetPlayerCardBadgeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ModifyEquipBadge)
end

PlayerCardRpc.instance = PlayerCardRpc.New()

return PlayerCardRpc
