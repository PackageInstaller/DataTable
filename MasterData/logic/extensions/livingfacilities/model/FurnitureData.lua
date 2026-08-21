-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/model/FurnitureData.lua

module("logic.extensions.livingfacilities.model.FurnitureData", package.seeall)

local M = class("FurnitureData", ItemData)

function M:ctor(params)
	M.super.ctor(self, params)
end

function M:getGroup()
	return self._itemInfo.group
end

function M:getTheme()
	return self._itemInfo.theme
end

function M:getZoneTypes()
	return self._itemInfo.zoneTypes or {}
end

function M:getIsOnline()
	return self._itemInfo.isOnline == 1
end

function M:getDecomposeReward()
	if not self._decomposeReward then
		self._decomposeReward = {}

		local decomposeRewardStr = self._itemInfo.decomposeReward

		for code, count in string.gmatch(decomposeRewardStr, "(%d+):(%d+)") do
			table.insert(self._decomposeReward, {
				code = tonumber(code),
				count = tonumber(count)
			})
		end
	end

	return self._decomposeReward[1] or {}
end

function M:getCanUse(roomType)
	if table.indexof(self:getZoneTypes(), roomType) then
		return self:getIsOnline()
	elseif #self:getZoneTypes() == 0 or self:getZoneTypes()[1] == 0 then
		return self:getIsOnline()
	else
		return false
	end
end

function M:isUsing()
	return HouseFurnitureModel.instance:getIsFurnitureInUse(tonumber(self._uuid))
end

function M:getAtmosphere()
	return self._itemInfo.atmosphere
end

function M:getAtmosphereSpecial()
	return self._itemInfo.atmosphereSpecial
end

function M:getCfgSpAtmosValAndTyp()
	local lst = self:getAtmosphereSpecial()
	local val, typ = 0, 0

	if lst and #lst == 2 then
		local roomTyp = lst[1]
		local cfg = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseLiveRoom, roomTyp)

		if cfg then
			val, typ = lst[2], cfg.atmosphere
		end
	end

	return val, typ
end

function M:getResPath()
	return self._itemInfo.resPath
end

function M:getCoordSize()
	return self._itemInfo.coordSize
end

function M:getCoordZLen()
	return self._itemInfo.coordZLen
end

function M:getOperaType()
	return self._itemInfo.operaType
end

function M:getIsShowBag()
	return true
end

function M:getSubType()
	return self._itemInfo.subType
end

return M
