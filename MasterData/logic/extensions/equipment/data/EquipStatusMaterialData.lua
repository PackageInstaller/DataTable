-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/data/EquipStatusMaterialData.lua

module("logic.extensions.equipment.data.EquipStatusMaterialData", package.seeall)

local M = class("EquipStatusMaterialData")

function M:ctor()
	self.RimScale = false
	self.RimColor = false
	self.RimPower = false
	self.RimOffset = false
	self.RimDepthThreshold = false
end

return M
