-- chunkname: @modules/logic/versionactivity2_4/warmup/model/V2a4_WarmUpBattleModel.lua

module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpBattleModel", package.seeall)

local V2a4_WarmUpBattleModel = class("V2a4_WarmUpBattleModel", BaseModel)
local sf = string.format
local ti = table.insert

function V2a4_WarmUpBattleModel:onInit()
	self:reInit()
end

function V2a4_WarmUpBattleModel:reInit()
	self._levelId = 0
	self._startTs = 0
	self._endTs = -1
	self._waveList = {}
end

function V2a4_WarmUpBattleModel:curWaveIndex()
	return #self._waveList
end

function V2a4_WarmUpBattleModel:curWave()
	local index = self:curWaveIndex()

	return self._waveList[index]
end

function V2a4_WarmUpBattleModel:curRound()
	local waveMO = self:curWave()

	if not waveMO then
		return nil, nil
	end

	return waveMO:curRound(), waveMO
end

function V2a4_WarmUpBattleModel:curRoundIndex()
	local roundMO = self:curRound()

	if not roundMO then
		return 0
	end

	return roundMO:index()
end

function V2a4_WarmUpBattleModel:genWave(gachaWaveMO)
	local waveIndex = self:curWaveIndex() + 1
	local waveMO = V2a4_WarmUpBattleWaveMO.New(waveIndex, gachaWaveMO)
	local gachaRoundMOList = gachaWaveMO:roundMOList()

	for _, gachaRoundMO in ipairs(gachaRoundMOList) do
		waveMO:genRound(gachaRoundMO)
	end

	ti(self._waveList, waveMO)

	return waveMO
end

function V2a4_WarmUpBattleModel:clean()
	self._levelId = 0
	self._startTs = 0
	self._endTs = 0
	self._waveList = {}
end

function V2a4_WarmUpBattleModel:restart(levelId)
	self:clean()

	self._levelId = levelId
	self._startTs = ServerTime.now()
	self._endTs = self._startTs + V2a4_WarmUpConfig.instance:getDurationSec()
end

function V2a4_WarmUpBattleModel:levelId()
	return self._levelId
end

function V2a4_WarmUpBattleModel:isTimeout()
	return self._startTs > self._endTs or ServerTime.now() >= self._endTs
end

function V2a4_WarmUpBattleModel:getRemainTime()
	return self._endTs - ServerTime.now()
end

function V2a4_WarmUpBattleModel:isFirstWaveDone()
	if self:curWaveIndex() >= 2 then
		return true
	end

	local waveMO = self:curWave()

	if not waveMO then
		return false
	end

	return waveMO:isFinished()
end

function V2a4_WarmUpBattleModel:getResultInfo()
	local isWin = false
	local totValidWaveCnt = 0
	local totValidRoundCnt = 0
	local sucHelpCnt = 0
	local totBingoRoundCnt = 0
	local totAnsYesCnt = 0
	local totAnsNoCnt = 0
	local isFirstWaveDone = self:isFirstWaveDone()

	for _, waveMO in ipairs(self._waveList) do
		local roundMOList = waveMO:roundMOList()
		local isSucHelp
		local curRroundCount = 0

		for _, roundMO in ipairs(roundMOList) do
			if roundMO:isFinished() then
				if roundMO:userAnsIsYes() then
					totAnsYesCnt = totAnsYesCnt + 1
				else
					totAnsNoCnt = totAnsNoCnt + 1
				end

				curRroundCount = curRroundCount + 1

				if roundMO:isWin() then
					totBingoRoundCnt = totBingoRoundCnt + 1

					if isSucHelp == nil then
						isSucHelp = true
					end
				else
					isSucHelp = false
				end
			else
				isSucHelp = false
			end
		end

		if curRroundCount == #roundMOList then
			totValidWaveCnt = totValidWaveCnt + 1
		end

		totValidRoundCnt = totValidRoundCnt + curRroundCount

		if isSucHelp then
			isWin = true
			sucHelpCnt = sucHelpCnt + 1
		end
	end

	if not isFirstWaveDone then
		isWin = false
	end

	local isPerfectWin = isWin and totValidRoundCnt == totBingoRoundCnt
	local totWrontRoundCnt = totValidRoundCnt - totBingoRoundCnt

	return {
		isWin = isWin,
		isPerfectWin = isPerfectWin,
		sucHelpCnt = sucHelpCnt,
		totValidWaveCnt = totValidWaveCnt,
		totValidRoundCnt = totValidRoundCnt,
		totBingoRoundCnt = totBingoRoundCnt,
		totWrontRoundCnt = totWrontRoundCnt,
		totWaveCnt = self:curWaveIndex(),
		totAnsYesCnt = totAnsYesCnt,
		totAnsNoCnt = totAnsNoCnt
	}
end

function V2a4_WarmUpBattleModel:dump(refStrBuf, depth)
	depth = depth or 0

	local tab = string.rep("\t", depth)

	ti(refStrBuf, tab .. sf("level = %s (%s)s", self._levelId, self:getRemainTime()))

	local list = self._waveList

	ti(refStrBuf, tab .. "Waves = {")

	for i = #list, 1, -1 do
		local waveMO = list[i]

		waveMO:dump(refStrBuf, depth + 1)
	end

	ti(refStrBuf, tab .. "}")
end

V2a4_WarmUpBattleModel.instance = V2a4_WarmUpBattleModel.New()

return V2a4_WarmUpBattleModel
