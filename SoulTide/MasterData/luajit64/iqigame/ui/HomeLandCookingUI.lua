-- chunkname: @IQIGame\\UI\\HomeLandCookingUI.lua

local HomeLandCookingUI = Base:Extend("HomeLandCookingUI", "IQIGame.Onigao.UI.HomeLandCookingUI", {
	cookingQueuePool = {}
})
local HomeLandCookPutView = require("IQIGame.UI.Cooking.HomeLandCookPutView")
local HomeLandCookQueueCell = require("IQIGame.UI.Cooking.HomeLandCookQueueCell")

function HomeLandCookingUI:OnInit()
	UGUIUtil.SetText(self.TextBtnMenu, HomeLandCookingUIApi:GetString("TextBtnMenu"))
	UGUIUtil.SetText(self.TextBtnUpgrade, HomeLandCookingUIApi:GetString("TextBtnUpgrade"))

	self.scrollQueuesComponent = self.GridQueue:GetComponent("ScrollAreaList")

	function self.scrollQueuesComponent.onSelectedCell(cell)
		self:OnSelectQueue(cell)
	end

	function self.scrollQueuesComponent.onRenderCell(cell)
		self:OnRenderQueue(cell)
	end

	function self.delegateClickBtnClose()
		self:OnBtnClose()
	end

	function self.delegateClickBtnMenu()
		self:OnBtnMenu()
	end

	function self.delegateUpdateCookingEvent(buildCid)
		self:OnUpdateCookingEvent(buildCid)
	end

	function self.delegateBtnHelp()
		self:OnBtnHelp()
	end

	function self.delegateBtnHelpDes()
		self:OnBtnHelpDes()
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

	self.cookPutView = HomeLandCookPutView.__New(self.Panel1)
end

function HomeLandCookingUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandCookingUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandCookingUI:OnOpen(userData)
	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, false))

	self.homeLandBuildingData = userData[1]
	self.decorate = userData[2]

	local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.homeLandBuildingData.cfgBuilding.BelongRoom)

	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandCookingUIApi:GetString("CameraPosition", self.homeLandBuildingData.buildingPOD.lv, roomPOD.suitCid), HomeLandCookingUIApi:GetString("CameraSize")))
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
	self.cookPutView:OnOpen()
end

function HomeLandCookingUI:OnClose(userData)
	if self.timerShow then
		self.timerShow:Stop()
	end

	self.timerShow = nil

	self.cookPutView:OnClose()

	if UIModule.HasUI(Constant.UIControllerName.HomeLandChooseCastleUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, true)
	end

	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandLuaModule.cameraPosition, HomeLandLuaModule.cameraSize))
	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, true))
end

function HomeLandCookingUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnMenu:GetComponent("Button").onClick:AddListener(self.delegateClickBtnMenu)
	self.BtnHelp:GetComponent("Button").onClick:AddListener(self.delegateBtnHelp)
	self.BtnHelpDes:GetComponent("Button").onClick:AddListener(self.delegateBtnHelpDes)
	self.BtnUpgrade:GetComponent("Button").onClick:AddListener(self.delegateBtnUpgrade)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateBtnGuide)
	EventDispatcher.AddEventListener(EventID.UpdateCookingEvent, self.delegateUpdateCookingEvent)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandCookingUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnMenu:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnMenu)
	self.BtnHelp:GetComponent("Button").onClick:RemoveListener(self.delegateBtnHelp)
	self.BtnHelpDes:GetComponent("Button").onClick:RemoveListener(self.delegateBtnHelpDes)
	self.BtnUpgrade:GetComponent("Button").onClick:RemoveListener(self.delegateBtnUpgrade)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnGuide)
	EventDispatcher.RemoveEventListener(EventID.UpdateCookingEvent, self.delegateUpdateCookingEvent)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandCookingUI:OnPause()
	return
end

function HomeLandCookingUI:OnResume()
	return
end

function HomeLandCookingUI:OnCover()
	return
end

function HomeLandCookingUI:OnReveal()
	return
end

function HomeLandCookingUI:OnRefocus(userData)
	return
end

function HomeLandCookingUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandCookingUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandCookingUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandCookingUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandCookingUI:OnDestroy()
	self.cookPutView:OnDestroy()

	for i, v in pairs(self.cookingQueuePool) do
		v:Dispose()
	end
end

function HomeLandCookingUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandCookingUI)
end

function HomeLandCookingUI:OnBtnMenu()
	UIModule.Open(Constant.UIControllerName.HomeLandCookingListUI, Constant.UILayer.UI, self.selectQueueData)
end

function HomeLandCookingUI:OnUpdateCookingEvent(buildCid)
	if self.homeLandBuildingData.cfgBuildingID == buildCid then
		self.homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(buildCid)

		self:UpdateView()
	end
end

function HomeLandCookingUI:OnHomeUpdateBuildingEvent(cfgBuildingID)
	if self.homeLandBuildingData ~= nil and self.homeLandBuildingData.cfgBuildingID == cfgBuildingID then
		self.homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuildingID)

		self:UpdateView()

		if UnityEngine.Camera.main then
			local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.homeLandBuildingData.cfgBuilding.BelongRoom)

			UnityEngine.Camera.main.transform.position = HomeLandCookingUIApi:GetString("CameraPosition", self.homeLandBuildingData.buildingPOD.lv, roomPOD.suitCid)
		end
	end
