-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogScale.lua

local m = {
	Duration = 0,
	ScaleElapsedTime = 0,
	Started = false
}

function m.New()
	return Clone(m)
end

function m:Start(performanceData, params)
	self.gameObject = performanceData.gameObject
	self.PerformanceData = performanceData
	self.StartScale = params[1]
	self.EndScale = params[2]
	self.Duration = params[3]

	if params[4] ~= nil then
		self.StartPos = self.gameObject.transform.anchoredPosition3D + params[4]
		self.EndPos = self.gameObject.transform.anchoredPosition3D + params[5]
	end

	self.Started = true

	if self.Duration == 0 then
		self:ScaleComplete()
	else
		self.gameObject.transform.localScale = self.StartScale
	end
end

function m:Stop()
	if self.Started then
		self:ScaleComplete()
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	if not self.Started then
		return
	end

	self.ScaleElapsedTime = self.ScaleElapsedTime + elapseSeconds

	local lerpValue = self.ScaleElapsedTime / self.Duration

	if lerpValue > 1 then
		lerpValue = 1
	end

	self.gameObject.transform.localScale = Vector3.Lerp(self.StartScale, self.EndScale, lerpValue)

	if self.StartPos ~= nil and self.EndPos ~= nil then
		self.gameObject.transform.anchoredPosition3D = Vector3.Lerp(self.StartPos, self.EndPos, lerpValue)
	end

	if lerpValue == 1 then
		self:ScaleComplete()
	end
end

function m:ScaleComplete()
	self.gameObject.transform.localScale = self.EndScale

	if self.EndPos ~= nil then
		self.gameObject.transform.anchoredPosition3D = self.EndPos
	end

	self.PerformanceData.Completed = true

	self:Clear()
end

function m:Clear()
	self.gameObject = nil
	self.PerformanceData = nil
	self.StartScale = nil
	self.EndScale = nil
	self.Duration = 0
	self.ScaleElapsedTime = 0
	self.StartPos = nil
	self.EndPos = nil
	self.Started = false
end

return m
