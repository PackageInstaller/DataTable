-- chunkname: @IQIGame\\UI\\DiySkillInfoUI.lua

local DiySkillInfoView = require("IQIGame.UI.RoleDevelopment.RoleTraining.DiySkillInfoView.DiySkillInfoView")
local DiySkillInfoUI = {}

DiySkillInfoUI = Base:Extend("DiySkillInfoUI", "IQIGame.Onigao.UI.DiySkillInfoUI", DiySkillInfoUI)

function DiySkillInfoUI:OnInit()
	self.diySkillInfoView = DiySkillInfoView.New(self.diySkillInfoPanel)
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.commonReturnBtn:SetHomeBtnState(false)
end

function DiySkillInfoUI:GetPreloadAssetPaths()
	return nil
end

function DiySkillInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DiySkillInfoUI:IsManualShowOnOpen(userData)
	return false
end

function DiySkillInfoUI:GetBGM(userData)
	return nil
end

function DiySkillInfoUI:OnOpen(userData)
	self.diySkillInfoView:Show(userData.roleCid, userData.skillType)
end

function DiySkillInfoUI:OnClose(userData)
	return
end

function DiySkillInfoUI:OnAddListeners()
	return
end

function DiySkillInfoUI:OnRemoveListeners()
	return
end

function DiySkillInfoUI:OnPause()
	return
end

function DiySkillInfoUI:OnResume()
	return
end

function DiySkillInfoUI:OnCover()
	return
end

function DiySkillInfoUI:OnReveal()
	return
end

function DiySkillInfoUI:OnRefocus(userData)
	return
end

function DiySkillInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DiySkillInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DiySkillInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DiySkillInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DiySkillInfoUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self.diySkillInfoView:Dispose()
	AssetUtil.UnloadAsset(self)
end

return DiySkillInfoUI
