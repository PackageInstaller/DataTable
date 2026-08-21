-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/AdditemHacktoolPanelView.lua

module("logic.extensions.hacktool.view.AdditemHacktoolPanelView", package.seeall)

local M = class("AdditemHacktoolPanelView", ViewComponent)
local TabName = {
	RunGroupThread = "RunGroupThread",
	DisplayCard = "DisplayCard",
	Trading = "Trading",
	OneKey = "OneKey",
	Echo = "Echo",
	HeroSkin = "HeroSkin",
	Furniture = "Furniture",
	DiceItem = "DiceItem",
	EchoDebris = "EchoDebris",
	EchoCardPack = "EchoCardPack",
	Hero = "Hero",
	Prop = "Prop",
	Portrait = "Portrait",
	Equip = "Equip",
	System = "System",
	HeroItem = "HeroItem",
	BackgroundItemType = "BackgroundItemType",
	RunGroupEquip = "RunGroupEquip",
	Protomer = "Protomer",
	TreasureBox = "TreasureBox"
}

local function getModelList(cos, filter, isCharacter)
	local model = BaseListModel.New()
	local list = isCharacter and cos[2] or cos

	for k, v in pairs(list) do
		if filter then
			local isInList = false

			if isCharacter then
				isInList = string.find(v.id, filter) or string.find(cos[1][k].name, filter)
			else
				isInList = string.find(v.name, filter) or string.find(v.id, filter)
			end

			if isInList then
				local item = ItemUtil.createItemData({
					count = 1,
					itemId = v.id
				})

				item:setItemMarkType(EventType.ITEM_NORMAL_MARK_TYPE)
				model:addMo(item)
			end
		else
			local item = ItemUtil.createItemData({
				count = 1,
				itemId = v.id
			})

			item:setItemMarkType(EventType.ITEM_NORMAL_MARK_TYPE)
			model:addMo(item)
		end
	end

	return model
end

local map = {
	{
		name = TabName.Prop,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.PropItemType)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.PropItemType
	},
	{
		name = TabName.Equip,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.EquipItemType)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.EquipItemType
	},
	{
		name = TabName.System,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.CurrencyItemType)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.CurrencyItemType
	},
	{
		name = TabName.Echo,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.EchoItemType)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.EchoItemType
	},
	{
		name = TabName.HeroItem,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.HeroItemType)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.HeroItemType
	},
	{
		name = TabName.Hero,
		data = function(filter)
			local cos = {
				PastInfoConfig.instance:getCharacterInfoList(),
				CharacterConfig.instance:getCharacterDataList()
			}

			return getModelList(cos, filter, true)
		end
	},
	{
		name = TabName.Trading,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.HouseItemType)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.HouseItemType
	},
	{
		name = TabName.Protomer,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.ProtomerItemType)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.ProtomerItemType
	},
	{
		name = TabName.OneKey,
		data = function(filter)
			return nil
		end
	},
	{
		name = TabName.Furniture,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.FurnitureItemType)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.FurnitureItemType
	},
	{
		name = TabName.RunGroupEquip,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.RoguelikeEquipType)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.RoguelikeEquipType
	},
	{
		name = TabName.Portrait,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.Portrait)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.Portrait
	},
	{
		name = TabName.DisplayCard,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.DisplayCard)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.DisplayCard
	},
	{
		name = TabName.RunGroupThread,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.RoguelikeClueType)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.RoguelikeClueType
	},
	{
		name = TabName.HeroSkin,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.HeroSkin)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.HeroSkin
	},
	[17] = {
		name = TabName.TreasureBox,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.TreasureBox)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.PropItemType
	},
	[18] = {
		name = TabName.DiceItem,
		data = function(filter)
			local cos = BackpackConfig.instance:getHackDice()

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.DiceItem
	},
	[19] = {
		name = TabName.EchoDebris,
		data = function(filter)
			local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.PuzzlePiecesItem)

			return getModelList(cos, filter, false)
		end,
		backType = GameEnum.ItemTypeEnum.PuzzlePiecesItem
	}
}

