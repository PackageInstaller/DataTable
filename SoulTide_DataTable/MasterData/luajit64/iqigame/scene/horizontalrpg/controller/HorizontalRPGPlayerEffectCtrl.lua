-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Controller\\HorizontalRPGPlayerEffectCtrl.lua

local m = {
	playTime = 0,
	startPlayTime = 0,
	isPlaying = false
}

function m.New(effect, playTime, effectObj)
	local o = Clone(m)

	o:Init(effect, playTime, effectObj)

	return o
end

function m:Init(effect, playTime, effectObj)
	self.effect = effect
	self.playTime = playTime
	self.effectObj = effectObj

	self:PlayEnd()
end

function m:FrameUpdate()
	if self.playTime > 0 and self.isPlaying and UnityEngine.Time.time - self.startPlayTime > self.playTime then
		self:PlayEnd()
	end
end

function m:StartPlay()
	self.startPlayTime = UnityEngine.Time.time
	self.isPlaying = true

	self.effectObj:SetActive(true)
end

function m:PlayEnd()
	self.isPlaying = false
	self.startPlayTime = 0

	self.effectObj:SetActive(false)
end

return m
