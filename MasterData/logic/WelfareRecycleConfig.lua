-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfareequiprecycle/config/WelfareRecycleConfig.lua

module("logic.extensions.welfareequiprecycle.config.WelfareRecycleConfig", package.seeall)

local WelfareRecycleConfig = class("WelfareRecycleConfig", BaseConfig)

function WelfareRecycleConfig:getNames()
	return {
		"throne_equipment_replace",
		"throne_equipment_replace_image",
		"throne_equipment_replace_common"
	}
end

function WelfareRecycleConfig:handleConfig(name, content)
	if name == "throne_equipment_replace" then
		self._throne_equipment_replace = content
	elseif name == "throne_equipment_replace_image" then
		self._throne_equipment_replace_image = content
	elseif name == "throne_equipment_replace_common" then
		self._throne_equipment_replace_common = content
	end
end

function WelfareRecycleConfig:getReplaceCfgByActId(actId)
	return self._throne_equipment_replace[actId]
end

function WelfareRecycleConfig:getReplaceCfgById(actId, type, id)
	if self._throne_equipment_replace[actId] and self._throne_equipment_replace[actId][type] then
		return self._throne_equipment_replace[actId][type][id]
	end
end

function WelfareRecycleConfig:getImageById(actId)
	return self._throne_equipment_replace_image[actId]
end

function WelfareRecycleConfig:getCommonValue(key)
	local obj = self._throne_equipment_replace_common[key]

	if obj then
		return obj.value
	end

	return nil
end

WelfareRecycleConfig.instance = WelfareRecycleConfig.New()

return WelfareRecycleConfig
