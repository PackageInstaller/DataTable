-- chunkname: @IQIGame\\UI\\HomeLandVisitHistoryUI.lua

local HomeLandVisitHistoryUI = Base:Extend("HomeLandVisitHistoryUI", "IQIGame.Onigao.UI.HomeLandVisitHistoryUI", {})
local HomeLandVisitHistoryItem = require("IQIGame.UI.HomeLandVisit.HomeLandVisitHistoryItem")

function HomeLandVisitHistoryUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, HomeLandVisitUIApi:GetString("TextVisitHistoryTitle", false))
	UGUIUtil.SetText(self.TextTitleEng, HomeLandVisitUIApi:GetString("TextVisitHistoryTitle", true))

	self.scrollComponent = self.Scroll:GetComponent("ScrollAreaList")

	function self.scrollComponent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function HomeLandVisitHistoryUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandVisitHistoryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandVisitHistoryUI:OnOpen(userData)
	self.buildIndData = userData

	self:UpDateView()
end

function HomeLandVisitHistoryUI:OnClose(userData)
	return
end

function HomeLandVisitHistoryUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function HomeLandVisitHistoryUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function HomeLandVisitHistoryUI:OnPause()
	return
end

function HomeLandVisitHistoryUI:OnResume()
	return
end

function HomeLandVisitHistoryUI:OnCover()
	return
end

function HomeLandVisitHistoryUI:OnReveal()
	return
end

function HomeLandVisitHistoryUI:OnRefocus(userData)
	return
end

function HomeLandVisitHistoryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandVisitHistoryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandVisitHistoryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandVisitHistoryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandVisitHistoryUI:OnDestroy()
	HomeLandVisitHistoryItem.DisposeIn(self)
end

function HomeLandVisitHistoryUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandVisitHistoryUI)
end

function HomeLandVisitHistoryUI:UpDateView()
	self.helpLogs = {}

	if self.buildIndData then
		self.helpLogs = self.buildIndData.buildingPOD.helpLogs
	end

	self.scrollComponent:Refresh(#self.helpLogs)
end

function HomeLandVisitHistoryUI:OnRenderItem(cell)
	local logPOD = self.helpLogs[cell.index + 1]

	if logPOD == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local itemGo = cell.gameObject
	local visitHistoryItem = HomeLandVisitHistoryItem.PackageOrReuseView(self, itemGo)

	visitHistoryItem:SetDate(self.buildIndData.cfgBuildingID, logPOD)
end

return HomeLandVisitHistoryUI
