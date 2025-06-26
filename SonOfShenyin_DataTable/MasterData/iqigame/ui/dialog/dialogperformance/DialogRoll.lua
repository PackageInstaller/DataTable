-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogRoll.lua

local m = {
	SPEED = 0.1,
	SpeedRatio = 1,
	Direction = 0,
	Started = false,
	MoveElapsedTime = 0
}

function m.New()
	return Clone(m)
end

function m:Start(performanceData, params)
	self.gameObject = performanceData.gameObject
	self.PerformanceData = performanceData
	self.Direction = params[1]
	self.SpeedRatio = params[2]
	self.Started = true
	self.TwoDimensionSeriesComponent = self.gameObject:GetComponent("TwoDimensionSeriesComponent")
	self.TwoDimensionSeriesComponent.value = 0
end

function m:Stop()
	if self.Started then
		self:RollComplete()
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	if not self.Started then
		return
	end

	self.MoveElapsedTime = self.MoveElapsedTime + elapseSeconds
	self.TwoDimensionSeriesComponent.value = self.MoveElapsedTime * m.SPEED * self.SpeedRatio * self.Direction
end

function m:RollComplete()
	self.TwoDimensionSeriesComponent.value = 0
	self.PerformanceData.Completed = true

	self:Clear()
end

function m:Clear()
	self.gameObject = nil
	self.PerformanceData = nil
	self.Direction = 0
	self.SpeedRatio = 0
	self.MoveElapsedTime = 0
	self.Started = false
end

return m
