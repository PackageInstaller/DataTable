-- chunkname: @modules/logic/versionactivity3_9/racingcar/model/V3a9RacingRoleListModel.lua

module("modules.logic.versionactivity3_9.racingcar.model.V3a9RacingRoleListModel", package.seeall)

local V3a9RacingRoleListModel = class("V3a9RacingRoleListModel", ListScrollModel)

function V3a9RacingRoleListModel:setMoList()
	local mos = self:getMos()

	if not mos then
		return
	end

	if not self._moList then
		self._moList = {}

		for _, mo in pairs(mos) do
			table.insert(self._moList, mo)
		end

		table.sort(self._moList, function(a, b)
			return a:getId() < b:getId()
		end)
	end

	self:setList(self._moList)
end

function V3a9RacingRoleListModel:onGetInfos(ids)
	local mos = self:getMos()

	if not mos then
		return
	end

	local list = {}

	if ids then
		for i = 1, #ids do
			list[ids[i]] = true
		end
	end

	for id, mo in pairs(mos) do
		mo:setUnlock(list[id])
	end
end

function V3a9RacingRoleListModel:getMoList()
	if not self._moList then
		self._moList = {}

		for _, co in ipairs(lua_racing_racer.configList) do
			local mo = V3a9RacingRoleMO.New()

			mo:init(co)
			table.insert(self._moList, mo)
		end
	end

	return self._moList
end

function V3a9RacingRoleListModel:getMos()
	if not self._mos then
		self._mos = {}

		for _, co in ipairs(lua_racing_racer.configList) do
			if co.display == 1 then
				local mo = V3a9RacingRoleMO.New()

				mo:init(co)

				self._mos[co.id] = mo
			end
		end
	end

	return self._mos
end

function V3a9RacingRoleListModel:onUnlockRole(id)
	if not id then
		return
	end

	if self._mos then
		local mo = self._mos[id]

		if not mo then
			return
		end

		mo:setUnlock(true)
	end
end

V3a9RacingRoleListModel.instance = V3a9RacingRoleListModel.New()

return V3a9RacingRoleListModel
