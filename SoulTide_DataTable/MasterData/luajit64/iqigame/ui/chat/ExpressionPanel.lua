-- chunkname: @IQIGame\\UI\\Chat\\ExpressionPanel.lua

local ExpressionPanel = {
	EXPRESSION_TOTAL = 1,
	EXPRESSION_NORMAL = 2,
	_pageCount = 15,
	currentPage = 1,
	currentTabIndex = 1,
	cellView = {},
	toggleTabs = {},
	_normalUseExpressionTable = {},
	_totalUseExpressionTable = {},
	_expressionTable = {},
	_pageTable = {}
}
local ExpressionCell = require("IQIGame.UI.Chat.ExpressionCell")

function ExpressionPanel.PackageOrReuseView(ui, itemCellPrefab)
	if ui == nil or itemCellPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_ExpressionPanel == nil then
		ui.__SUB_UI_MAP_ExpressionPanel = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_ExpressionPanel
	local itemCell

	if subUIMap[itemCellPrefab:GetInstanceID()] ~= nil and subUIMap[itemCellPrefab:GetInstanceID()]._isDestroyed == true then
		itemCell = subUIMap[itemCellPrefab:GetInstanceID()]
	else
		itemCell = ExpressionPanel:New(itemCellPrefab)
		subUIMap[itemCellPrefab:GetInstanceID()] = itemCell
	end

	itemCell.parentUI = ui

	return itemCell
end

function ExpressionPanel.DisposeIn(ui)
	if ui.__SUB_UI_MAP_ExpressionPanel == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_ExpressionPanel) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_ExpressionPanel = nil
end

function ExpressionPanel:Dispose()
	self.cellView.closeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtnHandler)

	for i = 1, #self.toggleTabs do
		local toggle = self.toggleTabs[i]

		toggle.onValueChanged:RemoveListener(self.DelegateToggleValueChange)
	end

	LuaCodeInterface.ClearOutlet(self.cellObj, self.cellView)

	self.cellObj = nil
	self.cellView = nil
end

function ExpressionPanel:New(cellObj)
	local itemCell = Clone(self)

	itemCell.cellView = {}
	itemCell.cellObj = cellObj

	LuaCodeInterface.BindOutlet(cellObj, itemCell.cellView)

	itemCell.cellView.ScrollAreaList = itemCell.cellView.expressionCellList:GetComponent("ScrollAreaList")

	function itemCell.cellView.ScrollAreaList.onRenderCell(cell)
		itemCell:OnRenderSubBtnGridCell(cell)
	end

	function itemCell.DelegateToggleValueChange(isOn)
		itemCell:ToggleValueChange(isOn)
	end

	itemCell.toggleTabs = {}

	local toggle, tabBtn

	if itemCell.cellView.togGroup ~= nil then
		for i = 1, itemCell.cellView.togGroup.transform.childCount do
			tabBtn = itemCell.cellView.togGroup.transform:GetChild(i - 1).gameObject
			toggle = tabBtn:GetComponent("Toggle")
			toggle.isOn = false

			toggle.onValueChanged:AddListener(itemCell.DelegateToggleValueChange)

			itemCell.toggleTabs[i] = toggle
		end
	end

	function itemCell.DelegateOnCloseBtnHandler()
		itemCell:OnCloseBtnHandler()
	end

	itemCell.cellView.closeBtn:GetComponent("Button").onClick:AddListener(itemCell.DelegateOnCloseBtnHandler)

	return itemCell
end

function ExpressionPanel:SetItem(expressionPrefab, pagePrefab)
	self.expressionPrefab = expressionPrefab
	self.pagePrefab = pagePrefab
	self._expressionTable = {}
	self.currentTabIndex = 1

	self:ShowPanel()
end

function ExpressionPanel:Open()
	self._pageCount = #CfgChatEmoticonTable

	self.cellView.ScrollAreaList:Refresh(self._pageCount)
end

function ExpressionPanel:ShowPanel()
	self.currentTabIndex = self.currentTabIndex == nil and 1 or self.currentTabIndex
	self.toggleTabs[self.currentTabIndex].isOn = true

	self:ShowTab(self.currentTabIndex)
end

function ExpressionPanel:ToggleValueChange(isOn)
	if isOn then
		local currentTarget = self.parentUI.UIController:GetCurrentTarget()

		for i = 1, #self.toggleTabs do
			if self.toggleTabs[i].gameObject == currentTarget then
				self:ShowTab(i)

				break
			end
		end
	end
end

function ExpressionPanel:ShowTab(tabIndex)
	self.currentTabIndex = tabIndex

	self.cellView.expressionPage:SetActive(false)
	self:ClearExpression()

	local expressionNum = 0

	if self.currentTabIndex == self.EXPRESSION_NORMAL then
		local commonExpression = PlayerPrefsUtil.GetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.CommonExpression_key)

		if commonExpression ~= "" then
			local expressionList = string.split(commonExpression, "|")

			for i = 1, #expressionList do
				if expressionList[i] ~= "" and CfgChatEmoticonTable[tonumber(expressionList[i])] ~= nil then
					local expressionCell = ExpressionCell.PackageOrReuseView(self, self.expressionPrefab, self.cellView.expressionCellList)

					expressionCell:SetItem(CfgChatEmoticonTable[tonumber(expressionList[i])])
					table.insert(self._expressionTable, expressionCell)
				end
			end
		end
	elseif self.currentTabIndex == self.EXPRESSION_TOTAL then
		local cfgEmotionLen = #CfgChatEmoticonTable

		if cfgEmotionLen >= self._pageCount then
			expressionNum = self._pageCount
		else
			expressionNum = cfgEmotionLen
		end

		self.currentPage = 1
	end
end

function ExpressionPanel:ChangeExpressionPage(selectPageNum)
	self.currentPage = selectPageNum

	self:ClearExpression()
end

function ExpressionPanel:AddExpression()
	local pageNum = math.ceil(#CfgChatEmoticonTable / self._pageCount)
	local expressionNum = 0

	if pageNum > self.currentPage then
		expressionNum = self._pageCount
	else
		expressionNum = math.modf(#CfgChatEmoticonTable, self._pageCount)
	end

	for i = 1, expressionNum do
		local expressionCell = ExpressionCell.PackageOrReuseView(self, self.expressionPrefab, self.cellView.expressionCellList)

		expressionCell:SetItem(CfgChatEmoticonTable[i + (self.currentPage - 1) * self._pageCount])
		table.insert(self._expressionTable, expressionCell)
	end

	if expressionNum < self._pageCount then
		-- block empty
	end
end

function ExpressionPanel:ClearPage()
	for i = #self._pageTable, 1, -1 do
		self._pageTable[i]:Clear()
	end
end

function ExpressionPanel:OnRenderSubBtnGridCell(cell)
	local index = cell.index + 1
	local has = CfgChatEmoticonTable[index]

	if has ~= nil then
		cell.gameObject:SetActive(true)

		local expressionCell = ExpressionCell.PackageOrReuseView(self, cell.gameObject, self.cellView.expressionCellList)

		expressionCell:SetItem(CfgChatEmoticonTable[index])
	else
		cell.gameObject:SetActive(false)
	end
end

function ExpressionPanel:OnCloseBtnHandler()
	self.cellObj:SetActive(false)
end

function ExpressionPanel:Clear()
	self:ClearExpression()
end

function ExpressionPanel:ClearExpression()
	for i = #self._expressionTable, 1, -1 do
		self._expressionTable[i]:Clear()
	end

	self._expressionTable = {}
end

return ExpressionPanel
