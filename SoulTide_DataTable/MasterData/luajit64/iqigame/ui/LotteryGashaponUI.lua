-- chunkname: @IQIGame\\UI\\LotteryGashaponUI.lua

local LotteryGashaponUI = {
	rewards = {},
	twScaleMachinePool = {},
	effectMachinePool = {},
	effectShakePool = {},
	effectEggOutPool = {},
	effectEggShowPool = {}
}

LotteryGashaponUI = Base:Extend("LotteryGashaponUI", "IQIGame.Onigao.UI.LotteryGashaponUI", LotteryGashaponUI)

function LotteryGashaponUI:OnInit()
	self:Initialize()
end

function LotteryGashaponUI:GetPreloadAssetPaths()
	return nil
end

function LotteryGashaponUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LotteryGashaponUI:IsManualShowOnOpen(userData)
	return false
end

function LotteryGashaponUI:GetBGM(userData)
	return nil
end

function LotteryGashaponUI:OnOpen(userData)
	self:Refresh(userData)
end

function LotteryGashaponUI:OnClose(userData)
	self:OnHide()
end

function LotteryGashaponUI:OnPause()
	return
end

function LotteryGashaponUI:OnResume()
	return
end

function LotteryGashaponUI:OnCover()
	return
end

function LotteryGashaponUI:OnReveal()
	return
end

function LotteryGashaponUI:OnRefocus(userData)
	return
end

function LotteryGashaponUI:OnUpdate(elapseSeconds, realElapseSeconds)
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

	if self.enableTimer then
		self.timer = self.timer + elapseSeconds

		if self.timer >= self.cfgMallData.Duration then
			self:StopEffectTimer()
			self:OnEffectTimerEnd()
		end
	end
end

function LotteryGashaponUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryGashaponUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryGashaponUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryGashaponUI:Initialize()
	for i = 1, self.goEffectMachineRoot.transform.childCount do
		self.effectMachinePool[i] = self.goEffectMachineRoot.transform:Find("Effect_" .. i).gameObject
		self.effectShakePool[i] = self.goEffectShakeRoot.transform:Find("Effect_" .. i).gameObject
		self.twScaleMachinePool[i] = self.effectMachinePool[i]:GetComponent("TweenScale")
	end

	for i = 1, self.goEffectEggOutRoot.transform.childCount do
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

	function self.onEffectEndDelegate(sender, args)
		self:OnEffectEnd(sender, args)
	end
end

function LotteryGashaponUI:Refresh(userData)
	self.cfgMallData = CfgMallTable[userData[1]]
	self.rewards = userData[2]
	self.isGashapon = self.cfgMallData.MallType == 1010709

	self:StopGashaponEffect()
	self:StopNormalEffect()
	self:StopEffectTimer()

	if self.isGashapon then
		self:PlayGashaponEffect()
	else
		self:PlayNormalEffect()
	end
end

function LotteryGashaponUI:OnHide()
	self:StopGashaponEffect()
	self:StopNormalEffect()
	self:StopEffectTimer()
end

function LotteryGashaponUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function LotteryGashaponUI:OnAddListeners()
	GameEntry.LuaEvent:Subscribe(CloseUIFormCompleteEventArgs.EventId, self.onCloseUIDelegate)
	GameEntry.LuaEvent:Subscribe(EffectPlayEndEventArgs.EventId, self.onEffectEndDelegate)
end

function LotteryGashaponUI:OnRemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(CloseUIFormCompleteEventArgs.EventId, self.onCloseUIDelegate)
	GameEntry.LuaEvent:Unsubscribe(EffectPlayEndEventArgs.EventId, self.onEffectEndDelegate)
end

function LotteryGashaponUI:OnUIClosed(sender, args)
	if self.isGashapon and args.UIFormAssetName == AssetPath.Get(GlobalKey.UIPrefabPath, Constant.UIControllerName.GetPanelUI) then
		EventDispatcher.Dispatch(EventID.RestoreBGM)
		UIModule.CloseSelf(self)
	end
end

function LotteryGashaponUI:OnEffectEnd(sender, args)
	if not self.isGashapon and self.lastEffectPlayID == args.EffectPlayID then
		self:ShowReward()
		UIModule.CloseSelf(self)
	end
end

function LotteryGashaponUI:OnEffectTimerEnd()
	self:ShowReward()
	UIModule.CloseSelf(self)
