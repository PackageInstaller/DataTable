-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogShake.lua

local m = {
	ShakeScale = 0,
	Started = false,
	ON_TIME_SHAKE_SECOND = 0.02,
	EndTime = 0,
	OneTimeShakeElapsedTime = 0
}

function m.New()
	return Clone(m)
end

function m:Start(performanceData, params)
	self.gameObject = performanceData.gameObject
	self.PerformanceData = performanceData

	local duration = params[1]

	self.EndTime = UnityEngine.Time.time + duration
	self.ShakeScale = params[2]
	self.InitPos = self.gameObject.transform.anchoredPosition3D
	self.TempPos = Vector3.zero
	self.TempPos.z = self.InitPos.z
	self.Started = true

	self:ResetOneTimeParams()
end

function m:Stop()
	if self.Started then
		self:ShakeComplete()
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	if self.EndTime > 0 and UnityEngine.Time.time < self.EndTime then
		if UnityEngine.Time.time - self.OneTimeShakeElapsedTime >= m.ON_TIME_SHAKE_SECOND then
			self:ResetOneTimeParams()
		end
	elseif self.EndTime > 0 then
		self:ShakeComplete()
	end
end

function m:ResetOneTimeParams()
	self.TempPos.x = math.random(-5, 5) * self.ShakeScale + self.InitPos.x
	self.TempPos.y = math.random(-5, 5) * self.ShakeScale + self.InitPos.y
	self.gameObject.transform.anchoredPosition3D = self.TempPos
	self.OneTimeShakeElapsedTime = UnityEngine.Time.time
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