function M:ctor()
	self._tabBarList = {}
	self._heroId = nil
end

function M:buildUI()
	self._btnClose = self:getBtn("0&title_view_-878360263")
	self._btnClose1 = self:getBtn("0&title_view_-878360263")
	self._btnHome = self:getBtn("0&title_view_1398742689")
	self.text_txtID = self:getText("additem_hacktool_panel_-840760328")
	self.btn_btnAdd = self:getBtn("additem_hacktool_panel_-542182225")
	self.btn_empty = self:getBtn("additem_hacktool_panel_-403173528")
	self.btnClearHero = self:getBtn("additem_hacktool_panel_-1608943632")
	self.btnAddAllHero = self:getBtn("additem_hacktool_panel_1594399899")
	self.btnAddAllHeroMaxLevel = self:getBtn("additem_hacktool_panel_-1383093869")
	self.btnAddAllHeroMaxConfig = self:getBtn("additem_hacktool_panel_1887722491")
	self.btnResetHeroConfig = self:getBtn("additem_hacktool_panel_-1061557176")
	self.btnDeleteHero = self:getBtn("additem_hacktool_panel_137362439")
	self.btnAddHeroAllAuthorityItems = self:getBtn("additem_hacktool_panel_16815784")
	self.btnAllHeroFull = self:getBtn("additem_hacktool_panel_-886890086")
	self.btnTrading = self:getBtn("additem_hacktool_panel_-1746534130")
	self.btnProtomer = self:getBtn("additem_hacktool_panel_578988740")
	self.input_input = self:getInput("additem_hacktool_panel_-1651678140")
	self.input_Name = self:getInput("additem_hacktool_panel_-202169644")
	self.inputComp_Name = self:getUIComponent("additem_hacktool_panel_-202169644", UIComponentType.InputField)
	self.text_txtName = self:getText("additem_hacktool_panel_1161226351")
	self.dropDownEquipBreach = self:getUIComponent("additem_hacktool_panel_1437267935", UIComponentType.DropdownApapter)
	self.inputEquipLevel = self:getInput("additem_hacktool_panel_-1781124890")
	self.inputHeroLevel = self:getInput("additem_hacktool_panel_245078937")
	self.dropDownEchoBreach = self:getUIComponent("additem_hacktool_panel_798760013", UIComponentType.DropdownApapter)
	self.dropDownHeroPowerLevel = self:getUIComponent("additem_hacktool_panel_-758835689", UIComponentType.DropdownApapter)
	self.dropDownHeroPowerNode = self:getUIComponent("additem_hacktool_panel_-1533061933", UIComponentType.DropdownApapter)
	self.dropDownHeroBreachLevel = self:getUIComponent("additem_hacktool_panel_-1498557075", UIComponentType.DropdownApapter)
	self.inputHeroFavLevel = self:getInput("additem_hacktool_panel_892667850")
	self.go_oneKeyNode = self:getGo("additem_hacktool_panel_1476701741")
	self.go_contentNode = self:getGo("additem_hacktool_panel_-723639693")
	self.goEquipNode = self:getGo("additem_hacktool_panel_-83553293")
	self.goEchoNode = self:getGo("additem_hacktool_panel_1103202736")
	self.goHeroNode = self:getGo("additem_hacktool_panel_-2084412415")
	self.btnAddequipmentView = self:getBtn("additem_hacktool_panel_-952479927")
	self.btnCustomHero = self:getBtn("additem_hacktool_panel_52067269")

	self:_buildTabBarList()

	self._scroll = self:getUIComponent("additem_hacktool_panel_370095053", UIComponentType.ScrollRect)
	self._loopLst = LoopGridViewHelper.New(self._scroll.gameObject)

	self._loopLst:InitGridView(0, self._onCellIconUpdate, self)
