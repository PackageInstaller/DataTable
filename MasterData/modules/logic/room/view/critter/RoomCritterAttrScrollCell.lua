-- chunkname: @modules/logic/room/view/critter/RoomCritterAttrScrollCell.lua

module("modules.logic.room.view.critter.RoomCritterAttrScrollCell", package.seeall)

local RoomCritterAttrScrollCell = class("RoomCritterAttrScrollCell", ListScrollCellExtend)

function RoomCritterAttrScrollCell:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#txt_name/#image_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._txtratio = gohelper.findChildText(self.viewGO, "#txt_ratio")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterAttrScrollCell:addEvents()
	return
end

function RoomCritterAttrScrollCell:removeEvents()
	return
end

function RoomCritterAttrScrollCell:_editableInitView()
	return
end

function RoomCritterAttrScrollCell:_editableAddEvents()
	return
end

function RoomCritterAttrScrollCell:_editableRemoveEvents()
	return
end

function RoomCritterAttrScrollCell:getDataMO()
	return self._critterAttributeInfoMO
end

function RoomCritterAttrScrollCell:onUpdateMO(mo)
	self._critterAttributeInfoMO = mo

	self:refreshUI()
end

function RoomCritterAttrScrollCell:onSelect(isSelect)
	return
end

function RoomCritterAttrScrollCell:onDestroyView()
	return
end

function RoomCritterAttrScrollCell:refreshUI()
	local mo = self._critterAttributeInfoMO

	if not mo then
		return
	end

	self._txtnum.text = mo.value
	self._txtratio.text = math.floor(mo.rate * 0.01) * 0.01 .. luaLang("multiple")

	if self._txtname then
		self._txtname.text = mo:getName()
	end

	if self._imageicon and not string.nilorempty(mo:getIcon()) then
		UISpriteSetMgr.instance:setCritterSprite(self._imageicon, mo:getIcon())
	end

	gohelper.setActive(self._goArrow, mo:getIsAddition())
end

return RoomCritterAttrScrollCell
