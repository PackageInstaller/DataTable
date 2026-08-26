-- chunkname: @modules/logic/versionactivity3_3/arcade/view/handbook/ArcadeHandBookItem.lua

module("modules.logic.versionactivity3_3.arcade.view.handbook.ArcadeHandBookItem", package.seeall)

local ArcadeHandBookItem = class("ArcadeHandBookItem", ListScrollCellExtend)

function ArcadeHandBookItem:onInitView()
	self._gounlock = gohelper.findChild(self.viewGO, "#go_unlock")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "#go_unlock/#simage_hero")
	self._imagehero = gohelper.findChildImage(self.viewGO, "#go_unlock/#simage_hero")
	self._goequiped = gohelper.findChild(self.viewGO, "#go_unlock/go_equiped")
	self._gohp = gohelper.findChild(self.viewGO, "#go_unlock/go_hp")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._simagelockhero = gohelper.findChildSingleImage(self.viewGO, "#go_lock/#simage_hero")
	self._imagelockhero = gohelper.findChildImage(self.viewGO, "#go_lock/#simage_hero")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._gobg = gohelper.findChild(self.viewGO, "bg")
	self._goselectbg = gohelper.findChild(self.viewGO, "#go_select/bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeHandBookItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ArcadeHandBookItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function ArcadeHandBookItem:_btnclickOnClick()
	local showtype, showid = ArcadeHandBookModel.instance:getShowTypeId()
	local type, id = self._mo:getType(), self._mo:getId()

	if showtype == type and showid == id then
		return
	end

	ArcadeHandBookModel.instance:setShowTypeId(type, id)

	if self._mo:isNew() then
		self._mo:setNew()
		self._mo:saveNew()
	end

	ArcadeController.instance:dispatchEvent(ArcadeEvent.OnClickHandBookItem, type, id)
end

function ArcadeHandBookItem:_editableInitView()
	gohelper.setActive(self._gohp, false)
end

function ArcadeHandBookItem:_editableAddEvents()
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHandBookItem, self.onSelect, self)
end

function ArcadeHandBookItem:_editableRemoveEvents()
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHandBookItem, self.onSelect, self)
end

function ArcadeHandBookItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshView()
end

function ArcadeHandBookItem:refreshView()
	self:_refreshStatus()

	local icon = self._mo:getIcon()

	if not string.nilorempty(icon) then
		self._simagehero:LoadImage(ResUrl.getEliminateIcon(icon), function()
			self:_setNativeSize(self._imagehero)
		end, self)
		self._simagelockhero:LoadImage(ResUrl.getEliminateIcon(icon), function()
			self:_setNativeSize(self._imagelockhero)
		end, self)
	end

	gohelper.setActive(self._goequiped, false)

	local sizeX, sizeY = self._mo:getIconSize()
	local anchorX, anchorY = self._mo:getAnchor()
	local itemParams = ArcadeEnum.HandBookItemParams
	local rowCount, index = self._mo:getRowInfo()
	local offsetSizeX = 0
	local offsetAnchorX = 0

	if sizeX == itemParams.MinSize then
		offsetSizeX = itemParams.SpaceX

		if index == 1 then
			offsetAnchorX = offsetSizeX
		elseif index == 3 then
			offsetAnchorX = -offsetSizeX
		end
	elseif rowCount == 1 then
		offsetSizeX = itemParams.SpaceX * 3
	end

	sizeX = sizeX + itemParams.DiffX
	sizeY = sizeY + itemParams.DiffY

	recthelper.setAnchor(self.viewGO.transform, anchorX + (sizeX + offsetAnchorX) * 0.5, -anchorY - sizeY * 0.5)

	local _sizex = math.min(sizeX + offsetSizeX, itemParams.MaxWidth)

	recthelper.setSize(self.viewGO.transform, _sizex, sizeY)
	self:onSelect()
end

function ArcadeHandBookItem:_setNativeSize(image)
	if not image then
		return
	end

	if self._mo:isSpecialIconSize() then
		local sizeX, sizeY = self._mo:getIconRectSize()

		recthelper.setSize(image.transform, sizeX, sizeY)
	else
		image:SetNativeSize()
	end
end

function ArcadeHandBookItem:_refreshStatus()
	local isLock = self._mo:isLock()

	gohelper.setActive(self._golock, isLock)
	gohelper.setActive(self._gounlock, not isLock)
	gohelper.setActive(self._goreddot, self._mo:isNew())
	gohelper.setActive(self._gobg, not isLock)
end

function ArcadeHandBookItem:onSelect()
	local isSelect = self:_isSelect()

	gohelper.setActive(self._goselect, isSelect)

	if isSelect then
		gohelper.setAsLastSibling(self.viewGO)
		gohelper.setActive(self._goreddot, false)
	end

	local isLock = self._mo:isLock()

	if not isLock then
		if isSelect then
			if not Color.white then
				self._imagehero.color = GameUtil.parseColor("#808080")
			end
		end
	end
end

function ArcadeHandBookItem:_isSelect()
	local type, id = self._mo:getType(), self._mo:getId()
	local selecttype, selectid = ArcadeHandBookModel.instance:getShowTypeId()

	return type == selecttype and id == selectid
end

function ArcadeHandBookItem:onDestroyView()
	self._simagehero:UnLoadImage()
	self._simagelockhero:UnLoadImage()
end

return ArcadeHandBookItem
