-- chunkname: @modules/logic/room/view/critter/detail/RoomCritterDetailAttrItem.lua

module("modules.logic.room.view.critter.detail.RoomCritterDetailAttrItem", package.seeall)

local RoomCritterDetailAttrItem = class("RoomCritterDetailAttrItem", LuaCompBase)

function RoomCritterDetailAttrItem:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#txt_name/#image_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._txtratio = gohelper.findChildText(self.viewGO, "#txt_ratio")
	self._goArrow = gohelper.findChild(self.viewGO, "#txt_ratio/arrow")
	self._goClick = gohelper.findChild(self.viewGO, "#txt_ratio/arrow/clickarea")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterDetailAttrItem:addEvents()
	return
end

function RoomCritterDetailAttrItem:removeEvents()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end
end

function RoomCritterDetailAttrItem:onClick()
	return
end

function RoomCritterDetailAttrItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function RoomCritterDetailAttrItem:addEventListeners()
	self:addEvents()
end

function RoomCritterDetailAttrItem:removeEventListeners()
	self:removeEvents()
end

function RoomCritterDetailAttrItem:_editableInitView()
	self._gobg = gohelper.findChild(self.viewGO, "bg")
end

function RoomCritterDetailAttrItem:onUpdateParam()
	return
end

function RoomCritterDetailAttrItem:onOpen()
	return
end

function RoomCritterDetailAttrItem:onClose()
	return
end

function RoomCritterDetailAttrItem:onDestroyView()
	return
end

function RoomCritterDetailAttrItem:setRatioColor(normal, add)
	self._normalColor = normal
	self._addColor = add
end

function RoomCritterDetailAttrItem:onRefreshMo(mo, index, num, ratio, name, clickCB, callbackObj)
	self._mo = mo

	if self._txtnum then
		self._txtnum.text = num or mo:getValueNum()
	end

	if self._txtratio then
		self._txtratio.text = ratio or mo:getRateStr()
	end

	if self._txtname then
		self._txtname.text = name or mo:getName()
	end

	if self._imageicon and not string.nilorempty(mo:getIcon()) then
		UISpriteSetMgr.instance:setCritterSprite(self._imageicon, mo:getIcon())
	end

	local isAddition = mo:getIsAddition()

	gohelper.setActive(self._goArrow, isAddition)

	self._txtratio.color = GameUtil.parseColor((isAddition or nil) and (self._addColor or self._normalColor))

	if not self._btnClick and self._goClick then
		self._btnClick = SLFramework.UGUI.UIClickListener.Get(self._goClick)

		self._btnClick:AddClickListener(clickCB, callbackObj)
	end

	if self._gobg then
		gohelper.setActive(self._gobg, index % 2 == 0)
	end
end

function RoomCritterDetailAttrItem:setMaturityNum()
	if self._txtratio then
		self._txtratio.text = self._mo:getValueNum()
	end
end

return RoomCritterDetailAttrItem