end

function M:destroyUI()
	self._loopLst:Dispose()

	self._loopLst = nil
end

function M:_buildTabBarList()
	local barParent = self:getGo("additem_hacktool_panel_-1244151192")

	self._toggleGroup = barParent:GetComponent(UIComponentType.SpaceXToggleGroup)

	local barList = Astral.GameObjectUtil.GetChildren(barParent)
	local togComp = false
	local binderView = false
	local scrollList = Astral.GameObjectUtil.GetChildren(self:getGo("additem_hacktool_panel_1629000457"))
	local scrollObj = false

	for i = 0, barList.Length - 1 do
		togComp = barList[i]:GetComponent(UIComponentType.SpaceXToggle)

		if togComp then
			table.insert(self._tabBarList, {
				togComp = togComp,
				scrollObj = scrollObj
			})
		end
	end

	local btnRole = self:getUIComponent("additem_hacktool_panel_-1623756682")

	goutil.setActive(btnRole.gameObject, false)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickReturn, self)
	self._btnClose1:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self.btn_btnAdd:AddClickListener(self._onClickAddBtn, self)
	self.btn_empty:AddClickListener(self._onClickEmptyBtn, self)
	self.btnClearHero:AddClickListener(self._onClickClearHeroBtn, self)
	self.btnAddAllHero:AddClickListener(self._onClickAddAllHeroBtn, self)
	self.btnAddAllHeroMaxLevel:AddClickListener(self._onClickAddAllMaxLevelHeroBtn, self)
	self.btnAddAllHeroMaxConfig:AddClickListener(self._onClickAddAllHeroMaxConfigBtn, self)
	self.btnResetHeroConfig:AddClickListener(self._onClickResetHeroConfigBtn, self)
	self.btnDeleteHero:AddClickListener(self._onClickDeleteHeroBtn, self)
	self.btnAddHeroAllAuthorityItems:AddClickListener(self._onClickGetAllHeroAuthorityUpgradeItems, self)
	self.btnAllHeroFull:AddClickListener(self._onClickAllHeroFullBtn, self)
	self.input_Name:AddOnValueChanged(self._onNameInputValueChange, self)
	self.btnAddequipmentView:AddClickListener(self._onOpenAddequipmentView, self)
	self.btnCustomHero:AddClickListener(self._onClickCustomHero, self)

	for k, v in ipairs(self._tabBarList) do
		v.togComp:AddListener(function(_, isOn)
			self:_dealBarClick(k, isOn)
		end, nil)
	end
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnClose1:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self.btn_btnAdd:RemoveClickListener()
	self.btn_empty:RemoveClickListener()
	self.btnClearHero:RemoveClickListener()
	self.btnAddAllHero:RemoveClickListener()
	self.btnAddAllHeroMaxLevel:RemoveClickListener()
	self.btnAddAllHeroMaxConfig:RemoveClickListener()
	self.btnResetHeroConfig:RemoveClickListener()
	self.btnDeleteHero:RemoveClickListener()
	self.btnAddHeroAllAuthorityItems:RemoveClickListener()
	self.btnAllHeroFull:RemoveClickListener()
	self.input_Name:RemoveOnValueChanged()
	self.btnAddequipmentView:RemoveClickListener()
	self.btnCustomHero:RemoveClickListener()

	for k, v in ipairs(self._tabBarList) do
		v.togComp:RemoveListener()
	end
end

function M:onEnter()
	self:_fixLoopGrid()

	local barItem = self._tabBarList[1]

	if barItem then
		self._toggleGroup:TryActiveChildOn(barItem.togComp, true)
	end

	GlobalDispatcher:addEventListener(EventType.HERO_POWER_REFRESH_NODE_INFO, self._changeValue, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_NORMAL_MARK_TYPE, self._clickCell, self)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.HERO_POWER_REFRESH_NODE_INFO, self._changeValue, self)
	GlobalDispatcher:removeEventListener(EventType.ITEM_NORMAL_MARK_TYPE, self._clickCell, self)

	self._curMoLst = nil

	self._loopLst:ClearCells()

	if self._toggleGroup then
		self._toggleGroup:SetAllTogglesOff()
	end
