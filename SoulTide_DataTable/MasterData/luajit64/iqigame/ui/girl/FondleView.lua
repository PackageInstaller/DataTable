-- chunkname: @IQIGame\\UI\\Girl\\FondleView.lua

local FondleView = {
	speed = 0,
	isFondle = false,
	currentPer = 0
}
local timerCD, timerClose

function FondleView.__New(ui, rootParent)
	local o = Clone(FondleView)

	o:InitView(ui, rootParent)

	return o
end

function FondleView:InitView(ui, rootParent)
	self.goView = ui
	self.root = rootParent
	self.canvas = self.root.UIController:GetComponent("Canvas")

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.FavorNoticeText:GetComponent("Text").text = GirlUIApi:GetString("labUpFavorTitleTxt")
	self.textTimeNode = self.TextFondleTimeNode
	self.imgPercent = self.ImagePercent:GetComponent("Image")
	self.textTime = self.TextFondleTime:GetComponent("Text")
	self.textFondleNum = self.TextFondleNum:GetComponent("Text")
	self.tweenAlpha = self.FavorLvUp:GetComponent("TweenAlpha")
	self.tweenAlpha.enabled = false

	function self.delegateOnFondleNumChange()
		self:OnFondleNumChange()
	end

	function self.delegateFavorLvUpTweenPosition()
		self:OnFinishedTweenPosition()
	end

	function self.delegateFavorLvUpTweenAlpha()
		self:OnFinishedTweenAlpha()
	end

	function self.delegateFondleResult(actionCid, addFavor, isFavorUp)
		self:OnFondleResult(actionCid, addFavor, isFavorUp)
	end

	function self.delegateFavorUpLvTween()
		self:OnFinishedFavorLv()
	end

	function self.delegateBtnFondle()
		self:OnBtnFondle()
	end

	self.FavorLvUp.gameObject:SetActive(false)

	self.imgPercent.fillAmount = 0
	timerCD = Timer.New(function()
		self:ChangeFondleCd()
	end, 1, -1)

	if FondleModule.fondleNum < FondleModule.fondleMaxNum then
		timerCD:Start()
		self.textTime.gameObject:SetActive(true)
		self.textTimeNode:SetActive(false)
	else
		if timerCD.running then
			timerCD:Stop()
		end

		self.textTime.gameObject:SetActive(false)
		self.textTimeNode:SetActive(false)
	end

	self:OnFondleNumChange()
	self:ChangeFondleCd()

	local fondleTimCD = GirlUIApi:GetString("FondleTime")

	self.speed = 100 / (fondleTimCD * 60)
	self.fondleTimer = Timer.New(function()
		self:ChangePercent()
	end, 0.016666666666666666, -1)

	self.root.HeadEffect:SetActive(false)
end

function FondleView:ChangePercent()
	self.currentPer = self.currentPer + self.speed

	if self.currentPer > 100 then
		self.fondleTimer:Stop()
		self:Fondle()
	end

	self.imgPercent.fillAmount = self.currentPer / 100
end

function FondleView:ChangeFondleCd()
	local cd = FondleModule.nextRecoveryFondleNumTime - PlayerModule.GetServerTime()

	if cd > 0 then
		self.textTime.text = self:GetFormatTime(cd) .. ""

		self.textTimeNode:SetActive(false)
	else
		self.textTime.text = ""

		self.textTimeNode:SetActive(false)
	end
end

function FondleView:GetFormatTime(second)
	local timeText = ""
	local h = math.floor(second / 3600)

	h = h < 10 and "0" .. h or tostring(h)

	local m = math.floor(second % 3600 / 60)

	m = m < 10 and "0" .. m or tostring(m)

	local s = math.floor(second % 60)

	s = s < 10 and "0" .. s or tostring(s)
	timeText = string.format("%s:%s:%s", h, m, s)

	return timeText
end

function FondleView:ShowLvUpView()
	if timerClose ~= nil then
		if timerClose.running then
			timerClose:Stop()
		end

		timerClose = nil
	end

	self.FavorNotice.gameObject:SetActive(true)

	local tween = self.FavorNoticeText:GetComponent("TweenPosition")

	tween:SetOnFinished(self.delegateFavorUpLvTween)

	local tweens = self.FavorNoticeText:GetComponents(typeof(UITweener))

	for i = 0, tweens.Length - 1 do
		tweens[i]:PlayForward()
	end

	local isFavorUp = false

	if GiftModule.lastFavorLv then
		isFavorUp = self.root.soulData.favorLv > GiftModule.lastFavorLv
	end

	if isFavorUp then
		local cfgDataOld = SoulModule.GetCfgSoulFavor(self.soulData.soulCid, GiftModule.lastFavorLv)
		local cfgDataNow = SoulModule.GetCfgSoulFavor(self.soulData.soulCid, self.soulData.favorLv)

		if cfgDataNow.LoveUIStyle > cfgDataOld.LoveUIStyle then
			GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.FavorUp))
		end
	end
