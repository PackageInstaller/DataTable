-- chunkname: @IQIGame\\UI\\EndlessMazeSettlementUI.lua

local EndlessMazeSettlementUI = Base:Extend("EndlessMazeSettlementUI", "IQIGame.Onigao.UI.EndlessMazeSettlementUI", {
	Cells = {},
	SuitItems = {}
})
local EndlessMazeRewardBoxSpineCell = require("IQIGame.UI.Maze.EndlessMazeRewardBoxSpineCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local EndlessMazeRuneSuitItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneSuitItem")

function EndlessMazeSettlementUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickOpenAllBtn()
		self:OnClickOpenAllBtn()
	end

	self.CellPool = UIObjectPool.New(5, function()
		return EndlessMazeRewardBoxSpineCell.New(UnityEngine.Object.Instantiate(self.BoxCellPrefab), function(cell)
			self:OnClickRewardBox(cell)
		end)
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	for i = 1, 6 do
		local item = EndlessMazeRuneSuitItem.New(UnityEngine.Object.Instantiate(self.RuneSuitItemPrefab))

		item.View.transform:SetParent(self.RuneSuitGrid.transform, false)

		self.SuitItems[i] = item
	end

	local titleText1, titleText2 = EndlessMazeSettlementUIApi:GetString("TitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
	UGUIUtil.SetText(self.ScoreLabel, EndlessMazeSettlementUIApi:GetString("ScoreLabel"))
	UGUIUtil.SetText(self.DangerLabel, EndlessMazeSettlementUIApi:GetString("DangerLabel"))
	UGUIUtil.SetTextInChildren(self.OpenAllBtn, EndlessMazeSettlementUIApi:GetString("OpenAllBtnText"))
	UGUIUtil.SetTextInChildren(self.CloseBtn, EndlessMazeSettlementUIApi:GetString("CloseBtnText"))
end

function EndlessMazeSettlementUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeSettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeSettlementUI:OnOpen(userData)
	self:Reset()
	self.MainPanel:SetActive(true)
	self:UpdateView()
end

function EndlessMazeSettlementUI:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.EndlessMazeSettlementUI)

	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		cell:Clear()
	end
end

function EndlessMazeSettlementUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.OpenAllBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickOpenAllBtn)
end

function EndlessMazeSettlementUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.OpenAllBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickOpenAllBtn)
end

function EndlessMazeSettlementUI:OnPause()
	return
end

function EndlessMazeSettlementUI:OnResume()
	return
end

function EndlessMazeSettlementUI:OnCover()
	return
end

function EndlessMazeSettlementUI:OnReveal()
	return
end

function EndlessMazeSettlementUI:OnRefocus(userData)
	return
end

function EndlessMazeSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeSettlementUI:OnDestroy()
	self:ClearCells(true)
	self.CellPool:Dispose()

	for i = 1, #self.SuitItems do
		local item = self.SuitItems[i]

		item:Dispose()
	end
end

function EndlessMazeSettlementUI:Reset()
	self.MainPanel:SetActive(false)
	self.Step2Node:SetActive(false)
	self.CloseBtn:SetActive(false)
end

