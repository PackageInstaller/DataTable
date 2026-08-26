-- chunkname: @modules/logic/login/model/ServerListModel.lua

module("modules.logic.login.model.ServerListModel", package.seeall)

local ServerListModel = class("ServerListModel", ListScrollModel)

function ServerListModel:setServerList(zoneInfos)
	local moMaintainList = {}
	local moAvailableList = {}
	local moFullList = {}

	for _, zone in ipairs(zoneInfos) do
		local serverMO = ServerMO.New()

		serverMO:init(zone)

		if serverMO.state == 0 then
			table.insert(moMaintainList, serverMO)
		elseif serverMO.state == 1 then
			table.insert(moAvailableList, serverMO)
		elseif serverMO.state == 2 then
			table.insert(moFullList, serverMO)
		end
	end

	local moFinal = {}

	for _, mo in ipairs(moAvailableList) do
		table.insert(moFinal, mo)
	end

	for _, mo in ipairs(moFullList) do
		table.insert(moFinal, mo)
	end

	for _, mo in ipairs(moMaintainList) do
		table.insert(moFinal, mo)
	end

	self:setList(moFinal)
end

ServerListModel.instance = ServerListModel.New()

return ServerListModel