end

function LotteryGashaponUI:OnLoadEntitySuccess(assetName, asset, duration, userData)
	self.goEffectClone = UnityEngine.Object.Instantiate(asset)

	self.goEffectClone.transform:SetParent(self.goEffectNormal.transform, false)
	self:StartEffectTimer()
end

function LotteryGashaponUI:PlayNormalEffect()
	if self.cfgMallData.SoundId ~= 0 then
		GameEntry.Sound:PlaySound(self.cfgMallData.SoundId, Constant.SoundGroup.UI)
	end

	if self.cfgMallData.EffectId ~= 0 then
		self.lastEffectPlayID = GameEntry.Effect:PlayUIMountPointEffect(self.cfgMallData.EffectId, 50000, 0, self.goEffectNormal, 0)
	else
		AssetUtil.LoadAsset(self, UIGlobalApi.GetPrefabRoot(self.cfgMallData.EffectShow), self.OnLoadEntitySuccess)
	end
end

function LotteryGashaponUI:StopNormalEffect()
	if self.lastEffectPlayID ~= nil then
		GameEntry.Effect:StopEffect(self.lastEffectPlayID)

		self.lastEffectPlayID = nil
	end

	if self.goEffectClone ~= nil then
		UnityEngine.Object.Destroy(self.goEffectClone)
	end
end

function LotteryGashaponUI:PlayGashaponEffect()
	EventDispatcher.Dispatch(EventID.StopBGM)
	GameEntry.Sound:PlaySound(10253, Constant.SoundGroup.UI)
	self:ShowEffectMachine()
end

function LotteryGashaponUI:StopGashaponEffect()
	self:StopEffectMachine()
	self:StopEffectShake()
	self:StopEffectEggOut()
	self:StopEffectEggShow()
end

function LotteryGashaponUI:ShowEffectMachine()
	for i = 1, #self.effectMachinePool do
		if i == self.cfgMallData.Sort then
			self:PlayEffect(self.effectMachinePool[i])

			break
		end
	end

	self.timerMachine = 0
	self.enableTimerMachine = true
end

function LotteryGashaponUI:ShowEffectShake()
	for i = 1, #self.effectShakePool do
		if i == self.cfgMallData.Sort then
			self:PlayEffect(self.effectShakePool[i])
		end
	end

	self.timerShake = 0
	self.enableTimerShake = true
end

function LotteryGashaponUI:ShowEffectEggOut()
	self.randomIndex = math.random(1, #self.effectEggOutPool)

	self:PlayEffect(self.effectEggOutPool[self.randomIndex])

	self.timerEggOut = 0
	self.enableTimerEggOut = true
end

function LotteryGashaponUI:ShowEffectEggShow()
	self:StopEffectMachine()
	self:StopEffectShake()
	self:PlayEffect(self.effectEggShowPool[self.randomIndex])

	self.timerEggShow = 0
	self.enableTimerEggShow = true
end

function LotteryGashaponUI:StopEffectMachine()
	self.timerMachine = 0
	self.enableTimerMachine = false

	for i, v in pairs(self.effectMachinePool) do
		self:StopEffect(v)
	end
end

function LotteryGashaponUI:StopEffectShake()
	self.timerShake = 0
	self.enableTimerShake = false

	for i, v in pairs(self.effectShakePool) do
		self:StopEffect(v)
	end
end

function LotteryGashaponUI:StopEffectEggOut()
	self.timerEggOut = 0
	self.enableTimerEggOut = false

	for i, v in pairs(self.effectEggOutPool) do
		self:StopEffect(v)
	end
end

function LotteryGashaponUI:StopEffectEggShow()
	self.timerEggShow = 0
	self.enableTimerEggShow = false

	for i, v in pairs(self.effectEggShowPool) do
		self:StopEffect(v)
	end
end

function LotteryGashaponUI:PlayEffect(goEffect)
	goEffect:SetActive(false)
	goEffect:SetActive(true)
end

function LotteryGashaponUI:StopEffect(goEffect)
	goEffect:SetActive(false)
end

function LotteryGashaponUI:StartEffectTimer()
	self.enableTimer = true
	self.timer = 0
end

function LotteryGashaponUI:StopEffectTimer()
	self.enableTimer = false
end

function LotteryGashaponUI:ShowReward()
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, self.rewards)
end

return LotteryGashaponUI
