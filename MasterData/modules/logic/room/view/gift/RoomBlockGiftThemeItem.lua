-- chunkname: @modules/logic/room/view/gift/RoomBlockGiftThemeItem.lua

module("modules.logic.room.view.gift.RoomBlockGiftThemeItem", package.seeall)

local RoomBlockGiftThemeItem = class("RoomBlockGiftThemeItem", LuaCompBase)

function RoomBlockGiftThemeItem:ctor(clonneGos)
	self.gotitle = clonneGos.gotitle
	self.goBlockItem = clonneGos.goBlockItem
	self.goBuildingItem = clonneGos.goBuildingItem
end

function RoomBlockGiftThemeItem:init(go)
	self.go = go
	self.itemRoot = gohelper.findChild(go, "item")

	local gotitle = gohelper.clone(self.gotitle, go)

	self.txttitle = gohelper.findChildText(gotitle, "#txt_styleName")
	self.txttitleNum = gohelper.findChildText(gotitle, "#txt_styleName/#txt_num")

	gohelper.setSibling(gotitle, 0)
	gohelper.setActive(gotitle, true)

	self._gridlayout = self.itemRoot:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
end

function RoomBlockGiftThemeItem:addEventListeners()
	self.addEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSelect, self._refreshSelect, self)
end

function RoomBlockGiftThemeItem:removeEventListeners()
	self.removeEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSelect, self._refreshSelect, self)
end

function RoomBlockGiftThemeItem:onUpdateMO(mo, subType)
	local themeCo = RoomConfig.instance:getThemeConfig(mo.themeId)

	self.moList = mo.moList
	self.subType = subType

	local cellsizeX, cellsizeY, spacingX, spacingY
	local subTypeInfo = RoomBlockGiftEnum.SubTypeInfo[subType]

	self._gridlayout.cellSize = Vector2(subTypeInfo.CellSize[1], subTypeInfo.CellSize[2])
	self._gridlayout.spacing = Vector2(subTypeInfo.CellSpacing[1] - 15, subTypeInfo.CellSpacing[2])

	if self.moList then
		for i, mo in ipairs(self.moList) do
			local item = self:_isBuilding(subType) and self:_getBuildingItem(i) or self:_getBlockItem(i)

			item:onUpdateMO(mo)

			local isSelect = mo.isSelect

			item:onSelect(isSelect)
		end

		if self._blockItems then
			for i, item in ipairs(self._blockItems) do
				local isActive = not self:_isBuilding(subType) and i <= #self.moList

				item:setActive(isActive)
			end
		end

		if self._buildingItems then
			for i, item in ipairs(self._buildingItems) do
				local isActive = self:_isBuilding(subType) and i <= #self.moList

				item:setActive(isActive)
			end
		end
	end

	self.txttitle.text = themeCo.name

	local colloctCount = self.moList and RoomBlockBuildingGiftModel.instance:getThemeColloctCount(self.moList) or 0

	if self.moList then
		if not #self.moList then
			local totalCount = 0
			local format = colloctCount == totalCount and "roomblockgift_colloctcount2" or "roomblockgift_colloctcount1"

			self.txttitleNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang(format), colloctCount, totalCount)
		end
	end
end

function RoomBlockGiftThemeItem:_isBuilding(subType)
	return subType == RoomBlockGiftEnum.SubType[2]
end

function RoomBlockGiftThemeItem:_getBlockItem(index)
	self._blockItems = self._blockItems or self:getUserDataTb_()

	local item = self._blockItems[index]

	if not item then
		local go = gohelper.clone(self.goBlockItem, self.itemRoot)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomBlockGiftPackageItem)
		self._blockItems[index] = item
	end

	return item
end

function RoomBlockGiftThemeItem:_getBuildingItem(index)
	self._buildingItems = self._buildingItems or self:getUserDataTb_()

	local item = self._buildingItems[index]

	if not item then
		local go = gohelper.clone(self.goBuildingItem, self.itemRoot)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomBlockGiftBuildingItem)
		self._buildingItems[index] = item
	end

	return item
end

function RoomBlockGiftThemeItem:_refreshSelect()
	if self.moList then
		for i, mo in ipairs(self.moList) do
			local item = self:_isBuilding(self.subType) and self:_getBuildingItem(i) or self:_getBlockItem(i)
			local isSelect = mo.isSelect

			item:onSelect(isSelect)
		end
	end
end

function RoomBlockGiftThemeItem:setActive(isActive)
	gohelper.setActive(self.go, isActive)
end

return RoomBlockGiftThemeItem
