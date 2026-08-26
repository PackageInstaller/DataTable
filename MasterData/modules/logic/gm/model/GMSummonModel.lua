-- chunkname: @modules/logic/gm/model/GMSummonModel.lua

module("modules.logic.gm.model.GMSummonModel", package.seeall)

local GMSummonModel = class("GMSummonModel", BaseModel)

GMSummonModel._index2Star = {
	6,
	5,
	4,
	3,
	2
}

function GMSummonModel:onInit()
	self:reInit()
end

function GMSummonModel:reInit()
	self._allSummonHeroList = {}
	self._upSummonHeroList = {}
	self._diffRaritySummonHeroList = {}
	self._diffRaritySummonShowList = {}
	self._poolId = nil
	self._totalCount = nil
	self._star6TotalCount = nil
	self._star5TotalCount = nil
end

function GMSummonModel:getAllInfo()
	return self._poolId, self._totalCount, self._star6TotalCount, self._star5TotalCount
end

function GMSummonModel:getDiffRaritySummonHeroInfo()
	return self._diffRaritySummonHeroList
end

function GMSummonModel:getDiffRaritySummonShowInfo()
	return self._diffRaritySummonShowList
end

function GMSummonModel:getUpSummonHeroInfo()
	return self._upSummonHeroList
end

function GMSummonModel:getAllSummonHeroInfo()
	return self._allSummonHeroList
end

function GMSummonModel:getAllUpSummonName()
	local str

	for index, value in ipairs(self._upSummonHeroList) do
		local name = self:getTargetName(value.id)

		str = index == 1 and name or str .. "、" .. name
	end

	return str
end

function GMSummonModel:setInfo(msg)
	self:reInit()

	self._poolId = msg.poolId
	self._totalCount = msg.totalCount
	self._star6TotalCount = msg.star6TotalCount
	self._star5TotalCount = msg.star5TotalCount

	local diffHeroInfo = cjson.decode(msg.resJs1)

	self:_setDiffRaritySummonHeroInfo(diffHeroInfo[1])
	self:_setDiffRaritySummonShowInfo(diffHeroInfo[2])
	self:_setUpSummonHeroInfo(cjson.decode(msg.resJs2))
	self:_setAllSummonHeroInfo(cjson.decode(msg.resJs3))
end

function GMSummonModel:_setDiffRaritySummonHeroInfo(dataList)
	for index, value in pairs(dataList) do
		local star = index + 1
		local temp = string.split(value, "#")
		local num, per = temp[1], temp[2]

		table.insert(self._diffRaritySummonHeroList, {
			star = tonumber(star),
			num = num,
			per = per
		})
	end

	table.sort(self._diffRaritySummonHeroList, function(a, b)
		return a.star > b.star
	end)
end

function GMSummonModel:_setDiffRaritySummonShowInfo(dataList)
	for index, value in pairs(dataList) do
		local star = index + 1

		table.insert(self._diffRaritySummonShowList, {
			star = tonumber(star),
			num = value
		})
	end

	table.sort(self._diffRaritySummonShowList, function(a, b)
		return a.star > b.star
	end)
end

function GMSummonModel:_setUpSummonHeroInfo(data)
	local function sortFunc(a, b)
		if a.star ~= b.star then
			return a.star > b.star
		else
			return a.id > b.id
		end
	end

	self:_setHeroInfo(self._upSummonHeroList, data, sortFunc)
end

function GMSummonModel:_setAllSummonHeroInfo(data)
	local function sortFunc(a, b)
		if a.per ~= b.per then
			return a.per > b.per
		else
			return a.id > b.id
		end
	end

	self:_setHeroInfo(self._allSummonHeroList, data, sortFunc)
	logNormal()
end

function GMSummonModel:_setHeroInfo(list, data, sortFunc)
	for index, value in ipairs(data) do
		local templist = {}

		for k, v in pairs(value) do
			local star = GMSummonModel._index2Star[index]
			local temp = string.split(v, "#")
			local num, per = temp[1], temp[2]

			table.insert(templist, {
				id = tonumber(k),
				star = star,
				num = num,
				per = tonumber(per)
			})
		end

		if #templist >= 2 then
			table.sort(templist, sortFunc)
		end

		tabletool.addValues(list, templist)
	end

	if #list >= 2 then
		table.sort(list, sortFunc)
	end
end

function GMSummonModel:getTargetName(id)
	local heroConfig = HeroConfig.instance:getHeroCO(id)

	return heroConfig.name
end

function GMSummonModel:getUpHeroInfo()
	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)
	local totalResult = {}
	local otherResult = {}
	local targetResult = {}

	if not string.nilorempty(poolCo.upWeight) then
		local strArr = string.split(poolCo.upWeight, "|")

		for index, str in ipairs(strArr) do
			local idArr = string.splitToNumber(str, "#")

			tabletool.addValues(totalResult, idArr)
		end
	end

	for index, value in ipairs(self._upSummonHeroList) do
		if not tabletool.indexOf(totalResult, value.id) then
			table.insert(otherResult, value)
		else
			table.insert(targetResult, value)
		end
	end

	return targetResult, otherResult
end

GMSummonModel.instance = GMSummonModel.New()

return GMSummonModel
