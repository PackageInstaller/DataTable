-- chunkname: @modules/logic/gm/view/GMAddItemView.lua

module("modules.logic.gm.view.GMAddItemView", package.seeall)

local GMAddItemView = class("GMAddItemView", BaseView)

GMAddItemView.LevelType = "人物等级"
GMAddItemView.HeroAttr = "英雄提升"
GMAddItemView.ClickItem = "ClickItem"
GMAddItemView.Return = "Return"

function GMAddItemView:ctor()
	self._allItems = nil
	self._itemListView = nil
	self._rootType = nil
	self.RootTypes = {
		{
			name = "物品",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Item
		},
		{
			name = "装备",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Equip
		},
		{
			name = "货币",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Currency
		},
		{
			name = "体力药",
			isRoot = 1,
			type = MaterialEnum.MaterialType.PowerPotion
		},
		{
			numTips = "目标等级",
			name = "人物等级",
			isRoot = 0,
			type = GMAddItemView.LevelType
		},
		{
			numTips = "增加经验值",
			name = "人物经验",
			isRoot = 0,
			type = MaterialEnum.MaterialType.Exp
		},
		{
			name = "英雄",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Hero
		},
		{
			name = "英雄提升",
			isRoot = 1,
			type = GMAddItemView.HeroAttr
		},
		{
			name = "英雄皮肤",
			isRoot = 1,
			type = MaterialEnum.MaterialType.HeroSkin
		},
		{
			name = "英雄信赖值",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Faith
		},
		{
			name = "主角技能",
			isRoot = 1,
			type = MaterialEnum.MaterialType.PlayerCloth
		},
		{
			name = "主角技能经验",
			isRoot = 1,
			type = MaterialEnum.MaterialType.PlayerClothExp
		},
		{
			name = "小屋建筑",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Building
		},
		{
			name = "小屋配方",
			isRoot = 1,
			type = MaterialEnum.MaterialType.Formula
		},
		{
			name = "地块包",
			isRoot = 1,
			type = MaterialEnum.MaterialType.BlockPackage
		}
	}
end

function GMAddItemView:_checkBuildItems()
	local function classify(list, list2, type, numTips)
		for i = 1, #list2 do
			local item = list2[i]
			local rare = item.rare

			table.insert(list, {
				itemId = item.id,
				itemIdStr = tostring(item.id),
				type = type,
				name = item.name,
				rare = rare,
				numTips = numTips
			})
		end
	end

	if self._allItems == nil then
		self._allItems = {}

		local oneMO = {
			itemId = 0,
			name = "ALL",
			numTips = "<size=25>等级#洞悉#共鸣#塑造</size>",
			itemIdStr = "0",
			rare = 5,
			type = GMAddItemView.HeroAttr
		}

		table.insert(self._allItems, oneMO)
		classify(self._allItems, lua_item.configList, MaterialEnum.MaterialType.Item, "物品数量")
		classify(self._allItems, lua_equip.configList, MaterialEnum.MaterialType.Equip, "装备数量")
		classify(self._allItems, lua_currency.configList, MaterialEnum.MaterialType.Currency, "货币数量")
		classify(self._allItems, lua_power_item.configList, MaterialEnum.MaterialType.PowerPotion, "体力药数量")
		classify(self._allItems, lua_character.configList, MaterialEnum.MaterialType.Hero, "英雄数量")
		classify(self._allItems, lua_skin.configList, MaterialEnum.MaterialType.HeroSkin, "英雄服装数量")
		classify(self._allItems, lua_character.configList, MaterialEnum.MaterialType.Faith, "增加英雄信赖值")
		classify(self._allItems, lua_cloth.configList, MaterialEnum.MaterialType.PlayerCloth, "服装数量")
		classify(self._allItems, lua_cloth.configList, MaterialEnum.MaterialType.PlayerClothExp, "增加服装经验值")
		classify(self._allItems, lua_room_building.configList, MaterialEnum.MaterialType.Building, "1")
		classify(self._allItems, lua_formula.configList, MaterialEnum.MaterialType.Formula, "1")
		classify(self._allItems, lua_character.configList, GMAddItemView.HeroAttr, "<size=25>等级#洞悉#共鸣#塑造</size>")
		classify(self._allItems, lua_block_package.configList, MaterialEnum.MaterialType.BlockPackage, "数量（不用填）")
	end
