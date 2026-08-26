-- chunkname: @modules/logic/login/work/SimulateLoginWork.lua

module("modules.logic.login.work.SimulateLoginWork", package.seeall)

local SimulateLoginWork = class("SimulateLoginWork", BaseWork)

function SimulateLoginWork:onStart(context)
	local url = LoginController.instance:get_getSessionIdUrl(self.context.useBackupUrl)
	local data = {}

	table.insert(data, string.format("account=%s", LoginModel.instance.channelUserId))
	table.insert(data, string.format("platformId=%s", "0"))

	url = url .. "?" .. table.concat(data, "&")
	self._getSimulatedSessionRequestId = SLFramework.SLWebRequest.Instance:Get(url, self._onGetSimulatedSessionIdResponse, self)
end

function SimulateLoginWork:_onGetSimulatedSessionIdResponse(isSuccess, msg)
	self._getSimulatedSessionRequestId = nil

	logNormal("get simulated session id response: " .. (msg or "nil"))

	if isSuccess and msg and msg ~= "" then
		local data = cjson.decode(msg)

		if data and data.resultCode and data.resultCode == 0 then
			LoginModel.instance.channelSessionId = data.slSessionId

			logNormal(string.format("模拟登录的sessoinId拿到了 platformId = %d sessionId = %s", data.platformId, data.slSessionId))
			self:onDone(true)
		else
			logNormal(string.format("出错了 resultCode = %d", (not data.resultCode or nil) and "nil"))
			self:onDone(false)
		end
	else
		logError("获取session失败")
		self:onDone(false)
	end
end

function SimulateLoginWork:clearWork()
	if self._getSimulatedSessionRequestId then
		SLFramework.SLWebRequest.Instance:Stop(self._getSimulatedSessionRequestId)

		self._getSimulatedSessionRequestId = nil
	end
end

return SimulateLoginWork
