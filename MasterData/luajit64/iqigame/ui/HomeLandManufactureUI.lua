-- chunkname: @IQIGame\\UI\\HomeLandManufactureUI.lua

local HomeLandManufactureUI = Base:Extend("HomeLandManufactureUI", "IQIGame.Onigao.UI.HomeLandManufactureUI", {
	manufactureQueueCellPool = {}
})
local HomeLandManufactureView = require("IQIGame.UI.HomeLandManufacture.HomeLandManufactureView")
local HomeLandManufactureQueueCell = require("IQIGame.UI.HomeLandManufacture.HomeLandManufactureQueueCell")

function HomeLandManufactureUI:OnInit()
	UGUIUtil.SetText(self.TextQueueTitle, HomeLandManufactureUIApi:GetString("TextQueueTitle"))
	UGUIUtil.SetText(self.TextManufacture, HomeLandManufactureUIApi:GetString("TextManufacture"))
	UGUIUtil.SetText(self.TextBtnUpgrade, HomeLandManufactureUIApi:GetString("TextBtnUpgrade"))
	UGUIUtil.SetTextInChildren(self.BtnDecompose, HomeLandManufactureUIApi:GetString("BtnDecomposeLabel"))

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnUpgradeComponent = self.BtnUpgrade:GetComponent("Button")
	self.btnHelpComponent = self.BtnHelp:GetComponent("Button")
	self.btnManufactureComponent = self.BtnManufacture:GetComponent("Button")
	self.btnDetailComponent = self.BtnDetail:GetComponent("Button")
	self.scrollQueuesComponent = self.ManufactureScroll:GetComponent("ScrollAreaList")

	function self.scrollQueuesComponent.onSelectedCell(cell)
		self:OnSelectQueue(cell)
	end

	function self.scrollQueuesComponent.onRenderCell(cell)
		self:OnRenderQueue(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateManufactureResultEvent()
		self:OnManufactureResultEvent()
	end

	function self.delegateBtnHelp()
		self:OnBtnHelp()
	end

	function self.delegateBtnManufacture()
		self:OnBtnManufacture()
	end

	function self.delegateBtnDetail()
		self:OnClickBtnDetail()
	end

	function self.delegateStartMake(isHaveItem, selectData, queueId)
		self:Making(isHaveItem, selectData, queueId)
	end

	function self.delegateBtnUpgrade()
		self:OnBtnUpgrade()
	end

	function self.delegateHomeUpdateBuildingEvent(cfgBuildingID)
		self:OnHomeUpdateBuildingEvent(cfgBuildingID)
	end

	function self.DelegateBtnGuide()
		self.OnBtnGuide()
	end

	function self.delegateBtnDecompose()
		self:OnBtnDecompose()
	end

	self.manufactureView = HomeLandManufactureView.__New(self.ManufactureView, self)
end

function HomeLandManufactureUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandManufactureUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandManufactureUI:OnOpen(userData)
	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, false))

	self.homeBuildingData = userData[1]
	self.decorate = userData[2]

	local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.homeBuildingData.cfgBuilding.BelongRoom)

	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandManufactureUIApi:GetString("CameraPosition", self.homeBuildingData.buildingPOD.lv, roomPOD.suitCid), HomeLandManufactureUIApi:GetString("CameraSize")))
	self.PanelObj:SetActive(false)

	self.timerShow = Timer.New(function()
		self.PanelObj:SetActive(true)
	end, 0.5)

	self.timerShow:Start()

	if UIModule.HasUI(Constant.UIControllerName.HomeLandChooseCastleUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, false)
	end

	self.selectQueueData = nil

	self:UpdateView()
	self.manufactureView:OnOpen()
end

function HomeLandManufactureUI:OnClose(userData)
	if self.timerShow then
		self.timerShow:Stop()
	end

	self.timerShow = nil

	self.manufactureView:OnClose()

	if UIModule.HasUI(Constant.UIControllerName.HomeLandChooseCastleUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, true)
	end

	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandLuaModule.cameraPosition, HomeLandLuaModule.cameraSize))
	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, true))
end

function HomeLandManufactureUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
	self.btnHelpComponent.onClick:AddListener(self.delegateBtnHelp)
	self.btnManufactureComponent.onClick:AddListener(self.delegateBtnManufacture)
	self.btnDetailComponent.onClick:AddListener(self.delegateBtnDetail)
	self.btnUpgradeComponent.onClick:AddListener(self.delegateBtnUpgrade)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateBtnGuide)
	self.BtnDecompose:GetComponent("Button").onClick:AddListener(self.delegateBtnDecompose)
	EventDispatcher.AddEventListener(EventID.HomeLandManufactureStart, self.delegateStartMake)
	EventDispatcher.AddEventListener(EventID.HomeLandManufactureResultEvent, self.delegateManufactureResultEvent)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandManufactureUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
	self.btnHelpComponent.onClick:RemoveListener(self.delegateBtnHelp)
	self.btnManufactureComponent.onClick:RemoveListener(self.delegateBtnManufacture)
	self.btnDetailComponent.onClick:RemoveListener(self.delegateBtnDetail)
	self.btnUpgradeComponent.onClick:RemoveListener(self.delegateBtnUpgrade)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnGuide)
	self.BtnDecompose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnDecompose)
	EventDispatcher.RemoveEventListener(EventID.HomeLandManufactureStart, self.delegateStartMake)
	EventDispatcher.RemoveEventListener(EventID.HomeLandManufactureResultEvent, self.delegateManufactureResultEvent)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandManufactureUI:OnPause()
	return
end

function HomeLandManufactureUI:OnResume()
	return
end

function HomeLandManufactureUI:OnCover()
	return
end

function HomeLandManufactureUI:OnReveal()
	return
end

function HomeLandManufactureUI:OnRefocus(userData)
	return
end

function HomeLandManufactureUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandManufactureUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandManufactureUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandManufactureUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandManufactureUI:OnDestroy()
	self.manufactureView:OnDestroy()

	for i, v in pairs(self.manufactureQueueCellPool) do
		v:Dispose()
	end
end

function HomeLandManufactureUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandManufactureUI)
end

function HomeLandManufactureUI:OnManufactureResultEvent()
	if self.homeBuildingData then
		self.homeBuildingData = HomeLandLuaModule.GetBuildingDataByID(self.homeBuildingData.cfgBuildingID)

		self:UpdateView()
	end
end

function HomeLandManufactureUI:OnHomeUpdateBuildingEvent(cfgBuildingID)
	if self.homeBuildingData ~= nil and self.homeBuildingData.cfgBuildingID == cfgBuildingID then
		self.homeBuildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuildingID)

		self:UpdateView()

		if UnityEngine.Camera.main then
			local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.homeBuildingData.cfgBuilding.BelongRoom)

			UnityEngine.Camera.main.transform.position = HomeLandManufactureUIApi:GetString("CameraPosition", self.homeBuildingData.buildingPOD.lv, roomPOD.suitCid)
		end
	end
end