end

function GMAddItemView:onInitView()
	self._maskGO = gohelper.findChild(self.viewGO, "addItem")
	self._inpItem = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item2/inpItem")
	self._txtNumPlaceholder = gohelper.findChildText(self.viewGO, "viewport/content/item2/inpNum/Placeholder")

	self:_hideScroll()
end

function GMAddItemView:addEvents()
	SLFramework.UGUI.UIClickListener.Get(self._inpItem.gameObject):AddClickListener(self._onClickInpItem, self, nil)
	SLFramework.UGUI.UIClickListener.Get(self._maskGO):AddClickListener(self._onClickMask, self, nil)
	self._inpItem:AddOnValueChanged(self._onInpValueChanged, self)
end

function GMAddItemView:removeEvents()
	SLFramework.UGUI.UIClickListener.Get(self._inpItem.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._maskGO):RemoveClickListener()
	self._inpItem:RemoveOnValueChanged()
end

function GMAddItemView:onOpen()
	GMController.instance:registerCallback(GMAddItemView.ClickItem, self._onClickItem, self)
	GMController.instance:registerCallback(GMAddItemView.Return, self._onClickReturn, self)
end

function GMAddItemView:onClose()
	GMController.instance:unregisterCallback(GMAddItemView.ClickItem, self._onClickItem, self)
	GMController.instance:unregisterCallback(GMAddItemView.Return, self._onClickReturn, self)
end

function GMAddItemView:_onClickInpItem()
	self:_showScroll()
end

function GMAddItemView:_onClickMask()
	self:_hideScroll()
end

function GMAddItemView:_showScroll()
	gohelper.setActive(self._maskGO, true)
	self:_checkBuildItems()

	self._rootType = nil

	self:_showDefaultItems()
end

function GMAddItemView:_hideScroll()
	gohelper.setActive(self._maskGO, false)

	self._rootType = nil

	GMAddItemModel.instance:clear()
end

function GMAddItemView:_onClickItem(mo)
	if not mo.type then
		return
	end

	if mo.isRoot == 1 then
		self._rootType = mo.type

		self:_showTargetItems()
	else
		self._inpItem:SetText(mo.type .. "#" .. (mo.itemIdStr or ""))
		self:_hideScroll()
	end

	self._txtNumPlaceholder.text = string.nilorempty(mo.numTips) and "Num" or mo.numTips
end

function GMAddItemView:_onClickReturn(mo)
	self._rootType = nil

	self:_showDefaultItems()
end

function GMAddItemView:_onInpValueChanged(inputStr)
	self._rootType = nil

	if string.nilorempty(inputStr) then
		self:_showDefaultItems()
	else
		self:_showTargetItems()
	end
end

function GMAddItemView:_showDefaultItems()
	GMAddItemModel.instance:setList(self.RootTypes)
end

function GMAddItemView:_showTargetItems()
	if not self._allItems then
		return
	end

	if self._rootType then
		local idCounter = 2
		local toShowItems = {}

		table.insert(toShowItems, {
			id = 1,
			name = "返回",
			type = 0
		})

		for i = 1, #self._allItems do
			local item = self._allItems[i]

			if item.type == self._rootType then
				item.id = idCounter
				idCounter = idCounter + 1

				table.insert(toShowItems, item)
			end
		end

		GMAddItemModel.instance:setList(toShowItems)
	else
		local itemIdStr = self._inpItem:GetText()

		if not string.nilorempty(itemIdStr) then
			local idCounter = 1
			local toShowItems = {}

			for i = 1, #self._allItems do
				local item = self._allItems[i]

				if string.find(item.name, itemIdStr) or string.find(item.itemIdStr, itemIdStr) then
					item.id = idCounter
					idCounter = idCounter + 1

					table.insert(toShowItems, item)
				end
			end

			GMAddItemModel.instance:setList(toShowItems)
		else
			GMAddItemModel.instance:setList(self.RootTypes)
		end
	end
end

return GMAddItemView
