-- chunkname: @modules/logic/common/model/SimpleRandomModel.lua

module("modules.logic.common.model.SimpleRandomModel", package.seeall)

local SimpleRandomModel = class("SimpleRandomModel", BaseModel)
local random = math.random
local randomseed = math.randomseed
local ti = table.insert
local sf = string.format

function SimpleRandomModel:onInit()
	self:reInit()
end

function SimpleRandomModel:reInit()
	self._rdHashSet = {}
end

function SimpleRandomModel:getListIdxAndItemIdx(reqLists)
	if isDebugBuild then
		assert(#reqLists > 0)
	end

	local hash
	local reqCount = 0

	for i, p in ipairs(reqLists) do
		reqCount = reqCount + #p

		if i == 1 then
			self._rdHashSet[p] = self._rdHashSet[p] or {}
			hash = self._rdHashSet[p]
		else
			hash[p] = hash[p] or {}
			hash = hash[p]
		end
	end

	if isDebugBuild then
		assert(type(hash) == "table", "never happen")
		assert(reqCount > 0, "empty reqLists")
	end

	if not hash.curRdIdx then
		local curRdIdx = 0

		if not hash.rdIdxList then
			local rdIdxList = {}

			if not hash.rdIdx2RealIdxPairDict then
				local rdIdx2RealIdxPairDict = {}

				if curRdIdx < #rdIdxList then
					curRdIdx = curRdIdx + 1
					hash.curRdIdx = curRdIdx

					local pair = hash.rdIdx2RealIdxPairDict[curRdIdx]

					return pair.whichList, pair.whichItem
				end

				for i = #rdIdxList + 1, reqCount do
					ti(rdIdxList, i)
					ti(rdIdx2RealIdxPairDict, {})
				end

				curRdIdx = 1

				randomseed(os.time())

				rdIdxList = GameUtil.randomTable(rdIdxList)

				local pSum = {
					[0] = 0
				}

				for i, p in ipairs(reqLists) do
					pSum[i] = pSum[i - 1] + #p
				end

				for i, rdIdx in ipairs(rdIdxList) do
					local pair = rdIdx2RealIdxPairDict[i]

					for j = 1, #pSum do
						local sum = pSum[j]

						if rdIdx <= sum then
							local ofs = pSum[j - 1]

							pair.whichList = j
							pair.whichItem = rdIdx - ofs

							break
						end
					end
				end

				hash.rdIdxList = rdIdxList
				hash.curRdIdx = curRdIdx
				hash.rdIdx2RealIdxPairDict = rdIdx2RealIdxPairDict

				local pair = hash.rdIdx2RealIdxPairDict[curRdIdx]

				return pair.whichList, pair.whichItem
			end
		end
	end
end

function SimpleRandomModel:getRateIndex(rateNumList)
	randomseed(os.time())

	local index = 0
	local tot = 0

	for _, rate in ipairs(rateNumList) do
		if rate > 0 then
			tot = tot + rate
		end
	end

	local value = random(1, tot)

	for _, rate in ipairs(rateNumList) do
		index = index + 1

		if rate > 0 then
			if value <= rate then
				return index
			end

			value = value - rate
		end
	end

	if isDebugBuild and false then
		local tbl = {}

		ti("[SimpleRandomModel - getRateIndex] =========== begin")
		ti("tot: " .. tot)
		ti("result index: " .. index)

		for i, rate in ipairs(rateNumList) do
			ti(sf("\t[%s]: %s", i, rate))
		end

		ti("[SimpleRandomModel - getRateIndex] =========== end")
		logError(table.concat(tbl, "\n"))
	end

	return index
end

function SimpleRandomModel:clean(reqLists)
	local hash

	for _, p in ipairs(reqLists or {}) do
		if hash == nil then
			hash = self._rdHashSet[p]
			self._rdHashSet[p] = nil
		else
			local oldHash = hash

			hash = hash[p]
			oldHash[p] = nil

			if not hash then
				break
			end
		end
	end
end

SimpleRandomModel.instance = SimpleRandomModel.New()

return SimpleRandomModel
