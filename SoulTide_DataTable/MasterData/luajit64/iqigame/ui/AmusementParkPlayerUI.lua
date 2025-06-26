-- chunkname: @IQIGame\\UI\\AmusementParkPlayerUI.lua

local AmusementParkPlayerUI = {
	SelectIndex = 1,
	ChildPanels = {},
	PlayerToggleCellPool = {}
}

AmusementParkPlayerUI = Base:Extend("AmusementParkPlayerUI", "IQIGame.Onigao.UI.AmusementParkPlayerUI", AmusementParkPlayerUI)

require("IQIGame.UIExternalApi.AmusementParkPlayerUIApi")

local AmusementParkPlayerRecruitView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayer.AmusementParkPlayerRecruitView")
local AmusementParkPlayerCultivateView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayer.AmusementParkPlayerCultivateView")
local AmusementParkPlayerDistributionView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayer.AmusementParkPlayerDistributionView")
local AmusementParkPlayerToggleCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayer.AmusementParkPlayerToggleCell")
local ROTicketCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.ROTicketCell")

function AmusementParkPlayerUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateToggleControl(isOn)
		self:OnTogControl(isOn)
	end

	function self.DelegateAPUpdateInfoPark()
		self:OnUpdateInfoPark()
	end

	self.ChildPanels = {}
	self.ChildPanels[1] = AmusementParkPlayerRecruitView.New(self.Recruit, self)
	self.ChildPanels[2] = AmusementParkPlayerCultivateView.New(self.Cultivate, self)
	self.ChildPanels[3] = AmusementParkPlayerDistributionView.New(self.Distribution, self)
	self.PlayerToggleCellPool = {}

	self.ChildPageToggleMould:SetActive(false)

	for i = 1, #self.ChildPanels do
		local toggleName = AmusementParkPlayerUIApi:GetString("ChildToggleName", i)
		local controlCell = AmusementParkPlayerToggleCell.New(UnityEngine.Object.Instantiate(self.ChildPageToggleMould))

		controlCell.View:SetActive(true)
		controlCell.View.transform:SetParent(self.ChildPageToggleNode.transform, false)
		controlCell:SetData(toggleName, i)

		local tog = controlCell.View:GetComponent("Toggle")

		tog.group = self.ChildPageToggleNode:GetComponent("ToggleGroup")
		self.PlayerToggleCellPool[i] = controlCell
	end

	local cfgControlData = CfgAmusementParkControlTable[AmusementParkModule.GlobalCid]

	self.ROTicketCell = ROTicketCell.New(self.TicketMould)

	self.ROTicketCell:RefreshData(cfgControlData.MoneyId)
end

function AmusementParkPlayerUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkPlayerUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkPlayerUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkPlayerUI:GetBGM(userData)
	return nil
end

function AmusementParkPlayerUI:OnOpen(userData)
	self.SelectIndex = userData.Index
	self.SelectBuild = userData.SelectBuild
	self.PlayerToggleCellPool[self.SelectIndex].View:GetComponent("Toggle").isOn = true

	self:UpdateView()
end

function AmusementParkPlayerUI:OnClose(userData)
	for i, v in pairs(self.ChildPanels) do
		v:Close()
	end
end

function AmusementParkPlayerUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)

	for i, v in pairs(self.PlayerToggleCellPool) do
		v.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleControl)
	end

	EventDispatcher.AddEventListener(EventID.APUpdateInfoEvent, self.DelegateAPUpdateInfoPark)
end

function AmusementParkPlayerUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)

	for i, v in pairs(self.PlayerToggleCellPool) do
		v.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleControl)
	end

	EventDispatcher.RemoveEventListener(EventID.APUpdateInfoEvent, self.DelegateAPUpdateInfoPark)
end

function AmusementParkPlayerUI:OnPause()
	return
end

function AmusementParkPlayerUI:OnResume()
	return
end

function AmusementParkPlayerUI:OnCover()
	return
end

function AmusementParkPlayerUI:OnReveal()
	return
end

function AmusementParkPlayerUI:OnRefocus(userData)
	return
end

function AmusementParkPlayerUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkPlayerUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkPlayerUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkPlayerUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkPlayerUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.ChildPanels) do
		v:Dispose()
	end

	self.ROTicketCell:Dispose()

	self.ROTicketCell = nil
end

function AmusementParkPlayerUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function AmusementParkPlayerUI:OnTogControl(isOn)
	if isOn then
		for i = 1, #self.PlayerToggleCellPool do
			local control = self.PlayerToggleCellPool[i]

			if control.View:GetComponent("Toggle").isOn and self.SelectIndex ~= i then
				self.SelectIndex = i

				self:ShowChildView()

				break
			end
		end
	end
end

function AmusementParkPlayerUI:OnUpdateInfoPark()
	for i, v in pairs(self.ChildPanels) do
		v:UpdateView(false)
	end
end

function AmusementParkPlayerUI:UpdateView()
	self:ShowChildView()
end

function AmusementParkPlayerUI:ShowChildView()
	for i, v in pairs(self.ChildPanels) do
		if self.SelectIndex == i then
			v:Open()
		else
			v:Close()
		end
	end
end

return AmusementParkPlayerUI
