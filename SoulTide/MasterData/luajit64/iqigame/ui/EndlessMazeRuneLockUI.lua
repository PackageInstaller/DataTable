-- chunkname: @IQIGame\\UI\\EndlessMazeRuneLockUI.lua

local EndlessMazeRuneLockUI = Base:Extend("EndlessMazeRuneLockUI", "IQIGame.Onigao.UI.EndlessMazeRuneLockUI", {
	RuneItemCells = {},
	RuneCells = {}
})
local EndlessMazeRuneItemCell = require("IQIGame.UI.Maze.EndlessMazeRuneItemCell")
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function EndlessMazeRuneLockUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.RuneItemCellPool = UIObjectPool.New(12, function()
		local itemCell = EndlessMazeRuneItemCell.New(UnityEngine.Object.Instantiate(self.RuneItemCellPrefab))

		return itemCell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.RuneCellPool = UIObjectPool.New(12, function()
		local itemCell = EndlessMazeRuneCell.New(UnityEngine.Object.Instantiate(self.RuneCellPrefab))

		return itemCell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	UGUIUtil.SetTextInChildren(self.CloseBtn, EndlessMazeRuneLockUIApi:GetString("CloseBtnText"))
end

function EndlessMazeRuneLockUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneLockUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneLockUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessMazeRuneLockUI:GetBGM(userData)
	return nil
end

function EndlessMazeRuneLockUI:OnOpen(userData)
	if userData ~= nil then
		self.OnCloseCallback = userData.onClose
	end

	self:UpdateView(userData ~= nil and userData.turnToRune or false)
end

function EndlessMazeRuneLockUI:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.EndlessMazeRuneLockUI)

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback()
	end
end

function EndlessMazeRuneLockUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneLockUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneLockUI:OnPause()
	return
end

function EndlessMazeRuneLockUI:OnResume()
	return
end

function EndlessMazeRuneLockUI:OnCover()
	return
end

function EndlessMazeRuneLockUI:OnReveal()
	return
end

function EndlessMazeRuneLockUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneLockUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneLockUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneLockUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneLockUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneLockUI:OnDestroy()
	self:ClearRuneItemCells(true)
	self.RuneItemCellPool:Dispose()
	self:ClearRuneCells(true)
	self.RuneCellPool:Dispose()
end

function EndlessMazeRuneLockUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EndlessMazeRuneLockUI:UpdateView(turnToRune)
	UGUIUtil.SetText(self.TitleText, EndlessMazeRuneLockUIApi:GetString("TitleText", turnToRune))
	UGUIUtil.SetText(self.TipText, EndlessMazeRuneLockUIApi:GetString("TipText", turnToRune))

	local runeItemDataList = {}
	local items = MazeDataModule.GetAllItems(0)

	for i = 1, #items do
		local itemData = items[i]
		local cfgItemData = itemData:GetCfg()

		if cfgItemData.Type == Constant.ItemType.Item and cfgItemData.SubType == Constant.ItemSubType.ItemUnlockRune then
			table.insert(runeItemDataList, itemData)
		end
	end

	self:ClearRuneItemCells(false)
	self:ClearRuneCells(false)

	for i = 1, #runeItemDataList do
		local itemData = runeItemDataList[i]
		local runeItemCell = self.RuneItemCellPool:Obtain()

		runeItemCell.View.transform:SetParent(self.RuneItemGrid.transform, false)
		runeItemCell.View:SetActive(true)
		runeItemCell:SetData(itemData)
		table.insert(self.RuneItemCells, runeItemCell)

		local runeItemCfgData = itemData:GetCfg()
		local runeCid

		for j = 1, #runeItemCfgData.EffectTypeID do
			local effectTypeId = runeItemCfgData.EffectTypeID[j]

			if effectTypeId == 51 then
				runeCid = runeItemCfgData.EffectTypeParam[j][1]

				break
			end
		end

		local runeCell = self.RuneCellPool:Obtain()

		runeCell.View.transform:SetParent(self.RuneGrid.transform, false)
		runeCell.View:SetActive(true)
		runeCell:SetDataByCID(runeCid)
		table.insert(self.RuneCells, runeCell)
		runeCell:Hide()
	end

	if turnToRune then
		local pointer = 1
		local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.EndlessMazeRuneLockUI, function()
			local runeItemCell = self.RuneItemCells[pointer]

			runeItemCell:Hide()

			local runeCell = self.RuneCells[pointer]

			runeCell:Show()
			GameEntry.Effect:PlayUIEffect(EndlessMazeRuneLockUIApi:GetString("UnlockEffect", runeCell.CfgRuneData.Quality), runeItemCell.View.transform.position, Constant.Unity.SortingOrderMaxValue)

			pointer = pointer + 1
		end, 0.5, #runeItemDataList)

		timer:Start()
	end
end

function EndlessMazeRuneLockUI:ClearRuneItemCells(isDestroy)
	for i = 1, #self.RuneItemCells do
		local cell = self.RuneItemCells[i]

		if not isDestroy then
			cell.View.transform:SetParent(self.UIController.transform, false)
		end

		cell.View:SetActive(false)
		cell:Reset()
		self.RuneItemCellPool:Release(cell)
	end

	self.RuneItemCells = {}
end

function EndlessMazeRuneLockUI:ClearRuneCells(isDestroy)
	for i = 1, #self.RuneCells do
		local cell = self.RuneCells[i]

		if not isDestroy then
			cell.View.transform:SetParent(self.UIController.transform, false)
		end

		cell.View:SetActive(false)
		cell:Reset()
		self.RuneCellPool:Release(cell)
	end

	self.RuneCells = {}
end

return EndlessMazeRuneLockUI
