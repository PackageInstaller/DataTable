-- chunkname: @modules/logic/login/work/HttpStartGameWork.lua

module("modules.logic.login.work.HttpStartGameWork", package.seeall)

local HttpStartGameWork = class("HttpStartGameWork", BaseWork)
local Interval = 5
local lastRequestTime, lastRespondStatus, lastRespondMsg

function HttpStartGameWork:onStart(context)
	if lastRequestTime and Time.time - lastRequestTime < Interval then
		TaskDispatcher.runDelay(self._delayRespondInCd, self, 0.1)
	else
		lastRequestTime = Time.time

		local url = LoginController.instance:get_startGameUrl(self.context.useBackupUrl)
		local data = {}

		table.insert(data, string.format("sessionId=%s", LoginModel.instance.sessionId))
		table.insert(data, string.format("zoneId=%s", self.context.lastServerMO.id))

		url = url .. "?" .. table.concat(data, "&")
		self._url = url
		self._httpStartGameRequestId = SLFramework.SLWebRequest.Instance:Get(url, self._onHttpStartGameResponse, self)

		logNormal(url)
	end
end

function HttpStartGameWork:_delayRespondInCd()
	self:_onHttpStartGameResponse(lastRespondStatus, lastRespondMsg)
end

function HttpStartGameWork:_onHttpStartGameResponse(isSuccess, msg)
	lastRespondStatus = isSuccess
	lastRespondMsg = msg
	self._httpStartGameRequestId = nil

	local url = self._url

	logNormal("http start game response: " .. (msg or "nil"))

	if isSuccess and msg and msg ~= "" then
		local data = cjson.decode(msg)

		if data and data.resultCode and data.resultCode == 0 then
			if data.state == 1 then
				LoginModel.instance.serverIp = data.ip
				LoginModel.instance.serverPort = data.port

				if not string.nilorempty(data.bakIp) then
					LoginModel.instance.serverBakIp = data.bakIp
					LoginModel.instance.serverBakPort = data.bakPort
				end

				LoginModel.instance.serverName = self.context.lastServerMO.name
				LoginModel.instance.serverId = self.context.lastServerMO.id

				if QuickEnterServerModel.enable and isDebugBuild then
					QuickEnterServerModel.instance:addLastEnterServer(LoginModel.instance.serverIp, LoginModel.instance.serverPort, LoginModel.instance.serverName, LoginModel.instance.serverId)
				end

				logNormal("<color=#00FF00>http 登录成功</color>")
				self:onDone(true)

				if not LoginModel.instance.serverIp or not LoginModel.instance.serverPort then
					logError(string.format("HttpStartGameWork response error serverIp:%s, serverPort:%s msg:%s url:%s", data.ip, data.port, msg, url))
				end
			else
				if data.state == 0 then
					self.context.dontReconnect = true

					if string.nilorempty(data.tips) then
						GameFacade.showMessageBox(MessageBoxIdDefine.ServerNotConnect, MsgBoxEnum.BoxType.Yes)
					else
						MessageBoxController.instance:showMsgBoxByStr(data.tips, MsgBoxEnum.BoxType.Yes)
					end

					logWarn("服务器未开启")
				else
					logWarn("服务器爆满")
				end

				self:onDone(false)
			end
		else
			self.context.resultCode = data and data.resultCode

			logNormal(string.format("http start game 出错了 resultCode = %d", data.resultCode or "nil"))
			self:onDone(false)
		end
	else
		logNormal("http start game 失败")
		self:onDone(false)
	end
end

function HttpStartGameWork:clearWork()
	self._url = nil

	TaskDispatcher.cancelTask(self._delayRespondInCd, self)

	if self._httpStartGameRequestId then
		SLFramework.SLWebRequest.Instance:Stop(self._httpStartGameRequestId)

		self._httpStartGameRequestId = nil
	end
end

return HttpStartGameWork