function EndlessMazeSettlementUI:UpdateView()
	local totalTime = 2
	local duration = 0.1
	local updateTime = math.ceil(totalTime / duration)
	local scoreValue = MazeDataModule.SettlementData.Score

	if scoreValue == nil then
		scoreValue = 0
	end

	local dangerValue = EndlessMazeSettlementUIApi:GetString("DangerValue", MazeDataModule.PlayerInfo.MonsterGrade, MazeDataModule.PlayerInfo.AbyssPowerId)
	local deltaScorePerUpdate = scoreValue / updateTime
	local deltaDangerPerUpdate = dangerValue / updateTime

	if scoreValue > 0 or dangerValue > 0 then
		local score = 0
		local danger = 0
		local timer

		timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.EndlessMazeSettlementUI, function()
			score = score + deltaScorePerUpdate

			if score > scoreValue then
				score = scoreValue
			end

			UGUIUtil.SetText(self.ScoreText, math.floor(score))

			danger = danger + deltaDangerPerUpdate

			if danger > dangerValue then
				danger = dangerValue
			end

			UGUIUtil.SetText(self.DangerText, math.floor(danger))

			if timer.loop == 1 then
				UGUIUtil.SetText(self.ScoreText, scoreValue)
				UGUIUtil.SetText(self.DangerText, dangerValue)
				self:ShowStep2()
			end
		end, duration, updateTime)

		timer:Start()
	else
		UGUIUtil.SetText(self.ScoreText, scoreValue)
		UGUIUtil.SetText(self.DangerText, dangerValue)
		self:ShowStep2()
	end

	local cidList, numList = MazeModule.GetEndlessMazeRuneSuitData()
	local legendCidList = MazeModule.GetEndlessMazeLegendRuneSuitData(cidList, numList)
	local normalSuitStartIndex = 1

	if #legendCidList > 0 then
		local item = self.SuitItems[1]

		item:SetData(2, nil, #legendCidList)

		normalSuitStartIndex = 2
	end

	for i = normalSuitStartIndex, #self.SuitItems do
		local item = self.SuitItems[i]

		item:SetData(1, cidList[i], numList[i])
	end
end

function EndlessMazeSettlementUI:ShowStep2()
	self.Step2Node:SetActive(true)

	local boxLength = #MazeDataModule.SettlementData.RewardsBoxes

	if boxLength > 0 then
		self.OpenAllBtn:SetActive(true)
		self.CloseBtn:SetActive(false)
	else
		self.OpenAllBtn:SetActive(false)
		self.CloseBtn:SetActive(true)
	end

	local boxCidRewards = {}

	for i = 1, boxLength do
		local boxPOD = MazeDataModule.SettlementData.RewardsBoxes[i]
		local boxData = boxCidRewards[boxPOD.cid]

		if boxData == nil then
			boxData = {
				cid = boxPOD.cid
			}
			boxData.num = 0
			boxData.items = {}
			boxCidRewards[boxPOD.cid] = boxData
		end

		boxData.num = boxData.num + boxPOD.num

		for j = 1, #boxPOD.items do
			table.insert(boxData.items, boxPOD.items[j])
		end
	end

	local boxDataList = {}

	for cid, boxData in pairs(boxCidRewards) do
		table.insert(boxDataList, boxData)
	end

	table.sort(boxDataList, function(boxData1, boxData2)
		local cfgMazeEndlessBoxData1 = CfgMazeEndlessBoxTable[boxData1.cid]
		local cfgMazeEndlessBoxData2 = CfgMazeEndlessBoxTable[boxData2.cid]

		if cfgMazeEndlessBoxData1.Type == cfgMazeEndlessBoxData2.Type then
			return cfgMazeEndlessBoxData1.Id < cfgMazeEndlessBoxData2.Id
		end

		return cfgMazeEndlessBoxData1.Type < cfgMazeEndlessBoxData2.Type
	end)
	self:ClearCells()

	for i = 1, #boxDataList do
		local boxData = boxDataList[i]
		local cell = self.CellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.BoxGrid.transform, false)
		table.insert(self.Cells, cell)

		local itemNum = 0
		local items

		if boxData ~= nil then
			itemNum = boxData.num
			items = boxData.items
		end

		local cfgMazeEndlessBoxData = CfgMazeEndlessBoxTable[boxData.cid]

		cell:SetData(cfgMazeEndlessBoxData.Type, itemNum, items)
	end
end

function EndlessMazeSettlementUI:ClearCells(isDestroy)
	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		cell:Clear()
		cell.View:SetActive(false)

		if not isDestroy then
			cell.View.transform:SetParent(self.UIController.transform, false)
		end

		self.CellPool:Release(cell)
	end

	self.Cells = {}
end

function EndlessMazeSettlementUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	MazeModule.ExitMaze()
end

function EndlessMazeSettlementUI:OnClickRewardBox(cell)
	if self:IsAnyBoxOpening() then
		return
	end

	if cell.State ~= EndlessMazeRewardBoxSpineCell.STATE_CLOSED then
		return
	end

	cell:OpenBox()

	local timer = Timer.New(function()
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, cell.Items)

		cell.State = EndlessMazeRewardBoxSpineCell.STATE_OPENED

		self:RefreshButtonState()
	end, 1)

	timer:Start()
end

function EndlessMazeSettlementUI:OnClickOpenAllBtn()
	if self:IsAnyBoxOpening() then
		return
	end

	local items = {}
	local itemCidIndex = {}

	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		if cell.Num > 0 and cell.State == EndlessMazeRewardBoxSpineCell.STATE_CLOSED then
			cell:OpenBox()

			for j = 1, #cell.Items do
				local itemShowPOD = cell.Items[j]
				local index = itemCidIndex[itemShowPOD.cid]

				if index == nil then
					local newItemShowPOD = {}

					newItemShowPOD.cid = itemShowPOD.cid
					newItemShowPOD.num = itemShowPOD.num
					newItemShowPOD.tag = itemShowPOD.tag

					table.insert(items, newItemShowPOD)

					itemCidIndex[itemShowPOD.cid] = #items
				else
					local newItemShowPOD = items[index]

					newItemShowPOD.num = newItemShowPOD.num + itemShowPOD.num
				end
			end
		end
	end

	if #items > 0 then
		local timer = Timer.New(function()
			NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)

			for i = 1, #self.Cells do
				local cell = self.Cells[i]

				cell.State = EndlessMazeRewardBoxSpineCell.STATE_OPENED
			end

			self:RefreshButtonState()
		end, 1)

		timer:Start()
	end
end

function EndlessMazeSettlementUI:RefreshButtonState()
	local allBoxesOpened = true

	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		if cell.Num > 0 and cell.State == EndlessMazeRewardBoxSpineCell.STATE_CLOSED then
			allBoxesOpened = false

			break
		end
	end

	self.OpenAllBtn:SetActive(not allBoxesOpened)
	self.CloseBtn:SetActive(allBoxesOpened)
end

function EndlessMazeSettlementUI:IsAnyBoxOpening()
	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		if cell.State == EndlessMazeRewardBoxSpineCell.STATE_OPENING then
			return true
		end
	end

	return false
end

return EndlessMazeSettlementUI
