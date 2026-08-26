-- chunkname: @modules/logic/seasonver/act123/utils/Season123UnlockLocalRecord.lua

module("modules.logic.seasonver.act123.utils.Season123UnlockLocalRecord", package.seeall)

local Season123UnlockLocalRecord = class("Season123UnlockLocalRecord")

function Season123UnlockLocalRecord:init(actId, reasonKey)
	self.activityId = actId
	self.reasonKey = reasonKey
	self._localKey = self:getLocalKey()
	self._dict = nil
	self._moduleSet = {}

	self:initLocalSave()
end

function Season123UnlockLocalRecord:initLocalSave()
	if string.nilorempty(self._localKey) then
		return
	end

	local rs = PlayerPrefsHelper.getString(self._localKey, "")

	if not string.nilorempty(rs) then
		local mapObj = cjson.decode(rs)

		if mapObj then
			self._dict = mapObj

			for subModule, list in pairs(mapObj) do
				self._moduleSet[subModule] = {}

				for i, id in ipairs(list) do
					self._moduleSet[subModule][id] = true
				end
			end
		else
			self._dict = {}
		end
	else
		self._dict = {}
	end
end

function Season123UnlockLocalRecord:add(id, subModule)
	if string.nilorempty(self._localKey) then
		return
	end

	self._moduleSet[subModule] = self._moduleSet[subModule] or {}

	if not self._moduleSet[subModule][id] then
		self._moduleSet[subModule][id] = true
		self._dict[subModule] = self._dict[subModule] or {}

		table.insert(self._dict[subModule], id)
		self:save()
	end
end

function Season123UnlockLocalRecord:contain(id, subModule)
	if string.nilorempty(self._localKey) then
		return false
	end

	return self._moduleSet[subModule] and self._moduleSet[subModule][id]
end

function Season123UnlockLocalRecord:save()
	if string.nilorempty(self._localKey) then
		return
	end

	PlayerPrefsHelper.setString(self._localKey, cjson.encode(self._dict))
end

function Season123UnlockLocalRecord:getLocalKey()
	return tostring(self.reasonKey) .. "#" .. tostring(self.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return Season123UnlockLocalRecord
