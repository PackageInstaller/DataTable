-- chunkname: @modules/logic/versionactivity2_4/warmup/model/V2a4_WarmUpGachaWaveMO.lua

module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpGachaWaveMO", package.seeall)

local randomseed = math.randomseed
local ti = table.insert
local sf = string.format
local V2a4_WarmUpGachaWaveMO = class("V2a4_WarmUpGachaWaveMO")

function V2a4_WarmUpGachaWaveMO:ctor(index, eV2a4_WarmUpEnum_AskType)
	self._index = index
	self._type = eV2a4_WarmUpEnum_AskType
	self._roundMOList = {}
end

function V2a4_WarmUpGachaWaveMO:_getYesOrNo()
	if not self.__rdIdxList then
		if not self.__curRdIdx then
			local idx = 0

			self.__rdSet = self.__rdSet or {}

			if idx < #self.__rdIdxList then
				local isNo, yesOrNoIndex = self:_nextRandomYesNo()
				local stk_overflow = 10

				while self.__rdSet[yesOrNoIndex] do
					stk_overflow = stk_overflow - 1

					if stk_overflow < 0 then
						logError("[V2a4_WarmUpGachaWaveMO - _getYesOrNo] stack overflow")

						break
					end

					isNo, yesOrNoIndex = self:_nextRandomYesNo()
				end

				if self.__curRdIdx <= #self.__rdIdxList then
					self.__rdSet[yesOrNoIndex] = true

					return isNo, yesOrNoIndex
				end

				self.__rdSet = {}
			end

			local yesAndNoMaxCount = V2a4_WarmUpConfig.instance:getYesAndNoMaxCount(self._type)

			if isDebugBuild then
				assert(yesAndNoMaxCount > 0, sf("unsupported V2a4_WarmUpEnum.AskType.xxx = %s", self._type))
			end

			for i = #self.__rdIdxList + 1, yesAndNoMaxCount do
				ti(self.__rdIdxList, i)
			end

			randomseed(os.time())

			self.__rdIdxList = GameUtil.randomTable(self.__rdIdxList)
			self.__curRdIdx = 0

			local isNo, yesOrNoIndex = self:_nextRandomYesNo()

			self.__rdSet[yesOrNoIndex] = true

			return isNo, yesOrNoIndex
		end
	end
end

function V2a4_WarmUpGachaWaveMO:_nextRandomYesNo()
	local rdIdx = self.__curRdIdx + 1
	local idx = self.__rdIdxList[rdIdx]
	local isNo = idx % 2 == 0
	local yesOrNoIndex = math.ceil(idx / 2)

	self.__curRdIdx = rdIdx

	return isNo, yesOrNoIndex
end

function V2a4_WarmUpGachaWaveMO:index()
	return self._index
end

function V2a4_WarmUpGachaWaveMO:type()
	return self._type
end

function V2a4_WarmUpGachaWaveMO:roundCount()
	return #self._roundMOList
end

function V2a4_WarmUpGachaWaveMO:roundMOList()
	return self._roundMOList
end

function V2a4_WarmUpGachaWaveMO:isAllAskYes()
	local askYesCnt = 0

	for _, roundMO in ipairs(self._roundMOList) do
		if roundMO:ansIsYes() then
			askYesCnt = askYesCnt + 1
		end
	end

	return askYesCnt > 0 and askYesCnt == self:roundCount()
end

function V2a4_WarmUpGachaWaveMO:genRound(CO)
	local isNo, yesOrNoIndex = self:_getYesOrNo()
	local roundIndex = self:roundCount() + 1
	local roundMO = V2a4_WarmUpGachaRoundMO.New(self, roundIndex, CO, isNo, yesOrNoIndex)

	ti(self._roundMOList, roundMO)

	return roundMO
end

return V2a4_WarmUpGachaWaveMO