end

function M:getBarItem(showType)
	local barItem = self._tabBarList[showType]
	local data = map[showType] and map[showType].data() or BaseListModel.New()

	if barItem and not barItem.binderView and data then
		barItem.binderView = AddItemListBinderView.New(data, barItem.scrollObj, self:getResInstance(ResName.Common_Backpack_Item), AddItemItemCell)

		barItem.binderView:buildUI()
		barItem.binderView:setViewPresentor(self._viewPresentor)
	end

	return barItem
end

function M:_dealBarClick(showType, isOn)
	self._curShowType = showType
	self._selectItemData = nil

	self.inputComp_Name:SetTextWithoutNotify("")

	local tabName = map[showType] and map[showType].name or ""

	goutil.setActive(self.btn_empty.gameObject, tabName ~= TabName.Hero and tabName ~= TabName.OneKey)
	goutil.setActive(self.btnClearHero.gameObject, tabName == TabName.Hero)
	goutil.setActive(self.go_oneKeyNode, tabName == TabName.OneKey)
	goutil.setActive(self.go_contentNode, tabName ~= TabName.OneKey)
	goutil.setActive(self.goEquipNode, tabName == TabName.Equip)
	goutil.setActive(self.goEchoNode, tabName == TabName.Echo)
	goutil.setActive(self.goHeroNode, tabName == TabName.Hero)
	goutil.setActive(self.goHeroNode, tabName == TabName.Hero)
	goutil.setActive(self.input_input.gameObject, tabName ~= TabName.HeroSkin and tabName ~= TabName.BackgroundItemType)
	goutil.setActive(self.btnAddequipmentView.gameObject, tabName == TabName.Equip)
	goutil.setActive(self.btnCustomHero.gameObject, tabName == TabName.Hero)
	self:_refreshLoopLst(nil)
end

function M:_refreshLoopLst(filter)
	local baseListModel = map[self._curShowType] and map[self._curShowType].data(filter) or BaseListModel.New()
	local len = baseListModel and baseListModel:getMoCount() or 0

	self._curMoLst = len > 0 and baseListModel:getMoList() or {}

	self._loopLst:SetListItemCount(len, true)
	self._loopLst:RefreshAllShownItem()

	self._scroll.verticalNormalizedPosition = 1
end

function M:_onCellIconUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local data = self._curMoLst[curIndex]
	local prefabName = "item"
	local item = self._loopLst:NewListViewItem(prefabName)
	local shower = Astral.SimpleLuaComponentContainer.Add(item.transform:GetChild(0).gameObject, AddItemItemCell)

	shower:updateData(data)
	shower:getComponent("num"):setVisible(false)
	shower:getComponent("num"):setCostTextActive(false)
	goutil.setActive(item.transform:GetChild(0).gameObject, true)

	return item
end

function M:_onClickReturn()
	ViewMgr.instance:open(ViewName.HackToolView)
	self:close()
end

function M:_onClickHome()
	if BattleMgr.instance:isInBattle() then
		ToolTipsMgr.showCharacterTopToast("战斗中不响应Home", CommEnum.CharacterTopToastIcon.Info, 1)

		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
	self:close()
end

