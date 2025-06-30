-- chunkname: @IQIGame\\UI\\ActivityFurnitureGashaponUI.lua

local ActivityFurnitureGashaponUI = {
	rewards = {},
	twScaleMachinePool = {},
	effectMachinePool = {},
	effectShakePool = {},
	effectEggOutPool = {},
	effectEggShowPool = {}
}

ActivityFurnitureGashaponUI = Base:Extend("ActivityFurnitureGashaponUI", "IQIGame.Onigao.UI.ActivityFurnitureGashaponUI", ActivityFurnitureGashaponUI)

function ActivityFurnitureGashaponUI:OnInit()
	self:Initialize()
end

function ActivityFurnitureGashaponUI:GetPreloadAssetPaths()
	return nil
end

function ActivityFurnitureGashaponUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityFurnitureGashaponUI:IsManualShowOnOpen(userData)
	return false
end

function ActivityFurnitureGashaponUI:GetBGM(userData)
	return nil
end

function ActivityFurnitureGashaponUI:OnOpen(userData)
	self:Refresh(userData)
end

function ActivityFurnitureGashaponUI:OnClose(userData)
	self:OnHide()
end

function ActivityFurnitureGashaponUI:OnPause()
	return
end

function ActivityFurnitureGashaponUI:OnResume()
	return
end

function ActivityFurnitureGashaponUI:OnCover()
	return
end

function ActivityFurnitureGashaponUI:OnReveal()
	return
end

function ActivityFurnitureGashaponUI:OnRefocus(userData)
	return
end

function ActivityFurnitureGashaponUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.enableTimerMachine then
		self.timerMachine = self.timerMachine + elapseSeconds

		if self.timerMachine >= self.durationMachine then
			self.enableTimerMachine = false

			self:ShowEffectShake()
		end
	end

	if self.enableTimerShake then
		self.timerShake = self.timerShake + elapseSeconds

		if self.timerShake >= self.durationShake then
			self.enableTimerShake = false

			self:ShowEffectEggOut()
		end
	end

	if self.enableTimerEggOut then
		self.timerEggOut = self.timerEggOut + elapseSeconds

		if self.timerEggOut >= self.durationEggOut then
			self.enableTimerEggOut = false

			self:ShowEffectEggShow()
		end
	end

	if self.enableTimerEggShow then
		self.timerEggShow = self.timerEggShow + elapseSeconds

		if self.timerEggShow >= self.durationEggShow then
			self.enableTimerEggShow = false

			self:ShowReward()
		end
	end
end

function ActivityFurnitureGashaponUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityFurnitureGashaponUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityFurnitureGashaponUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityFurnitureGashaponUI:Initialize()
	for i = 1, 2 do
		self.effectMachinePool[i] = self.goEffectMachineRoot.transform:Find("Effect_" .. i).gameObject
		self.effectShakePool[i] = self.goEffectShakeRoot.transform:Find("Effect_" .. i).gameObject
		self.twScaleMachinePool[i] = self.effectMachinePool[i]:GetComponent("TweenScale")
	end

	for i = 1, 5 do
		self.effectEggOutPool[i] = self.goEffectEggOutRoot.transform:Find("Effect_" .. i).gameObject
		self.effectEggShowPool[i] = self.goEffectEggShowRoot.transform:Find("Effect_" .. i).gameObject
	end

	self.durationMachine = LotteryGashaponUIApi:GetString("durationMachine")
	self.durationShake = LotteryGashaponUIApi:GetString("durationShake")
	self.durationEggOut = LotteryGashaponUIApi:GetString("durationEggOut")
	self.durationEggShow = LotteryGashaponUIApi:GetString("durationEggShow")

	function self.onCloseUIDelegate(sender, args)
		self:OnUIClosed(sender, args)
	end
end

function ActivityFurnitureGashaponUI:Refresh(userData)
	self.type = userData[1]
	self.rewards = userData[2]

	self:StopGashaponEffect()
	self:PlayGashaponEffect()
end

