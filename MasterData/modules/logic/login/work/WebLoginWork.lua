-- chunkname: @modules/logic/login/work/WebLoginWork.lua

module("modules.logic.login.work.WebLoginWork", package.seeall)

local WebLoginWork = class("WebLoginWork", BaseWork)

function WebLoginWork:onStart(context)
	local url = LoginController.instance:get_httpWebLoginUrl(self.context.useBackupUrl)
	local data = {}

	table.insert(data, string.format("slSessionId=%s", LoginModel.instance.channelSessionId))
	table.insert(data, string.format("clientVersion=%s", "0.0.0"))
	table.insert(data, string.format("sysType=%s", BootNativeUtil.isAndroid() and "1" or "0"))
	table.insert(data, string.format("accountId=%s", LoginModel.instance.channelUserId))
	table.insert(data, string.format("channelId=%s", LoginModel.instance.channelId))
	table.insert(data, string.format("subChannelId=%s", SDKMgr.instance:getSubChannelId()))

	url = url .. "?" .. table.concat(data, "&")
	self._url = url
	self._httpWebLoginRequestId = SLFramework.SLWebRequest.Instance:Get(url, self._onHttpWebLoginUrlResponse, self)

	logNormal(url)
end

function WebLoginWork:_onHttpWebLoginUrlResponse(isSuccess, msg)
	self._httpWebLoginRequestId = nil

	local url = self._url

	if isSuccess and msg and msg ~= "" then
		local data = cjson.decode(msg)

		if data and data.resultCode and data.resultCode == 0 then
			LoginModel.instance.userName = data.userName
			LoginModel.instance.sessionId = data.sessionId

			local zone = data.zoneInfo

			if zone then
				self.context.serverMO = {
					id = zone.id,
					name = zone.name,
					prefix = zone.prefix,
					state = zone.state
				}
			else
				logNormal("没有服务器，zone不存在")
			end

			self.context.webLoginSuccess = true

			self:onDone(true)

			if string.nilorempty(LoginModel.instance.userName) or string.nilorempty(LoginModel.instance.sessionId) then
				logError(string.format("WebLoginWork response error userName:%s, sessionId:%s msg:%s url:%s", data.userName, data.sessionId, msg, url))
			end
		else
			self.context.resultCode = data and data.resultCode

			logNormal(string.format("http web login 出错了 resultCode = %d", data.resultCode or "nil"))
			self:onDone(false)
		end
	else
		logNormal("http web 登录失败")
		self:onDone(false)
	end
end

function WebLoginWork:clearWork()
	self._url = nil

	if self._httpWebLoginRequestId then
		SLFramework.SLWebRequest.Instance:Stop(self._httpWebLoginRequestId)

		self._httpWebLoginRequestId = nil
	end
end

return WebLoginWork