end

function HomeLandCookingUI:UpdateView()
	UGUIUtil.SetText(self.TextTitle, HomeLandCookingUIApi:GetString("TextTitle", self.homeLandBuildingData.cfgBuilding.Name, self.homeLandBuildingData.buildingPOD.lv))

	self.queueCellTab = {}

	local kitchenPOD = self.homeLandBuildingData.buildingPOD.kitchenPOD
	local maxQueueCount = kitchenPOD.maxQueueCount
	local isCooking = false

	for i = 1, #CookingModule.cookingQueues do
		local isLock = i <= maxQueueCount
		local cookQueueData = CookingModule.cookingQueues[i]
		local culinaryPOD

		for i, v in pairs(kitchenPOD.culinarys) do
			if v.id == cookQueueData.id then
				culinaryPOD = v

				break
			end
		end

		if culinaryPOD ~= nil then
			cookQueueData:Update(culinaryPOD.cid, culinaryPOD.status, culinaryPOD.finishTime, isLock, culinaryPOD.costs, culinaryPOD)

			if isCooking == false and culinaryPOD.status == 1 then
				isCooking = true
			end
		else
			cookQueueData:Update(nil, 0, nil, isLock, {}, culinaryPOD)
		end
	end

	self.scrollQueuesComponent:Refresh(#CookingModule.cookingQueues)
	self:ChangeQueueSelect()
	self:OpenChildView()
	self:PlayStateEffect(isCooking)
	UGUIUtil.SetText(self.TextQueueNum, HomeLandCookingUIApi:GetString("TextQueueNum", kitchenPOD.maxQueueCount - self:GetEmptyQueueNum(), kitchenPOD.maxQueueCount))

	local buildingData = HomeLandLuaModule.GetBuildingDataByID(self.homeLandBuildingData.cfgBuildingID)

	if buildingData then
		local num, maxNum = buildingData:GetHelpTimes()

		UGUIUtil.SetText(self.TextHelp, HomeLandCookingUIApi:GetString("TextHelp", num, maxNum))
	end

	self:UpdateRedPoint()
end

function HomeLandCookingUI:GetEmptyQueueNum()
	local num = 0

	if self.homeLandBuildingData then
		local kitchenPOD = self.homeLandBuildingData.buildingPOD.kitchenPOD

		for i = 1, kitchenPOD.maxQueueCount do
			local culinaryPOD = kitchenPOD.culinarys[i]

			if culinaryPOD == nil then
				num = num + 1
			end
		end
	end

	return num
end

function HomeLandCookingUI:GetEmptyQueueData()
	for i = 1, #CookingModule.cookingQueues do
		local queueData = CookingModule.cookingQueues[i]

		if queueData.status == nil and queueData.unlock == true then
			return queueData
		end
	end

	return nil
end

function HomeLandCookingUI:OnRenderQueue(cell)
	local queueData = CookingModule.cookingQueues[cell.index + 1]

	if queueData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local goCell = cell.gameObject

	goCell:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local queueCell = self.cookingQueuePool[instanceID]

	if queueCell == nil then
		queueCell = HomeLandCookQueueCell:New(goCell)
		self.cookingQueuePool[instanceID] = queueCell
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

function HomeLandCookingUI:OnSelectQueue(cell)
	local selectQueue = CookingModule.cookingQueues[cell.index + 1]

	if selectQueue and selectQueue.unlock then
		self.selectQueueData = selectQueue

		self:ChangeQueueSelect()
		self:OpenChildView()

		if selectQueue.status == 2 then
			HomeLandLuaModule.RewardCook(self.homeLandBuildingData.cfgBuildingID, selectQueue.id)
		end
	end
end

function HomeLandCookingUI:OpenChildView(type)
	if self.selectQueueData then
		self.cookPutView:UpdateView(self.selectQueueData, self:GetEmptyQueueNum(), self.homeLandBuildingData.cfgBuildingID)
	end
end

function HomeLandCookingUI:ChangeQueueSelect()
	local pos = 1

	if self.selectQueueData then
		for i = 1, #CookingModule.cookingQueues do
			local queueData = CookingModule.cookingQueues[i]

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

function HomeLandCookingUI:PlayStateEffect(top)
	return
end

function HomeLandCookingUI:OnBtnHelp()
	local buildingData = HomeLandLuaModule.GetBuildingDataByID(self.homeLandBuildingData.cfgBuildingID)

	UIModule.Open(Constant.UIControllerName.HomeLandVisitHistoryUI, Constant.UILayer.UI, buildingData)
end

function HomeLandCookingUI:UpdateRedPoint()
	local isRed = CookingModule.ISCookingMenuRedPoint()

	self.MenuRedPoint:SetActive(isRed)
end

function HomeLandCookingUI:OnBtnHelpDes()
	UIModule.Open(Constant.UIControllerName.TextTipsUI, Constant.UILayer.UI, {
		HomeLandCookingUIApi:GetString("TextTip", HomeLandLuaModule.GetHomeLandComfortLv())
	})
end

function HomeLandCookingUI:OnBtnUpgrade()
	UIModule.Open(Constant.UIControllerName.HomeLandFunctionLevelUpUI, Constant.UILayer.UI, {
		self.homeLandBuildingData.cfgBuildingID,
		self.decorate
	})
end

function HomeLandCookingUI:OnBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 4200)
end

return HomeLandCookingUI
