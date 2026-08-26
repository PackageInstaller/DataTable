-- chunkname: @modules/logic/act201/model/Activity201Model.lua

module("modules.logic.act201.model.Activity201Model", package.seeall)

local Activity201Model = class("Activity201Model", BaseModel)

function Activity201Model:onInit()
	self._dict = {}
end

function Activity201Model:reInit()
	self._dict = {}
end

function Activity201Model:setActivityInfo(info)
	local activityId = info.activityId
	local activityInfoMo = self:getInvitationInfo(activityId)

	if activityInfoMo == nil then
		activityInfoMo = Activity201Mo.New()
		self._dict[activityId] = activityInfoMo
	end

	activityInfoMo:init(info)
end

function Activity201Model:getInvitationInfo(activityId)
	return self._dict[activityId]
end

function Activity201Model:getHelpId()
	return self.HELP_ID
end

function Activity201Model:getSelfBindId(activityId)
	local activityInfo = self:getInvitationInfo(activityId)

	if activityInfo == nil or activityInfo.inviteCode == nil then
		return nil
	end

	return activityInfo.inviteCode
end

function Activity201Model:haveBind(activityId)
	local activityInfo = self:getInvitationInfo(activityId)

	if activityInfo == nil or activityInfo.isTurnBack == nil then
		return false
	end

	return activityInfo.isTurnBack
end

function Activity201Model:setBindState(activityId, state)
	if self:haveBind(activityId) then
		logError("Have bind friend ID")

		return
	end

	local info = self:getInvitationInfo(activityId)

	info.isTurnBack = state
end

function Activity201Model:isActOpen(activityId)
	local online = ActivityModel.instance:isActOnLine(activityId)

	if online == false then
		return online
	end

	local startTime = ActivityModel.instance:getActStartTime(activityId)
	local endTime = ActivityModel.instance:getActEndTime(activityId)
	local nowTime = ServerTime.now() * 1000

	return startTime <= nowTime and nowTime < endTime
end

function Activity201Model:getLoginUrl()
	local channel = self:getCurChannel()
	local serverType = GameChannelConfig.getServerType()
	local isRelease = serverType == GameChannelConfig.ServerType.OutRelease or serverType == GameChannelConfig.ServerType.OutPreview
	local urlHead = isRelease and Activity201Config.instance:getUrlByChannelId(channel) or Activity201Config.instance:getTestUrlByChannelId(channel)

	if channel == TurnbackEnum.ChannelType.eFun then
		return self:getEFunLoginUrl(urlHead)
	elseif channel == TurnbackEnum.ChannelType.KO then
		return self:getKOLoginUrl(urlHead)
	else
		return self:getGlobalLoginUrl(urlHead)
	end
end

function Activity201Model:getGlobalLoginUrl(urlHead)
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

function Activity201Model:getEFunLoginUrl(urlHead)
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

function Activity201Model:getKOLoginUrl(urlHead)
	local extraParams = SDKMgr.instance:getUserInfoExtraParams()
	local data = {
		urlHead .. "?" .. string.format("jwt=%s", extraParams.ko_jwt)
	}

	return table.concat(data, "&")
end

function Activity201Model:getCurrentDeviceType()
	if SDKMgr.instance:isEmulator() then
		return WebViewEnum.DeviceType.Emulator
	elseif SLFramework.FrameworkSettings.IsEditor or BootNativeUtil.isWindows() then
		return WebViewEnum.DeviceType.PC
	else
		return WebViewEnum.DeviceType.Normal
	end
end

function Activity201Model:getCurChannel()
	if GameChannelConfig.isEfun() then
		return TurnbackEnum.ChannelType.eFun
	elseif GameChannelConfig.isLongCheng() then
		return TurnbackEnum.ChannelType.KO
	else
		return TurnbackEnum.ChannelType.Global
	end
end

Activity201Model.instance = Activity201Model.New()

return Activity201Model
