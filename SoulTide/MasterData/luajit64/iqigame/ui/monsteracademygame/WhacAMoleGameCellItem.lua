-- chunkname: @IQIGame\\UI\\MonsterAcademyGame\\WhacAMoleGameCellItem.lua

local m = {
	isValid = false,
	isMole = false,
	CanClick = false
}

function m.New(viewRoot)
	local obj = Clone(m)

	obj:__Init(viewRoot)

	return obj
end

function m:__Init(viewRoot)
	self.ViewRoot = viewRoot

	LuaCodeInterface.BindOutlet(self.ViewRoot, self)

	function self.normalButtonClickEventProxy()
		if not self.CanClick then
			return
		end

		self:OnNormalButtonClickEventHandler()
	end

	function self.targetButtonClickEventProxy()
		if not self.CanClick then
			return
		end

		self:OnTargetButtonClickEventHandler()
	end

	self.goNormal:GetComponent("Button").onClick:AddListener(self.normalButtonClickEventProxy)
	self.goTarget:GetComponent("Button").onClick:AddListener(self.targetButtonClickEventProxy)

	self.lastTargetScale = self.goTarget.transform.localScale

	self:__InitMoleTweenScale()
	self:ShowNormal()
end

function m:__InitMoleTweenScale()
	self.moleTweenScale = self.goTarget.gameObject:GetComponent("TweenScale")
end

function m:OnNormalButtonClickEventHandler()
	if self.isValid then
		return
	end

	self.isValid = true

	if self.isMole then
		self:__ShowClickSuccess()
	else
		self:__ShowClickFail()
	end
end

function m:OnTargetButtonClickEventHandler()
	if self.isValid then
		return
	end

	self.isValid = true

	self:__ShowClickSuccess()
end

function m:ShowNormal()
	self.__StopTimer(self.moleDurationTimer)
	self.__StopTimer(self.showSuccessTimer)
	self.__StopTimer(self.showFailTimer)
	self.goNormal.gameObject:SetActive(true)

	self.goTarget.transform.localScale = self.lastTargetScale

	self.goSuccess.gameObject:SetActive(false)
	self.goFailed.gameObject:SetActive(false)
end

function m:ShowMole(duration)
	self.moleDurationTimer = Timer.New(function()
		self:__HideMole()
	end, duration)

	self.moleTweenScale:ResetToBeginning()
	self.moleTweenScale:PlayForward()
	self.moleTweenScale:SetOnFinished(function()
		self.isMole = true
		self.isValid = false

		self.moleDurationTimer:Start()
	end)
end

function m:__HideMole()
	self.moleTweenScale:PlayReverse()
	self.moleTweenScale:SetOnFinished(function()
		self.isMole = false
		self.isValid = false
	end)
end

function m:__ShowClickSuccess()
	self:__HideClickFail()

	if self.goSuccess.gameObject.activeSelf then
		return
	end

	self.MoleClickResult(true)
	self.goSuccess.gameObject:SetActive(true)

	self.showSuccessTimer = Timer.New(function()
		self:__HideClickSuccess()
	end, 1)

	self.showSuccessTimer:Start()
end

function m:__HideClickSuccess()
	self.__StopTimer(self.showSuccessTimer)

	self.isValid = false

	self.goSuccess.gameObject:SetActive(false)
end

function m:__ShowClickFail()
	self:__HideClickSuccess()

	if self.goFailed.gameObject.activeSelf then
		return
	end

	self.MoleClickResult(false)
	self.goFailed.gameObject:SetActive(true)

	self.showFailTimer = Timer.New(function()
		self:__HideClickFail()
	end, 1)

	self.showFailTimer:Start()
end

function m:__HideClickFail()
	self.__StopTimer(self.showFailTimer)

	self.isValid = false

	self.goFailed.gameObject:SetActive(false)
end

function m.__StopTimer(timer)
	if timer == nil then
		return
	end

	timer:Stop()

	timer = nil
end

function m:OnDestroy()
	self.goNormal:GetComponent("Button").onClick:RemoveListener(self.normalButtonClickEventProxy)
	self.goTarget:GetComponent("Button").onClick:RemoveListener(self.targetButtonClickEventProxy)
	self:__HideClickSuccess()
	self:__HideClickFail()
	self.__StopTimer(self.moleDurationTimer)
	LuaCodeInterface.ClearOutlet(self.ViewRoot, self)

	self.ViewRoot = nil
end

return m
