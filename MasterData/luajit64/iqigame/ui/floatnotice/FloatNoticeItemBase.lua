-- chunkname: @IQIGame\\UI\\FloatNotice\\FloatNoticeItemBase.lua

local m = {
	MoveDuration = 0.1,
	TargetY = 0,
	StartY = 0,
	FadeoutDuration = 1,
	Type = 0,
	MoveTimer = 0,
	ActiveTimer = 0,
	IsExpireAfterMove = false,
	KeepShowDuration = 2,
	IsExpired = false,
	FadeInDuration = 0.3,
	TempPos = Vector2.zero
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.Type = self:__GetType()
	self.CanvasGroup = self.View:GetComponent(typeof(UnityEngine.CanvasGroup))

	self:OnInit()
end

function m:OnInit()
	return
end

function m:__GetType()
	return Constant.Notice.FloatTypeNormal
end

function m:Refresh(param)
	self.ActiveTimer = 0
	self.CanvasGroup.alpha = 0

	self:SetData(param)
end

function m:SetData(param)
	return
end

function m:MoveUp(targetY)
	self.TargetY = targetY
	self.StartY = self.View.transform.anchoredPosition.y
	self.MoveTimer = 0
end

function m:Update(elapseSeconds, realElapseSeconds)
	self.MoveTimer = self.MoveTimer + elapseSeconds

	if self.TargetY ~= 0 then
		local lerpValue = self.MoveTimer / self.MoveDuration

		if lerpValue > 1 then
			lerpValue = 1
		end

		self.TempPos.y = self.StartY + (self.TargetY - self.StartY) * lerpValue
		self.View.transform.anchoredPosition = self.TempPos

		if lerpValue == 1 then
			self.TargetY = 0
		end
	end

	self.ActiveTimer = self.ActiveTimer + elapseSeconds

	local alpha = 1

	if self.ActiveTimer < self.FadeInDuration then
		alpha = self.ActiveTimer / self.FadeInDuration

		if alpha > 1 then
			alpha = 1
		end
	elseif self.ActiveTimer > self.KeepShowDuration then
		alpha = 1 - (self.ActiveTimer - self.KeepShowDuration) / self.FadeoutDuration

		if alpha < 0 then
			alpha = 0
		end

		if alpha == 0 then
			self.IsExpired = true
		end
	end

	self.CanvasGroup.alpha = alpha

	if self.TargetY == 0 and self.IsExpireAfterMove then
		self.IsExpired = true
	end

	self:OnUpdate(elapseSeconds, realElapseSeconds)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function m:FinishMoving()
	if self.TargetY > 0 then
		self.TempPos.y = self.TargetY
		self.View.transform.anchoredPosition = self.TempPos
		self.TargetY = 0
	end
end

function m:AboutToOutOfSight()
	self.IsExpireAfterMove = true

	self:OnAboutToOutOfSight()
end

function m:OnAboutToOutOfSight()
	return
end

function m:Reset()
	self.TempPos.y = 0
	self.View.transform.anchoredPosition = self.TempPos
	self.CanvasGroup.alpha = 0
	self.TargetY = 0
	self.IsExpired = false
	self.IsExpireAfterMove = false

	self:OnReset()
end

function m:OnReset()
	return
end

function m:Dispose()
	self:OnDispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CanvasGroup = nil
end

function m:OnDispose()
	return
end

return m
