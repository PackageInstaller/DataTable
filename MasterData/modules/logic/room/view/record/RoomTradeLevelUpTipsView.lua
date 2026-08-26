-- chunkname: @modules/logic/room/view/record/RoomTradeLevelUpTipsView.lua

module("modules.logic.room.view.record.RoomTradeLevelUpTipsView", package.seeall)

local RoomTradeLevelUpTipsView = class("RoomTradeLevelUpTipsView", BaseView)

function RoomTradeLevelUpTipsView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagecaidai = gohelper.findChildSingleImage(self.viewGO, "#simage_caidai")
	self._txtname = gohelper.findChildText(self.viewGO, "title/#txt_name")
	self._txttype = gohelper.findChildText(self.viewGO, "title/#txt_type")
	self._scrolllevelup = gohelper.findChildScrollRect(self.viewGO, "#scroll_levelup")
	self._goinfo = gohelper.findChild(self.viewGO, "#scroll_levelup/Viewport/Content/levelupInfo/#go_info")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTradeLevelUpTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomTradeLevelUpTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RoomTradeLevelUpTipsView:_btncloseOnClick()
	self:closeThis()
end

function RoomTradeLevelUpTipsView:_editableInitView()
	gohelper.setActive(self._goinfo, false)
end

function RoomTradeLevelUpTipsView:onOpen()
	self.tradeLevel = self.viewParam.level

	if self.tradeLevel then
		self:_updateLevelInfo(self.tradeLevel)
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
end

function RoomTradeLevelUpTipsView:onUpdateParam()
	self.tradeLevel = self.viewParam.level
end

function RoomTradeLevelUpTipsView:onClickModalMask()
	self:closeThis()
end

function RoomTradeLevelUpTipsView:onDestroyView()
	return
end

function RoomTradeLevelUpTipsView:_updateLevelInfo(level)
	local co = ManufactureConfig.instance:getTradeLevelCfg(level)

	self._txtname.text = co.dimension
	self._txttype.text = co.job

	local unlockList = RoomTradeTaskModel.instance:getLevelUnlock(level)
	local levelUnlockList = {}

	if unlockList then
		for i, info in ipairs(unlockList) do
			local type = info.type
			local list = levelUnlockList[type]

			if not list then
				list = {}
				levelUnlockList[type] = list
			end

			table.insert(list, info)
		end
	end

	for type, list in pairs(levelUnlockList) do
		local co = RoomTradeConfig.instance:getLevelUnlockCo(type)

		if co.itemType == 1 then
			if type == RoomTradeEnum.LevelUnlock.BuildingMaxLevel then
				for _, info in ipairs(list) do
					self:_setBuildingMaxLevelItem(info, type)
				end
			else
				self:_setNewBuildingItem(list, type)
			end
		elseif co.itemType == 2 then
			self:_setGetBonusItem(list, type)
		else
			self:setNormalItem(list, type)
		end
	end

	local tempInfoItems = self:getUserDataTb_()

	if self._unlockInfoItems then
		for type, item in pairs(self._unlockInfoItems) do
			table.insert(tempInfoItems, item)
		end

		table.sort(tempInfoItems, self._sortInfoItem)
		self:_sortItem(tempInfoItems)
	end
end

function RoomTradeLevelUpTipsView._sortInfoItem(item1, item2)
	local co1 = item1.co
	local co2 = item2.co

	if co1 and co2 then
		return co1.sort < co2.sort
	end
end

function RoomTradeLevelUpTipsView:_sortItem(tempInfoItems)
	if tempInfoItems then
		for index, item in ipairs(tempInfoItems) do
			item.go.transform:SetSiblingIndex(index)
			gohelper.setActive(item.bgGo, index % 2 == 0)
		end
	end
end

function RoomTradeLevelUpTipsView:_setGetBonusItem(infos, type)
	if not LuaUtil.tableNotEmpty(infos) then
		return
	end

	local item = self:_getInfoItem(type)

	item.co = RoomTradeConfig.instance:getLevelUnlockCo(type)
	item.descTxt.text = item.co.levelupDes
	item.type = type

	for i, info in ipairs(infos) do
		local bouns = info.bouns
		local str = string.split(bouns, "#")
		local type = str[1]
		local id = str[2]
		local count = str[3]

		item.itemList = item.itemList or self:getUserDataTb_()

		local iconItem = item.itemList[i]

		if not iconItem then
			local go = gohelper.cloneInPlace(item.goicon, "item_" .. i)

			iconItem = self:getUserDataTb_()
			iconItem.go = go
			iconItem.icon = IconMgr.instance:getCommonPropItemIcon(go)

			iconItem.icon:setMOValue(type, id, count, nil, true)
			iconItem.icon:setCountFontSize(40)
			iconItem.icon:showStackableNum2()
			iconItem.icon:isShowEffect(true)

			item.itemList[i] = iconItem
		else
			iconItem.icon:setMOValue(type, id, count, nil, true)
		end

		gohelper.setActive(iconItem.go, true)
	end

	gohelper.setActive(item.itemGo, true)
	gohelper.setActive(item.go, true)
