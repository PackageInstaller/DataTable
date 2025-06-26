-- chunkname: @IQIGame\\UI\\JumpCreateRoleUI.lua

local JumpCreateRoleUI = Base:Extend("JumpCreateRoleUI", "IQIGame.Onigao.UI.JumpCreateRoleUI", {})

function JumpCreateRoleUI:OnInit()
	function self.delegateBtnJump()
		self:OnBtnJump()
	end
end

function JumpCreateRoleUI:GetPreloadAssetPaths()
	return nil
end

function JumpCreateRoleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function JumpCreateRoleUI:IsManualShowOnOpen(userData)
	return false
end

function JumpCreateRoleUI:GetBGM(userData)
	return nil
end

function JumpCreateRoleUI:OnOpen(userData)
	return
end

function JumpCreateRoleUI:OnClose(userData)
	return
end

function JumpCreateRoleUI:OnAddListeners()
	self.BtnJump:GetComponent("Button").onClick:AddListener(self.delegateBtnJump)
end

function JumpCreateRoleUI:OnRemoveListeners()
	self.BtnJump:GetComponent("Button").onClick:RemoveListener(self.delegateBtnJump)
end

function JumpCreateRoleUI:OnPause()
	return
end

function JumpCreateRoleUI:OnResume()
	return
end

function JumpCreateRoleUI:OnCover()
	return
end

function JumpCreateRoleUI:OnReveal()
	return
end

function JumpCreateRoleUI:OnRefocus(userData)
	return
end

function JumpCreateRoleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if UIModule.HasUI(Constant.UIControllerName.InputPlayerNameTextUI) then
		self.BtnJump:SetActive(false)
	else
		self.BtnJump:SetActive(true)
	end
end

function JumpCreateRoleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function JumpCreateRoleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function JumpCreateRoleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function JumpCreateRoleUI:OnDestroy()
	return
end

function JumpCreateRoleUI:OnBtnJump()
	CreateRoleModule.JumpCreateRole()

	if CreateRoleModule.CreateState > 0 then
		UIModule.Close(Constant.UIControllerName.JumpCreateRoleUI)
	end
end

return JumpCreateRoleUI
