-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Tile.lua

local sf = string.format

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Tile", package.seeall)

local V3a7_Wmz_GameItem_Tile = class("V3a7_Wmz_GameItem_Tile", V3a7_Wmz_GameItem_Cell)

function V3a7_Wmz_GameItem_Tile:unbind(...)
	self._mo:unbind(...)
end

function V3a7_Wmz_GameItem_Tile:bind(...)
	self._mo:bind(...)
end

function V3a7_Wmz_GameItem_Tile:ctor(...)
	V3a7_Wmz_GameItem_Tile.super.ctor(self, ...)

	self._drag = UIDragListenerHelper.New()
end

function V3a7_Wmz_GameItem_Tile:_editableInitView()
	V3a7_Wmz_GameItem_Tile.super._editableInitView(self)

	self._btnClick = gohelper.findChildClick(self._godragArea, "")

	self:_editableInitView_drag()
end

function V3a7_Wmz_GameItem_Tile:_editableAddEvents()
	self._btnClick:AddClickListener(self._onBtnClick, self)
end

function V3a7_Wmz_GameItem_Tile:_editableRemoveEvents()
	self._btnClick:RemoveClickListener()
end

function V3a7_Wmz_GameItem_Tile:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
	V3a7_Wmz_GameItem_Tile.super.onDestroyView(self)
end

function V3a7_Wmz_GameItem_Tile:_editableInitView_drag()
	gohelper.setActive(self._godragArea, true)
	self._drag:create(self._godragArea, self)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventDragging, self._onDrag, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)
end

function V3a7_Wmz_GameItem_Tile:_onDragBegin(...)
	if not self:bPlayingZone() then
		return
	end

	local p = self:parent()

	p:onDragBegin(self, ...)
end

function V3a7_Wmz_GameItem_Tile:_onDrag(...)
	if not self:bPlayingZone() then
		return
	end

	local p = self:parent()

	p:onDrag(self, ...)
end

function V3a7_Wmz_GameItem_Tile:_onDragEnd(...)
	if not self:bPlayingZone() then
		return
	end

	local p = self:parent()

	p:onDragEnd(self, ...)
end

function V3a7_Wmz_GameItem_Tile:setData(mo)
	V3a7_Wmz_GameItem_Tile.super.setData(self, mo)
	self:_debug_refresh()
end

function V3a7_Wmz_GameItem_Tile:_onBtnClick()
	return
end

function V3a7_Wmz_GameItem_Tile:getTileItem()
	return self
end

function V3a7_Wmz_GameItem_Tile:getCellItem()
	local p = self:parent()

	return p:getCellItem(self:xy())
end

function V3a7_Wmz_GameItem_Tile:_debug_refresh()
	if not WmzEnum.rDir then
		return
	end

	local ptDebugName = WmzEnum.nameOfPT(self:pathType())

	self:setName(sf("%s: %s", self:indexStr(), ptDebugName))
end

function V3a7_Wmz_GameItem_Tile:_refreshBorder()
	local isCompleted = self:isCompleted() or self:bZoneCompleted()

	if isCompleted then
		self:_setAsCellBorder()
	else
		self:_setAsTileBorder()
	end
end

function V3a7_Wmz_GameItem_Tile:onCompleteZone(bCompleted)
	V3a7_Wmz_GameItem_Tile.super.onCompleteZone(self, bCompleted)
	self:_refreshBorder()
end

return V3a7_Wmz_GameItem_Tile
