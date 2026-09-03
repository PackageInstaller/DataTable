-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/model/PetRace.lua

PetRaceEnum = {}
PetRaceEnum.state = {
	fighting = 3,
	matchOver = 4,
	regist = 0,
	match = 1,
	embattle = 2
}
PetRace = class("PetRace", objectlua.Object)

PetRace:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PetRace:has("_finalEight", {
	is = "rw"
})
PetRace:has("_isMaxRegist", {
	is = "rw"
})
PetRace:has("_isRegist", {
	is = "rw"
})
PetRace:has("_round", {
	is = "rw"
})
PetRace:has("_roundEndTime", {
	is = "rw"
})
PetRace:has("_state", {
	is = "rw"
})
PetRace:has("_startTime", {
	is = "rw"
})
PetRace:has("_debugRate", {
	is = "rw"
})
PetRace:has("_wonderBattle", {
	is = "rw"
})
PetRace:has("_autoEnter", {
	is = "rw"
})
PetRace:has("_scoreEmbattle", {
	is = "rw"
})
PetRace:has("_finalEmbattle", {
	is = "rw"
})
PetRace:has("_roundList", {
	is = "rw"
})
PetRace:has("_topEight", {
	is = "rw"
})
PetRace:has("_myRank", {
	is = "rw"
})
PetRace:has("_totalUser", {
	is = "rw"
})
PetRace:has("_myScore", {
	is = "rw"
})
PetRace:has("_finalVO", {
	is = "rw"
})
PetRace:has("_enterIndex", {
	is = "rw"
})
PetRace:has("_curIndex", {
	is = "rw"
})
PetRace:has("_enterList", {
	is = "rw"
})

function PetRace:initialize()
	super.initialize(self)

	self._finalEight = {}
	self._isMaxRegist = false
	self._isRegist = false
	self._round = 1
	self._roundEndTime = 0
	self._state = 0
	self._autoEnter = 0
	self._scoreEmbattle = {}
	self._finalEmbattle = {}
	self._roundList = {}
	self._topEight = {}
	self._myRank = -1
	self._totalUser = 0
	self._myScore = 0
	self._finalVO = {}
end

function PetRace:synchronize(data)
	self._isRegist = false

	if data.enterIndex ~= nil then
		self._isRegist = data.enterIndex ~= -1 and data.enterIndex == data.curIndex
	end

	self._enterIndex = data.enterIndex
	self._curIndex = data.curIndex
	self._enterList = data.enterList or {}
	self._autoEnter = data.autoEnter
	self._state = data.state or PetRaceEnum.state.matchOver
	self._round = data.round or 0
	self._roundEndTime = data.time or 0
	self._startTime = data.startTime or 0
	self._debugRate = data.debugRate or 1
	self._finalEmbattle = data.finalEmbattle or {}
	self._scoreEmbattle = data.scoreEmbattle or {}
	self._roundList = data.roundList or {}
	self._topEight = data.topEight or {}
	self._totalUser = data.totalUser or 0
	self._myRank = data.myRank or -1
	self._myScore = data.myScore or 0
	self._finalVO = data.finalVO or {}
end

function PetRace:getMatchState()
	if self._enterIndex ~= self._curIndex then
		return PetRaceEnum.state.regist
	end

	return self._state
end

function PetRace:getWinNum()
	local winNum = 0

	for i, v in pairs(self._roundList or {}) do
		if v.winId and #v.winId > 0 and v.userId == v.winId then
			winNum = winNum + 1
		end
	end

	return winNum
end

function PetRace:getLostNum()
	local lostNum = 0

	for i, v in pairs(self._roundList or {}) do
		if v.winId and #v.winId > 0 and v.userId ~= v.winId then
			lostNum = lostNum + 1
		end
	end

	return lostNum
end

function PetRace:getRestHeros()
	local restHeros = {}
	local workHeros = {}

	for k, v in pairs(self._scoreEmbattle) do
		for pos, data in pairs(v.embattle) do
			workHeros[data.heroId] = true
		end
	end

	local heros = self:getDevelopSystem():getHeroList():getHeros()

	for k, v in pairs(heros) do
		if not workHeros[v:getId()] then
			table.insert(restHeros, v:getId())
		end
	end

	return restHeros
end

function PetRace:getTeamCombatByEmbattle(embattleInfo)
	local combat = 0

	for k, v in pairs(embattleInfo) do
		local heroId = v.heroId
		local heroData = self:getDevelopSystem():getHeroList():getHeroById(heroId)

		combat = combat + heroData:getCombat()
	end

	return combat
end

function PetRace:getTeamCostByEmbattle(embattleInfo)
	local cost = 0

	for k, v in pairs(embattleInfo) do
		local heroId = v.heroId

		cost = cost + PrototypeFactory:getInstance():getHeroPrototype(heroId):getConfig().Cost
	end

	return cost
end

function PetRace:getTeamSpeedByEmbattle(embattleInfo)
	local speed = 0

	for k, v in pairs(embattleInfo) do
		local heroId = v.heroId

		speed = speed + PrototypeFactory:getInstance():getHeroPrototype(heroId):getConfig().Speed
	end

	return speed
end