function ActivityFurnitureGashaponUI:OnHide()
	self:StopGashaponEffect()
end

function ActivityFurnitureGashaponUI:OnDestroy()
	return
end

function ActivityFurnitureGashaponUI:OnAddListeners()
	GameEntry.LuaEvent:Subscribe(CloseUIFormCompleteEventArgs.EventId, self.onCloseUIDelegate)
end

function ActivityFurnitureGashaponUI:OnRemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(CloseUIFormCompleteEventArgs.EventId, self.onCloseUIDelegate)
end

function ActivityFurnitureGashaponUI:OnUIClosed(sender, args)
	if args.UIFormAssetName == AssetPath.Get(GlobalKey.UIPrefabPath, Constant.UIControllerName.GetPanelUI) then
		EventDispatcher.Dispatch(EventID.RestoreBGM)
		UIModule.CloseSelf(self)
	end
end

function ActivityFurnitureGashaponUI:OnEffectTimerEnd()
	self:ShowReward()
	UIModule.CloseSelf(self)
end

function ActivityFurnitureGashaponUI:PlayGashaponEffect()
	EventDispatcher.Dispatch(EventID.StopBGM)
	GameEntry.Sound:PlaySound(10253, Constant.SoundGroup.UI)
	self:ShowEffectMachine()
end

function ActivityFurnitureGashaponUI:StopGashaponEffect()
	self:StopEffectMachine()
	self:StopEffectShake()
	self:StopEffectEggOut()
	self:StopEffectEggShow()
end

function ActivityFurnitureGashaponUI:ShowEffectMachine()
	if self.type == 1 then
		self:PlayEffect(self.effectMachinePool[1])
	elseif self.type == 2 then
		self:PlayEffect(self.effectMachinePool[2])
	end

	self.timerMachine = 0
	self.enableTimerMachine = true
end

function ActivityFurnitureGashaponUI:ShowEffectShake()
	if self.type == 1 then
		self:PlayEffect(self.effectShakePool[1])
	elseif self.type == 2 then
		self:PlayEffect(self.effectShakePool[2])
	end

	self.timerShake = 0
	self.enableTimerShake = true
end

function ActivityFurnitureGashaponUI:ShowEffectEggOut()
	self.randomIndex = math.random(1, 5)

	self:PlayEffect(self.effectEggOutPool[self.randomIndex])

	self.timerEggOut = 0
	self.enableTimerEggOut = true
end

function ActivityFurnitureGashaponUI:ShowEffectEggShow()
	self:StopEffectMachine()
	self:StopEffectShake()
	self:PlayEffect(self.effectEggShowPool[self.randomIndex])

	self.timerEggShow = 0
	self.enableTimerEggShow = true
end

function ActivityFurnitureGashaponUI:StopEffectMachine()
	self.timerMachine = 0
	self.enableTimerMachine = false

	for i, v in pairs(self.effectMachinePool) do
		self:StopEffect(v)
	end
end

function ActivityFurnitureGashaponUI:StopEffectShake()
	self.timerShake = 0
	self.enableTimerShake = false

	for i, v in pairs(self.effectShakePool) do
		self:StopEffect(v)
	end
end

function ActivityFurnitureGashaponUI:StopEffectEggOut()
	self.timerEggOut = 0
	self.enableTimerEggOut = false

	for i, v in pairs(self.effectEggOutPool) do
		self:StopEffect(v)
	end
end

function ActivityFurnitureGashaponUI:StopEffectEggShow()
	self.timerEggShow = 0
	self.enableTimerEggShow = false

	for i, v in pairs(self.effectEggShowPool) do
		self:StopEffect(v)
	end
end

function ActivityFurnitureGashaponUI:PlayEffect(goEffect)
	goEffect:SetActive(false)
	goEffect:SetActive(true)
end

function ActivityFurnitureGashaponUI:StopEffect(goEffect)
	goEffect:SetActive(false)
end

function ActivityFurnitureGashaponUI:ShowReward()
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, self.rewards)
end

return ActivityFurnitureGashaponUI
