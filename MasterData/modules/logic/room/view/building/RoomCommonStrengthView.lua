-- chunkname: @modules/logic/room/view/building/RoomCommonStrengthView.lua

module("modules.logic.room.view.building.RoomCommonStrengthView", package.seeall)

local RoomCommonStrengthView = class("RoomCommonStrengthView", BaseView)

function RoomCommonStrengthView:onInitView()
	self._goline1 = gohelper.findChild(self.viewGO, "lines/#go_line1")
	self._goline2 = gohelper.findChild(self.viewGO, "lines/#go_line2")
	self._goproductItem = gohelper.findChild(self.viewGO, "strengthen/productContent/#go_productItem")
	self._gotips = gohelper.findChild(self.viewGO, "strengthen/productContent/#go_tips")
	self._txtresourceRequireDetail = gohelper.findChildText(self.viewGO, "strengthen/productContent/#go_tips/#txt_resourceRequireDetail")
	self._godetail = gohelper.findChild(self.viewGO, "#go_detail")
	self._gonextslotitem = gohelper.findChild(self.viewGO, "#go_detail/scroll_nextproductslot/viewport/content/#go_nextslotitem")
	self._txtnext = gohelper.findChildText(self.viewGO, "#go_detail/#txt_next")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "strengthen/productContent/btn/#btn_close")
	self._btnclosedetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_detail/#btn_closedetail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCommonStrengthView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclosedetail:AddClickListener(self._btnclosedetailOnClick, self)
end

function RoomCommonStrengthView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclosedetail:RemoveClickListener()
end

function RoomCommonStrengthView:_btncloseOnClick()
	self:_applyLevelChange()
	self:closeThis()
end

function RoomCommonStrengthView:_btndetailOnClick(index)
	local levelGroupItem = self._levelGroupItemList[index]

	if not self._levels[index] then
		self:_refreshSlot(self._nextSlotItemList, self._gonextslotitem, levelGroupItem.levelGroup, self._levels[index] + 1)

		local maxLevel = RoomConfig.instance:getProductionLineLevelGroupMaxLevel(levelGroupItem.levelGroup)

		self._txtnext.text = maxLevel <= self._levels[index] and luaLang("room_building_maxlevel") or luaLang("room_building_nextlevel")

		local posX, posY, posZ = transformhelper.getPos(levelGroupItem.godetail.transform)

		transformhelper.setPos(self._godetail.transform, posX, posY, posZ)
		gohelper.setActive(self._godetail.gameObject, true)
	end
end

function RoomCommonStrengthView:_btnaddOnClick(index)
	self:_levelChange(index, 1)
end

function RoomCommonStrengthView:_btnclosedetailOnClick()
	gohelper.setActive(self._godetail.gameObject, false)
end

function RoomCommonStrengthView:_levelChange(index, change)
	local newLevels = tabletool.copy(self._levels)

	newLevels[index] = math.max(0, (self._levels[index] or 0) + change)

	local canLevelUp, errorCode = self:canLevelUp(newLevels, change > 0)

	if not canLevelUp then
		if errorCode == -1 then
			GameFacade.showToast(ToastEnum.RoomErrorCantLevup)

			return
		elseif errorCode == -3 then
			GameFacade.showToast(ToastEnum.RoomErrorCantLevup2)

			return
		end
	end

	if change > 0 then
		local levelGroups = {
			self._productionLineMO.config.levelGroup
		}
		local cost = self:getLevelUpCost(levelGroups[index], newLevels[index])
		local costConfig = ItemModel.instance:getItemConfig(cost.type, cost.id)

		GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeLevelUp, MsgBoxEnum.BoxType.Yes_No, function()
			self._levels = newLevels

			self:_refreshStrength()
		end, nil, nil, nil, nil, nil, cost.quantity, costConfig.name)
	elseif change < 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeLevelDown, MsgBoxEnum.BoxType.Yes_No, function()
			self._levels = newLevels

			self:_refreshStrength()
		end)
	end
