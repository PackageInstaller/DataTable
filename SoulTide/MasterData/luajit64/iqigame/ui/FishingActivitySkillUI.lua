-- chunkname: @IQIGame\\UI\\FishingActivitySkillUI.lua

local FishingActivitySkillUI = {
	childViewIndex = 1
}

FishingActivitySkillUI = Base:Extend("FishingActivitySkillUI", "IQIGame.Onigao.UI.FishingActivitySkillUI", FishingActivitySkillUI)

local FishingActivitySkillListView = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivitySkill.FishingActivitySkillListView")
local FishingActivityAttrView = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivitySkill.FishingActivityAttrView")

require("IQIGame.UIExternalApi.FishingActivitySkillUIApi")

function FishingActivitySkillUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnToggleAttrValueChanged(isOn)
		self:OnToggleAttrValueChanged(isOn)
	end

	function self.DelegateOnToggleActionValueChanged(isOn)
		self:OnToggleActionValueChanged(isOn)
	end

	function self.DelegateUpdateSkill()
		self:OnUpdateSkill()
	end

	self.skillAttrView = FishingActivityAttrView.New(self.AttrView)
	self.skillListView = FishingActivitySkillListView.New(self.SkillView)

	local cfgControlData = CfgFishActiveControlTable[FishingActivityModule.globalCid]

	self.MoneyCellBuilder = MoneyCellsBuilder.New(self.CurrencyCom)

	self.MoneyCellBuilder:RefreshView({
		cfgControlData.MoneyId,
		cfgControlData.ScoreId
	})

	self.EnergyCell = EnergyCell.New(self.EnergyCom)
end

function FishingActivitySkillUI:GetPreloadAssetPaths()
	return nil
end

function FishingActivitySkillUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FishingActivitySkillUI:IsManualShowOnOpen(userData)
	return false
end

function FishingActivitySkillUI:GetBGM(userData)
	return nil
end

function FishingActivitySkillUI:OnOpen(userData)
	self:UpdateView()
end

function FishingActivitySkillUI:OnClose(userData)
	return
end

function FishingActivitySkillUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.ToggleAttr:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggleAttrValueChanged)
	self.ToggleAction:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggleActionValueChanged)
	EventDispatcher.AddEventListener(EventID.FishingActivityUpdateEvent, self.DelegateUpdateSkill)
end

function FishingActivitySkillUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.ToggleAttr:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggleAttrValueChanged)
	self.ToggleAction:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggleActionValueChanged)
	EventDispatcher.RemoveEventListener(EventID.FishingActivityUpdateEvent, self.DelegateUpdateSkill)
end

function FishingActivitySkillUI:OnPause()
	return
end

function FishingActivitySkillUI:OnResume()
	return
end

function FishingActivitySkillUI:OnCover()
	return
end

function FishingActivitySkillUI:OnReveal()
	return
end

function FishingActivitySkillUI:OnRefocus(userData)
	return
end

function FishingActivitySkillUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FishingActivitySkillUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FishingActivitySkillUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FishingActivitySkillUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FishingActivitySkillUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.skillListView:Dispose()
	self.skillAttrView:Dispose()
	self.MoneyCellBuilder:Dispose()

	self.MoneyCellBuilder = nil

	self.EnergyCell:Dispose()
end

function FishingActivitySkillUI:UpdateView()
	self:RefreshChildView()
end

function FishingActivitySkillUI:RefreshChildView()
	self.skillAttrView:Close()
	self.skillListView:Close()

	if self.childViewIndex == 1 then
		self.skillAttrView:Open()
	elseif self.childViewIndex == 2 then
		self.skillListView:Open()
	end
end

function FishingActivitySkillUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function FishingActivitySkillUI:OnToggleAttrValueChanged(isOn)
	if isOn then
		self.childViewIndex = 1

		self:RefreshChildView()
	end
end

function FishingActivitySkillUI:OnToggleActionValueChanged(isOn)
	if isOn then
		self.childViewIndex = 2

		self:RefreshChildView()
	end
end

function FishingActivitySkillUI:OnUpdateSkill()
	self.skillAttrView:UpdateView()
	self.skillListView:UpdateView(false)
end

return FishingActivitySkillUI