function M:_onClickClearHeroBtn()
	local data = HackToolUtil.createDeleteAllHeroCmd()

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickAddAllHeroBtn()
	local data = HackToolUtil.createAddNormalHerosCmd()

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickAddAllMaxLevelHeroBtn()
	local data = HackToolUtil.createAddAllFullHerosCmd()

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickAddAllHeroMaxConfigBtn()
	if self._selectItemData then
		local quality = self._selectItemData:getQuality()
		local maxPowerLevel = CharacterExpConfig.instance:getMaxPowerLevelByQuality(quality)
		local maxLevel = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(maxPowerLevel, quality)
		local t = HeroDepotModel.getHeroInfoByID

		self.dropDownHeroPowerLevel.dropdown.value = maxPowerLevel - 1
		self.dropDownHeroPowerNode.dropdown.value = 5

		self.inputHeroLevel:SetText(maxLevel)
		self.inputHeroFavLevel:SetText(10)

		self.dropDownHeroBreachLevel.dropdown.value = 5

		self:_onClickAddBtn()
	else
		FloatWordMgr.instance:show(lang("tip_not_select_obj"))
	end
end

function M:_onOpenAddequipmentView()
	ViewMgr.instance:open(ViewName.AddequipmentHacktoolPanelViewPresentor)
end

function M:checkAddHeroConfig()
	if self._selectItemData then
		local quality = self._selectItemData:getQuality()
		local powerLevel = tonumber(self.dropDownHeroPowerLevel.dropdown.value) + 1
		local maxPowerLevel = CharacterExpConfig.instance:getMaxPowerLevelByQuality(quality)

		if maxPowerLevel < powerLevel then
			FloatWordMgr.instance:show(lang("tip_role_quality_power_max") .. maxPowerLevel)

			return false
		end

		local maxLevel = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(powerLevel, quality)
		local heroLevel = tonumber(self.inputHeroLevel:GetText()) or 1

		heroLevel = heroLevel < 1 and 1 or heroLevel
		heroLevel = heroLevel > 90 and 90 or heroLevel

		self.inputHeroLevel:SetText(heroLevel)

		if maxLevel < heroLevel then
			FloatWordMgr.instance:show(lang("tip_role_quality_power_max_to") .. maxLevel)

			return false
		end

		return true
	else
		return false
	end
end

function M:_onClickDeleteHeroBtn()
	if self._selectItemData then
		local heroId = self._selectItemData:getItemId()
		local heroName = ContainmentUtil.getHeroName(heroId)

		if not HeroDepotModel.instance:getHeroInfoByID(heroId) then
			FloatWordMgr.instance:show(string.format("未拥有角色[%s]%s", heroId, heroName))

			return
		end

		local dialog = Dialog.showMessage("提示", string.format("确认删除角色[%s]%s ?", heroId, heroName))

		dialog:setConfirmListener(function()
			local data = HackToolUtil.createDeleteHeroCmd(heroId)

			HackToolAgent.instance:sendGmRequest(data)
		end, self)
	else
		FloatWordMgr.instance:show(lang("tip_not_select_obj"))
	end
end

function M:_onClickGetAllHeroAuthorityUpgradeItems()
	if self._selectItemData then
		local heroId = self._selectItemData:getItemId()
		local heroName = ContainmentUtil.getHeroName(heroId)

		if not HeroDepotModel.instance:getHeroInfoByID(heroId) then
			FloatWordMgr.instance:show(string.format("未拥有角色[%s]%s", heroId, heroName))

			return
		end

		local dialog = Dialog.showMessage("提示", string.format("确认获得角色[%s]%s 亲和度升级所需材料?", heroId, heroName))

		dialog:setConfirmListener(function()
			local items = {}

			for _, _cfg in ipairs(HeroPowerConfig.instance:getCharacterAllNodeInfos(heroId) or {}) do
				local _cost = _cfg.cost

				for i = 1, #_cost do
					local _num = items[_cost[i].id] or 0

					items[_cost[i].id] = _num + _cost[i].num
				end
			end

			local formatItems = {}

			for _itemId, _num in pairs(items) do
				table.insert(formatItems, {
					itemId = _itemId,
					num = _num
				})
			end

			if #formatItems > 0 then
				local data = HackToolUtil.createAddItemCmd(formatItems)

				HackToolAgent.instance:sendGmRequest(data)
			end
		end, self)
	else
		FloatWordMgr.instance:show(lang("tip_not_select_obj"))
	end