function HomeLandManufactureUI:UpdateView()
	self.queueCellTab = {}

	local manufacturePOD = self.homeBuildingData.buildingPOD.manufacture
	local maxQueueCount = manufacturePOD.maxQueueCount
	local numQueue = 0

	for i = 1, #HomeLandManufactureMould.manufactureQueues do
		local isLock = i <= maxQueueCount
		local manufactureQueueData = HomeLandManufactureMould.manufactureQueues[i]
		local makePOD

		for i, v in pairs(manufacturePOD.makes) do
			if v.id == manufactureQueueData.id then
				makePOD = v

				break
			end
		end

		if makePOD ~= nil then
			numQueue = numQueue + 1

			manufactureQueueData:Update(makePOD.cid, makePOD.status, makePOD.finishTime, makePOD.costs, isLock)
		else
			manufactureQueueData:Update(nil, 0, nil, {}, isLock)
		end
	end

	self.scrollQueuesComponent:Refresh(#HomeLandManufactureMould.manufactureQueues)
	self:ChangeQueueSelect()
	self:OpenChildView()

	local num, maxNum = self.homeBuildingData:GetHelpTimes()

	UGUIUtil.SetText(self.TextBtnClose, HomeLandManufactureUIApi:GetString("TextBtnClose", self.homeBuildingData.cfgBuilding.Name, self.homeBuildingData.buildingPOD.lv))
	UGUIUtil.SetText(self.HelpText, HomeLandManufactureUIApi:GetString("HelpText", num, maxNum))
	UGUIUtil.SetText(self.TextQueueNum, HomeLandManufactureUIApi:GetString("TextQueueNum", numQueue, maxQueueCount))
end

function HomeLandManufactureUI:OnRenderQueue(cell)
	local queueData = HomeLandManufactureMould.manufactureQueues[cell.index + 1]

	if queueData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local goCell = cell.gameObject

	goCell:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local queueCell = self.manufactureQueueCellPool[instanceID]

	if queueCell == nil then
		queueCell = HomeLandManufactureQueueCell:New(goCell)
		self.manufactureQueueCellPool[instanceID] = queueCell
	end

	queueCell:SetDate(queueData)

	if queueData.unlock then
		if self.selectQueueData then
			if self.selectQueueData.id == queueData.id then
				self.selectQueueData = queueData
			end
		else
			self.selectQueueData = queueData
		end

		self.queueCellTab[cell.index + 1] = queueCell
	end
end

function HomeLandManufactureUI:OnSelectQueue(cell)
	local selectQueue = HomeLandManufactureMould.manufactureQueues[cell.index + 1]

	if selectQueue and selectQueue.unlock then
		self.selectQueueData = selectQueue

		self:ChangeQueueSelect()
		self:OpenChildView()
	end
end

function HomeLandManufactureUI:ChangeQueueSelect()
	local pos = 1

	if self.selectQueueData then
		for i = 1, #HomeLandManufactureMould.manufactureQueues do
			local queueData = HomeLandManufactureMould.manufactureQueues[i]

			if queueData.id == self.selectQueueData.id then
				pos = i

				break
			end
		end
	end

	for i = 1, #self.queueCellTab do
		local cell = self.queueCellTab[i]

		if i == pos then
			cell:SetSelect(true)
		else
			cell:SetSelect(false)
		end
	end
end

function HomeLandManufactureUI:OpenChildView()
	if self.selectQueueData then
		self.manufactureView:UpdateView(self.selectQueueData, self.homeBuildingData.cfgBuildingID)
		self.Effect:SetActive(self.selectQueueData.status ~= 0)
	end
end

function HomeLandManufactureUI:OnBtnHelp()
	UIModule.Open(Constant.UIControllerName.HomeLandVisitHistoryUI, Constant.UILayer.UI, self.homeBuildingData)
end

function HomeLandManufactureUI:OnClickBtnDetail()
	UIModule.Open(Constant.UIControllerName.TextTipsUI, Constant.UILayer.UI, {
		HomeLandManufactureUIApi:GetString("TextManufactureMsg", HomeLandLuaModule.GetHomeLandComfortLv())
	})
end

function HomeLandManufactureUI:OnBtnManufacture()
	local isUnlockItem = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAKE_MANUFACTURE)

	if not isUnlockItem then
		NoticeModule.ShowNoticeByType(1, CfgFunctionTypeTable[Constant.UnlockType.MAKE_MANUFACTURE].LockNotice)

		return
	end

	UIModule.Open(Constant.UIControllerName.HomeLandManufactureListUI, Constant.UILayer.UI, {
		self.selectQueueData.id,
		self.homeBuildingData,
		self.decorate
	})
end

function HomeLandManufactureUI:Making(isHaveItem, selectData, queueId)
	if isHaveItem == false then
		NoticeModule.ShowNoticeByType(1, HomeLandManufactureUIApi:GetString("ErrorMsg"))

		return
	end

	if selectData == nil then
		NoticeModule.ShowNoticeByType(1, HomeLandManufactureUIApi:GetString("ErrorMsg1"))

		return
	end

	local isEmpty = true

	for i = 1, #HomeLandManufactureMould.manufactureQueues do
		local queueData = HomeLandManufactureMould.manufactureQueues[i]

		if queueData.id == queueId then
			isEmpty = queueData.status == 0

			break
		end
	end

	if not isEmpty then
		NoticeModule.ShowNoticeByType(1, HomeLandManufactureUIApi:GetString("ErrorMsg2"))

		return
	end

	HomeLandManufactureMould.Make(self.homeBuildingData.cfgBuildingID, queueId, selectData.cid)
	UIModule.Close(Constant.UIControllerName.HomeLandManufactureListUI)
end

function HomeLandManufactureUI:OnBtnUpgrade()
	UIModule.Open(Constant.UIControllerName.HomeLandFunctionLevelUpUI, Constant.UILayer.UI, {
		self.homeBuildingData.cfgBuildingID,
		self.decorate
	})
end

function HomeLandManufactureUI:OnBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 4300)
end

function HomeLandManufactureUI:OnBtnDecompose()
	UIModule.Open(Constant.UIControllerName.HomeLandManufactureDecomposeUI, Constant.UILayer.UI)
end

return HomeLandManufactureUI
