-- chunkname: @IQIGame\\UI\\HomeLandMakeItemListUI.lua

local HomeLandMakeItemListUI = Base:Extend("HomeLandMakeItemListUI", "IQIGame.Onigao.UI.HomeLandMakeItemListUI", {
	selectToggleIndex = 1
})
local HomeLandProcessToggleCell = require("IQIGame.UI.HomeLandProcess.HomeLandProcessToggleCell")
local HomeLandProcessRender = require("IQIGame.UI.HomeLandProcess.HomeLandProcessRender")

function HomeLandMakeItemListUI:OnInit()
	UGUIUtil.SetText(self.TextBtnLevelUp, HomeLandMakeItemListUIApi:GetString("TextBtnLevelUp"))

	self.propsType = HomeLandMakeItemListUIApi:GetString("PropsType")

	local ProcessingType = HomeLandMakeItemListUIApi:GetString("ProcessingType")

	self.toggleTabs = {}

	for i = 1, #ProcessingType do
		local toggleGO = self["Toggle" .. i]

		toggleGO:GetComponent("ToggleHelperComponent").text = ProcessingType[i][2]

		local toggle = toggleGO:GetComponent("Toggle")

		toggle.isOn = false
		toggle.group = self.Toggles:GetComponent("ToggleGroup")
		self.toggleTabs[i] = toggle
	end

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnUpgradeComponent = self.BtnLevelUp:GetComponent("Button")
	self.scrollTypeComponent = self.ScrollAreaType:GetComponent("ScrollAreaList")

	function self.scrollTypeComponent.onSelectedCell(cell)
		self:OnSelectType(cell)
	end

	function self.scrollTypeComponent.onRenderCell(cell)
		self:OnRenderType(cell)
	end

	self.scrollRenderComponent = self.ScrollAreaRender:GetComponent("ScrollAreaList")

	function self.scrollRenderComponent.onSelectedCell(cell)
		self:OnSelectProcessRender(cell)
	end

	function self.scrollRenderComponent.onRenderCell(cell)
		self:OnRenderProcessRender(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnUpgrade()
		self:OnBtnUpgrade()
	end

	function self.delegateToggleValueChange(isOn)
		self:OnToggleValueChange(isOn)
	end

	function self.delegateUpdateHomeLandProcess()
		self:OnUpdateHomeLandProcess()
	end

	function self.delegateHomeUpdateBuildingEvent(cfgBuildingID)
		self:OnHomeUpdateBuildingEvent(cfgBuildingID)
	end
end

function HomeLandMakeItemListUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandMakeItemListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandMakeItemListUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandMakeItemListUI:GetBGM(userData)
	return nil
end

function HomeLandMakeItemListUI:OnOpen(userData)
	self.homeBuildingData = userData[1]
	self.decorate = userData[2]

	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, false))
	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandMakeItemListUIApi:GetString("CameraPosition", self.homeBuildingData.buildingPOD.lv), HomeLandMakeItemListUIApi:GetString("CameraSize")))
	self.UIController.gameObject:SetActive(false)

	self.timerShow = Timer.New(function()
		self.UIController.gameObject:SetActive(true)
	end, 0.5)

	self.timerShow:Start()

	if UIModule.HasUI(Constant.UIControllerName.HomeLandChooseCastleUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, false)
	end

	for i, v in pairs(self.toggleTabs) do
		v.isOn = false
	end

	self.selectTypeData = nil
	self.selectToggleCell = nil
	self.selectToggleIndex = 1

	self:UpdateView()
end

function HomeLandMakeItemListUI:OnClose(userData)
	if self.timerShow then
		self.timerShow:Stop()
	end

	self.timerShow = nil

	if UIModule.HasUI(Constant.UIControllerName.HomeLandChooseCastleUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, true)
	end

	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandLuaModule.cameraPosition, HomeLandLuaModule.cameraSize))
	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, true))
end

function HomeLandMakeItemListUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
	self.btnUpgradeComponent.onClick:AddListener(self.delegateBtnUpgrade)

	for i, v in pairs(self.toggleTabs) do
		v.onValueChanged:AddListener(self.delegateToggleValueChange)
	end

	EventDispatcher.AddEventListener(EventID.UpdateHomeLandProcessEvent, self.delegateUpdateHomeLandProcess)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandMakeItemListUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
	self.btnUpgradeComponent.onClick:RemoveListener(self.delegateBtnUpgrade)

	for i, v in pairs(self.toggleTabs) do
		v.onValueChanged:RemoveListener(self.delegateToggleValueChange)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateHomeLandProcessEvent, self.delegateUpdateHomeLandProcess)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandMakeItemListUI:OnPause()
	return
end

function HomeLandMakeItemListUI:OnResume()
	return
end

function HomeLandMakeItemListUI:OnCover()
	return
end

