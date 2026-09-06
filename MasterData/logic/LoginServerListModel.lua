-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/model/LoginServerListModel.lua

module("logic.extensions.login.model.LoginServerListModel", package.seeall)

local LoginServerListModel = class("LoginServerListModel", BaseModel)

LoginServerListModel.rcmWeights = {
	48,
	32,
	21,
	13,
	9,
	5,
	3,
	2,
	1,
	1,
	0
}

function LoginServerListModel:onInit()
	LoginServerListModel.super.onInit(self)
	self:onReset()
end

function LoginServerListModel:onReset()
	LoginServerListModel.super.onReset(self)

	self._sortedServers = {}
	self._baseNumber = {}
	self._moList = {}
	self._fullServers = {}
end

function LoginServerListModel:popActiveServer(areaId)
	if not areaId then
		for k, v in pairs(self._moList) do
			local svr = self:popActiveServer(k)

			if svr then
				return svr
			end
		end

		return
	end

	if not self._sortedServers[areaId] or #self._sortedServers[areaId] == 0 then
		self:sortServers(areaId)
	end

	while true do
		local svr, baseNumber = self:_popActiveServer(self._sortedServers[areaId], self._baseNumber[areaId])

		self._baseNumber[areaId] = baseNumber

		if not svr or not self:isServerFull(areaId, svr.id) then
			return svr
		end
	end
end

function LoginServerListModel:_popActiveServer(sortedServers, baseNumber)
	if not sortedServers then
		return
	end

	local len = #sortedServers

	if len == 0 then
		return
	end

	local rate = math.random(1, baseNumber)
	local w = 0
	local idx

	for i = 1, len do
		if rate <= w + sortedServers[i].weight then
			idx = i

			break
		end

		w = w + sortedServers[i].weight
	end

	idx = idx or 1

	local svr = sortedServers[idx]

	if svr then
		table.remove(sortedServers, idx)

		baseNumber = baseNumber - svr.weight
	end

	return svr, baseNumber
end

function LoginServerListModel:pushActiveServer(svr)
	local areaId = svr.areaId
	local sortedServers, baseNumber = self:_pushActiveServer(svr, self._sortedServers[areaId], self._baseNumber[areaId])

	self._sortedServers[areaId] = sortedServers
	self._baseNumber[areaId] = baseNumber
end

function LoginServerListModel:_pushActiveServer(svr, sortedServers, baseNumber)
	local areaId = svr.areaId

	if self:isServerFull(areaId, svr.id) then
		return sortedServers, baseNumber
	end

	sortedServers = sortedServers or {}
	baseNumber = baseNumber or 0

	if not table.indexof(sortedServers, svr) then
		table.insert(sortedServers, svr)

		baseNumber = baseNumber + svr.weight
	end

	return sortedServers, baseNumber
end

function LoginServerListModel:getServerByZoneId(areaId, serverZoneId)
	if serverZoneId ~= nil then
		serverZoneId = checknumber(serverZoneId)

		if not self._moList[areaId] then
			for i = 1, #self._moList[areaId] do
				if self._moList[areaId][i].id == serverZoneId then
					return self._moList[areaId][i]
				end
			end
		end
	end

	return self:popActiveServer(areaId)
end

function LoginServerListModel:isServerFull(areaId, id)
	return self._fullServers[areaId] and self._fullServers[areaId][id]
end

function LoginServerListModel:setServerFull(areaId, id)
	self._fullServers[areaId] = self._fullServers[areaId] or {}
	self._fullServers[areaId][id] = true
end

function LoginServerListModel:setMoList(areaId, moList)
	self._moList[areaId] = moList

	table.sort(moList, function(x, y)
		return checknumber(x.id) < checknumber(y.id)
	end)

	for i = 1, #moList do
		if not moList[i].state then
			if not LoginServerListModel.rcmWeights[moList[i].state + 1] then
				moList[i].weight = 0
				moList[i].areaId = areaId
			end
		end
	end

	self:sortServers(areaId)
end

function LoginServerListModel:sortServers(areaId)
	if not areaId then
		for k, v in pairs(self._moList) do
			self:sortServers(k)
		end

		return
	end

	self._fullServers[areaId] = nil

	local sortedServers, baseNumber = self:_sortServers(areaId)

	self._sortedServers[areaId] = sortedServers
	self._baseNumber[areaId] = baseNumber
end

function LoginServerListModel:_sortServers(areaId, withFull)
	if not self._moList[areaId] then
		local sortedServers = {}
		local baseNumber = 0

		for k, v in pairs(self._moList[areaId]) do
			if not self:isServerFull(areaId, v.id) and (withFull or v.state ~= 10) then
				baseNumber = baseNumber + v.weight

				table.insert(sortedServers, v)
			end
		end

		return sortedServers, baseNumber
	end
end

function LoginServerListModel:getMoList()
	return self._moList or {}
end

LoginServerListModel.instance = LoginServerListModel.New()

return LoginServerListModel
