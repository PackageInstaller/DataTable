-- chunkname: @IQIGame\\UI\\Activity\\DollBingo\\ActivityUI\\ActivityNewDollStoryUIController.lua

local ActivityNewDollStoryUIController = {
	currentPage = 1,
	pageCount = 3,
	storyCellPool = {},
	storyCells = {},
	cfgStoryTab = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local NewCharacterStoryCell = require("IQIGame.UI.Activity.NewCharacter.NewCharacterStoryCell")

function ActivityNewDollStoryUIController.New(uiController)
	local obj = Clone(ActivityNewDollStoryUIController)

	obj:__Init(uiController)

	return obj
end

function ActivityNewDollStoryUIController:__Init(uiController)
	self.UIController = uiController
end

function ActivityNewDollStoryUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function ActivityNewDollStoryUIController:OnInit()
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.goMoneyParent)
	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)

	UGUIUtil.SetText(self.goTitle, ActivityNewDollStoryUIApi:GetString("TextPanelTitle"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnRight()
		self:OnClickBtnRight()
	end

	function self.delegateBtnLeft()
		self:OnClickBtnLeft()
	end

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end

	self.scrollAreaList = self.ScrollArea:GetComponent("ScrollAreaListPage")

	function self.scrollAreaList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.scrollAreaList.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	self.storyCellPool = UIObjectPool.New(4, function()
		return NewCharacterStoryCell.New(UnityEngine.Object.Instantiate(self.storyMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function ActivityNewDollStoryUIController:GetPreloadAssetPaths()
	return nil
end

function ActivityNewDollStoryUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityNewDollStoryUIController:IsManualShowOnOpen(userData)
	return false
end

function ActivityNewDollStoryUIController:GetBGM(userData)
	return nil
end

function ActivityNewDollStoryUIController:OnOpen(userData)
	self.operateEventID = userData

	local cfgNewCharacterData = CfgNewCharacterActivityTable[ActiveOperationEventModule.GetEventDataPOD(self.operateEventID).dataCfgId]
	local costID = cfgNewCharacterData.CardID

	self.moneyCellBuilder:RefreshView({
		costID
	})
	self:UpdateView()
end

function ActivityNewDollStoryUIController:OnClose(userData)
	return
end

function ActivityNewDollStoryUIController:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.goBtnClose1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function ActivityNewDollStoryUIController:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.goBtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function ActivityNewDollStoryUIController:OnPause()
	return
end

function ActivityNewDollStoryUIController:OnResume()
	return
end

function ActivityNewDollStoryUIController:OnCover()
	return
end

function ActivityNewDollStoryUIController:OnReveal()
	return
end

function ActivityNewDollStoryUIController:OnRefocus(userData)
	return
end

function ActivityNewDollStoryUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActivityNewDollStoryUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityNewDollStoryUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityNewDollStoryUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityNewDollStoryUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.moneyCellBuilder:Dispose()

	self.moneyCellBuilder = nil

	self.energyCell:Dispose()

	self.energyCell = nil

	for i, v in pairs(self.storyCells) do
		self.storyCellPool:Release(v)
	end

	self.storyCells = {}

	self.storyCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function ActivityNewDollStoryUIController:OnUpdateOperations()
	self:UpdateView()
end

function ActivityNewDollStoryUIController:UpdateView()
	self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)
	self.cfgStoryTab = {}

	if self.eventPOD then
		self.cfgNewCharacterActivity = CfgNewCharacterActivityTable[self.eventPOD.dataCfgId]

		for i, v in pairsCfg(CfgNewCharacterStoryTable) do
			if v.GroupNum == self.cfgNewCharacterActivity.Id then
				table.insert(self.cfgStoryTab, v)
			end
		end

		table.sort(self.cfgStoryTab, function(a, b)
			return a.Id < b.Id
		end)

		self.totalPage = math.ceil(#self.cfgStoryTab / self.pageCount)

		self:RefreshList()
	end
end

function ActivityNewDollStoryUIController:RefreshList()
	for i = 1, self.totalPage do
		local pageStory = self:GetCurrentPageDate(i)

		for j = 1, #pageStory do
			local cfg = pageStory[j]
			local state = ActiveNewCharacterModule.CheckNewCharacterStoryState(self.operateEventID, cfg.Id)

			if state == 2 then
				self.currentPage = i

				break
			end
		end
	end

	for i, v in pairs(self.storyCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
		self.storyCellPool:Release(v)
	end

	self.storyCells = {}
	self.scrollAreaList.startIndex = self.currentPage - 1

	self.scrollAreaList:Refresh(self.totalPage)
end

function ActivityNewDollStoryUIController:OnRenderGridCell(cell)
	local goObj = cell.gameObject

	goObj:SetActive(true)

	local index = cell.index + 1
	local pageStory = self:GetCurrentPageDate(index)

	for i = 1, #pageStory do
		local cfg = pageStory[i]
		local cell = self.storyCellPool:Obtain()

		cell.View.transform:SetParent(goObj.transform, false)
		cell.View:SetActive(true)
		cell:SetData(self.operateEventID, cfg)
		table.insert(self.storyCells, cell)
	end
end

function ActivityNewDollStoryUIController:GetCurrentPageDate(showPage)
	local tab = {}

	for i = 1, #self.cfgStoryTab do
		local page = math.ceil(i / self.pageCount)

		if page == showPage then
			table.insert(tab, self.cfgStoryTab[i])
		end
	end

	return tab
end

function ActivityNewDollStoryUIController:OnPageReachedMain(page)
	self.currentPage = page.index + 1

	self:ShowCurrentPage()
end

function ActivityNewDollStoryUIController:OnClickBtnLeft()
	self.scrollAreaList:TurnToBackward()
end

function ActivityNewDollStoryUIController:OnClickBtnRight()
	self.scrollAreaList:TurnToForward()
end

function ActivityNewDollStoryUIController:ShowCurrentPage()
	self.BtnLeft:SetActive(self.currentPage ~= 1)
	self.BtnRight:SetActive(self.currentPage ~= self.totalPage)
end

function ActivityNewDollStoryUIController:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.ActivityNewDollStoryUI)
end

return ActivityNewDollStoryUIController
