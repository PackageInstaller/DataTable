-- chunkname: @IQIGame\\UI\\GhostGameUI.lua

local ghostGameBuffGridView = require("IQIGame.UI.GhostGame.GhostGameBuffGridView")
local GhostGameUI = {}

GhostGameUI = Base:Extend("GhostGameUI", "IQIGame.Onigao.UI.GhostGameUI", GhostGameUI)

function GhostGameUI:OnInit()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.commonReturnBtn:SetHomeBtnState(false)
	self.commonReturnBtn:RegisterReturnEvent(function()
		self:ReturnEvent()
	end)

	function self.delegateOnGhostGameCountDownChange(countDown)
		self:UpdateCountDown(countDown)
	end

	function self.delegateOnGhostAttackNumChange(attackNum)
		self:UpdateAttackNum(attackNum)
	end

	function self.delegateOnGhostGameStartEvent()
		self:OnGhostGameStartEvent()
	end

	function self.delegateOnGhostGameOverEvent()
		self:OnGhostGameOverEvent()
	end

	function self.delegateOnClickStartGameBtn()
		self:OnClickStartGameBtn()
	end

	function self.delegateOnClickGameOverBtn()
		self:OnClickGameOverBtn()
	end

	function self.delegateOnGhostGameKillEnemyEvent()
		self:OnGhostGameKillEnemyEvent()
	end

	self.buffGridPanel = ghostGameBuffGridView.New(self.BuffView)
end

function GhostGameUI:GetPreloadAssetPaths()
	return nil
end

function GhostGameUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GhostGameUI:IsManualShowOnOpen(userData)
	return false
end

function GhostGameUI:GetBGM(userData)
	return nil
end

function GhostGameUI:OnOpen(userData)
	self:UpdateAttackNum(userData.attackNum)
	self:UpdateCountDown(userData.gameTime)
	self:SetBaseInfoState(false)
	self:SetCenterCountDownState(false)
	self:SetGameOverState(false)
	self:UpdateRewardInfo(0)
end

function GhostGameUI:OnClose(userData)
	return
end

function GhostGameUI:OnAddListeners()
	self.StartBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickStartGameBtn)
	self.gameOverBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickGameOverBtn)
	EventDispatcher.AddEventListener(EventID.GhostAttackNumChange, self.delegateOnGhostAttackNumChange)
	EventDispatcher.AddEventListener(EventID.GhostGameCountDownChange, self.delegateOnGhostGameCountDownChange)
	EventDispatcher.AddEventListener(EventID.GhostGameOverEvent, self.delegateOnGhostGameOverEvent)
	EventDispatcher.AddEventListener(EventID.GhostGameStartEvent, self.delegateOnGhostGameStartEvent)
	EventDispatcher.AddEventListener(EventID.GhostGameKillEnemyEvent, self.delegateOnGhostGameKillEnemyEvent)
end

function GhostGameUI:OnRemoveListeners()
	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickStartGameBtn)
	self.gameOverBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGameOverBtn)
	EventDispatcher.RemoveEventListener(EventID.GhostAttackNumChange, self.delegateOnGhostAttackNumChange)
	EventDispatcher.RemoveEventListener(EventID.GhostGameCountDownChange, self.delegateOnGhostGameCountDownChange)
	EventDispatcher.RemoveEventListener(EventID.GhostGameOverEvent, self.delegateOnGhostGameOverEvent)
	EventDispatcher.RemoveEventListener(EventID.GhostGameStartEvent, self.delegateOnGhostGameStartEvent)
	EventDispatcher.RemoveEventListener(EventID.GhostGameKillEnemyEvent, self.delegateOnGhostGameKillEnemyEvent)
end

function GhostGameUI:OnPause()
	return
end

function GhostGameUI:OnResume()
	return
end

function GhostGameUI:OnCover()
	return
end

function GhostGameUI:OnReveal()
	return
end

function GhostGameUI:OnRefocus(userData)
	return
end

function GhostGameUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.buffGridPanel:Update(elapseSeconds, realElapseSeconds)
end

function GhostGameUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GhostGameUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GhostGameUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GhostGameUI:OnDestroy()
	self:StopCountdownTimer()
	AssetUtil.UnloadAsset(self)
	self.commonReturnBtn:Dispose()
	self.buffGridPanel:Dispose()
end

function GhostGameUI:UpdateCountDown(countDown)
	UGUIUtil.SetText(self.countDownText, countDown)
end

function GhostGameUI:UpdateAttackNum(attackNum)
	UGUIUtil.SetText(self.attackNumText, attackNum)
end

function GhostGameUI:OnClickStartGameBtn()
	GhostGameModule.RequestStartGame()
end

function GhostGameUI:OnClickGameOverBtn()
	GhostGameModule.ExitGame()
end

function GhostGameUI:SetCenterCountDownState(state)
	LuaUtility.SetGameObjectShow(self.CenterCountDown, state)
end

function GhostGameUI:SetBaseInfoState(state)
	LuaUtility.SetGameObjectShow(self.CountDownParent, state)
	LuaUtility.SetGameObjectShow(self.AttackParent, state)
	LuaUtility.SetGameObjectShow(self.StartBtn, not state)
end

function GhostGameUI:SetGameOverState(state)
	LuaUtility.SetGameObjectShow(self.GameOverParent, state)
	LuaUtility.SetGameObjectShow(self.gameOverBtn, state)
end

function GhostGameUI:CountTimer(callback)
	self.commonReturnBtn:SetState(false)
	self:SetCenterCountDownState(true)

	local tempTime = GhostGameModule.uiResumeTime

	self:RefreshCountdownInfo(tempTime)
	self:StopCountdownTimer()

	self.countDownTimer = Timer.New(function()
		tempTime = tempTime - 1

		if tempTime <= 0 then
			self:SetCenterCountDownState(false)
			self.commonReturnBtn:SetState(true)

			if callback then
				callback()
			end

			return
		end

		self:RefreshCountdownInfo(tempTime)
	end, 1, GhostGameModule.uiResumeTime + 1)

	self.countDownTimer:Start()
end

function GhostGameUI:StopCountdownTimer()
	if self.countDownTimer then
		self.countDownTimer:Stop()

		self.countDownTimer = nil
	end
end

function GhostGameUI:RefreshCountdownInfo(time)
	UGUIUtil.SetText(self.centerCountdownText, time)
end

function GhostGameUI:OnGhostGameStartEvent()
	self:SetBaseInfoState(true)
	self:CountTimer(function()
		GhostGameModule.StartGame()
	end)
end

function GhostGameUI:OnGhostGameOverEvent()
	self:SetGameOverState(true)
end

function GhostGameUI:OnGhostGameKillEnemyEvent()
	local killNum = 0

	for k, v in pairs(GhostGameModule.KillList) do
		killNum = killNum + v
	end

	self:UpdateRewardInfo(killNum)
end

function GhostGameUI:UpdateRewardInfo(num)
	UGUIUtil.SetText(self.rewardNumText, "×" .. num)
end

function GhostGameUI:ReturnEvent()
	GhostGameModule.IsPause = true

	NoticeModule.ShowNotice(70011, function()
		GhostGameModule.ExitGame()
	end, function()
		if GhostGameModule.IsStart then
			self:CountTimer(function()
				GhostGameModule.IsPause = false
			end)
		end
	end)
end

return GhostGameUI
