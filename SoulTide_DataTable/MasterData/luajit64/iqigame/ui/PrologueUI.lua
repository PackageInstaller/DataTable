-- chunkname: @IQIGame\\UI\\PrologueUI.lua

local PrologueUI = Base:Extend("PrologueUI", "IQIGame.Onigao.UI.PrologueUI", {
	playSound = 0,
	isPressEffectEnd = false,
	soundID = 0,
	pressDownCd = 1,
	passCd = 0
})

function PrologueUI:OnInit()
	UGUIUtil.SetText(self.TextBtnBack, PrologueVideoUIApi:GetString("TextBtnBack"))

	self.btnEffect = self.Button:GetComponent("LongButton")
	self.btnBox = self.ButtonBox:GetComponent("Button")

	function self.btnEffect.OnPointerUpAction(go)
		self:OnPointerUp(go)
	end

	function self.btnEffect.OnPointerDownAction(go)
		self:OnPointerDown(go)
	end

	function self.delegateUpdateTime()
		self:OnUpdateTimer()
	end

	function self.delegateBtnBox()
		self:OnClickBtnBox()
	end

	function self.delegateClickBtnBack()
		self:OnBtnBack()
	end

	self.timer = Timer.New(self.delegateUpdateTime, 0.5, -1)
end

function PrologueUI:GetPreloadAssetPaths()
	return nil
end

function PrologueUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PrologueUI:OnOpen(userData)
	self.isPressEffectEnd = false
	self.btnBox.enabled = false

	self.Effect_ClickPrompt1:SetActive(true)
	self.Effect_ClickPrompt2:SetActive(true)
	self.Effect_Word4:SetActive(true)
	EventDispatcher.Dispatch(EventID.StopBGM)
	self:PlaySound(10231)
end

function PrologueUI:OnClose(userData)
	EventDispatcher.Dispatch(EventID.RestoreBGM)

	if not CreateRoleModule.isJump then
		CreateRoleModule.OpenLotteryUI()
	end

	if self.playSound > 0 then
		GameEntry.Sound:StopSound(self.playSound)
	end
end

function PrologueUI:OnAddListeners()
	self.btnBox.onClick:AddListener(self.delegateBtnBox)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.delegateClickBtnBack)
end

function PrologueUI:OnRemoveListeners()
	self.btnBox.onClick:RemoveListener(self.delegateBtnBox)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnBack)
end

function PrologueUI:OnPause()
	return
end

function PrologueUI:OnResume()
	return
end

function PrologueUI:OnCover()
	return
end

function PrologueUI:OnReveal()
	return
end

function PrologueUI:OnRefocus(userData)
	return
end

function PrologueUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PrologueUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PrologueUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PrologueUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PrologueUI:OnDestroy()
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	if self.timerLongPress2 then
		self.timerLongPress2:Stop()

		self.timerLongPress2 = nil
	end

	if self.timerContinued1 then
		self.timerContinued1:Stop()

		self.timerContinued1 = nil
	end
end

function PrologueUI:OnUpdateTimer()
	if self.isPressEffectEnd == true then
		self.timer:Stop()

		return
	end

	self.passCd = self.passCd + 0.5

	if self.passCd >= self.pressDownCd then
		self.Effect_LongPress1:SetActive(false)
		self.Effect_LongPress2:SetActive(false)
		self:OnLongPressTime()
	end
end

function PrologueUI:OnPointerDown(go)
	self.timer:Stop()

	if self.isPressEffectEnd == true then
		return
	end

	self.passCd = 0

	self.timer:Start()
	self:PlayLongPress()
	self:PlaySound(10232)
end

function PrologueUI:OnPointerUp(go)
	if self.isPressEffectEnd == true then
		return
	end

	self.timer:Stop()
	self.Effect_LongPress1:SetActive(false)
	self.Effect_LongPress2:SetActive(false)

	if self.passCd >= self.pressDownCd then
		self:OnLongPressTime()
	else
		self.Effect_ClickPrompt1:SetActive(true)
		self.Effect_ClickPrompt2:SetActive(true)
		self.Effect_Word4:SetActive(true)
		self:PlaySound(10231)

		if self.timerLongPress2 then
			self.timerLongPress2:Stop()

			self.timerLongPress2 = nil
		end

		if self.timerContinued1 then
			self.timerContinued1:Stop()

			self.timerContinued1 = nil
		end
	end
end

function PrologueUI:OnLongPressTime()
	self.isPressEffectEnd = true

	self.Effect_Continued1:SetActive(true)
	self.Effect_Spread1:SetActive(true)
	self:PlaySound(10233)

	local timeSpread2 = Timer.New(function()
		self:OnBtnBack()
	end, 3)

	timeSpread2:Start()
end

function PrologueUI:PlayLongPress()
	self.Effect_ClickPrompt1:SetActive(false)
	self.Effect_ClickPrompt2:SetActive(false)
	self.Effect_Word4:SetActive(false)
	self.Effect_LongPress1:SetActive(true)

	self.timerLongPress2 = Timer.New(function()
		self.Effect_LongPress1:SetActive(false)
		self.Effect_LongPress2:SetActive(true)

		if self.timerLongPress2 then
			self.timerLongPress2:Stop()

			self.timerLongPress2 = nil
		end
	end, 3)

	self.timerLongPress2:Start()

	self.timerContinued1 = Timer.New(function()
		self.Effect_Continued1:SetActive(true)
		self.Effect_LongPress2:SetActive(false)

		if self.timerContinued1 then
			self.timerContinued1:Stop()

			self.timerContinued1 = nil
		end
	end, 4.5)

	self.timerContinued1:Start()
end

function PrologueUI:OnClickBtnBox()
	self:PlaySound(10236)

	self.btnBox.enabled = false

	self.Effect_Rare5:SetActive(true)
	self.Effect_world3:SetActive(false)
	self.Effect_LotteryUIBox05:SetActive(false)

	self.timerEnd = Timer.New(function()
		UIModule.Close(Constant.UIControllerName.PrologueUI)
		self.timerEnd:Stop()

		self.timerEnd = nil
	end, 1)

	self.timerEnd:Start()
end

function PrologueUI:PlaySound(soundID)
	if self.playSound > 0 and self.soundID > 0 then
		local cfgSound = CfgSoundTable[self.soundID]

		GameEntry.Sound:StopSound(self.playSound, cfgSound.FadeOutSeconds)

		self.playSound = 0
	end

	self.soundID = soundID
	self.playSound = GameEntry.Sound:PlaySound(self.soundID, Constant.SoundGroup.UI)
end

function PrologueUI:OnBtnBack()
	UIModule.Close(Constant.UIControllerName.PrologueUI)
end

return PrologueUI
