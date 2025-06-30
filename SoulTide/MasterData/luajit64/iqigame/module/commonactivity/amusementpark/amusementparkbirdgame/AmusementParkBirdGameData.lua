-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkBirdGame\\AmusementParkBirdGameData.lua

local m = {
	startGame = false,
	score = 0,
	endGameTime = 0,
	startGameTime = 0
}

function m.New(cid)
	local o = Clone(m)

	o:Init(cid)

	return o
end

function m:Init(cid)
	self.cid = cid
	self.startGame = false
end

function m:GetCfgData()
	return CfgAmusementParkBirdControlTable[self.cid]
end

function m:StartGame()
	self.startGame = true
	self.startGameTime = PlayerModule.GetServerTime()
end

function m:EndGame()
	self.startGame = false
	self.endGameTime = PlayerModule.GetServerTime()
end

function m:GetGameScore()
	local second = math.floor(self.endGameTime - self.startGameTime)

	if self.startGame then
		second = math.floor(PlayerModule.GetServerTime() - self.startGameTime)
	end

	return second
end

return m
