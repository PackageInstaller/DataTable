-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogMove.lua

local m = {
	MoveElapsedTime = 0,
	Duration = 0,
	Started = false
}

function m.New()
	return Clone(m)
end

function m:Start(performanceData, params)
	self.gameObject = performanceData.gameObject
	self.PerformanceData = performanceData
	self.StartPos = params[1]
	self.EndPos = params[2]
	self.Duration = params[3]
	self.Started = true

	if self.Duration == 0 then
		self:MoveComplete()
	else
		self.gameObject.transform.anchoredPosition3D = self.StartPos
	end
end

function m:Stop()
	if self.Started then
		self:MoveComplete()
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	if not self.Started then
		return
	end

	self.MoveElapsedTime = self.MoveElapsedTime + elapseSeconds

	local lerpValue = self.MoveElapsedTime / self.Duration

	if lerpValue > 1 then
		lerpValue = 1
	end

	self.gameObject.transform.anchoredPosition3D = Vector3.Lerp(self.StartPos, self.EndPos, lerpValue)

	if lerpValue == 1 then
		self:MoveComplete()
	end
end

function m:MoveComplete()
	self.gameObject.transform.anchoredPosition3D = self.EndPos
	self.PerformanceData.Completed = true

	self:Clear()
end

function m:Clear()
	self.gameObject = nil
	self.PerformanceData = nil
	self.StartPos = nil
	self.EndPos = nil
	self.Duration = 0
	self.MoveElapsedTime = 0
	self.Started = false
end

return m