end

function M:_onClickAllHeroFullBtn()
	local dialog = Dialog.showMessage("提示", string.format("确认删除所有角色 ?"))

	dialog:setConfirmListener(function()
		local data = HackToolUtil.createHeroFullAllCmd()

		HackToolAgent.instance:sendGmRequest(data)
	end, self)
end

function M:_onClickResetHeroConfigBtn()
	if self._selectItemData then
		local heroId = self._selectItemData:getItemId()
		local heroName = ContainmentUtil.getHeroName(heroId)

		if not HeroDepotModel.instance:getHeroInfoByID(heroId) then
			FloatWordMgr.instance:show(string.format("未拥有角色[%s]%s", heroId, heroName))

			return
		end

		local dialog = Dialog.showMessage("提示", string.format("确认重置角色[%s]%s ?", heroId, heroName))

		dialog:setConfirmListener(function()
			local data = HackToolUtil.createResetHeroCmd(heroId)

			HackToolAgent.instance:sendGmRequest(data)
		end, self)
	else
		FloatWordMgr.instance:show(lang("tip_not_select_obj"))
	end
end

function M:_onClickEmptyBtn()
	if not map[self._curShowType or 1] then
		return
	end

	local backType = map[self._curShowType or 1].backType
	local data = HackToolUtil.createClearItemCmd({
		backType
	})

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickAddBtn()
	if not self._selectItemData then
		FloatWordMgr.instance:show(lang("tip_not_select_obj"))

		return
	end

	local tabName = map[self._curShowType] and map[self._curShowType].name or ""

	if tabName == TabName.Equip then
		local itemId = self._selectItemData:getItemId()
		local equipBreachLevel = tonumber(self.dropDownEquipBreach.dropdown.value)
		local equipLevel = tonumber(self.inputEquipLevel:GetText()) or 1

		equipLevel = equipLevel < 0 and 0 or equipLevel
		equipLevel = equipLevel > 100 and 100 or equipLevel

		self.inputEquipLevel:SetText(equipLevel)

		local num = self.input_input:GetText() ~= nil and tonumber(self.input_input:GetText()) or 1

		self.input_input:SetText(num)
		print("添加装备", itemId, equipBreachLevel, equipLevel)

		local data = HackToolUtil.createAddEquipmentCmd(tonumber(itemId), num, equipLevel, equipBreachLevel)

		HackToolAgent.instance:sendGmRequest(data)
	elseif tabName == TabName.Hero then
		ViewMgr.instance:open(ViewName.CustomCharacterView)
	elseif tabName == TabName.Echo then
		local dropDownVal = tonumber(self.dropDownEchoBreach.dropdown.value)
		local echoBreachLevel = dropDownVal + 1
		local itemId = self._selectItemData:getItemId()

		print("隐秘回响", echoBreachLevel)

		local num = self.input_input:GetText() ~= nil and tonumber(self.input_input:GetText()) or 1

		self.input_input:SetText(num)

		local data = HackToolUtil.createAddEchoCmd(tonumber(itemId), num, echoBreachLevel)

		HackToolAgent.instance:sendGmRequest(data)
	else
		local num = self.input_input:GetText() ~= nil and tonumber(self.input_input:GetText()) or 1

		self.input_input:SetText(num)

		local _itemId = tonumber(self._selectItemData:getItemId())

		if num > 0 then
			local data = HackToolUtil.createAddItemCmd({
				{
					itemId = _itemId,
					num = num
				}
			})

			HackToolAgent.instance:sendGmRequest(data)
		elseif num < 0 then
			local _num = math.abs(num)
			local _itemCount = ItemModel.instance:getItemCountByItemId(_itemId)
			local _type = ItemUtil.getItemTypeByItemId(_itemId)

			if _itemCount < _num and _type ~= GameEnum.ItemTypeEnum.CurrencyItemType then
				FloatWordMgr.instance:show(string.format(lang("tip_prop_not_enough"), _num, _itemCount))

				return
			end

			local _itemDataLst = ItemModel.instance:getItemsByItemId(_itemId)

			if _itemDataLst then
				local _itemData = _itemDataLst[1]
				local _itemUuid = _itemData:getUuid()
				local data = HackToolUtil.createReduceItemCmd({
					{
						itemId = _itemId,
						num = _num,
						uuid = _itemUuid
					}
				})

				HackToolAgent.instance:sendGmRequest(data)
			else
				printWarn(string.format("无法找到[%d]道具itemData", itemId))
			end
		end
	end
