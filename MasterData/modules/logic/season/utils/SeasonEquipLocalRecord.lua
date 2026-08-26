-- chunkname: @modules/logic/season/utils/SeasonEquipLocalRecord.lua

module("modules.logic.season.utils.SeasonEquipLocalRecord", package.seeall)

local SeasonEquipLocalRecord = class("SeasonEquipLocalRecord")

function SeasonEquipLocalRecord:init(actId, reasonKey)
	self.activityId = actId
	self.reasonKey = reasonKey
	self._list = nil
	self._dict = nil

	self:initLocalSave()
end

function SeasonEquipLocalRecord:initLocalSave()
	self._dict = {}

	local rs = PlayerPrefsHelper.getString(self:getLocalKey(), "")

	if not string.nilorempty(rs) then
		self._list = cjson.decode(rs)

		for _, id in ipairs(self._list) do
			self._dict[id] = 1
		end
	else
		self._list = {}
	end
end

function SeasonEquipLocalRecord:recordAllItem()
	local itemMap = Activity104Model.instance:getAllItemMo(self.activityId) or {}

	for itemUid, itemMO in pairs(itemMap) do
		self:add(itemUid)
	end

	self:save()
end

function SeasonEquipLocalRecord:add(id)
	if not self._dict[id] then
		table.insert(self._list, id)

		self._dict[id] = 1
	end
end

function SeasonEquipLocalRecord:contain(id)
	return self._dict[id]
end

function SeasonEquipLocalRecord:save()
	PlayerPrefsHelper.setString(self:getLocalKey(), cjson.encode(self._list))
end

function SeasonEquipLocalRecord:getLocalKey()
	return tostring(self.reasonKey) .. "#" .. tostring(self.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return SeasonEquipLocalRecord
