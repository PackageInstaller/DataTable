-- chunkname: @modules/logic/room/view/record/RoomTradeLevelUnlockItem.lua

module("modules.logic.room.view.record.RoomTradeLevelUnlockItem", package.seeall)

local RoomTradeLevelUnlockItem = class("RoomTradeLevelUnlockItem", BaseView)

function RoomTradeLevelUnlockItem:onInitView()
	self._imagebg = gohelper.findChildImage(self.viewGO, "normal/#image_bg")
	self._txtnum = gohelper.findChildText(self.viewGO, "normal/prop/#txt_num")
	self._goprop = gohelper.findChild(self.viewGO, "normal/prop")
	self._imagepropicon = gohelper.findChildSingleImage(self.viewGO, "normal/prop/propicon")
	self._imageicon = gohelper.findChildImage(self.viewGO, "normal/#image_icon")
	self._simagepropicon = gohelper.findChildSingleImage(self.viewGO, "normal/prop/propicon")
	self._txtname = gohelper.findChildText(self.viewGO, "normal/txt/#txt_name")
	self._gonum = gohelper.findChild(self.viewGO, "normal/txt/#go_num")
	self._txtcur = gohelper.findChildText(self.viewGO, "normal/txt/#go_num/#txt_cur")
	self._txtnext = gohelper.findChildText(self.viewGO, "normal/txt/#go_num/#txt_next")
	self._goup = gohelper.findChild(self.viewGO, "normal/go_up")
	self._gonew = gohelper.findChild(self.viewGO, "normal/go_new")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTradeLevelUnlockItem:addEvents()
	return
end

function RoomTradeLevelUnlockItem:removeEvents()
	return
end

function RoomTradeLevelUnlockItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function RoomTradeLevelUnlockItem:addEventListeners()
	self:addEvents()
end

function RoomTradeLevelUnlockItem:removeEventListeners()
	self:removeEvents()
end

function RoomTradeLevelUnlockItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self._imagebg.gameObject)

	self._click:AddClickListener(self._btnClickOnClick, self)
end

function RoomTradeLevelUnlockItem:_btnClickOnClick()
	if not self._mo or not self._mo.type then
		return
	end

	if self._co.itemType == 1 and self._mo.buildingId then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Building, self._mo.buildingId)
	elseif self._mo.type == RoomTradeEnum.LevelUnlock.GetBouns then
		local split = string.split(self._mo.bouns, "#")

		MaterialTipController.instance:showMaterialInfo(split[1], split[2])
	end
end

function RoomTradeLevelUnlockItem:onStart()
	return
end

function RoomTradeLevelUnlockItem:onDestroy()
	self._imagepropicon:UnLoadImage()
	self._simagepropicon:UnLoadImage()

	if self._click then
		self._click:RemoveClickListener()
	end
end

function RoomTradeLevelUnlockItem:onRefreshMo(mo)
	self._co = RoomTradeConfig.instance:getLevelUnlockCo(mo.type)
	self._mo = mo

	if self._co then
		self._txtname.text = self._co.name

		gohelper.setActive(self._goup, self._co.type == 2)
		gohelper.setActive(self._gonew.gameObject, self._co.type == 1)

		if mo.type == RoomTradeEnum.LevelUnlock.GetBouns then
			if not string.nilorempty(mo.bouns) then
				local split = string.split(mo.bouns, "#")
				local _, _icon = ItemModel.instance:getItemConfigAndIcon(split[1], split[2])

				if not string.nilorempty(_icon) then
					self._imagepropicon:LoadImage(_icon)
				end

				self._txtnum.text = luaLang("multiple") .. split[3]
			end
		elseif self._co.itemType == 1 and mo.buildingId then
			local buildingicon = RoomTradeTaskModel.instance:getBuildingTaskIcon(mo.buildingId)

			if not string.nilorempty(buildingicon) then
				self._simagepropicon:LoadImage(buildingicon)
			end

			recthelper.setWidth(self._simagepropicon.transform, 308)
			recthelper.setHeight(self._simagepropicon.transform, 277.2)

			self._txtnum.text = ""
		else
			local icon = self._co.icon

			if not string.nilorempty(icon) then
				UISpriteSetMgr.instance:setCritterSprite(self._imageicon, icon)
			end
		end

		local showIcon = mo.type == RoomTradeEnum.LevelUnlock.GetBouns or self._co.itemType == 1

		gohelper.setActive(self._goprop, showIcon)
		gohelper.setActive(self._imageicon.gameObject, not showIcon)
	end

	local isHasNum = LuaUtil.tableNotEmpty(mo.num)

	if isHasNum then
		self._txtcur.text = mo.num.last
		self._txtnext.text = mo.num.cur
	end

	recthelper.setAnchorY(self._imageicon.transform, isHasNum and 0 or 8)
	gohelper.setActive(self._gonum, isHasNum)
end

return RoomTradeLevelUnlockItem
