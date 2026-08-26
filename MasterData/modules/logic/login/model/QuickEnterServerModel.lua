-- chunkname: @modules/logic/login/model/QuickEnterServerModel.lua

module("modules.logic.login.model.QuickEnterServerModel", package.seeall)

local QuickEnterServerModel = class("QuickEnterServerModel")

QuickEnterServerModel.enable = SDKMgr.instance:useSimulateLogin() and PlayerPrefsHelper.getNumber("QuickEnterServerModel_Enable", 0) == 1

function QuickEnterServerModel:ctor()
	self._serverList = nil
end

function QuickEnterServerModel:initList()
	if not self._serverList then
		self._serverList = {}

		local str = PlayerPrefsHelper.getString("QuickEnterServerModel_ServerList" .. self:getLoginUrl(), "")

		if not string.nilorempty(str) then
			self._serverList = cjson.decode(str)
		end
	end
end

function QuickEnterServerModel:addLastEnterServer(ip, port, name, id)
	self:initList()

	for i, v in ipairs(self._serverList) do
		if v.name == name then
			v.ip = ip
			v.port = port
			v.id = id

			table.remove(self._serverList, i)
			table.insert(self._serverList, 1, v)
			self:saveServerList()

			return
		end
	end

	if #self._serverList >= 5 then
		table.remove(self._serverList, 5)
	end

	table.insert(self._serverList, 1, {
		ip = ip,
		port = port,
		name = name,
		id = id
	})
	self:saveServerList()
end

function QuickEnterServerModel:saveServerList()
	PlayerPrefsHelper.setString("QuickEnterServerModel_ServerList" .. self:getLoginUrl(), cjson.encode(self._serverList))
end

function QuickEnterServerModel:getLastEnterServerList()
	self:initList()

	return self._serverList
end

function QuickEnterServerModel:setLastIndex(index)
	PlayerPrefsHelper.setNumber("QuickEnterServerModel_LastIndex" .. self:getLoginUrl(), index)
end

function QuickEnterServerModel:getLastIndex()
	return PlayerPrefsHelper.getNumber("QuickEnterServerModel_LastIndex" .. self:getLoginUrl(), 0)
end

function QuickEnterServerModel:getLoginUrl()
	return (LoginController.instance:get_getSessionIdUrl(LoginModel.instance:getUseBackup()))
end

QuickEnterServerModel.instance = QuickEnterServerModel.New()

return QuickEnterServerModel
