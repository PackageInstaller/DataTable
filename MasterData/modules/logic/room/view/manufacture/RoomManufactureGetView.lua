-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureGetView.lua

module("modules.logic.room.view.manufacture.RoomManufactureGetView", package.seeall)

local RoomManufactureGetView = class("RoomManufactureGetView", BaseView)

function RoomManufactureGetView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollproduct = gohelper.findChildScrollRect(self.viewGO, "#scroll_product")
	self._goproductitem = gohelper.findChild(self.viewGO, "#scroll_product/Viewport/Content/#go_productitem")
	self._gonormalLayout = gohelper.findChild(self.viewGO, "#scroll_product/Viewport/Content/#go_normalLayout")
	self._gousedTitle = gohelper.findChild(self.viewGO, "#scroll_product/Viewport/Content/txt_tips")
	self._gousedLayout = gohelper.findChild(self.viewGO, "#scroll_product/Viewport/Content/#go_usedLayout")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureGetView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomManufactureGetView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RoomManufactureGetView:_btncloseOnClick()
	self:closeThis()
end

function RoomManufactureGetView:_editableInitView()
	gohelper.setActive(self._goproductitem, false)
end

function RoomManufactureGetView:onUpdateParam()
	if self.viewParam then
		self.normalList = self.viewParam.normalList
		self.usedList = self.viewParam.usedList
	end

	self.normalList = self.normalList or {}
	self.usedList = self.usedList or {}
end

function RoomManufactureGetView:onOpen()
	self:onUpdateParam()
	self:setNormalList()
	self:setUsedList()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shouhuo_2_2)
end

function RoomManufactureGetView:setNormalList()
	gohelper.CreateObjList(self, self._onSeItem, self.normalList, self._gonormalLayout, self._goproductitem)
end

function RoomManufactureGetView:setUsedList()
	if self.usedList then
		local isHasUsed = #self.usedList > 0

		gohelper.setActive(self._gousedTitle, isHasUsed)
		gohelper.setActive(self._gousedLayout, isHasUsed)
		gohelper.CreateObjList(self, self._onSeItem, self.usedList, self._gousedLayout, self._goproductitem)
	end
end

function RoomManufactureGetView:_onSeItem(obj, data, index)
	local isShowExtra = data.isShowExtra
	local goExtra = gohelper.findChild(obj, "tag_extra")
	local goExtraEff = gohelper.findChild(obj, "#baoji")

	gohelper.setActive(goExtra, isShowExtra)
	gohelper.setActive(goExtraEff, isShowExtra)

	local goIcon = gohelper.findChild(obj, "go_icon")
	local itemIcon = IconMgr.instance:getCommonItemIcon(goIcon)

	itemIcon:isShowQuality(false)

	local countBg = itemIcon:getCountBg()
	local count = itemIcon:getCount()
	local transCountBg = countBg.transform
	local transCount = count.transform

	recthelper.setAnchorY(transCountBg, RoomManufactureEnum.ItemCountBgY)
	recthelper.setAnchorY(transCount, RoomManufactureEnum.ItemCountY)
	itemIcon:onUpdateMO(data)

	local imgquality = gohelper.findChildImage(obj, "#image_quality")
	local rare = itemIcon:getRare()
	local qualityImg = RoomManufactureEnum.RareImageMap[rare]

	UISpriteSetMgr.instance:setCritterSprite(imgquality, qualityImg)
end

function RoomManufactureGetView:onClose()
	return
end

function RoomManufactureGetView:onDestroyView()
	return
end

return RoomManufactureGetView
