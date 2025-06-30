-- chunkname: @IQIGame\\UI\\GuildMemberAppointUI.lua

local GuildMemberAppointUI = {}

GuildMemberAppointUI = Base:Extend("GuildMemberAppointUI", "IQIGame.Onigao.UI.GuildMemberAppointUI", GuildMemberAppointUI)

require("IQIGame.UIExternalApi.GuildMemberAppointUIApi")

local GuildMemberAppointAlertView = require("IQIGame.UI.Guild.GuildMember.GuildMemberAppointAlertView")
local GuildRemoveAlertView = require("IQIGame.UI.Guild.GuildMember.GuildRemoveAlertView")

function GuildMemberAppointUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.appointAlertView = GuildMemberAppointAlertView.New(self.AppointPositionType)

	function self.appointAlertView.callBackCloseUI()
		self:OnClickCloseBtn()
	end

	self.removeAlertView = GuildRemoveAlertView.New(self.RemoveType)

	function self.removeAlertView.callBackCloseUI()
		self:OnClickCloseBtn()
	end
end

function GuildMemberAppointUI:GetPreloadAssetPaths()
	return nil
end

function GuildMemberAppointUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildMemberAppointUI:IsManualShowOnOpen(userData)
	return false
end

function GuildMemberAppointUI:GetBGM(userData)
	return nil
end

function GuildMemberAppointUI:OnOpen(userData)
	self.openType = userData.OpenType
	self.memberData = userData.MemberData

	self:UpdateView()
end

function GuildMemberAppointUI:OnClose(userData)
	self.appointAlertView:Close()
	self.removeAlertView:Close()
end

function GuildMemberAppointUI:OnAddListeners()
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function GuildMemberAppointUI:OnRemoveListeners()
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function GuildMemberAppointUI:OnPause()
	return
end

function GuildMemberAppointUI:OnResume()
	return
end

function GuildMemberAppointUI:OnCover()
	return
end

function GuildMemberAppointUI:OnReveal()
	return
end

function GuildMemberAppointUI:OnRefocus(userData)
	return
end

function GuildMemberAppointUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildMemberAppointUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildMemberAppointUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildMemberAppointUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildMemberAppointUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.appointAlertView:Dispose()

	self.appointAlertView = nil

	self.removeAlertView:Dispose()

	self.removeAlertView = nil
end

function GuildMemberAppointUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function GuildMemberAppointUI:UpdateView()
	self.appointAlertView:Close()
	self.removeAlertView:Close()

	if self.openType == 1 then
		self.appointAlertView:Open()
		self.appointAlertView:SetData(self.memberData)
	elseif self.openType == 2 then
		self.removeAlertView:Open()
		self.removeAlertView:SetData(self.memberData)
	end
end

return GuildMemberAppointUI
