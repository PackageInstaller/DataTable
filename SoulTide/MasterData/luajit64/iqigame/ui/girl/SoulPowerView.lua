-- chunkname: @IQIGame\\UI\\Girl\\SoulPowerView.lua

local SoulPowerView = {}
local time, per, isPointerDown, speed

function SoulPowerView.__New(ui)
	local o = Clone(SoulPowerView)

	o:InitView(ui)

	return o
end

function SoulPowerView:InitView(ui)
	per = 0
	isPointerDown = false
	speed = 0
	self.goView = ui

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.imgProgress = self.ImageProgress:GetComponent("Image")
	self.imgProgress.fillAmount = per
	self.textLifeLimit = self.TextLifeLimit:GetComponent("Text")
	self.textFavorLimit = self.TextFavorLimit:GetComponent("Text")
	self.textFavorCurLimit = self.TextFavorCurLimit:GetComponent("Text")
	self.textLifePower = self.TextLifePower:GetComponent("Text")
	self.textLifePowerDesc = self.LifePowerDesc:GetComponent("Text")
	self.BtnUpText:GetComponent("Text").text = GirlUIApi:GetString("GetUpStrTxt")

	function self.delegateLevelUpComplete()
		self:OnResetTween()
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnUp()
		return
	end

	function self.delegatePlayerInfoChanged()
		self:OnPlayerInfoChanged()
	end

	self.textLifePowerDesc.text = GirlUIApi:GetString("VitalitySourceTxt")

	self:AddEventListener()

	time = Timer.New(function()
		self:ChangePercent()
	end, 0.03333333333333333, -1)
end

function SoulPowerView:AddEventListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnUp:GetComponent("Button").onClick:AddListener(self.delegateBtnUp)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
end

function SoulPowerView:RemoveEventListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnUp:GetComponent("Button").onClick:RemoveListener(self.delegateBtnUp)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
end

function SoulPowerView:UpPanelEffectShow()
	self.LevelUpPanel:SetActive(true)

	local tween = self.LevelUpPanel:GetComponent(typeof(UITweener))

	if tween ~= nil then
		tween:SetOnFinished(self.delegateLevelUpComplete)
		tween:PlayForward()
	end
end

function SoulPowerView:OnResetTween()
	local tween = self.LevelUpPanel:GetComponent(typeof(UITweener))

	self:ResetAllTweenIn(tween.transform)
	tween:RemoveOnFinished(self.delegateLevelUpComplete)
	self.LevelUpPanel:SetActive(false)
end

function SoulPowerView:ResetAllTweenIn(transform)
	local tweens = transform:GetComponents(typeof(UITweener))

	for i = 0, tweens.Length - 1 do
		tweens[i]:ResetToBeginning()
	end

	for i = 0, transform.childCount - 1 do
		self:ResetAllTweenIn(transform:GetChild(i))
	end
end

function SoulPowerView:UpDataView(soulData)
	self.soulData = soulData
	self.imgProgress.fillAmount = 1

	self.MaxUpNode:SetActive(false)
	self.NormalNode:SetActive(true)

	local curFavorLevel = self.soulData.favorMaxLv
	local maxFavorLevel = self.soulData:GetNextMaxFavorDegree()

	if maxFavorLevel == nil then
		maxFavorLevel = curFavorLevel
	end

	self.textFavorCurLimit.text = GirlUIApi:GetString("FavorUpperLimitTxt", curFavorLevel)
	self.textFavorLimit.text = GirlUIApi:GetString("FavorUpperLimitTxt", maxFavorLevel)
end

function SoulPowerView:CheckRedPoint(soulData)
	self.powerRedPoint:SetActive(false)
end

function SoulPowerView:OnPlayerInfoChanged()
	self:ChangePercent()
end

function SoulPowerView:ChangePercent()
	if self.soulData == nil then
		return
	end

	self.imgProgress.fillAmount = 1

	local curFavorLevel = self.soulData.favorMaxLv
	local maxFavorLevel = self.soulData:GetNextMaxFavorDegree()

	if maxFavorLevel == nil then
		maxFavorLevel = curFavorLevel
	end

	self.textFavorCurLimit.text = GirlUIApi:GetString("FavorUpperLimitTxt", curFavorLevel)
	self.textFavorLimit.text = GirlUIApi:GetString("FavorUpperLimitTxt", maxFavorLevel)
end

function SoulPowerView:OnBtnClose()
	if self.callBackCloseFun ~= nil then
		self.callBackCloseFun()
	end
end

function SoulPowerView:Dispose()
	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.callBackOpenFun = nil
	self.callBackCloseFun = nil
	self.goView = nil
end

function SoulPowerView:Close()
	return
end

return SoulPowerView
