-- chunkname: @IQIGame\\UI\\DetailsPreviewUI.lua

local roleDetailsView = require("IQIGame.UI.DetailsPreview.RolePreviewDetailsView")
local skillDetailsView = require("IQIGame.UI.DetailsPreview.SkillPreviewDetailsView")
local DetailsPreviewUI = {}

DetailsPreviewUI = Base:Extend("DetailsPreviewUI", "IQIGame.Onigao.UI.DetailsPreviewUI", DetailsPreviewUI)

function DetailsPreviewUI:OnInit()
	self.commonReturnBtn = CommonReturnBtn.New(self.comReturnBtn, self)

	self.commonReturnBtn:SetHomeBtnState(false)

	self.roleDetailsPanel = roleDetailsView.New(self.infoPanel, self)
	self.skillDetailsPanel = skillDetailsView.New(self.skillPanel, self)
end

function DetailsPreviewUI:GetPreloadAssetPaths()
	return nil
end

function DetailsPreviewUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DetailsPreviewUI:IsManualShowOnOpen(userData)
	return false
end

function DetailsPreviewUI:GetBGM(userData)
	return nil
end

function DetailsPreviewUI:OnOpen(userData)
	self:SetReturnBtnState(true)

	if userData.type == Constant.ItemType.Hero then
		self.roleDetailsPanel:Show()
		self.roleDetailsPanel:SetData(userData.cid)
		self.skillDetailsPanel:Hide()
	elseif userData.type == Constant.ItemType.Skill then
		self.skillDetailsPanel:Show()
		self.skillDetailsPanel:SetData(userData.cid)
		self.roleDetailsPanel:Hide()
	else
		self.skillDetailsPanel:Hide()
		self.roleDetailsPanel:Hide()
	end
end

function DetailsPreviewUI:OnClose(userData)
	return
end

function DetailsPreviewUI:OnAddListeners()
	return
end

function DetailsPreviewUI:OnRemoveListeners()
	return
end

function DetailsPreviewUI:OnPause()
	return
end

function DetailsPreviewUI:OnResume()
	return
end

function DetailsPreviewUI:OnCover()
	return
end

function DetailsPreviewUI:OnReveal()
	return
end

function DetailsPreviewUI:OnRefocus(userData)
	return
end

function DetailsPreviewUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DetailsPreviewUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DetailsPreviewUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DetailsPreviewUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DetailsPreviewUI:OnDestroy()
	self.roleDetailsPanel:Dispose()
	self.skillDetailsPanel:Dispose()
	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

function DetailsPreviewUI:SetReturnBtnState(state)
	if state == true then
		self.commonReturnBtn:Show()
	else
		self.commonReturnBtn:Hide()
	end
end

return DetailsPreviewUI
