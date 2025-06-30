-- chunkname: @IQIGame\\UI\\HomeLandMakeItemUI.lua

local HomeLandMakeItemUI = Base:Extend("HomeLandMakeItemUI", "IQIGame.Onigao.UI.HomeLandMakeItemUI", {
	count = 0
})
local HomeLandCompoundView = require("IQIGame.UI.HomeLandProcess.HomeLandCompoundView")
local HomeLandDeComposeView = require("IQIGame.UI.HomeLandProcess.HomeLandDeComposeView")

function HomeLandMakeItemUI:OnInit()
	UGUIUtil.SetText(self.TextBtnMin, HomeLandMakeItemListUIApi:GetString("TextBtnMin"))
	UGUIUtil.SetText(self.TextBtnReduce, HomeLandMakeItemListUIApi:GetString("TextBtnReduce"))
	UGUIUtil.SetText(self.TextBtnAdd, HomeLandMakeItemListUIApi:GetString("TextBtnAdd"))
	UGUIUtil.SetText(self.TextBtnMax, HomeLandMakeItemListUIApi:GetString("TextBtnMax"))

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnMinComponent = self.BtnMin:GetComponent("Button")
	self.btnReduceComponent = self.BtnReduce:GetComponent("Button")
	self.btnAddComponent = self.BtnAdd:GetComponent("Button")
	self.btnMaxComponent = self.BtnMax:GetComponent("Button")
	self.btnProcessComponent = self.BtnProcess:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnMin()
		self:OnBtnMin()
	end

	function self.delegateBtnReduce()
		self:OnBtnReduce()
	end

	function self.delegateBtnMax()
		self:OnBtnMax()
	end

	function self.delegateBtnAdd()
		self:OnBtnAdd()
	end

	function self.delegateBtnProcess()
		self:OnBtnProcess()
	end

	self.compoundView = HomeLandCompoundView.New(self.CompoundView)
	self.deComposeView = HomeLandDeComposeView.New(self.DecomposeView)
end

function HomeLandMakeItemUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandMakeItemUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandMakeItemUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandMakeItemUI:GetBGM(userData)
	return nil
end

function HomeLandMakeItemUI:OnOpen(userData)
	self.processData = userData[1]
	self.homeBuildingData = userData[2]
	self.processType = userData[3]
	self.count = 1

	self:UpdateView()
	self:OnBtnMin()

	if UIModule.HasUI(Constant.UIControllerName.HomeLandMakeItemListUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandMakeItemListUI, false)
	end
end

function HomeLandMakeItemUI:OnClose(userData)
	self.compoundView:Close()
	self.deComposeView:Close()

	if UIModule.HasUI(Constant.UIControllerName.HomeLandMakeItemListUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandMakeItemListUI, true)
	end
end

function HomeLandMakeItemUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
	self.btnMinComponent.onClick:AddListener(self.delegateBtnMin)
	self.btnReduceComponent.onClick:AddListener(self.delegateBtnReduce)
	self.btnAddComponent.onClick:AddListener(self.delegateBtnAdd)
	self.btnMaxComponent.onClick:AddListener(self.delegateBtnMax)
	self.btnProcessComponent.onClick:AddListener(self.delegateBtnProcess)
end

function HomeLandMakeItemUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
	self.btnMinComponent.onClick:RemoveListener(self.delegateBtnMin)
	self.btnReduceComponent.onClick:RemoveListener(self.delegateBtnReduce)
	self.btnAddComponent.onClick:RemoveListener(self.delegateBtnAdd)
	self.btnMaxComponent.onClick:RemoveListener(self.delegateBtnMax)
	self.btnProcessComponent.onClick:RemoveListener(self.delegateBtnProcess)
end

function HomeLandMakeItemUI:OnPause()
	return
end

function HomeLandMakeItemUI:OnResume()
	return
end

function HomeLandMakeItemUI:OnCover()
	return
end

function HomeLandMakeItemUI:OnReveal()
	return
end

function HomeLandMakeItemUI:OnRefocus(userData)
	return
end

function HomeLandMakeItemUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandMakeItemUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandMakeItemUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandMakeItemUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandMakeItemUI:OnDestroy()
	self.compoundView:Dispose()
	self.deComposeView:Dispose()
end

function HomeLandMakeItemUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandMakeItemUI)
end

function HomeLandMakeItemUI:UpdateView()
	UGUIUtil.SetText(self.TextBtnClose, HomeLandMakeItemListUIApi:GetString("TextBtnClose", self.homeBuildingData.buildingPOD.lv))
	UGUIUtil.SetText(self.TextBtnProcess, HomeLandMakeItemListUIApi:GetString("TextBtnProcess", self.processType))
	self.compoundView:Close()
	self.deComposeView:Close()

	if self.processType == 1 then
		self.compoundView:Open()
		self.compoundView:UpdateView(self.processData, self.count)
	elseif self.processType == 2 then
		self.deComposeView:Open()
		self.deComposeView:UpdateView(self.processData, self.count)
	end
end

function HomeLandMakeItemUI:HomeLandMakeItemUI(cfgBuildingID, lv)
	if self.homeBuildingData ~= nil and self.homeBuildingData.buildingPOD.cid == cfgBuildingID then
		self.homeBuildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuildingID)

		self:UpdateView()
	end
end

function HomeLandMakeItemUI:ShowCount()
	if self.processType == 1 then
		local maxNum = HomeLandProcessMould.CompoundMaxNum(self.processData)

		if self.count < 1 or maxNum < 1 then
			self.count = 1
		end

		if maxNum < self.count then
			self.count = maxNum
		end

		self.count = self.count == 0 and 1 or self.count

		UGUIUtil.SetText(self.TextValue, tostring(self.count))
		self.compoundView:UpdateView(self.processData, self.count)
	elseif self.processType == 2 then
		local have = WarehouseModule.GetItemNumByCfgID(self.processData.cfgInfo.ItemID)

		if self.count < 1 or have < 1 then
			self.count = 1
		end

		if have < self.count then
			self.count = have
		end

		self.count = self.count == 0 and 1 or self.count

		UGUIUtil.SetText(self.TextValue, tostring(self.count))
		self.deComposeView:UpdateView(self.processData, self.count)
	end
end

function HomeLandMakeItemUI:OnBtnMin()
	self.count = 1

	self:ShowCount()
end

function HomeLandMakeItemUI:OnBtnReduce()
	self.count = self.count - 1

	self:ShowCount()
end

function HomeLandMakeItemUI:OnBtnAdd()
	self.count = self.count + 1

	self:ShowCount()
end

function HomeLandMakeItemUI:OnBtnMax()
	if self.processType == 1 then
		self.count = HomeLandProcessMould.CompoundMaxNum(self.processData)
	elseif self.processType == 2 then
		self.count = WarehouseModule.GetItemNumByCfgID(self.processData.cfgInfo.ItemID)
	end

	self:ShowCount()
end

function HomeLandMakeItemUI:OnBtnProcess()
	if self.count <= 0 then
		NoticeModule.ShowNoticeByType(1, HomeLandMakeItemListUIApi:GetString("ErrorMsg", self.processType))

		return
	end

	if self.processType == 1 then
		local maxNum = HomeLandProcessMould.CompoundMaxNum(self.processData)

		if maxNum < self.count then
			NoticeModule.ShowNoticeByType(1, HomeLandMakeItemListUIApi:GetString("ErrorMsg1", self.processType))

			return
		end

		HomeLandProcessMould.Compound(self.processData.cid, self.homeBuildingData.cfgBuildingID, self.count)
	elseif self.processType == 2 then
		local have = WarehouseModule.GetItemNumByCfgID(self.processData.cfgInfo.ItemID)

		if have < self.count then
			NoticeModule.ShowNoticeByType(1, HomeLandMakeItemListUIApi:GetString("ErrorMsg1", self.processType))

			return
		end

		HomeLandProcessMould.Decompose(self.processData.cid, self.homeBuildingData.cfgBuildingID, self.count)
	end

	self:OnBtnClose()
end

return HomeLandMakeItemUI
