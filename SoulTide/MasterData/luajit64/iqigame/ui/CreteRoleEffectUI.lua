-- chunkname: @IQIGame\\UI\\CreteRoleEffectUI.lua

local CreteRoleEffectUI = Base:Extend("CreteRoleEffectUI", "IQIGame.Onigao.UI.CreteRoleEffectUI", {
	count = 0,
	ChangePageEffectPlayId = 0
})

function CreteRoleEffectUI:OnInit()
	return
end

function CreteRoleEffectUI:GetPreloadAssetPaths()
	return nil
end

function CreteRoleEffectUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CreteRoleEffectUI:IsManualShowOnOpen(userData)
	return false
end

function CreteRoleEffectUI:GetBGM(userData)
	return nil
end

function CreteRoleEffectUI:OnOpen(userData)
	self.count = 0
	self.ChangePageEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(9003402, 50000, 0, self.RotatableEffectNode, self.UIController:GetComponent("Canvas").sortingOrder + 1)
	self.timer = Timer.New(function()
		self:OpenSimulateLotteryUI()
	end, 0.1, -1)

	self.timer:Start()
end

function CreteRoleEffectUI:OnClose(userData)
	self:StopChangePageEffect()

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function CreteRoleEffectUI:OnAddListeners()
	return
end

function CreteRoleEffectUI:OnRemoveListeners()
	return
end

function CreteRoleEffectUI:OnPause()
	return
end

function CreteRoleEffectUI:OnResume()
	return
end

function CreteRoleEffectUI:OnCover()
	return
end

function CreteRoleEffectUI:OnReveal()
	return
end

function CreteRoleEffectUI:OnRefocus(userData)
	return
end

function CreteRoleEffectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CreteRoleEffectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CreteRoleEffectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CreteRoleEffectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CreteRoleEffectUI:OnDestroy()
	return
end

function CreteRoleEffectUI:OpenSimulateLotteryUI()
	self.count = self.count + 1

	if self.count == 10 then
		UIModule.Open(Constant.UIControllerName.SimulateLotteryUI, Constant.UILayer.UI, {
			delayCloseTime = 0,
			items = {
				{
					tag = 1,
					num = 1,
					cid = 10112
				}
			},
			onComplete = function()
				UIModule.Close(Constant.UIControllerName.SimulateLotteryUI)
				CreateRoleModule.OnEndDialogEvent(CreateRoleModule.CreateRoleDiaLog3)
			end
		})
	elseif self.count == 20 then
		self.timer:Stop()
		self:Close()
	end
end

function CreteRoleEffectUI:Close()
	UIModule.Close(Constant.UIControllerName.CreteRoleEffectUI)
end

function CreteRoleEffectUI:StopChangePageEffect()
	if self.ChangePageEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.ChangePageEffectPlayId)

		self.ChangePageEffectPlayId = 0
	end
end

return CreteRoleEffectUI