end

function FondleView:OnFinishedFavorLv()
	self.FavorNotice.gameObject:SetActive(false)

	local tween = self.FavorNoticeText:GetComponent("TweenPosition")

	tween:RemoveOnFinished(self.delegateFavorUpLvTween)
	FondleView:ResetAllTweenIn(self.FavorNoticeText.transform)
end

function FondleView:ResetAllTweenIn(transform)
	local tweens = transform:GetComponents(typeof(UITweener))

	for i = 0, tweens.Length - 1 do
		tweens[i]:ResetToBeginning()
	end
end

function FondleView:OnFinishedTweenPosition()
	timerClose = Timer.New(function()
		self.tweenAlpha.enabled = true

		self.tweenAlpha:SetOnFinished(self.delegateFavorLvUpTweenAlpha)
		self.tweenAlpha:PlayForward()
	end, 2)

	timerClose:Start()
end

function FondleView:OnFinishedTweenAlpha()
	self.tweenAlpha:RemoveOnFinished(self.delegateFavorLvUpTweenAlpha)
	self.FavorLvUp.gameObject:SetActive(false)

	if timerClose ~= nil then
		if timerClose.running then
			timerClose:Stop()
		end

		timerClose = nil
	end
end

function FondleView:AddEventListener()
	self.BtnFondle:GetComponent("Button").onClick:AddListener(self.delegateBtnFondle)
	EventDispatcher.AddEventListener(EventID.FondleNumChange, self.delegateOnFondleNumChange)
	EventDispatcher.AddEventListener(EventID.FondleResultSuccess, self.delegateFondleResult)
end

function FondleView:RemoveEventListener()
	self.BtnFondle:GetComponent("Button").onClick:RemoveListener(self.delegateBtnFondle)
	EventDispatcher.RemoveEventListener(EventID.FondleNumChange, self.delegateOnFondleNumChange)
	EventDispatcher.RemoveEventListener(EventID.FondleResultSuccess, self.delegateFondleResult)
end

function FondleView:OnBtnFondle()
	if FondleModule.fondleNum <= 0 then
		return
	end

	if self.isFondle == true then
		return
	end

	self.isFondle = true
	self.currentPer = 0
	self.imgPercent.fillAmount = 0

	self.fondleTimer:Start()
	self:PlayHeadEffect()
end

function FondleView:PlayHeadEffect()
	self.root.HeadEffect:SetActive(true)

	local animation = self.root.HeadEffect:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	animation.state:SetAnimation(0, "action", true)

	self.root.HeadEffect:GetComponentInChildren(typeof(UnityEngine.Renderer)).enabled = true
	self.root.HeadEffect:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder = self.canvas.sortingOrder + 4

	local pos = GirlUIApi:GetString("HeadPoint", self.soulData.soulCid)

	self.root.HeadEffect.transform.localPosition = pos
end

function FondleView:OnFondleNumChange()
	self.textFondleNum.text = GirlUIApi:GetString("labTouchText", FondleModule.fondleNum)

	if FondleModule.fondleNum < FondleModule.fondleMaxNum then
		timerCD:Start()
		self.textTime.gameObject:SetActive(true)
		self.textTimeNode.gameObject:SetActive(false)
	else
		if timerCD.running then
			timerCD:Stop()
		end

		self.textTime.gameObject:SetActive(false)
		self.textTimeNode.gameObject:SetActive(false)
	end
end

function FondleView:Update(soulID, lastLv, lastStage, soulData, isShow)
	self.soulData = soulData

	if soulID ~= nil and soulData.soulCid == soulID then
		local newLv = self.soulData.favorLv
		local showType = 0

		if newLv - lastLv > 0 then
			showType = 1
		end

		if showType > 0 and isShow then
			self:ShowLvUpView()
		end

		self:OnFondleNumChange()
	end
end

function FondleView:OnFondleResult(actionCid, addFavor, isFavorUp)
	if not isFavorUp and actionCid > 0 then
		GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.FlickHead, actionCid))
	end

	if self.soulData.dailyDislike == true then
		-- block empty
	end
end

function FondleView:Dispose()
	if timerCD ~= nil then
		if timerCD.running then
			timerCD:Stop()
		end

		timerCD = nil
	end

	if timerClose ~= nil then
		if timerCD.running then
			timerClose:Stop()
		end

		timerClose = nil
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function FondleView:Open()
	self:AddEventListener()

	self.imgPercent.fillAmount = 0

	self.FavorNotice.gameObject:SetActive(false)
end

function FondleView:Close()
	self:RemoveEventListener()
end

function FondleView:Fondle()
	self.currentPer = 0
	self.imgPercent.fillAmount = 0

	FondleModule.Fondle(self.soulData.soulCid)
	self.root.HeadEffect:SetActive(false)

	self.isFondle = false
end

return FondleView
