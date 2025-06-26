-- chunkname: @IQIGame\\UI\\HomeLandManufactureListUI.lua

local HomeLandManufactureListUI = Base:Extend("HomeLandManufactureListUI", "IQIGame.Onigao.UI.HomeLandManufactureListUI", {})
local HomeLandManufactureThemeView = require("IQIGame.UI.HomeLandManufacture.HomeLandManufactureThemeView")

function HomeLandManufactureListUI:OnInit()
	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateHomeUpdateBuildingEvent(buildCid)
		self:OnHomeUpdateBuildingEvent(buildCid)
	end

	self.manufactureThemeView = HomeLandManufactureThemeView.New(self.PanelTheme, self)
end

function HomeLandManufactureListUI:GetPreloadAssetPaths()
	return {
		UIGlobalApi.GetItemCellAssetPath()
	}
end

function HomeLandManufactureListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandManufactureListUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandManufactureListUI:GetBGM(userData)
	return nil
end

function HomeLandManufactureListUI:OnOpen(userData)
	self.queueId = userData[1]
	self.homeBuildingData = userData[2]
	self.decorate = userData[3]

	self:UpdateView()
end

function HomeLandManufactureListUI:OnClose(userData)
	self.manufactureThemeView:Close()
end

function HomeLandManufactureListUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandManufactureListUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandManufactureListUI:OnPause()
	return
end

function HomeLandManufactureListUI:OnResume()
	return
end

function HomeLandManufactureListUI:OnCover()
	return
end

function HomeLandManufactureListUI:OnReveal()
	return
end

function HomeLandManufactureListUI:OnRefocus(userData)
	return
end

function HomeLandManufactureListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandManufactureListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandManufactureListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandManufactureListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandManufactureListUI:OnDestroy()
	self.manufactureThemeView:Dispose()
end

function HomeLandManufactureListUI:OnHomeUpdateBuildingEvent(cfgBuildingID)
	if self.homeBuildingData ~= nil and self.homeBuildingData.cfgBuildingID == cfgBuildingID then
		self.homeBuildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuildingID)

		UGUIUtil.SetText(self.TextBtnClose, HomeLandManufactureUIApi:GetString("TextBtnClose", self.homeBuildingData.cfgBuilding.Name, self.homeBuildingData.buildingPOD.lv))
	end
end

function HomeLandManufactureListUI:UpdateView()
	UGUIUtil.SetText(self.TextBtnClose, HomeLandManufactureUIApi:GetString("TextBtnClose", self.homeBuildingData.cfgBuilding.Name, self.homeBuildingData.buildingPOD.lv))
	self.manufactureThemeView:Open()
end

function HomeLandManufactureListUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandManufactureListUI)
end

function HomeLandManufactureListUI:OnBtnUpgrade()
	UIModule.Open(Constant.UIControllerName.HomeLandFunctionLevelUpUI, Constant.UILayer.UI, {
		self.homeBuildingData.cfgBuildingID,
		self.decorate
	})
end

return HomeLandManufactureListUI
