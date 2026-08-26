-- chunkname: @modules/logic/settings/model/SettingsKeyListModel.lua

module("modules.logic.settings.model.SettingsKeyListModel", package.seeall)

local SettingsKeyListModel = class("SettingsKeyListModel", ListScrollModel)

function SettingsKeyListModel:Init()
	self._keyMaps = PCInputController.instance:getKeyMap()
end

function SettingsKeyListModel:SetActivity(id)
	self:clear()

	local keys = self._keyMaps[id]

	if keys then
		local list = {}

		for _, v in ipairs(keys) do
			if v.editable == 1 then
				table.insert(list, {
					id = v.id,
					value = v
				})
			end
		end

		table.sort(list, function(a, b)
			return a.id < b.id
		end)
		self:setList(list)
	end
end

function SettingsKeyListModel:Reset(index)
	PCInputModel.instance:Reset(index)

	self._keyMaps = PCInputController.instance:getKeyMap()

	self:SetActivity(index)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyTipsChange)
end

function SettingsKeyListModel:modifyKey(activityId, keyId, key)
	local keys = self._keyMaps[activityId]

	if not keys or not keys[keyId] then
		logError("SettingsKeyListModel:modifyKey error, activityId = %s, keyId = %s", activityId, keyId)

		return
	end

	keys[keyId][4] = key

	self:SetActivity(activityId)
	self:saveKeyMap()
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyTipsChange)
end

function SettingsKeyListModel:checkDunplicateKey(activityId, key)
	local keys = self._keyMaps[activityId]

	if not keys then
		logError("SettingsKeyListModel:checkDunplicateKey error, activityId = %s, keyId = %s", activityId, key)

		return
	end

	for _, v in pairs(keys) do
		if v.key == key then
			return v
		end
	end

	return nil
end

function SettingsKeyListModel:saveKeyMap()
	PCInputController.instance:saveKeyMap(self._keyMaps)
end

SettingsKeyListModel.instance = SettingsKeyListModel.New()

return SettingsKeyListModel
