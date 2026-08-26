-- chunkname: @modules/logic/versionactivity3_3/arcade/model/handbook/ArcadeHandBookItemMO.lua

module("modules.logic.versionactivity3_3.arcade.model.handbook.ArcadeHandBookItemMO", package.seeall)

local ArcadeHandBookItemMO = class("ArcadeHandBookItemMO", ArcadeHandBookMO)

function ArcadeHandBookItemMO:_setSize()
	if self:isSpecialIconSize() then
		local minSize = ArcadeEnum.HandBookItemParams.MinSize

		self._sizeX = minSize
		self._sizeY = minSize
	else
		ArcadeHandBookItemMO.super._setSize(self)
	end
end

function ArcadeHandBookItemMO:getDesc()
	local desc = self.co.describe

	if not string.nilorempty(desc) then
		desc = ArcadeConfig.instance:getCollectionDesc(self.co.id, true)
	end

	return desc or ""
end

function ArcadeHandBookItemMO:isSpecialIconSize()
	return self.co.id == 13005
end

function ArcadeHandBookItemMO:getIconRectSize()
	if self:isSpecialIconSize() then
		return 128, 256
	else
		return self:getIconSize()
	end
end

return ArcadeHandBookItemMO