end

function RoomTradeLevelUpTipsView:_setNewBuildingItem(infos, type)
	if not LuaUtil.tableNotEmpty(infos) then
		return
	end

	local item = self:_getInfoItem(type)

	item.co = RoomTradeConfig.instance:getLevelUnlockCo(type)
	item.descTxt.text = item.co.levelupDes
	item.type = type

	for i, info in ipairs(infos) do
		item.itemList = item.itemList or self:getUserDataTb_()

		local iconItem = item.itemList[i]

		if not iconItem then
			local go = gohelper.cloneInPlace(item.goicon, "item_" .. i)

			iconItem = self:getUserDataTb_()
			iconItem.go = go
			iconItem.icon = IconMgr.instance:getCommonPropItemIcon(go)

			iconItem.icon:setMOValue(MaterialEnum.MaterialType.Building, info.buildingId, 1, nil, true)
			iconItem.icon:setCountFontSize(40)
			iconItem.icon:showStackableNum2()
			iconItem.icon:isShowEffect(true)
			iconItem.icon:isShowCount(false)

			item.itemList[i] = iconItem
		else
			iconItem.icon:setMOValue(MaterialEnum.MaterialType.Building, info.buildingId, 1, nil, true)
		end

		gohelper.setActive(iconItem.go, true)
	end

	gohelper.setActive(item.itemGo, true)
	gohelper.setActive(item.go, true)
end

function RoomTradeLevelUpTipsView:_setBuildingMaxLevelItem(info, type)
	if not LuaUtil.tableNotEmpty(info) then
		return
	end

	local item = self:_getInfoItem(type)

	item.co = RoomTradeConfig.instance:getLevelUnlockCo(type)
	item.descTxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(item.co.levelupDes, info.num.cur - info.num.last)
	item.type = type
	item.itemList = item.itemList or self:getUserDataTb_()

	local iconItem = item.itemList[1]

	if not iconItem then
		local go = gohelper.cloneInPlace(item.goicon, "item_" .. 1)

		iconItem = self:getUserDataTb_()
		iconItem.go = go
		iconItem.icon = IconMgr.instance:getCommonPropItemIcon(go, "item_" .. 1)

		iconItem.icon:setMOValue(MaterialEnum.MaterialType.Building, info.buildingId, 1, nil, true)
		iconItem.icon:setCountFontSize(40)
		iconItem.icon:showStackableNum2()
		iconItem.icon:isShowEffect(true)
		iconItem.icon:isShowCount(false)

		item.itemList[1] = iconItem
	else
		iconItem.icon:setMOValue(MaterialEnum.MaterialType.Building, info.buildingId, 1, nil, true)
	end

	gohelper.setActive(iconItem.go, true)
	gohelper.setActive(item.itemGo, true)
	gohelper.setActive(item.go, true)
end

function RoomTradeLevelUpTipsView:setNormalItem(infos, type)
	if not LuaUtil.tableNotEmpty(infos) then
		return
	end

	local item = self:_getInfoItem(type)

	item.type = type
	item.co = RoomTradeConfig.instance:getLevelUnlockCo(type)
	item.type = type

	for _, info in ipairs(infos) do
		local num = info.num
		local co = RoomTradeConfig.instance:getLevelUnlockCo(type)

		item.descTxt.text = LuaUtil.tableNotEmpty(num) and GameUtil.getSubPlaceholderLuaLangOneParam(co.levelupDes, num.cur - num.last) or co.levelupDes
	end

	gohelper.setActive(item.go, true)
end

function RoomTradeLevelUpTipsView:_getInfoItem(index)
	self._unlockInfoItems = self._unlockInfoItems or self:getUserDataTb_()

	local item = self._unlockInfoItems[index]

	if not item then
		item = {}

		local go = gohelper.cloneInPlace(self._goinfo, "item_" .. index)

		item.go = go
		item.descTxt = gohelper.findChildText(go, "desc")
		item.itemGo = gohelper.findChild(go, "item")
		item.bgGo = gohelper.findChild(go, "bg")
		item.goicon = gohelper.findChild(go, "item/go_icon")

		gohelper.setActive(item.goicon, false)

		self._unlockInfoItems[index] = item
	end

	return item
end

return RoomTradeLevelUpTipsView
