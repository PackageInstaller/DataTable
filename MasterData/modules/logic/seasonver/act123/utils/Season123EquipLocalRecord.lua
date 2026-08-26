-- chunkname: @modules/logic/seasonver/act123/utils/Season123EquipLocalRecord.lua

module("modules.logic.seasonver.act123.utils.Season123EquipLocalRecord", package.seeall)

local Season123EquipLocalRecord = class("Season123EquipLocalRecord")

function Season123EquipLocalRecord:init(actId, reasonKey)
	self.activityId = actId
	self.reasonKey = reasonKey
	self._list = nil
	self._dict = nil

	self:initLocalSave()
end

function Season123EquipLocalRecord:initLocalSave()
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

function Season123EquipLocalRecord:recordAllItem()
	local equipItemList = Season123Model.instance:getAllUnlockAct123EquipIds(self.activityId) or {}

	for itemId, id in pairs(equipItemList) do
		self:add(itemId)
	end

	self:save()
end

function Season123EquipLocalRecord:add(id)
	if not self._dict[id] then
		table.insert(self._list, id)

		self._dict[id] = 1
	end
end

function Season123EquipLocalRecord:contain(id)
	return self._dict[id]
end

function Season123EquipLocalRecord:save()
	PlayerPrefsHelper.setString(self:getLocalKey(), cjson.encode(self._list))
end

function Season123EquipLocalRecord:getLocalKey()
	return tostring(self.reasonKey) .. "#" .. tostring(self.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return Season123EquipLocalRecord
