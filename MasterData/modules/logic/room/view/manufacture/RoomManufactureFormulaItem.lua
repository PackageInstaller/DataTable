-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureFormulaItem.lua

module("modules.logic.room.view.manufacture.RoomManufactureFormulaItem", package.seeall)

local RoomManufactureFormulaItem = class("RoomManufactureFormulaItem", ListScrollCellExtend)

function RoomManufactureFormulaItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureFormulaItem:addEvents()
	self._btnneedMatClick:AddClickListener(self.onClick, self)
	self._btnnoMatClick:AddClickListener(self.onClick, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onItemChanged, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onItemChanged, self)
end

function RoomManufactureFormulaItem:removeEvents()
	self._btnneedMatClick:RemoveClickListener()
	self._btnnoMatClick:RemoveClickListener()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onItemChanged, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onItemChanged, self)
end

function RoomManufactureFormulaItem:onClick()
	ManufactureController.instance:clickFormulaItem(self.id)
end

function RoomManufactureFormulaItem:onMatClick(matData)
	local type = matData.type
	local id = matData.id

	MaterialTipController.instance:showMaterialInfo(type, id)
end

function RoomManufactureFormulaItem:_onItemChanged()
	self:refreshItem()
	self:refreshMats()
end

function RoomManufactureFormulaItem:_editableInitView()
	self._goneedMat = gohelper.findChild(self.viewGO, "#go_needMat")
	self._btnneedMatClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_needMat/#btn_productClick")
	self._imgneedMatRareBg = gohelper.findChildImage(self.viewGO, "#go_needMat/content/head/#image_quality")
	self._goneedMatItem = gohelper.findChild(self.viewGO, "#go_needMat/content/head/#go_item")
	self._txtneedMatproductionName = gohelper.findChildText(self.viewGO, "#go_needMat/content/#txt_productionName")
	self._golayoutmat = gohelper.findChild(self.viewGO, "#go_needMat/content/layout_mat")
	self._gomatItem = gohelper.findChild(self.viewGO, "#go_needMat/content/layout_mat/#go_matItem")
	self._txtneedMattime = gohelper.findChildText(self.viewGO, "#go_needMat/content/time/#txt_time")
	self._txtneedMatnum = gohelper.findChildText(self.viewGO, "#go_needMat/num/#txt_num")
	self._goneedtraced = gohelper.findChild(self.viewGO, "#go_needMat/#go_traced")
	self._txtneed = gohelper.findChildText(self.viewGO, "#go_needMat/#txt_need")
	self._gonoMat = gohelper.findChild(self.viewGO, "#go_noMat")
	self._btnnoMatClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_noMat/#btn_productClick")
	self._imgnoMatRareBg = gohelper.findChildImage(self.viewGO, "#go_noMat/content/head/#image_quality")
	self._gonoMatitem = gohelper.findChild(self.viewGO, "#go_noMat/content/head/#go_item")
	self._txtnoMatproductionName = gohelper.findChildText(self.viewGO, "#go_noMat/content/#txt_productionName")
	self._txtnoMattime = gohelper.findChildText(self.viewGO, "#go_noMat/content/time/#txt_time")
	self._txtnoMatnum = gohelper.findChildText(self.viewGO, "#go_noMat/num/#txt_num")
	self._gonomattraced = gohelper.findChild(self.viewGO, "#go_noMat/#go_traced")
	self._txtnomatneed = gohelper.findChildText(self.viewGO, "#go_noMat/#txt_need")
	self.matItemList = {}

	gohelper.setActive(self._gomatItem, false)
end

function RoomManufactureFormulaItem:onUpdateMO(mo)
	self.id = mo.id
	self.buildingUid = mo.buildingUid

	self:refreshItem()
	self:refreshMats()
	self:refreshTime()
end

function RoomManufactureFormulaItem:refreshItem()
	local itemId = ManufactureConfig.instance:getItemId(self.id)

	if not itemId then
		return
	end

	if not self._itemIcon then
		self._itemIcon = IconMgr.instance:getCommonItemIcon(self._goneedMatItem)

		self._itemIcon:isShowQuality(false)
	end

	local batchIconPath = ManufactureConfig.instance:getBatchIconPath(self.id)

	self._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, itemId, nil, nil, nil, {
		specificIcon = batchIconPath
	})

	local rare = self._itemIcon:getRare()
	local qualityImg = RoomManufactureEnum.RareImageMap[rare]

	UISpriteSetMgr.instance:setCritterSprite(self._imgneedMatRareBg, qualityImg)
	UISpriteSetMgr.instance:setCritterSprite(self._imgnoMatRareBg, qualityImg)
	self:refreshItemName()
	self:refreshItemNum()

	local needCount, isTracedLack = ManufactureModel.instance:getLackMatCount(self.id)
	local showNeedText = needCount and needCount ~= 0

	if showNeedText then
		local langStr = isTracedLack and luaLang("room_manufacture_traced_count") or luaLang("room_manufacture_formula_need_count")
		local text = GameUtil.getSubPlaceholderLuaLangOneParam(langStr, needCount)

		if self._txtneed then
			self._txtneed.text = text
		end

		if self._txtnomatneed then
			self._txtnomatneed.text = text
		end
	end

	gohelper.setActive(self._txtneed, showNeedText)
	gohelper.setActive(self._txtnomatneed, showNeedText)

	local isTraced = RoomTradeModel.instance:isTracedGoods(self.id)

	gohelper.setActive(self._goneedtraced, isTraced)
	gohelper.setActive(self._gonomattraced, isTraced)
