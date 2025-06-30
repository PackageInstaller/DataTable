-- chunkname: @IQIGame\\UI\\GuildEditUI.lua

local GuildEditUI = {
	auditType = 0,
	policyType = 0
}

GuildEditUI = Base:Extend("GuildEditUI", "IQIGame.Onigao.UI.GuildEditUI", GuildEditUI)

require("IQIGame.UIExternalApi.GuildEditUIApi")

local GuildEditChangeNameView = require("IQIGame.UI.Guild.GuildEdit.GuildEditChangeNameView")
local GuildEditSettingView = require("IQIGame.UI.Guild.GuildEdit.GuildEditSettingView")
local GuildHeadCell = require("IQIGame.UI.Guild.GuildMain.GuildHeadCell")

function GuildEditUI:OnInit()
	UGUIUtil.SetText(self.PolicyTitle, GuildEditUIApi:GetString("PolicyTitle"))
	UGUIUtil.SetText(self.AuditTypeTitle, GuildEditUIApi:GetString("AuditTypeTitle"))

	self.TogglePolicy0:GetComponent("ToggleHelperComponent").text = GuildEditUIApi:GetString("TextPolicy", 0)
	self.TogglePolicy1:GetComponent("ToggleHelperComponent").text = GuildEditUIApi:GetString("TextPolicy", 1)
	self.ToggleAuditType0:GetComponent("ToggleHelperComponent").text = GuildEditUIApi:GetString("TextAuditType", 0)
	self.ToggleAuditType1:GetComponent("ToggleHelperComponent").text = GuildEditUIApi:GetString("TextAuditType", 1)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateBtnGuildSet()
		self:OnBtnGuildSet()
	end

	function self.DelegateBtnHead()
		self:OnBtnHead()
	end

	function self.DelegatePolicyToggle0(isOn)
		self:OnPolicyToggle0(isOn)
	end

	function self.DelegatePolicyToggle1(isOn)
		self:OnPolicyToggle1(isOn)
	end

	function self.DelegateAuditTypeToggle0(isOn)
		self:OnAuditTypeToggle0(isOn)
	end

	function self.DelegateAuditTypeToggle1(isOn)
		self:OnAuditTypeToggle1(isOn)
	end

	function self.DelegateGuildUpdateEvent()
		self:OnGuildUpdateEvent()
	end

	self.editSettingView = GuildEditSettingView.New(self.GuildSetting)
	self.editChangeNameView = GuildEditChangeNameView.New(self.GuildChangeName)
	self.guildHeadCell = GuildHeadCell.New(self.GuildHead)
end

function GuildEditUI:GetPreloadAssetPaths()
	return nil
end

function GuildEditUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildEditUI:IsManualShowOnOpen(userData)
	return false
end

function GuildEditUI:GetBGM(userData)
	return nil
end

function GuildEditUI:OnOpen(userData)
	self.editSettingView:Close()
	self.editChangeNameView:Close()
	self:UpdateView()
end

function GuildEditUI:OnClose(userData)
	self.editSettingView:Close()
	self.editChangeNameView:Close()
end

function GuildEditUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.GuildBtnSet:GetComponent("Button").onClick:AddListener(self.DelegateBtnGuildSet)
	self.GuildBtnHead:GetComponent("Button").onClick:AddListener(self.DelegateBtnHead)
	self.TogglePolicy0:GetComponent("Toggle").onValueChanged:AddListener(self.DelegatePolicyToggle0)
	self.TogglePolicy1:GetComponent("Toggle").onValueChanged:AddListener(self.DelegatePolicyToggle1)
	self.ToggleAuditType0:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateAuditTypeToggle0)
	self.ToggleAuditType1:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateAuditTypeToggle1)
	EventDispatcher.AddEventListener(EventID.GuildUpdateEvent, self.DelegateGuildUpdateEvent)
end

function GuildEditUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.GuildBtnSet:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnGuildSet)
	self.GuildBtnHead:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHead)
	self.TogglePolicy0:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegatePolicyToggle0)
	self.TogglePolicy1:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegatePolicyToggle1)
	self.ToggleAuditType0:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateAuditTypeToggle0)
	self.ToggleAuditType1:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateAuditTypeToggle1)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateEvent, self.DelegateGuildUpdateEvent)