end

function RoomCommonStrengthView:_applyLevelChange()
	if not self._productionLineId then
		return
	end

	local dirty = self._productionLineMO.level ~= self._levels[1]

	if dirty then
		RoomRpc.instance:sendProductionLineLvUpRequest(self._productionLineId, self._levels[1])
	end
end

function RoomCommonStrengthView:_editableInitView()
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._godetail, false)
	gohelper.setActive(self._goproductItem, false)
	gohelper.setActive(self._gonextslotitem, false)

	self._levelGroupItemList = {}
	self._nextSlotItemList = {}
end

function RoomCommonStrengthView:_refreshUI()
	self:_refreshStrength()
end

function RoomCommonStrengthView:_refreshStrength()
	local levelGroups = {
		self._productionLineMO.config.levelGroup
	}

	gohelper.setActive(self._goline1, #levelGroups == 2)
	gohelper.setActive(self._goline2, #levelGroups == 3)

	for i, levelGroup in ipairs(levelGroups) do
		local levelGroupItem = self._levelGroupItemList[i]

		if not levelGroupItem then
			levelGroupItem = self:getUserDataTb_()
			levelGroupItem.index = i
			levelGroupItem.go = gohelper.cloneInPlace(self._goproductItem, "item" .. i)
			levelGroupItem.gored1 = gohelper.findChild(levelGroupItem.go, "iconbg/go_red1")
			levelGroupItem.gored2 = gohelper.findChild(levelGroupItem.go, "iconbg/go_red2")
			levelGroupItem.simageproducticon = gohelper.findChildSingleImage(levelGroupItem.go, "simage_producticon")
			levelGroupItem.txtname = gohelper.findChildText(levelGroupItem.go, "name/txt_name")
			levelGroupItem.txtlv = gohelper.findChildText(levelGroupItem.go, "txt_lv")
			levelGroupItem.godetail = gohelper.findChild(levelGroupItem.go, "go_detail")
			levelGroupItem.btndetail = gohelper.findChildButtonWithAudio(levelGroupItem.go, "name/txt_name/btn_detail")
			levelGroupItem.btnadd = gohelper.findChildButtonWithAudio(levelGroupItem.go, "btn_add")
			levelGroupItem.goslotitem = gohelper.findChild(levelGroupItem.go, "scroll_productslot/viewport/content/go_slotitem")
			levelGroupItem.gostrengthitem = gohelper.findChild(levelGroupItem.go, "coinList/coinItem")
			levelGroupItem.slotItemList = {}
			levelGroupItem.strengthItemList = {}

			gohelper.setActive(levelGroupItem.gored1, i % 2 == 0)
			gohelper.setActive(levelGroupItem.gored2, i % 2 == 1)
			gohelper.addUIClickAudio(levelGroupItem.btndetail.gameObject, AudioEnum.UI.Play_UI_Taskinterface)
			gohelper.addUIClickAudio(levelGroupItem.btnadd.gameObject, AudioEnum.UI.UI_Common_Click)
			levelGroupItem.btndetail:AddClickListener(self._btndetailOnClick, self, levelGroupItem.index)
			levelGroupItem.btnadd:AddClickListener(self._btnaddOnClick, self, levelGroupItem.index)
			gohelper.setActive(levelGroupItem.goslotitem, false)
			gohelper.setActive(levelGroupItem.gostrengthitem, false)
			table.insert(self._levelGroupItemList, levelGroupItem)
		end

		levelGroupItem.levelGroup = levelGroup

		if not self._levels[i] then
			local level = 0
			local maxLevel = RoomConfig.instance:getProductionLineLevelGroupMaxLevel(levelGroup)
			local levelConfig = RoomConfig.instance:getProductionLineLevelConfig(levelGroup, level)

			levelGroupItem.simageproducticon:LoadImage(ResUrl.getRoomImage("modulepart/" .. levelConfig.icon))

			levelGroupItem.txtname.text = self._productionLineMO.config.name
			levelGroupItem.txtlv.text = string.format("Lv.%s", level)
			levelGroupItem.btnadd.button.enabled = level < maxLevel

			ZProj.UGUIHelper.SetGrayscale(levelGroupItem.btnadd.gameObject, maxLevel <= level)
			self:_refreshSlot(levelGroupItem.slotItemList, levelGroupItem.goslotitem, levelGroup, level)
			self:_refreshStrengthItem(levelGroupItem, levelGroup, level)
			gohelper.setActive(levelGroupItem.go, true)
		end
	end

	for i = #levelGroups + 1, #self._levelGroupItemList do
		local levelGroupItem = self._levelGroupItemList[i]

		gohelper.setActive(levelGroupItem.go, false)
	end

	gohelper.setAsLastSibling(self._gotips)
end

function RoomCommonStrengthView:_refreshSlot(slotItemList, goslotitem, levelGroup, level)
	local slotList = {}

	if level == 0 then
		local levelGroupInfo = RoomConfig.instance:getProductionLineLevelConfig(levelGroup, level)

		if not string.nilorempty(levelGroupInfo.desc) then
			table.insert(slotList, {
				desc = string.format("<color=#57503B>%s</color>", levelGroupInfo.desc)
			})
		end
	else
		local levelGroupConfig = RoomConfig.instance:getProductionLineLevelConfig(levelGroup, level)

		if levelGroupConfig then
			table.insert(slotList, {
				desc = string.format("<color=#608C54>%s</color>", levelGroupConfig.desc)
			})
		end
	end

	for i, slot in ipairs(slotList) do
		local slotItem = slotItemList[i]

		if not slotItem then
			slotItem = self:getUserDataTb_()
			slotItem.go = gohelper.cloneInPlace(goslotitem, "item" .. i)
			slotItem.gopoint1 = gohelper.findChild(slotItem.go, "go_point1")
			slotItem.gopoint2 = gohelper.findChild(slotItem.go, "go_point2")
			slotItem.txtslotdesc = gohelper.findChildText(slotItem.go, "")

			gohelper.setActive(slotItem.gopoint1, i % 2 == 1)
			gohelper.setActive(slotItem.gopoint2, i % 2 == 0)
			table.insert(slotItemList, slotItem)
		end

		slotItem.txtslotdesc.text = slot.desc

		gohelper.setActive(slotItem.go, true)
	end

	for i = #slotList + 1, #slotItemList do
		local slotItem = slotItemList[i]

		gohelper.setActive(slotItem.go, false)
	end
end

function RoomCommonStrengthView:_refreshStrengthItem(levelGroupItem, levelGroup, level)
	local maxLevel = 1

	for i = 1, maxLevel do
		local strengthItem = levelGroupItem.strengthItemList[i]

		if not strengthItem then
			strengthItem = self:getUserDataTb_()
			strengthItem.go = gohelper.cloneInPlace(levelGroupItem.gostrengthitem, "item" .. i)
			strengthItem.simageicon = gohelper.findChildSingleImage(strengthItem.go, "coin")

			table.insert(levelGroupItem.strengthItemList, strengthItem)
		end

		gohelper.setActive(strengthItem.simageicon.gameObject, level > 1)

		if level > 1 then
			local levelGroupConfig = RoomConfig.instance:getProductionLineLevelConfig(levelGroup, level)
			local cost = levelGroupConfig.cost
			local costParam = string.splitToNumber(cost, "#")
			local icon = ItemModel.instance:getItemSmallIcon(costParam[2])

			strengthItem.simageicon:LoadImage(icon)
		end

		gohelper.setActive(strengthItem.go, true)
	end

	for i = maxLevel + 1, #levelGroupItem.strengthItemList do
		local strengthItem = levelGroupItem.strengthItemList[i]

		gohelper.setActive(strengthItem.go, false)
	end
end

function RoomCommonStrengthView:_updateBuildingLevels(buildingUid)
	self._levels = {
		self._productionLineMO.level
	}

	self:_refreshStrength()
end

function RoomCommonStrengthView:_onEscape()
	if self._gotips.activeInHierarchy then
		gohelper.setActive(self._gotips, false)

		return
	end

	if self._godetail.activeInHierarchy then
		gohelper.setActive(self._godetail, false)

		return
	end

	self:_applyLevelChange()
	self:closeThis()
end

function RoomCommonStrengthView:onOpen()
	self._productionLineId = self.viewParam.lineMO.id
	self._productionLineMO = self.viewParam.lineMO
	self._levels = {
		self._productionLineMO.level
	}

	gohelper.addUIClickAudio(self._btnclose.gameObject, AudioEnum.UI.Play_UI_Rolesback)
	self:_refreshUI()
	self.addEventCb(self, RoomController.instance, RoomEvent.ProduceLineLevelUp, self._updateBuildingLevels, self)
	NavigateMgr.instance:addEscape(ViewName.RoomCommonStrengthView, self._onEscape, self)
end

function RoomCommonStrengthView:onUpdateParam()
	self._productionLineId = self.viewParam.lineMO.id
	self._productionLineMO = self.viewParam.lineMO
	self._levels = {
		self._productionLineMO.level
	}

	self:_refreshUI()
end

function RoomCommonStrengthView:onClose()
	return
end

function RoomCommonStrengthView:onDestroyView()
	for i, levelGroupItem in ipairs(self._levelGroupItemList) do
		levelGroupItem.simageproducticon:UnLoadImage()
		levelGroupItem.btndetail:RemoveClickListener()
		levelGroupItem.btnadd:RemoveClickListener()

		for j, strengthItem in ipairs(levelGroupItem.strengthItemList) do
			strengthItem.simageicon:UnLoadImage()
		end
	end
end

function RoomCommonStrengthView:canLevelUp(newLevels, isLevelUp)
	local items = self:getLevelUpCostItems(newLevels)
	local _, enough = ItemModel.instance:hasEnoughItems(items)

	if not enough then
		local specialItems = {}

		for i, item in ipairs(items) do
			if item.type == MaterialEnum.MaterialType.Item and item.id == RoomBuildingEnum.SpecialStrengthItemId then
				table.insert(specialItems, tabletool.copy(item))
			end
		end

		local _, specialEnough = ItemModel.instance:hasEnoughItems(specialItems)

		if not specialEnough then
			return false, -3
		else
			return false, -1
		end
	end

	return true
end

function RoomCommonStrengthView:getLevelUpCostItems(newLevels)
	local levelGroups = {
		self._productionLineMO.config.levelGroup
	}
	local originalLevels = {
		self._productionLineMO.level
	}
	local items = {}

	for i, newLevel in ipairs(newLevels) do
		if not originalLevels[i] then
			local originalLevel = 1
			local minLevel = math.min(originalLevel, newLevel)
			local maxLevel = math.max(originalLevel, newLevel)
			local rate = originalLevel < newLevel and 1 or -1

			for level = minLevel + 1, maxLevel do
				local cost = self:getLevelUpCost(levelGroups[i], level)

				cost.quantity = rate * cost.quantity

				table.insert(items, cost)
			end
		end
	end

	return items
end

function RoomCommonStrengthView:getLevelUpCost(levelGroup, level)
	local levelGroupConfig = RoomConfig.instance:getProductionLineLevelConfig(levelGroup, level)
	local cost = levelGroupConfig.cost
	local costParam = string.splitToNumber(cost, "#")

	return {
		type = costParam[1],
		id = costParam[2],
		quantity = costParam[3]
	}
end

return RoomCommonStrengthView
