-- chunkname: @IQIGame\\UI\\Maze\\MazeUIShopLevelUpElement.lua

local ItemCell = {}

function ItemCell.New(view)
	local obj = Clone(ItemCell)

	obj:__Init(view)

	return obj
end

function ItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function ItemCell:Show(itemCid)
	self.gameObject:SetActive(true)

	local itemCfg = CfgItemTable[itemCid]
	local itemIconPath = UIGlobalApi.GetIconPath(itemCfg.Icon)

	AssetUtil.LoadImage(self, itemIconPath, self.itemIcon:GetComponent("Image"))

	local qualityPath = CommonSlotUIApi:GetItemFrame(Constant.ItemType.Item, itemCfg.Quality)

	AssetUtil.LoadImage(self, qualityPath, self.qualityBg:GetComponent("Image"))
end

function ItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local LevelUpElement = {
	conditionItems = {},
	itemCellList = {},
	itemDataList = {}
}

function LevelUpElement.New(view)
	local obj = Clone(LevelUpElement)

	obj:__Init(view)

	return obj
end

function LevelUpElement:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	ForTransformChild(self.conditionRoot.transform, function(_trans, _index)
		table.insert(self.conditionItems, _trans)
	end)

	self.scrollAreaList = self.newItemAreaList:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(cell)
		self:__OnRenderItemCell(cell)
	end

	function self.__delegateOnLevelUpButtonClick()
		self:__OnLevelUpButtonClick()
	end

	function self.__delegateOnClickCloseBtn()
		self:__OnClickCloseBtn()
	end

	self.levelUpBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnLevelUpButtonClick)
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnClickCloseBtn)
end

function LevelUpElement:__OnLevelUpButtonClick()
	if not self.canLevelUp then
		return
	end

	MazeModule.OnBlackMarketUpgrade()
end

function LevelUpElement:__OnClickCloseBtn()
	self:Hide()
end

function LevelUpElement:__OnRenderItemCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.itemCellList[insID]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.gameObject)
		self.itemCellList[insID] = itemCell
	end

	local dataIndex = cell.index + 1

	itemCell:Show(self.itemDataList[dataIndex])
end

function LevelUpElement:Show()
	self.gameObject:SetActive(true)

	local level = MazeModule.GetShopLevel()
	local maxLevel = getCfgTableLength(CfgLabyrinthMarketLevelTable)

	if maxLevel <= level then
		self:__ShowMaxLevel()

		return
	end

	local labyrinthMarketLevelData = table.search(CfgLabyrinthMarketLevelTable, function(k, v)
		if v.Level == level then
			return v
		end
	end)
	local isNeedCost = labyrinthMarketLevelData.Cost[1] ~= nil

	LuaUtility.SetGameObjectShow(self.costParent, isNeedCost)

	if isNeedCost then
		local cost = labyrinthMarketLevelData.Cost[2]
		local costItem = labyrinthMarketLevelData.Cost[1]
		local totalItemCount = WarehouseModule.GetItemNumByCfgID(costItem)

		self.canLevelUp = cost <= totalItemCount

		if self.canLevelUp then
			self.costText:GetComponent("Text").text = string.format("%s", cost)
		else
			self.costText:GetComponent("Text").text = string.format("<color=#FF0000>%s</color>", cost)
		end

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[costItem].Icon), self.costImg:GetComponent("Image"))
	else
		self.canLevelUp = true
		self.costText:GetComponent("Text").text = string.format("%s", 0)
	end

	self.nextLevelText:GetComponent("Text").text = MazeApi:GetCNLevelTextAndSuffix(level + 1)
	self.levelText:GetComponent("Text").text = MazeApi:GetCNLevelTextAndSuffix(level)

	UGUIUtil.SetText(self.nextLvDesc, labyrinthMarketLevelData.LevelDes)

	local conditionDesc = MazeApi:UpgradeConditionTitle()

	ForArray(labyrinthMarketLevelData.ConditionIds, function(_index, _conditionCid)
		local conditionIsPass = ConditionModule.Check(_conditionCid)

		if self.canLevelUp then
			self.canLevelUp = conditionIsPass

			MazeModule.log("检查迷宫商店升级条件 {0}, 结果 {1}", _conditionCid, self.canLevelUp)
		end

		local desc

		if conditionIsPass then
			desc = string.format(ColorCfg.Maze.LightBlue, ConditionModule.GetDesc(_conditionCid) .. "; ")
		else
			desc = string.format(ColorCfg.Maze.Red, ConditionModule.GetDesc(_conditionCid) .. "; ")
		end

		conditionDesc = conditionDesc .. desc
	end)
	self.conditionItems[1].gameObject:SetActive(true)

	self.conditionItems[1]:GetComponent("Text").text = conditionDesc

	ForArrayByCount(2, #self.conditionItems, 1, function(_index)
		self.conditionItems[_index].gameObject:SetActive(false)
	end)

	self.itemDataList = labyrinthMarketLevelData.NextDisplay

	self.scrollAreaList:Refresh(#self.itemDataList)

	self.levelUpBtn:GetComponent("Button").interactable = self.canLevelUp

	LuaUtility.SetGameObjectShow(self.nextLevelText, true)
	LuaUtility.SetGameObjectShow(self.arrow, true)
	LuaUtility.SetGameObjectShow(self.NextLvDescRoot, true)
	LuaUtility.SetGameObjectShow(self.levelUpBtn, true)
	LuaUtility.SetGameObjectShow(self.conditionRoot, true)
	LuaUtility.SetGameObjectShow(self.newItemRoot, true)
	LuaUtility.SetGameObjectShow(self.NextLvDescRoot, true)
	LuaUtility.SetGameObjectShow(self.maxRoot, false)
end

function LevelUpElement:__ShowMaxLevel()
	local level = MazeModule.GetShopLevel()

	self.levelText:GetComponent("Text").text = MazeApi:GetMazeLvText(level)

	LuaUtility.SetGameObjectShow(self.nextLevelText, false)
	LuaUtility.SetGameObjectShow(self.arrow, false)
	LuaUtility.SetGameObjectShow(self.NextLvDescRoot, false)
	LuaUtility.SetGameObjectShow(self.levelUpBtn, false)
	LuaUtility.SetGameObjectShow(self.conditionRoot, false)
	LuaUtility.SetGameObjectShow(self.newItemRoot, false)
	LuaUtility.SetGameObjectShow(self.NextLvDescRoot, false)
	LuaUtility.SetGameObjectShow(self.maxRoot, true)
end

function LevelUpElement:Hide()
	self.gameObject:SetActive(false)
end

function LevelUpElement:Dispose()
	self.conditionItems = nil

	self.levelUpBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnLevelUpButtonClick)
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnClickCloseBtn)

	self.scrollAreaList.onRenderCell = nil
	self.scrollAreaList = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return LevelUpElement
