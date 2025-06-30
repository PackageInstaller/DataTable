-- chunkname: @IQIGame\\UI\\MazeHiddenMazeUI.lua

local MazeHiddenMazeUI = Base:Extend("MazeHiddenMazeUI", "IQIGame.Onigao.UI.MazeHiddenMazeUI", {})
local MazeHiddenMazeCell = require("IQIGame.UI.Maze.MazeHiddenMazeCell")

function MazeHiddenMazeUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local cellNum = 4

	for i = 1, cellNum do
		self["DelegateOnClickCell" .. i] = function()
			self:OnClickCell(i)
		end
	end

	function self.DelegateOnClickClaimBtn()
		self:OnClickClaimBtn()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	function self.DelegateOnExchangeSuccess(data)
		self:OnExchangeSuccess(data)
	end

	self.MazeCells = {}

	for i = 1, cellNum do
		local cell = MazeHiddenMazeCell.New(self["Cell" .. i], i)

		table.insert(self.MazeCells, cell)
	end

	UGUIUtil.SetText(self.TitleText, MazeHiddenMazeUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TipText, MazeHiddenMazeUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.ClaimBtn, MazeHiddenMazeUIApi:GetString("ClaimBtnText"))
end

function MazeHiddenMazeUI:GetPreloadAssetPaths()
	return nil
end

function MazeHiddenMazeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeHiddenMazeUI:IsManualShowOnOpen(userData)
	return false
end

function MazeHiddenMazeUI:GetBGM(userData)
	return nil
end

function MazeHiddenMazeUI:OnOpen(userData)
	self:UpdateView()
end

function MazeHiddenMazeUI:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.MazeHiddenMazeUI)

	if self.DelayCallClaimFunction ~= nil then
		self.DelayCallClaimFunction()

		self.DelayCallClaimFunction = nil
	end
end

function MazeHiddenMazeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)

	for i = 1, #self.MazeCells do
		local cell = self.MazeCells[i]

		cell.View:GetComponent("Button").onClick:AddListener(self["DelegateOnClickCell" .. i])
	end

	self.ClaimBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClaimBtn)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.ExChangeItemSuccessEvent, self.DelegateOnExchangeSuccess)
end

function MazeHiddenMazeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)

	for i = 1, #self.MazeCells do
		local cell = self.MazeCells[i]

		cell.View:GetComponent("Button").onClick:RemoveListener(self["DelegateOnClickCell" .. i])
	end

	self.ClaimBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClaimBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.ExChangeItemSuccessEvent, self.DelegateOnExchangeSuccess)
end

function MazeHiddenMazeUI:OnPause()
	return
end

function MazeHiddenMazeUI:OnResume()
	return
end

function MazeHiddenMazeUI:OnCover()
	return
end

function MazeHiddenMazeUI:OnReveal()
	return
end

function MazeHiddenMazeUI:OnRefocus(userData)
	return
end

function MazeHiddenMazeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeHiddenMazeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeHiddenMazeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeHiddenMazeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeHiddenMazeUI:OnDestroy()
	for i = 1, #self.MazeCells do
		local cell = self.MazeCells[i]

		cell:Dispose()
	end
end

function MazeHiddenMazeUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function MazeHiddenMazeUI:UpdateView()
	local maxOrder = 0
	local latestChapterCfgData

	for id, cfgChapterData in pairsCfg(CfgChapterTable) do
		if cfgChapterData.Type == 2 and ConditionModule.Check(cfgChapterData.LockCondition) and (latestChapterCfgData == nil or maxOrder < cfgChapterData.Order) then
			maxOrder = cfgChapterData.Order
			latestChapterCfgData = cfgChapterData
		end
	end

	local currentSpaceTreasureCfgData

	for id, cfgSpaceTreasureData in pairsCfg(CfgSpaceTreasureTable) do
		if cfgSpaceTreasureData.ChapterId == latestChapterCfgData.Id then
			currentSpaceTreasureCfgData = cfgSpaceTreasureData

			break
		end
	end

	self.SelectedCell = nil

	for i = 1, #self.MazeCells do
		local cell = self.MazeCells[i]

		cell:SetSelect(false)
		cell:SetData(currentSpaceTreasureCfgData.ExchangeId[i], currentSpaceTreasureCfgData.Desc[i])
	end

	self:RefreshState()
	self.InputBlock:SetActive(false)
end

function MazeHiddenMazeUI:OnClickCell(index)
	if self.SelectedCell ~= nil then
		self.SelectedCell:SetSelect(false)
	end

	local cell = self.MazeCells[index]

	cell:SetSelect(true)

	self.SelectedCell = cell

	UGUIUtil.SetText(self.SelectedMazeDescText, cell.Desc)
	self:RefreshState()
end

function MazeHiddenMazeUI:RefreshState()
	self.TipText:SetActive(self.SelectedCell == nil)
	self.SelectedMazeView:SetActive(self.SelectedCell ~= nil)
end

function MazeHiddenMazeUI:OnClickClaimBtn()
	local cfgExchangeData = self.SelectedCell.CfgExchangeData
	local leftCount, costItemCid, costItemNum, nextIndex = ChurchModule.GetExchangeInfo(cfgExchangeData)
	local haveNum = WarehouseModule.GetItemNumByCfgID(costItemCid)

	if cfgExchangeData.Limit > 0 and leftCount <= 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, BuyExchangeUIApi:GetString("ErrorMsg1"))

		return
	end

	if haveNum < costItemNum then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, BuyExchangeUIApi:GetString("ErrorMsg2", CfgItemTable[costItemCid].Name))

		return
	end

	self.InputBlock:SetActive(true)
	self.SelectedCell:PlaySearchAnim()

	function self.DelayCallClaimFunction()
		self:ClaimReward()
	end

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.MazeHiddenMazeUI, function()
		if self.DelayCallClaimFunction ~= nil then
			self.DelayCallClaimFunction()

			self.DelayCallClaimFunction = nil
		end
	end, 3)

	timer:Start()
end

function MazeHiddenMazeUI:ClaimReward()
	ChurchModule.SendExchangeMsg(self.SelectedCell.CfgExchangeData.Id, 1)
end

function MazeHiddenMazeUI:OnUpdateItem()
	for i = 1, #self.MazeCells do
		local cell = self.MazeCells[i]

		cell:RefreshItem()
	end
end

function MazeHiddenMazeUI:OnExchangeSuccess(data)
	self.InputBlock:SetActive(false)

	if data.success then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, data.showItems)
	end
end

return MazeHiddenMazeUI
