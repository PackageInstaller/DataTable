-- chunkname: @IQIGame\\UI\\Maze\\MazeUISenroElement.lua

local MazeUISenroTalentElement = require("IQIGame/UI/Maze/MazeUISenroTalentElement")
local SenroBuffItem = {}

function SenroBuffItem.New(view)
	local obj = Clone(SenroBuffItem)

	obj:__Init(view)

	return obj
end

function SenroBuffItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function SenroBuffItem:Show(_senroTalentPOD)
	self.gameObject:SetActive(true)

	local talentCfg = CfgLabyrinthSenrotalentTable[_senroTalentPOD.id]

	self.contentText:GetComponent("Text").text = talentCfg.TalentTips[_senroTalentPOD.level]

	UGUIUtil.SetText(self.textTitle, talentCfg.Name)
	AssetUtil.LoadImage(self, talentCfg.Icon, self.iconRoot:GetComponent("Image"))
end

function SenroBuffItem:Hide()
	self.gameObject:SetActive(false)
end

function SenroBuffItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local EffectOverView = {
	itemCellList = {},
	itemDataList = {}
}

function EffectOverView.New(view)
	local obj = Clone(EffectOverView)

	obj:__Init(view)

	return obj
end

function EffectOverView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.scrollAreaList = self.itemScrollview:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(cell)
		self:__OnRenderItemCell(cell)
	end

	function self.__delegateOnCloseBtnClick()
		self:Hide()
	end

	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
end

function EffectOverView:__OnRenderItemCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.itemCellList[insID]

	if itemCell == nil then
		itemCell = SenroBuffItem.New(cell.gameObject)
		self.itemCellList[insID] = itemCell
	end

	local dataIndex = cell.index + 1

	itemCell:Show(self.itemDataList[dataIndex])
end

function EffectOverView:Show()
	self.gameObject:SetActive(true)
	self:__RefreshShow()
end

function EffectOverView:Refresh()
	if not self.gameObject.activeSelf then
		return
	end

	self:__RefreshShow()
end

function EffectOverView:__RefreshShow()
	self.itemDataList = MazeModule.GetSenroTalentList()

	self.scrollAreaList:Refresh(#self.itemDataList)
end

function EffectOverView:Hide()
	self.gameObject:SetActive(false)
end

function EffectOverView:Dispose()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)

	for k, v in pairs(self.itemCellList) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local LevelUpView = {
	conditionItems = {}
}

function LevelUpView.New(view)
	local obj = Clone(LevelUpView)

	obj:__Init(view)

	return obj
end

function LevelUpView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	ForTransformChild(self.conditionRoot.transform, function(_trans, _index)
		table.insert(self.conditionItems, _trans)
	end)

	function self.__delegateOnLevelUpButtonClick()
		self:__OnLevelUpButtonClick()
	end

	function self.__delegateOnCloseBtnClick()
		self:Hide()
	end

	self.lvUpBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnLevelUpButtonClick)
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
end

function LevelUpView:__OnLevelUpButtonClick()
	if not self.canLevelUp then
		return
	end

	MazeModule.OnUpgradeSenro()
end

function LevelUpView:Show()
	self.gameObject:SetActive(true)
	self:__RefreshShow()
end

function LevelUpView:Refresh()
	if not self.gameObject.activeSelf then
		return
	end

	self:__RefreshShow()
end

function LevelUpView:__RefreshShow()
	local level = MazeModule.GetSenroTalentLevel()
	local maxLevel = getCfgTableLength(CfgLabyrinthSenroTable)

	if maxLevel <= level then
		self:__ShowMaxLevel()

		return
	end

	local labyrinthSenroData = table.search(CfgLabyrinthSenroTable, function(k, v)
		if v.Level == level then
			return v
		end
	end)
	local isNeedCost = labyrinthSenroData.Cost[1] ~= nil

	LuaUtility.SetGameObjectShow(self.costParent, isNeedCost)

	if isNeedCost then
		local cost = labyrinthSenroData.Cost[2]
		local costItem = labyrinthSenroData.Cost[1]
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

	UGUIUtil.SetText(self.effectText, labyrinthSenroData.LevelDes)
	ForArray(labyrinthSenroData.ConditionIds, function(_index, _conditionCid)
		local conditionItem = self.conditionItems[_index]

		if conditionItem == nil then
			return
		end

		local conditionIsPass = ConditionModule.Check(_conditionCid)

		if self.canLevelUp then
			self.canLevelUp = conditionIsPass

			MazeModule.log("检查迷宫天赋升级条件 {0}, 结果 {1}", _conditionCid, self.canLevelUp)
		end

		local desc

		if conditionIsPass then
			desc = string.format(ColorCfg.Maze.LightBlue, MazeApi:UpgradeConditionTitle() .. ConditionModule.GetDesc(_conditionCid))
		else
			desc = string.format(ColorCfg.Maze.Red, MazeApi:UpgradeConditionTitle() .. ConditionModule.GetDesc(_conditionCid))
		end

		conditionItem:GetComponent("Text").text = desc

		conditionItem.gameObject:SetActive(true)
	end)

	local beginIndex = #labyrinthSenroData.ConditionIds + 1

	ForArrayByCount(beginIndex, #self.conditionItems, 1, function(_index)
		self.conditionItems[_index].gameObject:SetActive(false)
	end)

	self.lvUpBtn:GetComponent("Button").interactable = self.canLevelUp

	LuaUtility.SetGameObjectShow(self.arrow, true)
	LuaUtility.SetGameObjectShow(self.nextLevelText, true)
	LuaUtility.SetGameObjectShow(self.effectRoot, true)
	LuaUtility.SetGameObjectShow(self.conditionRoot, true)
	LuaUtility.SetGameObjectShow(self.lvUpBtn, true)
	LuaUtility.SetGameObjectShow(self.maxRoot, false)
