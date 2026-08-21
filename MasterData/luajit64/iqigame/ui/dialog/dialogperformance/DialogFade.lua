-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogFade.lua

local m = {
	StartAlpha = 0,
	EndAlpha = 0,
	Started = false,
	FadeElapsedTime = 0,
	Duration = 0,
	Type = 0
}

function m.New(userData)
	local obj = Clone(m)

	obj.Type = userData.type
	obj.NpcPortrait = userData.npcPortrait

	return obj
end

function m:Start(performanceData, params)
	self.gameObject = performanceData.gameObject
	self.PerformanceData = performanceData
	self.StartAlpha = params[1]
	self.EndAlpha = params[2]
	self.Duration = params[3]
	self.Started = true

	self:SetAlpha(self.StartAlpha)

	if self.Type == Constant.DialogPerformance.TYPE_NPC then
		self.NpcPortrait.IsFading = true

		self.NpcPortrait:UpdateSortingOrder()
	end
end

function m:Stop()
	if self.Started then
		local endAlpha = self:FadeComplete(true)

		if self.Type == Constant.DialogPerformance.TYPE_NPC and endAlpha == 1 then
			self.NpcPortrait.IsFading = false

			self.NpcPortrait:UpdateSortingOrder()
		end
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	if not self.Started then
		return
	end

	self.FadeElapsedTime = self.FadeElapsedTime + elapseSeconds

	local lerpValue = 0

	if self.Duration ~= 0 then
		lerpValue = self.FadeElapsedTime / self.Duration
	else
		lerpValue = 1
	end

	if lerpValue > 1 then
		lerpValue = 1
	end

	local success = self:SetAlpha(self.StartAlpha + (self.EndAlpha - self.StartAlpha) * lerpValue)

	if lerpValue == 1 and success then
		self:FadeComplete()
	end
end

function m:SetAlpha(alpha)
	if self.Type == Constant.DialogPerformance.TYPE_NPC and self.NpcPortrait.LoadingAsset then
		return false
	end

	return EntityShowUtil.SetAlpha(self.gameObject, alpha)
end

function m:FadeComplete(reset)
	local alpha = reset and self.Type == Constant.DialogPerformance.TYPE_Background and 1 or self.EndAlpha

	self:SetAlpha(alpha)

	self.PerformanceData.Completed = true

	self:Clear()

	return alpha
end

function m.ResetHost(obj)
	EntityShowUtil.SetAlpha(obj, 1)
end

function m:Clear()
	self.gameObject = nil
	self.ImageComponent = nil
	self.PerformanceData = nil
	self.StartAlpha = nil
	self.EndAlpha = nil
	self.Duration = 0
	self.FadeElapsedTime = 0
	self.Started = false
end

return m
