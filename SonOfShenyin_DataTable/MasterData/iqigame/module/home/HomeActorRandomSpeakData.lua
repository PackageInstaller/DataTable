-- chunkname: @IQIGame\\Module\\Home\\HomeActorRandomSpeakData.lua

local HomeActorRandomSpeakData = {
	totalTime = 0,
	heroCid = 0,
	intervalTime = 0,
	speakCidList = {}
}

function HomeActorRandomSpeakData.New(heroCid, intervalTime)
	local obj = Clone(HomeActorRandomSpeakData)

	obj:__Init(heroCid, intervalTime)

	return obj
end

function HomeActorRandomSpeakData:__Init(heroCid, intervalTime)
	self.heroCid = heroCid
	self.intervalTime = intervalTime

	ForPairs(CfgHeroSoundTable, function(_cid, _cfg)
		if _cfg.HeroId ~= self.heroCid then
			return
		end

		if _cfg.Type ~= 1 then
			return
		end

		table.insert(self.speakCidList, _cid)
	end)
end

function HomeActorRandomSpeakData:TryExecute()
	if #self.speakCidList == 0 then
		return false
	end

	self.totalTime = self.totalTime + Time.deltaTime

	if self.totalTime < self.intervalTime then
		return false
	end

	self.totalTime = 0

	local isSpeak = math.random(1, 100)

	if isSpeak >= 50 then
		return false
	end

	local speakIndex = math.random(1, #self.speakCidList)

	return true, self.speakCidList[speakIndex]
end

function HomeActorRandomSpeakData:Dispose()
	return
end

return HomeActorRandomSpeakData
