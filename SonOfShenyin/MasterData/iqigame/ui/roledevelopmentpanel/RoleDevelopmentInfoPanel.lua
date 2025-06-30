-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\RoleDevelopmentInfoPanel.lua

local RoleDevelopmentPanelBase = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentPanelBase")
local RoleUpgradeView = require("IQIGame.UI.RoleDevelopment.RoleTraining.RoleUpgradeView")
local UpgradeCoreView = require("IQIGame.UI.RoleDevelopment.UpgradeCoreView")
local RoleBreachView = require("IQIGame.UI.RoleDevelopment.RoleBreachView")
local RoleBreachPreviewView = require("IQIGame.UI.RoleDevelopment.RoleBreachPreviewView")
local panel = Clone(RoleDevelopmentPanelBase)
local viewEnum = {
	UpgradeView = 2,
	BreachView = 3,
	BreachPreviewView = 4,
	InfoView = 1
}

function panel:__OnInit()
	self.curViewEnum = nil

	function self.DelegateOnGetHeroPreviewDataSuccess()
		self:OpenBreachView()
	end

	function self.DelegateOnClickCloseSubViewBtn()
		self:OnClickCloseSubViewBtn()
	end

	self.roleUpgradeView = RoleUpgradeView.New(self.RoleUpgradePanel, self)
	self.roleInfoView = UpgradeCoreView.New(self.RoleInfoPanel, self)
	self.roleBreachView = RoleBreachView.New(self.RoleBreachPanel, self)
	self.roleBreachPreviewView = RoleBreachPreviewView.New(self.RoleBreachPreviewPanel, self)
end

function panel:__OnAddListeners()
	self.CloseSubViewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseSubViewBtn)
	EventDispatcher.AddEventListener(EventID.GetRolePreviewBreakDataSucess, self.DelegateOnGetHeroPreviewDataSuccess)
end

function panel:__OnRemoveListeners()
	self.CloseSubViewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseSubViewBtn)
	EventDispatcher.RemoveEventListener(EventID.GetRolePreviewBreakDataSucess, self.DelegateOnGetHeroPreviewDataSuccess)
end

function panel:__OnShow()
	self:OpenRoleInfoView(false)
end

function panel:__OnHide()
	self.roleInfoView:Hide()
	self.roleUpgradeView:Hide()
	self.roleBreachView:Hide()
	self.roleBreachPreviewView:Hide()
end

function panel:__OnDispose()
	self.roleUpgradeView:Dispose()
	self.roleInfoView:Dispose()
	self.roleBreachView:Dispose()
	self.roleBreachPreviewView:Dispose()
end

function panel:__OnRefresh()
	self:OpenRoleInfoView(false)
end

function panel:OpenRoleInfoView(playOrNot)
	self.curViewEnum = viewEnum.InfoView

	self.roleUpgradeView:Hide()
	self.roleBreachView:Hide()
	self.roleInfoView:Show()
	self.roleInfoView:SetData(self.roleCid)

	if playOrNot then
		EventDispatcher.Dispatch(EventID.PlayContentAnimEvent, true)
	end

	self:SetCloseSubViewBtnState(false)
end

function panel:OpenUpgradeView()
	self.curViewEnum = viewEnum.UpgradeView

	self.roleInfoView:Hide()
	self.roleBreachView:Hide()
	self.roleUpgradeView:Show()
	self.roleUpgradeView:SetData(self.roleCid)
	EventDispatcher.Dispatch(EventID.PlayContentAnimEvent, false)
	self:SetCloseSubViewBtnState(true)
end

function panel:OpenBreachView()
	self.curViewEnum = viewEnum.BreachView

	self.roleInfoView:Hide()
	self.roleUpgradeView:Hide()
	self.roleBreachView:Show()
	self.roleBreachView:SetData(self.roleCid, false)

	if RoleDevelopmentModule.ShowBreachAnim then
		EventDispatcher.Dispatch(EventID.PlayContentAnimEvent, false)
	end

	self:SetCloseSubViewBtnState(true)
end

function panel:OpenRoleBreachPreviewView()
	self.curViewEnum = viewEnum.BreachPreviewView

	self.roleBreachPreviewView:SetData(self.roleCid)
	self.roleBreachPreviewView:Show()
end

function panel:OnClickCloseSubViewBtn()
	if self.curViewEnum == viewEnum.UpgradeView then
		self:OpenRoleInfoView(true)
	elseif self.curViewEnum == viewEnum.BreachView then
		self:OpenRoleInfoView(true)
	end
end

function panel:SetCloseSubViewBtnState(state)
	LuaUtility.SetGameObjectShow(self.CloseSubViewBtn, state)
end

return panel
