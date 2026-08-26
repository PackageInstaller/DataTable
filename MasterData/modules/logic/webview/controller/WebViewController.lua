-- chunkname: @modules/logic/webview/controller/WebViewController.lua

local sf = string.format
local ti = table.insert
local tc = table.concat

module("modules.logic.webview.controller.WebViewController", package.seeall)

local WebViewController = class("WebViewController")

function WebViewController:openWebView(url, needRecordUser, callback, callbackObj, left, top, right, bottom, autoTop, autoBottom)
	if SLFramework.FrameworkSettings.IsEditor or BootNativeUtil.isWindows() then
		if needRecordUser then
			url = self:getRecordUserUrl(url)
		end

		GameUtil.openURL(url)

		return
	end

	if string.nilorempty(url) then
		logError("url 不能为空")

		return
	end

	ViewMgr.instance:openView(ViewName.WebView, {
		url = url,
		needRecordUser = needRecordUser,
		callback = callback,
		callbackObj = callbackObj,
		left = left,
		top = top,
		right = right,
		bottom = bottom,
		autoTop = autoTop,
		autoBottom = autoBottom
	})
end

function WebViewController:getRecordUserUrl(baseUrl)
	if string.nilorempty(baseUrl) then
		return baseUrl
	end

	local strBuf = {}
	local isTw = GameChannelConfig.isEfun()
	local isKr = GameChannelConfig.isLongCheng()

	if SLFramework.FrameworkSettings.IsEditor and isDebugBuild then
		isTw = isTw or SettingsModel.instance:isTwRegion()
		isKr = isKr or SettingsModel.instance:isKrRegion()
	end

	baseUrl = not string.find(baseUrl, "?") and baseUrl .. "?" or baseUrl .. "&"

	if isTw then
		local extraParams = SDKMgr.instance:getUserInfoExtraParams()
		local roleInfo = PayModel.instance:getGameRoleInfo()

		ti(strBuf, baseUrl .. sf("userId=%s", extraParams.userId))
		ti(strBuf, sf("sign=%s", extraParams.sign))
		ti(strBuf, sf("timestamp=%s", extraParams.timestamp))
		ti(strBuf, "gameCode=twcfwl")
		ti(strBuf, sf("serverCode=%s", roleInfo.serverId))
		ti(strBuf, sf("roleId=%s", roleInfo.roleId))
		ti(strBuf, sf("serverName=%s", self:urlEncode(roleInfo.serverName)))
		ti(strBuf, sf("roleName=%s", self:urlEncode(roleInfo.roleName)))
		ti(strBuf, "language=zh-TW")
	elseif isKr then
		local extraParams = SDKMgr.instance:getUserInfoExtraParams()

		if extraParams then
			if not extraParams.ko_jwt then
				local ko_jwt = "nil"

				ti(strBuf, baseUrl .. sf("jwt=%s", ko_jwt))
			end
		end
	else
		ti(strBuf, baseUrl .. sf("timestamp=%s", ServerTime.now() * 1000))
		ti(strBuf, sf("gameId=%s", SDKMgr.instance:getGameId()))
		ti(strBuf, sf("gameRoleId=%s", PlayerModel.instance:getMyUserId()))
		ti(strBuf, sf("channelUserId=%s", LoginModel.instance.channelUserId))
		ti(strBuf, sf("deviceModel=%s", self:urlEncode(UnityEngine.SystemInfo.deviceModel)))
		ti(strBuf, sf("deviceId=%s", SDKMgr.instance:getDeviceInfo().deviceId))
		ti(strBuf, sf("os=%s", self:urlEncode(UnityEngine.SystemInfo.operatingSystem)))
		ti(strBuf, sf("token=%s", SDKMgr.instance:getGameSdkToken()))
		ti(strBuf, sf("channelId=%s", SDKMgr.instance:getChannelId()))
		ti(strBuf, sf("isEmulator=%s", SDKMgr.instance:isEmulator() and 1 or 0))
	end

	local url = tc(strBuf, "&")

	logNormal(url)

	return url
end

