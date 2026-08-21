-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogEffect.lua

local m = {
	EffectPlayID = 0,
	EffectCid = 0,
	Started = false
}

function m.New()
	local obj = Clone(m)

	function obj.DelegateOnEndEffectPlayEnd(sender, args)
		obj:OnEndEffectPlayEnd(sender, args)
	end

	return obj
end

function m:Start(performanceData, params)
	self.gameObject = performanceData.gameObject
	self.PerformanceData = performanceData
	self.EffectCid = params[1]

	local posX = params[2]
	local posY = params[3]

	self.SortingOrder = params[4]

	local offset = Vector3.zero

	offset.x = posX
	offset.y = posY

	GameEntry.LuaEvent:Subscribe(EffectPlayEndEventArgs.EventId, self.DelegateOnEndEffectPlayEnd)

	self.EffectPlayID = GameEntry.Effect:PlayUIMountPointEffect(self.EffectCid, 50000, 0, self.gameObject, self.SortingOrder, 0, 0, offset)
	self.Started = true
end

function m:OnEndEffectPlayEnd(sender, args)
	if self.EffectPlayID == args.EffectPlayID and self.Started then
		self:EffectComplete()
	end
end

function m:Stop()
	if self.Started then
		GameEntry.Effect:StopEffect(self.EffectPlayID)
		self:EffectComplete()
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:EffectComplete()
	GameEntry.LuaEvent:Unsubscribe(EffectPlayEndEventArgs.EventId, self.DelegateOnEndEffectPlayEnd)

	self.PerformanceData.Completed = true

	self:Clear()
end

function m:Clear()
	self.gameObject = nil
	self.PerformanceData = nil
	self.EffectCid = 0
	self.PositionType = 0
	self.Started = false
end

return m
