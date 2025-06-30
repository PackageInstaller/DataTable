-- chunkname: @IQIGame\\UI\\RoleUpgradeUI.lua

local RoleUpgradeUI = {}

RoleUpgradeUI = Base:Extend("RoleUpgradeUI", "IQIGame.Onigao.UI.RoleUpgradeUI", RoleUpgradeUI)

local RoleUpgradeView = require("IQIGame.UI.RoleDevelopment.RoleTraining.RoleUpgradeView")

function RoleUpgradeUI:OnInit()
	self.roleUpgradeView = RoleUpgradeView.New(self.RoleUpgradePanel)
end

function RoleUpgradeUI:GetPreloadAssetPaths()
	return nil
end

function RoleUpgradeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RoleUpgradeUI:IsManualShowOnOpen(userData)
	return false
end

function RoleUpgradeUI:GetBGM(userData)
	return nil
end

function RoleUpgradeUI:OnOpen(heroCid)
	self.roleUpgradeView:SetData(heroCid)
end

function RoleUpgradeUI:OnClose(userData)
	return
end

function RoleUpgradeUI:OnAddListeners()
	return
end

function RoleUpgradeUI:OnRemoveListeners()
	return
end

function RoleUpgradeUI:OnPause()
	return
end

function RoleUpgradeUI:OnResume()
	return
end

function RoleUpgradeUI:OnCover()
	return
end

function RoleUpgradeUI:OnReveal()
	return
end

function RoleUpgradeUI:OnRefocus(userData)
	return
end

function RoleUpgradeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RoleUpgradeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RoleUpgradeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RoleUpgradeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RoleUpgradeUI:OnDestroy()
	self.roleUpgradeView:Dispose()
end

return RoleUpgradeUI
