-- chunkname: @modules/logic/turnback/invitation/model/TurnBackInvitationModel.lua

module("modules.logic.turnback.invitation.model.TurnBackInvitationModel", package.seeall)

local TurnBackInvitationModel = class("TurnBackInvitationModel", BaseModel)

TurnBackInvitationModel.LOGIN_URL_HEAD = "https://re.bluepoch.com/event/invite/20240919/"
TurnBackInvitationModel.HELP_ID = 0

function TurnBackInvitationModel:onInit()
	self._dict = {}
end

function TurnBackInvitationModel:reInit()
	self._dict = {}
end

function TurnBackInvitationModel:setActivityInfo(info)
	local activityId = info.activityId
	local activityInfoMo = self:getInvitationInfo(activityId)

	if activityInfoMo == nil then
		activityInfoMo = TurnBackInvitationInfoMo.New()
		self._dict[activityId] = activityInfoMo
	end

	activityInfoMo:init(info)
end

function TurnBackInvitationModel:getInvitationInfo(activityId)
	return self._dict[activityId]
end

function TurnBackInvitationModel:getHelpId()
	return self.HELP_ID
end

function TurnBackInvitationModel:getSelfBindId(activityId)
	local activityInfo = self:getInvitationInfo(activityId)

	if activityInfo == nil or activityInfo.inviteCode == nil then
		return nil
	end

	return activityInfo.inviteCode
end

function TurnBackInvitationModel:haveBind(activityId)
	local activityInfo = self:getInvitationInfo(activityId)

	if activityInfo == nil or activityInfo.isTurnBack == nil then
		return false
	end

	return activityInfo.isTurnBack
end

function TurnBackInvitationModel:setBindState(activityId, state)
	if self:haveBind(activityId) then
		logError("Have bind friend ID")

		return
	end

	local info = self:getInvitationInfo(activityId)

	info.isTurnBack = state
end

function TurnBackInvitationModel:isActOpen(activityId)
	local online = ActivityModel.instance:isActOnLine(activityId)

	if online == false then
		return online
	end

	local startTime = ActivityModel.instance:getActStartTime(activityId)
	local endTime = ActivityModel.instance:getActEndTime(activityId)
	local nowTime = ServerTime.now() * 1000

	return startTime <= nowTime and nowTime < endTime
end

function TurnBackInvitationModel:getLoginUrl()
	local serverType = GameChannelConfig.getServerType()
	local isRelease = serverType == GameChannelConfig.ServerType.OutRelease or serverType == GameChannelConfig.ServerType.OutPreview
	local channel = self:getCurChannel()
	local urlHead = isRelease and TurnBackInvitationConfig.instance:getUrlByChannelId(channel) or TurnBackInvitationConfig.instance:getTestUrlByChannelId(channel)

	if urlHead == nil then
		logError(string.format("TurnBackInvitationModel getUrl Fail channelId: %s", channel))

		return nil
	end

	if channel == TurnbackEnum.ChannelType.eFun then
		return self:getEFunLoginUrl(urlHead)
	elseif channel == TurnbackEnum.ChannelType.KO then
		return self:getKOLoginUrl(urlHead)
	else
		return self:getGlobalLoginUrl(urlHead)
	end
end

function TurnBackInvitationModel:isRelease()
	local serverType = GameChannelConfig.getServerType()
end

function TurnBackInvitationModel:getGlobalLoginUrl(urlHead)
	local data = {
		urlHead .. "?" .. string.format("timestamp=%s", ServerTime.now() * 1000)
	}

	table.insert(data, string.format("gameId=%s", SDKMgr.instance:getGameId()))
	table.insert(data, string.format("gameRoleId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(data, string.format("channelUserId=%s", LoginModel.instance.channelUserId))

	local deviceModel = string.format("deviceModel=%s", WebViewController.instance:urlEncode(UnityEngine.SystemInfo.deviceModel))

	table.insert(data, deviceModel)
	table.insert(data, string.format("deviceId=%s", SDKMgr.instance:getDeviceInfo().deviceId))

	local operatingSystem = string.format("os=%s", WebViewController.instance:urlEncode(UnityEngine.SystemInfo.operatingSystem))

	table.insert(data, operatingSystem)
	table.insert(data, string.format("token=%s", SDKMgr.instance:getGameSdkToken()))
	table.insert(data, string.format("channelId=%s", SDKMgr.instance:getChannelId()))
	table.insert(data, string.format("isEmulator=%s", self:getCurrentDeviceType()))

	local languageModel = WebViewController.instance:urlEncode(LangSettings.instance:getCurLangKeyByShortCut())

	table.insert(data, string.format("language=%s", languageModel))

	return table.concat(data, "&")
end

function TurnBackInvitationModel:getEFunLoginUrl(urlHead)
	local extraParams = SDKMgr.instance:getUserInfoExtraParams()
	local data = {
		urlHead .. "&" .. string.format("userId=%s", extraParams.userId)
	}

	table.insert(data, string.format("sign=%s", extraParams.sign))
	table.insert(data, string.format("timestamp=%s", extraParams.timestamp))
	table.insert(data, string.format("gameCode=twcfwl"))

	local roleInfo = PayModel.instance:getGameRoleInfo()

	table.insert(data, string.format("serverCode=%s", roleInfo.serverId))
	table.insert(data, string.format("roleId=%s", roleInfo.roleId))

	local serverNameModel = string.format("serverName=%s", WebViewController.instance:urlEncode(roleInfo.serverName))

	table.insert(data, serverNameModel)

	local roleNameModel = string.format("roleName=%s", WebViewController.instance:urlEncode(roleInfo.roleName))

	table.insert(data, roleNameModel)
	table.insert(data, string.format("language=zh-TW"))

	return table.concat(data, "&")
end

function TurnBackInvitationModel:getKOLoginUrl(urlHead)
	local extraParams = SDKMgr.instance:getUserInfoExtraParams()
	local data = {
		urlHead .. "?" .. string.format("jwt=%s", extraParams.ko_jwt)
	}

	return table.concat(data, "&")
end

function TurnBackInvitationModel:getCurrentDeviceType()
	if SDKMgr.instance:isEmulator() then
		return WebViewEnum.DeviceType.Emulator
	elseif SLFramework.FrameworkSettings.IsEditor or BootNativeUtil.isWindows() then
		return WebViewEnum.DeviceType.PC
	else
		return WebViewEnum.DeviceType.Normal
	end
end

function TurnBackInvitationModel:getCurChannel()
	if GameChannelConfig.isEfun() then
		return TurnbackEnum.ChannelType.eFun
	elseif GameChannelConfig.isLongCheng() then
		return TurnbackEnum.ChannelType.KO
	else
		return TurnbackEnum.ChannelType.Global
	end
end

TurnBackInvitationModel.instance = TurnBackInvitationModel.New()

return TurnBackInvitationModel
