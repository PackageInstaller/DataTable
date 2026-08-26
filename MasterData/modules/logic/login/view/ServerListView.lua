-- chunkname: @modules/logic/login/view/ServerListView.lua

module("modules.logic.login.view.ServerListView", package.seeall)

local ServerListView = class("ServerListView", BaseView)

function ServerListView:onInitView()
	return
end

function ServerListView:addEvents()
	return
end

function ServerListView:onOpen()
	local useBackupUrl = self.viewParam.useBackupUrl
	local url = LoginController.instance:get_getServerListUrl(useBackupUrl)
	local data = {}

	table.insert(data, string.format("sessionId=%s", LoginModel.instance.sessionId))
	table.insert(data, string.format("zoneId=%s", 0))

	url = url .. "?" .. table.concat(data, "&")
	self._webRequestId = SLFramework.SLWebRequest.Instance:Get(url, self._onGetServerListResponse, self)
end

function ServerListView:onClose()
	if self._webRequestId then
		SLFramework.SLWebRequest.Instance:Stop(self._webRequestId)

		self._webRequestId = nil
	end
end

function ServerListView:_onGetServerListResponse(isSuccess, msg)
	self._webRequestId = nil

	logNormal("get server list response: " .. (msg or "nil"))

	if isSuccess and msg and msg ~= "" then
		local data = cjson.decode(msg)

		if data and data.resultCode and data.resultCode == 0 then
			if data.zoneInfos then
				ServerListModel.instance:setServerList(data.zoneInfos)
			end
		else
			logNormal(string.format("get server list 出错了 resultCode = %d", data.resultCode))
		end
	else
		logError("get server list 失败")
	end
end

return ServerListView