function WebViewController:urlEncode(s)
	s = string.gsub(s, "([^%w%.%- ])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)

	return (string.gsub(s, " ", "+"))
end

function WebViewController:getVideoUrl(heroId, skinId)
	local urlHead = self:getVideoUrlHead()

	urlHead = string.format(urlHead, heroId)

	local data = {
		urlHead .. string.format("gameId=%s", SDKMgr.instance:getGameId())
	}

	table.insert(data, string.format("accountId=%s", LoginModel.instance.channelUserId))
	table.insert(data, string.format("roleId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(data, string.format("skinId=%s", skinId))

	local languageModel = WebViewController.instance:urlEncode(LangSettings.instance:getCurLangKeyByShortCut(true))

	table.insert(data, string.format("language=%s", languageModel))

	local deviceTypeModel = TurnBackInvitationModel.instance:getCurrentDeviceType()

	table.insert(data, string.format("deviceType=%s", deviceTypeModel))

	return (table.concat(data, "&"))
end

function WebViewController:getVideoUrlHead()
	local gameId = SDKMgr.instance:getGameId()
	local urlHead
	local serverType = GameChannelConfig.getServerType()
	local isRelease = serverType == GameChannelConfig.ServerType.OutRelease or serverType == GameChannelConfig.ServerType.OutPreview

	return tostring(gameId) == "50001" and (isRelease and "https://re.bluepoch.com/event/skinvideo/%s?" or "https://re-test.sl916.com/event/skinvideo/%s?") or isRelease and "https://reverse1999.bluepoch.com/event/skinvideo/%s?" or "https://re1999-hwtest.sl916.com/event/skinvideo/%s?"
end

function WebViewController:getWebViewTopOffset(width, height, contentHeight)
	width = width or UnityEngine.Screen.width
	height = height or UnityEngine.Screen.height
	contentHeight = contentHeight or WebViewEnum.DefaultMargin.Top

	local defaultHeight = 1080
	local defaultWidth = 1920
	local defaultRatio = defaultWidth / defaultHeight
	local currentRatio = width / height
	local targetHeight = width / defaultRatio
	local btnOffset = 0
	local offset = 0
	local ratio = 0.5

	if currentRatio >= defaultRatio - 0.01 then
		btnOffset = contentHeight * (height / defaultHeight)
		offset = math.max(0, (height - targetHeight) * ratio) + contentHeight * (height / defaultHeight)
	elseif currentRatio <= defaultRatio - 0.01 then
		btnOffset = contentHeight * (targetHeight / defaultHeight)
		offset = math.max(0, (height - targetHeight) * ratio) + contentHeight * (targetHeight / defaultHeight)
	else
		offset = contentHeight * (targetHeight / defaultHeight)
	end

	return offset
end

function WebViewController:getWebViewBottomOffset(width, height, contentHeight)
	width = width or UnityEngine.Screen.width
	height = height or UnityEngine.Screen.height
	contentHeight = contentHeight or WebViewEnum.DefaultMargin.Bottom

	local defaultHeight = 1080
	local defaultWidth = 1920
	local defaultRatio = defaultWidth / defaultHeight
	local currentRatio = width / height
	local targetHeight = width / defaultRatio
	local btnOffset = 0
	local offset = 0
	local ratio = 0.5

	if currentRatio >= defaultRatio - 0.01 then
		btnOffset = contentHeight * (height / defaultHeight)
		offset = math.max(0, (height - targetHeight) * ratio) + contentHeight * (height / defaultHeight)
	elseif currentRatio <= defaultRatio - 0.01 then
		btnOffset = contentHeight * (targetHeight / defaultHeight)
		offset = math.max(0, (height - targetHeight) * ratio) + contentHeight * (targetHeight / defaultHeight)
	else
		offset = contentHeight * (targetHeight / defaultHeight)
	end

	return offset
end

function WebViewController.urlParse(url)
	local query = string.split(url, "?")

	if query and query[2] then
		local res = {}

		for k, v in string.gmatch(query[2], "([^&=]+)=([^&=]*)") do
			res[k] = v
		end

		return res
	end

	return nil
end

function WebViewController:simpleOpenWebView(baseUrl, onWebViewCb, onWebViewCbObj)
	local url = self:getRecordUserUrl(baseUrl)

	self:openWebView(url, false, onWebViewCb, onWebViewCbObj)
end

function WebViewController:simpleOpenWebBrowser(baseUrl)
	local url = self:getRecordUserUrl(baseUrl)

	GameUtil.openURL(url)
end

WebViewController.instance = WebViewController.New()

return WebViewController
