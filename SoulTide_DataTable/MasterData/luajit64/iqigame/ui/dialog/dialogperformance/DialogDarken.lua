-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogDarken.lua

local m = {
	SuccessCount = 0,
	Started = false,
	DEFAULT_COLOR_DARK = Color(0.19607843137254902, 0.19607843137254902, 0.19607843137254902, 1)
}

function m.New(userData)
	local obj = Clone(m)

	obj.NpcPortrait = userData.npcPortrait

	return obj
end

function m:Start(performanceData, params)
	self.gameObject = performanceData.gameObject
	self.PerformanceData = performanceData
	self.Started = true
	self.DarkColor = m.DEFAULT_COLOR_DARK

	if params ~= nil and #params > 0 then
		self.DarkColor = hexStringToColor("#" .. params[1])
	end

	self:SetGameObjectColor(self.DarkColor)
end

function m:Stop()
	if self.Started then
		self:SetGameObjectColor(Color.white)
		self:DarkenComplete()
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	if not self.Started then
		return
	end

	local success = self:SetGameObjectColor(self.DarkColor)

	self.SuccessCount = self.SuccessCount + (success and 1 or 0)

	if self.SuccessCount > 2 then
		self:DarkenComplete()
	end
end

function m:SetGameObjectColor(color)
	if self.NpcPortrait ~= nil and self.NpcPortrait.LoadingAsset then
		return false
	end

	return EntityShowUtil.SetColor(self.gameObject, color)
end

function m:DarkenComplete()
	self.PerformanceData.Completed = true

	self:Clear()
end

function m.ResetHost(obj)
	EntityShowUtil.SetColor(obj, Color.white)
end

function m:Clear()
	self.gameObject = nil
	self.PerformanceData = nil
	self.Started = false
	self.SuccessCount = 0
	self.DarkColor = nil
end

return m
