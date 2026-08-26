-- chunkname: @modules/logic/room/view/RoomInitBuildingDegreeItem.lua

module("modules.logic.room.view.RoomInitBuildingDegreeItem", package.seeall)

local RoomInitBuildingDegreeItem = class("RoomInitBuildingDegreeItem", ListScrollCellExtend)

function RoomInitBuildingDegreeItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInitBuildingDegreeItem:addEvents()
	return
end

function RoomInitBuildingDegreeItem:removeEvents()
	return
end

function RoomInitBuildingDegreeItem:_editableInitView()
	self._go = self.viewGO
	self._goline = gohelper.findChild(self.viewGO, "line")
	self._txtdegree = gohelper.findChildText(self.viewGO, "txt_degree")
	self._goicon = gohelper.findChild(self.viewGO, "icon")
	self._goblockicon = gohelper.findChild(self.viewGO, "block_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "txt_name")
	self._txtcount = gohelper.findChildText(self.viewGO, "txt_count")
end

function RoomInitBuildingDegreeItem:onUpdateMO(mo)
	self._showDegreeMO = mo

	self:_refreshUI()
end

function RoomInitBuildingDegreeItem:_refreshUI()
	local mo = self._showDegreeMO

	if not mo then
		return
	end

	local isBlock = mo.degreeType == 1

	if self._lastIsBlock ~= isBlock then
		self._lastIsBlock = isBlock

		gohelper.setActive(self._goline, isBlock)
		gohelper.setActive(self._goblockicon, isBlock)
		gohelper.setActive(self._goicon, not isBlock)
	end

	self._txtcount.text = luaLang("multiple") .. mo.count
	self._txtname.text = isBlock and luaLang("p_roominitbuilding_plane") or mo.name
	self._txtdegree.text = mo.degree
end

function RoomInitBuildingDegreeItem:onDestroy()
	return
end

return RoomInitBuildingDegreeItem
