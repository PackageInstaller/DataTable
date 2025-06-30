-- chunkname: @IQIGame\\UI\\HomeLandWorkEffectUI.lua

local HomeLandWorkEffectUI = Base:Extend("HomeLandWorkEffectUI", "IQIGame.Onigao.UI.HomeLandWorkEffectUI", {
	effectCount = 0,
	ChangePageEffectPlayId = 0
})

function HomeLandWorkEffectUI:OnInit()
	function self.delegateBtnJump()
		self:OnBtnJump()
	end
end

function HomeLandWorkEffectUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandWorkEffectUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandWorkEffectUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandWorkEffectUI:GetBGM(userData)
	return nil
end

function HomeLandWorkEffectUI:OnOpen(userData)
	self.affairData = userData
	self.effectCount = 0
	self.isJump = false

	self:PlayEffect()
	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandWorkEffectUIApi:GetString("WorkCameraPosition"), HomeLandWorkEffectUIApi:GetString("WorkCameraSize")))
	GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandChooseCastleUI, false)
end

function HomeLandWorkEffectUI:OnClose(userData)
	if self.timerMove then
		self.timerMove:Stop()
	end

	self.timerMove = nil

	self:StopChangePageEffect()
end

function HomeLandWorkEffectUI:OnAddListeners()
	self.BtnJump:GetComponent("Button").onClick:AddListener(self.delegateBtnJump)
end

function HomeLandWorkEffectUI:OnRemoveListeners()
	self.BtnJump:GetComponent("Button").onClick:RemoveListener(self.delegateBtnJump)
end

function HomeLandWorkEffectUI:OnPause()
	return
end

function HomeLandWorkEffectUI:OnResume()
	return
end

function HomeLandWorkEffectUI:OnCover()
	return
end

function HomeLandWorkEffectUI:OnReveal()
	return
end

function HomeLandWorkEffectUI:OnRefocus(userData)
	return
end

function HomeLandWorkEffectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandWorkEffectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandWorkEffectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandWorkEffectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandWorkEffectUI:OnDestroy()
	return
end

function HomeLandWorkEffectUI:PlayEffect()
	self:StopChangePageEffect()
	self.ImgBG:SetActive(true)

	local timer = Timer.New(function()
		self.effectCount = self.effectCount + 1

		self:EffectTimerEnd()
	end, HomeLandWorkEffectUIApi:GetString("CreateRoleTime"))

	if self.effectCount == 1 then
		HLWorkModule.EnterWorkRoom(self.affairData)
	end

	timer:Start()
end

function HomeLandWorkEffectUI:EffectTimerEnd()
	self.ImgBG:SetActive(false)

	self.isJump = true

	if self.effectCount == 1 then
		self.timerMove = Timer.New(function()
			self:PlayEffect()

			self.isJump = false
		end, HomeLandWorkEffectUIApi:GetString("WaitTime"))

		self.timerMove:Start()
	elseif self.effectCount == 2 then
		self:Close()
	end
end

function HomeLandWorkEffectUI:StopChangePageEffect()
	if self.ChangePageEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.ChangePageEffectPlayId)

		self.ChangePageEffectPlayId = 0
	end
end

function HomeLandWorkEffectUI:OnBtnJump()
	if self.isJump then
		self.isJump = false

		if self.timerMove then
			self.timerMove:Stop()
		end

		self.timerMove = nil

		self:PlayEffect()
	end
end

function HomeLandWorkEffectUI:Close()
	UIModule.Close(Constant.UIControllerName.HomeLandWorkEffectUI)
end

return HomeLandWorkEffectUI
