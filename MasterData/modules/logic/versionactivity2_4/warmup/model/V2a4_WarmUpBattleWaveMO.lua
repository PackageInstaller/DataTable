-- chunkname: @modules/logic/versionactivity2_4/warmup/model/V2a4_WarmUpBattleWaveMO.lua

module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpBattleWaveMO", package.seeall)

local V2a4_WarmUpBattleWaveMO = class("V2a4_WarmUpBattleWaveMO")
local sf = string.format
local ti = table.insert

function V2a4_WarmUpBattleWaveMO:ctor(index, gachaWaveMO)
	self._index = index
	self._gachaMO = gachaWaveMO
	self._isFinished = false
	self._isWin = false
	self._isPerfectWin = false
	self._curRound = 0
	self._roundMOList = {}
end

function V2a4_WarmUpBattleWaveMO:genRound(gachaRoundMO)
	if self._isFinished then
		return
	end

	local roundIndex = self:roundCount() + 1
	local roundMO = V2a4_WarmUpBattleRoundMO.New(self, roundIndex, gachaRoundMO)

	table.insert(self._roundMOList, roundMO)

	return roundMO
end

function V2a4_WarmUpBattleWaveMO:index()
	return self._index
end

function V2a4_WarmUpBattleWaveMO:type()
	return self._gachaMO:type()
end

function V2a4_WarmUpBattleWaveMO:isRound_Text()
	return self:type() == V2a4_WarmUpEnum.AskType.Text
end

function V2a4_WarmUpBattleWaveMO:isRound_Photo()
	return self:type() == V2a4_WarmUpEnum.AskType.Photo
end

function V2a4_WarmUpBattleWaveMO:roundMOList()
	return self._roundMOList
end

function V2a4_WarmUpBattleWaveMO:roundCount()
	return #self._roundMOList
end

function V2a4_WarmUpBattleWaveMO:validRoundCount()
	local cnt = 0

	for _, roundMO in ipairs(self._roundMOList) do
		if roundMO:isFinished() then
			cnt = cnt + 1
		end
	end

	return cnt
end

function V2a4_WarmUpBattleWaveMO:isLastRound()
	return self:roundCount() == self._curRound
end

function V2a4_WarmUpBattleWaveMO:isFirstRound()
	return self._curRound == 1
end

function V2a4_WarmUpBattleWaveMO:isWin()
	return self._isWin
end

function V2a4_WarmUpBattleWaveMO:isPerfectWin()
	return self._isPerfectWin
end

function V2a4_WarmUpBattleWaveMO:isFinished()
	return self._isFinished
end

function V2a4_WarmUpBattleWaveMO:nextRound()
	if self._isFinished then
		return false
	end

	local newRound = self._curRound + 1

	if newRound > self:roundCount() then
		self:_onFinish()

		return false
	end

	self._curRound = newRound

	return true
end

function V2a4_WarmUpBattleWaveMO:_onFinish()
	if self._isFinished then
		return
	end

	self._isFinished = true
	self._curRound = self:roundCount()

	for _, round in ipairs(self._roundMOList) do
		self._isWin = round:isWin()

		if self._isWin then
			break
		end
	end

	for _, round in ipairs(self._roundMOList) do
		self._isPerfectWin = round:isWin()

		if not self._isPerfectWin then
			break
		end
	end
end

function V2a4_WarmUpBattleWaveMO:curRound()
	return self._roundMOList[self._curRound]
end

function V2a4_WarmUpBattleWaveMO:winRoundCount()
	local cnt = 0

	for _, round in ipairs(self._roundMOList) do
		if round:isWin() then
			cnt = cnt + 1
		end
	end

	return cnt
end

function V2a4_WarmUpBattleWaveMO:isFirstWave()
	return self._index == 1
end

function V2a4_WarmUpBattleWaveMO:isAllAskYes()
	return self._gachaMO:isAllAskYes()
end

function V2a4_WarmUpBattleWaveMO.s_type(t)
	for k, v in pairs(V2a4_WarmUpEnum.AskType) do
		if t == v then
			return k
		end
	end

	return "[V2a4_WarmUpBattleWaveMO - s_type] error !"
end

function V2a4_WarmUpBattleWaveMO:dump(refStrBuf, depth)
	depth = depth or 0

	local tab = string.rep("\t", depth)

	ti(refStrBuf, tab .. sf("index = %s", self._index))
	ti(refStrBuf, tab .. sf("isFinished = %s", self._isFinished))
	ti(refStrBuf, tab .. sf("isWin = %s", self._isWin))
	ti(refStrBuf, tab .. sf("type = %s", V2a4_WarmUpBattleWaveMO.s_type(self:type())))
	ti(refStrBuf, tab .. sf("Cur Round Index = %s --> ", self._curRound))

	local list = self._roundMOList

	ti(refStrBuf, tab .. "Rounds = {")

	for i = 1, #list do
		local roundMO = list[i]

		roundMO:dump(refStrBuf, depth + 1)
	end

	ti(refStrBuf, tab .. "}")
end

return V2a4_WarmUpBattleWaveMO
