-- chunkname: @IQIGame\\UI\\SurvivalFlyGameMainUI.lua

local SurvivalFlyGameMainUI = {
	residualBlood = 0.1
}

SurvivalFlyGameMainUI = Base:Extend("SurvivalFlyGameMainUI", "IQIGame.Onigao.UI.SurvivalFlyGameMainUI", SurvivalFlyGameMainUI)

require("IQIGame.UIExternalApi.SurvivalFlyGameMainUIApi")

function SurvivalFlyGameMainUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateSurvivalKillMonster()
		self:OnUpdateKillMonster()
	end

	function self.DelegateBtnSpecialItem()
		self:OnBtnSpecialItem()
	end

	function self.DelegateUpdatePlayerEvent()
		self:OnUpdatePlayer()
	end

	self.joystickComp = self.Joystick:GetComponent("FingersJoystickScript")

	function self.joystickComp.JoystickExecuted(script, value)
		self:OnJoystickExecuted(script, value)
	end
end

function SurvivalFlyGameMainUI:GetPreloadAssetPaths()
	return nil
end

function SurvivalFlyGameMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SurvivalFlyGameMainUI:IsManualShowOnOpen(userData)
	return false
end

function SurvivalFlyGameMainUI:GetBGM(userData)
	return nil
end

function SurvivalFlyGameMainUI:OnOpen(userData)
	self:UpdateView()
end

function SurvivalFlyGameMainUI:OnClose(userData)
	return
end

function SurvivalFlyGameMainUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnSpecialItem:GetComponent("Button").onClick:AddListener(self.DelegateBtnSpecialItem)
	EventDispatcher.AddEventListener(EventID.SurvivalKillMonsterEvent, self.DelegateSurvivalKillMonster)
	EventDispatcher.AddEventListener(EventID.SurvivalUpdatePlayerEvent, self.DelegateUpdatePlayerEvent)
end

function SurvivalFlyGameMainUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnSpecialItem:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSpecialItem)
	EventDispatcher.RemoveEventListener(EventID.SurvivalKillMonsterEvent, self.DelegateSurvivalKillMonster)
	EventDispatcher.RemoveEventListener(EventID.SurvivalUpdatePlayerEvent, self.DelegateUpdatePlayerEvent)
end

function SurvivalFlyGameMainUI:OnPause()
	return
end

function SurvivalFlyGameMainUI:OnResume()
	return
end

function SurvivalFlyGameMainUI:OnCover()
	return
end

function SurvivalFlyGameMainUI:OnReveal()
	return
end

function SurvivalFlyGameMainUI:OnRefocus(userData)
	return
end

function SurvivalFlyGameMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SurvivalFlyGameMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SurvivalFlyGameMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SurvivalFlyGameMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SurvivalFlyGameMainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	self.joystickComp.JoystickExecuted = nil
end

function SurvivalFlyGameMainUI:OnJoystickExecuted(script, value)
	EventDispatcher.Dispatch(EventID.JoystickMove, value)
end

function SurvivalFlyGameMainUI:UpdateView()
	self:RefreshKillMonsterNum()
	self:RefreshPlayerMsg()
end

function SurvivalFlyGameMainUI:OnUpdateKillMonster()
	self:RefreshKillMonsterNum()
end

function SurvivalFlyGameMainUI:OnUpdatePlayer()
	self:RefreshPlayerMsg()
end

function SurvivalFlyGameMainUI:RefreshKillMonsterNum()
	UGUIUtil.SetText(self.TextKillMonster, FlyGameModule.killMonsterNum)
	UGUIUtil.SetText(self.TextKillBoss, FlyGameModule.killBossNum)
end

function SurvivalFlyGameMainUI:RefreshPlayerMsg()
	local per = FlyGameModule.survivalFlyGameScene.gamePlayer.blood / FlyGameModule.survivalFlyGameScene.gamePlayer.totalBlood

	self.ImgBlood:GetComponent("Image").fillAmount = per
	self.ImgBloodLess:GetComponent("Image").fillAmount = per

	self.ImgBlood:SetActive(per > self.residualBlood)
	self.ImgBloodLess:SetActive(per <= self.residualBlood)
	UGUIUtil.SetText(self.TextBlood, SurvivalFlyGameMainUIApi:GetString("TextBlood", FlyGameModule.survivalFlyGameScene.gamePlayer.blood, per <= self.residualBlood))
	UGUIUtil.SetText(self.TextTotalBlood, SurvivalFlyGameMainUIApi:GetString("TextHpTotal", FlyGameModule.survivalFlyGameScene.gamePlayer.totalBlood))
	UGUIUtil.SetText(self.TextEnergy, FlyGameModule.survivalFlyGameScene.gamePlayer.energyValue)
	self.ImgEnergyReady:SetActive(FlyGameModule.survivalFlyGameScene.gamePlayer.energyValue >= 100)
end

function SurvivalFlyGameMainUI:OnBtnSpecialItem()
	FlyGameModule.UseBombs()
end

function SurvivalFlyGameMainUI:OnClickBtnClose()
	FlyGameModule.GameOver()
end

return SurvivalFlyGameMainUI
