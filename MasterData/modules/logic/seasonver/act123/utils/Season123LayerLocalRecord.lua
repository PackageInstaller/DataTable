-- chunkname: @modules/logic/seasonver/act123/utils/Season123LayerLocalRecord.lua

module("modules.logic.seasonver.act123.utils.Season123LayerLocalRecord", package.seeall)

local Season123LayerLocalRecord = class("Season123LayerLocalRecord")

function Season123LayerLocalRecord:init(actId)
	self.activityId = actId
	self.reasonKey = PlayerPrefsKey.Season123LayerAnimAlreadyPlay
	self._localKey = self:getLocalKey()
	self._dict = nil

	self:initLocalSave()
end

function Season123LayerLocalRecord:initLocalSave()
	local rs = PlayerPrefsHelper.getString(self._localKey, "")

	if not string.nilorempty(rs) then
		local mapObj = cjson.decode(rs)

		self._dict = mapObj and mapObj or {}
	else
		self._dict = {}
	end
end

function Season123LayerLocalRecord:add(stage, layer, subModule)
	if not self._dict[stage] then
		if self._dict[stage] < layer then
			self._dict[stage] = layer

			self:save()
		end
	end
end

function Season123LayerLocalRecord:contain(stage, layer, subModule)
	if not self._dict[stage] then
		local oldLayer = 0

		return oldLayer < layer
	end
end

function Season123LayerLocalRecord:save()
	PlayerPrefsHelper.setString(self._localKey, cjson.encode(self._dict))
end

function Season123LayerLocalRecord:getLocalKey()
	return tostring(self.reasonKey) .. "#" .. tostring(self.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return Season123LayerLocalRecord