end

function M:_getHeroInfo(itemId)
	local heroData = HeroDepotModel.instance:getHeroInfoByID(itemId)

	if heroData == false then
		self.inputHeroLevel:SetText("")

		self.dropDownHeroPowerLevel.dropdown.value = 0
		self.dropDownHeroBreachLevel.dropdown.value = 0
		self.dropDownHeroPowerNode.dropdown.value = 0

		self.inputHeroFavLevel:SetText("")

		return
	end

	self._heroId = itemId

	HeroPowerAgent.instance:sendHeroPowerInfoRequest(self._heroId)
end

function M:_changeValue()
	local heroData = HeroDepotModel.instance:getHeroInfoByID(self._heroId)

	self.inputHeroLevel:SetText(heroData:getLevel())

	self.dropDownHeroPowerLevel.dropdown.value = heroData:getPowerLv() - 1
	self.dropDownHeroBreachLevel.dropdown.value = heroData:getBreakLv()

	self.inputHeroFavLevel:SetText(heroData:getTacit())

	local nextUnlockIndex = CharacterAuthorityModel.instance:getNextBeUnlockIndex(self._heroId)

	if nextUnlockIndex == 21 then
		self.dropDownHeroPowerNode.dropdown.value = 5
	else
		self.dropDownHeroPowerNode.dropdown.value = (nextUnlockIndex + 4) % 5
	end
end

function M:_clickCell(e, itemData, go, index)
	self._selectItemData = itemData

	local itemId = itemData:getItemId()
	local tabName = map[self._curShowType] and map[self._curShowType].name or ""

	if tabName == TabName.Hero then
		self:_getHeroInfo(itemId)
	end

	self.text_txtID.text = itemId
	self.text_txtName.text = itemData:getName()

	if itemData:getType() == GameEnum.ItemTypeEnum.DiceItem then
		itemData:addFackAttr(EquipEnum.FackAttrType.ShowType)

		local data = ToolTipsUtil.createItemTipsData(itemData, go)

		if not ViewMgr.instance:isOpen(data.viewName) then
			ToolTipsMgr.showTips(data.viewName, data)
		end

		return
	end

	if ItemUtil.isCharacterSkinById(itemId) and ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		return
	end

	local count = ItemModel.instance:getItemCountByItemId(itemId)
	local itemData = ItemData.New({
		count = count,
		itemId = itemId
	})
	local data = ToolTipsUtil.createItemTipsData(itemData, go)

	if not ViewMgr.instance:isOpen(data.viewName) then
		ToolTipsMgr.showTips(data.viewName, data)
	end
end

function M:_getNameInputValue()
	local inputText = self.input_Name:GetText()

	if inputText == nil then
		inputText = ""
	end

	return inputText
end

function M:_onNameInputValueChange()
	self:_refreshLoopLst(self:_getNameInputValue())
end

function M:_fixLoopGrid()
	local loopGridView = self._loopLst:GetLoopGridView()

	GridAdaptUtil.fixLoopGridCount(loopGridView)
end

function M:_onClickCustomHero()
	ViewMgr.instance:open(ViewName.CustomCharacterView)
end

return M