end

function LevelUpView:__ShowMaxLevel()
	local level = MazeModule.GetSenroTalentLevel()

	UGUIUtil.SetText(self.levelText, MazeApi:GetMazeLvText(level))

	self.lvUpBtn:GetComponent("Button").interactable = false

	ForArrayByCount(1, #self.conditionItems, 1, function(_index)
		self.conditionItems[_index].gameObject:SetActive(false)
	end)
	LuaUtility.SetGameObjectShow(self.arrow, false)
	LuaUtility.SetGameObjectShow(self.nextLevelText, false)
	LuaUtility.SetGameObjectShow(self.effectRoot, false)
	LuaUtility.SetGameObjectShow(self.conditionRoot, false)
	LuaUtility.SetGameObjectShow(self.lvUpBtn, false)
	LuaUtility.SetGameObjectShow(self.maxRoot, true)
end

function LevelUpView:Hide()
	self.gameObject:SetActive(false)
end

function LevelUpView:Dispose()
	self.conditionItems = nil

	self.lvUpBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnLevelUpButtonClick)
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {}

function Element.New(view)
	local obj = Clone(Element)

	obj:__Init(view)

	return obj
end

function Element:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.effectOverViewView = EffectOverView.New(self.senroEffectOverview)
	self.levelUpView = LevelUpView.New(self.levelUpRoot)
	self.talentElement = MazeUISenroTalentElement.New(self.talentRoot, self)

	function self.__delegateOnMazeSenroDataChange()
		self:__OnMazeSenroDataChange()
	end

	function self.__delegateOnMazeSenroTalentDataChange()
		self:__OnMazeSenroDataChange()
	end

	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtn, self)

	self.commonReturnBtn:RegisterReturnEvent(function()
		self:Hide()
	end)

	self.moneyCell = CurrencyCell.New(self.moneyTopRoot)
end

function Element:Show()
	self.talentElement:Show()
	self.effectOverViewView:Hide()
	self.levelUpView:Hide()
	self.gameObject:SetActive(true)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.MazeSenroUI)
	EventDispatcher.AddEventListener(EventID.MazeSenroDataChange, self.__delegateOnMazeSenroDataChange)
	EventDispatcher.AddEventListener(EventID.MazeSenroTalentDataChange, self.__delegateOnMazeSenroTalentDataChange)
end

function Element:ShowLvUpView()
	self.levelUpView:Show()
end

function Element:ShowEffectOverview()
	self.effectOverViewView:Show()
end

function Element:__OnMazeSenroDataChange()
	self.effectOverViewView:Refresh()
	self.levelUpView:Refresh()
end

function Element:Hide()
	EventDispatcher.RemoveEventListener(EventID.MazeSenroDataChange, self.__delegateOnMazeSenroDataChange)
	EventDispatcher.RemoveEventListener(EventID.MazeSenroTalentDataChange, self.__delegateOnMazeSenroTalentDataChange)
	self.gameObject:SetActive(false)
end

function Element:Dispose()
	EventDispatcher.RemoveEventListener(EventID.MazeSenroDataChange, self.__delegateOnMazeSenroDataChange)
	EventDispatcher.RemoveEventListener(EventID.MazeSenroTalentDataChange, self.__delegateOnMazeSenroTalentDataChange)
	self.effectOverViewView:Dispose()
	self.levelUpView:Dispose()
	self.talentElement:Dispose()
	self.commonReturnBtn:Dispose()
	self.moneyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