end

function RoomManufactureFormulaItem:refreshItemName()
	local itemName = ManufactureConfig.instance:getManufactureItemName(self.id)

	self._txtneedMatproductionName.text = itemName
	self._txtnoMatproductionName.text = itemName
end

function RoomManufactureFormulaItem:refreshItemNum()
	local hasQuantity = ManufactureModel.instance:getManufactureItemCount(self.id)
	local strQuantity = formatLuaLang("materialtipview_itemquantity", hasQuantity)

	self._txtneedMatnum.text = strQuantity
	self._txtnoMatnum.text = strQuantity
end

function RoomManufactureFormulaItem:refreshMats()
	local matList = ManufactureConfig.instance:getNeedMatItemList(self.id)

	if matList then
		if not #matList then
			local matCount = 0
			local hasMat = matCount > 0
			local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self.buildingUid)
			local buildingType = buildingMO and buildingMO.config.buildingType

			if hasMat then
				for index, matData in ipairs(matList) do
					local manufactureItemId = matData.id
					local needQuantity = matData.quantity
					local matItem = self:getMatItem(index)
					local itemId = ManufactureConfig.instance:getItemId(manufactureItemId)
					local _, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, itemId)

					if not string.nilorempty(icon) then
						matItem.icon:LoadImage(icon)
					end

					matItem.txtunitNum.text = needQuantity

					local hasTemp = false
					local isEnough = false
					local hasQuantity, inSlotCount = ManufactureModel.instance:getManufactureItemCount(manufactureItemId, true, true)
					local canUsePreBuildingItem = ManufactureModel.instance:hasPathLinkedToThisBuildingType(manufactureItemId, buildingType)

					if canUsePreBuildingItem then
						hasTemp = inSlotCount and inSlotCount > 0

						local inSlotCompleteCount = ManufactureModel.instance:getManufactureItemCountInSlotQueue(manufactureItemId, true, true)

						isEnough = needQuantity <= hasQuantity + inSlotCompleteCount
					else
						isEnough = needQuantity <= hasQuantity
					end

					local strNum = ""

					if hasTemp then
						local str = isEnough and luaLang("room_manufacture_item_mat_count") or luaLang("room_manufacture_item_mat_count_not_enough")

						strNum = GameUtil.getSubPlaceholderLuaLangTwoParam(str, hasQuantity, inSlotCount)
					else
						strNum = isEnough and hasQuantity or string.format("<color=#BE4343>%s</color>", hasQuantity)
					end

					matItem.txthasNum.text = strNum

					matItem.btnClick:RemoveClickListener()
					matItem.btnClick:AddClickListener(self.onMatClick, self, {
						type = MaterialEnum.MaterialType.Item,
						id = itemId
					})
					gohelper.setActive(matItem.go, true)
				end

				for i = matCount + 1, #self.matItemList do
					gohelper.setActive(self.matItemList[i].go, false)
				end
			end

			gohelper.setActive(self._goneedMat, hasMat)
			gohelper.setActive(self._gonoMat, not hasMat)

			if self._itemIcon then
				self._itemIcon.tr:SetParent((hasMat or nil) and (self._goneedMatItem.transform or self._gonoMatitem.transform))
				recthelper.setAnchor(self._itemIcon.tr, 0, 0)
			end
		end
	end
end

function RoomManufactureFormulaItem:getMatItem(index)
	local matItem = self.matItemList[index]

	if not matItem then
		matItem = self:getUserDataTb_()
		matItem.go = gohelper.clone(self._gomatItem, self._golayoutmat, index)
		matItem.icon = gohelper.findChildSingleImage(matItem.go, "#simage_productionIcon")
		matItem.txtunitNum = gohelper.findChildText(matItem.go, "#simage_productionIcon/#txt_unitNum")
		matItem.txthasNum = gohelper.findChildText(matItem.go, "#txt_hasNum")
		matItem.goline = gohelper.findChild(matItem.go, "#go_line")
		matItem.btnClick = gohelper.findChildClickWithAudio(matItem.go, "#btn_click", AudioEnum.UI.Store_Good_Click)

		table.insert(self.matItemList, matItem)
	end

	return matItem
end

function RoomManufactureFormulaItem:refreshTime()
	local needTimeSce = ManufactureConfig.instance:getNeedTime(self.id)
	local time = ManufactureController.instance:getFormatTime(needTimeSce)

	self._txtneedMattime.text = time
	self._txtnoMattime.text = time
end

function RoomManufactureFormulaItem:onDestroyView()
	for _, matItem in ipairs(self.matItemList) do
		if matItem.icon then
			matItem.icon:UnLoadImage()

			matItem.icon = nil
		end

		if matItem.btnClick then
			matItem.btnClick:RemoveClickListener()
		end
	end
end

return RoomManufactureFormulaItem