end

function GuildEditUI:OnPause()
	return
end

function GuildEditUI:OnResume()
	return
end

function GuildEditUI:OnCover()
	return
end

function GuildEditUI:OnReveal()
	return
end

function GuildEditUI:OnRefocus(userData)
	return
end

function GuildEditUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildEditUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildEditUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildEditUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildEditUI:OnDestroy()
	self.editSettingView:Dispose()
	self.editChangeNameView:Dispose()
	self.guildHeadCell:Dispose()
end

function GuildEditUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function GuildEditUI:ShowDefault()
	self.editSettingView:Close()
	self.editChangeNameView:Close()
end

function GuildEditUI:OnBtnGuildSet()
	self.editChangeNameView:Open()
end

function GuildEditUI:OnBtnHead()
	self.editSettingView:Open()
end

function GuildEditUI:OnPolicyToggle0(isOn)
	if isOn then
		self.policyType = 0

		if self.myMemberData.position == Constant.GuildPosition.Guild_Ordinary_Members then
			return
		end

		GuildModule.EditInfo(GuildModule.guildPOD.base.headIcon, GuildModule.guildPOD.base.avatarFrame, self.policyType, GuildModule.guildPOD.base.auditType)
	end
end

function GuildEditUI:OnPolicyToggle1(isOn)
	if isOn then
		self.policyType = 1

		if self.myMemberData.position == Constant.GuildPosition.Guild_Ordinary_Members then
			return
		end

		GuildModule.EditInfo(GuildModule.guildPOD.base.headIcon, GuildModule.guildPOD.base.avatarFrame, self.policyType, GuildModule.guildPOD.base.auditType)
	end
end

function GuildEditUI:OnAuditTypeToggle0(isOn)
	if isOn then
		self.auditType = 0

		if self.myMemberData.position == Constant.GuildPosition.Guild_Ordinary_Members then
			return
		end

		GuildModule.EditInfo(GuildModule.guildPOD.base.headIcon, GuildModule.guildPOD.base.avatarFrame, GuildModule.guildPOD.base.policy, self.auditType)
	end
end

function GuildEditUI:OnAuditTypeToggle1(isOn)
	if isOn then
		self.auditType = 1

		if self.myMemberData.position == Constant.GuildPosition.Guild_Ordinary_Members then
			return
		end

		GuildModule.EditInfo(GuildModule.guildPOD.base.headIcon, GuildModule.guildPOD.base.avatarFrame, GuildModule.guildPOD.base.policy, self.auditType)
	end
end

function GuildEditUI:OnGuildUpdateEvent()
	self:UpdateView()
end

function GuildEditUI:UpdateView()
	self.auditType = GuildModule.guildPOD.base.auditType
	self.policyType = GuildModule.guildPOD.base.policy
	self.myMemberData = GuildModule.GetMySelfGuildMemberData()

	local isLeader = self.myMemberData.position == Constant.GuildPosition.Guild_President

	self.GuildBtnSet:GetComponent("Button").interactable = isLeader
	self.GuildBtnHead:GetComponent("Button").interactable = isLeader
	self.TogglePolicy0:GetComponent("Toggle").interactable = isLeader
	self.TogglePolicy1:GetComponent("Toggle").interactable = isLeader
	self.ToggleAuditType0:GetComponent("Toggle").interactable = isLeader
	self.ToggleAuditType1:GetComponent("Toggle").interactable = isLeader

	UGUIUtil.SetText(self.GuildName, GuildModule.guildPOD.base.name)
	self.guildHeadCell:SetData(GuildModule.guildPOD.base.headIcon, GuildModule.guildPOD.base.avatarFrame, GuildModule.guildPOD.base.level)

	self["TogglePolicy" .. self.policyType]:GetComponent("Toggle").isOn = true
	self["ToggleAuditType" .. self.auditType]:GetComponent("Toggle").isOn = true

	self.editSettingView:UpdateView()
end

return GuildEditUI