function HomeLandMakeItemListUI:OnReveal()
	return
end

function HomeLandMakeItemListUI:OnRefocus(userData)
	return
end

function HomeLandMakeItemListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandMakeItemListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandMakeItemListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandMakeItemListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandMakeItemListUI:OnDestroy()
	HomeLandProcessToggleCell.DisposeIn(self)
	HomeLandProcessRender.DisposeIn(self)
end

function HomeLandMakeItemListUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandMakeItemListUI)
end

function HomeLandMakeItemListUI:OnHomeUpdateBuildingEvent(cfgBuildingID)
	if self.homeBuildingData ~= nil and self.homeBuildingData.buildingPOD.cid == cfgBuildingID then
		self.homeBuildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuildingID)

		self:UpdateView()
	end
end

function HomeLandMakeItemListUI:UpdateView()
	UGUIUtil.SetText(self.TextBtnClose, HomeLandMakeItemListUIApi:GetString("TextBtnClose", self.homeBuildingData.buildingPOD.lv))
	self.scrollTypeComponent:Refresh(#self.propsType)
	self:ShowRightView()
end

function HomeLandMakeItemListUI:ShowRightView()
	self:ShowRenderList()

	self.toggleTabs[self.selectToggleIndex].isOn = true
end

function HomeLandMakeItemListUI:OnToggleValueChange(isOn)
	for i = 1, #self.toggleTabs do
		local toggle = self.toggleTabs[i]

		if toggle.isOn == true and self.selectToggleIndex ~= i then
			self.selectToggleIndex = i

			self:ShowRenderList()

			break
		end
	end
end

function HomeLandMakeItemListUI:OnRenderType(cell)
	local processData = self.propsType[cell.index + 1]

	if processData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local goCell = cell.gameObject

	goCell:SetActive(true)

	local ToggleCell = HomeLandProcessToggleCell.PackageOrReuseView(self, goCell)

	ToggleCell:SetData(processData)
	ToggleCell:Select(false)

	if self.selectTypeData ~= nil then
		if self.selectTypeData[1] == processData[1] then
			self.selectTypeData = processData

			ToggleCell:Select(true)

			self.selectToggleCell = ToggleCell
		end
	else
		self.selectTypeData = processData

		ToggleCell:Select(true)

		self.selectToggleCell = ToggleCell
	end
end

function HomeLandMakeItemListUI:OnSelectType(cell)
	local processData = self.propsType[cell.index + 1]

	if self.selectTypeData and self.selectTypeData[1] ~= processData[1] then
		local ToggleCell = HomeLandProcessToggleCell.PackageOrReuseView(self, cell.gameObject)

		ToggleCell:SetData(processData)
		ToggleCell:Select(true)

		if self.selectToggleCell then
			self.selectToggleCell:Select(false)
		end

		self.selectTypeData = processData
		self.selectToggleCell = ToggleCell

		self:ShowRightView()
	end
end

function HomeLandMakeItemListUI:OnUpdateHomeLandProcess()
	self:ShowRenderList()
end

function HomeLandMakeItemListUI:ShowRenderList()
	if self.selectTypeData then
		self.selectPropsType = self.selectTypeData[1]
		self.processDataTab = HomeLandProcessMould.GetProcessData(self.selectPropsType, self.selectToggleIndex)

		self.scrollRenderComponent:Refresh(#self.processDataTab)
	end
end

function HomeLandMakeItemListUI:OnRenderProcessRender(cell)
	local processData = self.processDataTab[cell.index + 1]

	if processData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local goCell = cell.gameObject

	goCell:SetActive(true)

	local ToggleCell = HomeLandProcessRender.PackageOrReuseView(self, goCell)

	ToggleCell:SetData(self.selectToggleIndex, processData)
end

function HomeLandMakeItemListUI:OnSelectProcessRender(cell)
	local processData = self.processDataTab[cell.index + 1]

	if processData.unlock then
		if self.selectToggleIndex == 1 then
			self:Compound(processData)
		elseif self.selectToggleIndex == 2 then
			self:Decompose(processData)
		end
	end
end

function HomeLandMakeItemListUI:Compound(processData)
	UIModule.Open(Constant.UIControllerName.HomeLandMakeItemUI, Constant.UILayer.UI, {
		processData,
		self.homeBuildingData,
		1
	})
end

function HomeLandMakeItemListUI:Decompose(processData)
	UIModule.Open(Constant.UIControllerName.HomeLandMakeItemUI, Constant.UILayer.UI, {
		processData,
		self.homeBuildingData,
		2
	})
end

function HomeLandMakeItemListUI:OnBtnUpgrade()
	UIModule.Open(Constant.UIControllerName.HomeLandFunctionLevelUpUI, Constant.UILayer.UI, {
		self.homeBuildingData.cfgBuildingID,
		self.decorate
	})
end

return HomeLandMakeItemListUI
