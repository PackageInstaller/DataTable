-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Cell.lua

local sf = string.format

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Cell", package.seeall)

local V3a7_Wmz_GameItem_Cell = class("V3a7_Wmz_GameItem_Cell", V3a7_Wmz_GameItemImpl)

function V3a7_Wmz_GameItem_Cell:ctor(...)
	V3a7_Wmz_GameItem_Cell.super.ctor(self, ...)
end

function V3a7_Wmz_GameItem_Cell:_editableInitView()
	V3a7_Wmz_GameItem_Cell.super._editableInitView(self)
end

function V3a7_Wmz_GameItem_Cell:onDestroyView()
	V3a7_Wmz_GameItem_Cell.super.onDestroyView(self)
end

function V3a7_Wmz_GameItem_Cell:setData(mo)
	V3a7_Wmz_GameItem_Cell.super.setData(self, mo)
	self:setActive_goLineStart(false)

	local ePathType = self:pathType()

	self._line0:setData(ePathType)
	self._line1:setData(ePathType)
	self:setActive_goLine(self:bWelded())
	self:_debug_refresh()
end

function V3a7_Wmz_GameItem_Cell:setIndexXY()
	assert(false, "invalid call")
end

function V3a7_Wmz_GameItem_Cell:getTileItem()
	local p = self:parent()

	return p:getTileItem(self:tileId())
end

function V3a7_Wmz_GameItem_Cell:_refreshBorder()
	self:_setAsCellBorder()
end

function V3a7_Wmz_GameItem_Cell:_debug_refresh()
	if not WmzEnum.rDir then
		return
	end

	local floorType = self:floorType()

	self:setName(sf("(%s,%s): %s", self:x(), self:y(), WmzEnum.nameOfFT(floorType)))
end

return V3a7_Wmz_GameItem_Cell
