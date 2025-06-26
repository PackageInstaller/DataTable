-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogMoveAround.lua

local m = {
	ShakeScale = 0,
	OneTimeShakeSecond = 0,
	AMPLITUDE = 1,
	Started = false,
	EndTime = 0,
	IsHorizontal = false,
	Direction = 0,
	OneTimeShakeElapsedTime = 0
}

function m.New()
	return Clone(m)
end

function m:Start(performanceData, params)
	self.gameObject = performanceData.gameObject
	self.PerformanceData = performanceData
	self.OneTimeShakeSecond = 1 / params[1]
	self.ShakeScale = params[2]

	local duration = params[3]

	self.EndTime = UnityEngine.Time.time + duration
	self.IsHorizontal = params[4] == 0
	self.InitPos = self.gameObject.transform.anchoredPosition3D
	self.TempPos = self.InitPos:Clone()
	self.Direction = -1
	self.OneTimeShakeElapsedTime = UnityEngine.Time.time
	self.Started = true
end

function m:Stop()
	if self.Started then
		self:ShakeComplete()
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	if self.EndTime > 0 and UnityEngine.Time.time < self.EndTime then
		self:UpdateOneTimeParams()

		if UnityEngine.Time.time - self.OneTimeShakeElapsedTime >= self.OneTimeShakeSecond then
			self.Direction = self.Direction * -1
			self.OneTimeShakeElapsedTime = UnityEngine.Time.time
		end
	elseif self.EndTime > 0 then
		self:ShakeComplete()
	end
end

function m:UpdateOneTimeParams()
	if self.IsHorizontal then
		self.TempPos.x = self.TempPos.x + m.AMPLITUDE * self.ShakeScale * self.Direction
	else
		self.TempPos.y = self.TempPos.y + m.AMPLITUDE * self.ShakeScale * self.Direction
	end

	self.gameObject.transform.anchoredPosition3D = self.TempPos
end

function m:ShakeComplete()
	self.gameObject.transform.anchoredPosition3D = self.InitPos
	self.PerformanceData.Completed = true

	self:Clear()
end

function m:Clear()
	self.gameObject = nil
	self.PerformanceData = nil
	self.InitPos = nil
	self.TempPos = nil
	self.EndTime = 0
	self.OneTimeShakeElapsedTime = 0
	self.Started = false
end

return m
