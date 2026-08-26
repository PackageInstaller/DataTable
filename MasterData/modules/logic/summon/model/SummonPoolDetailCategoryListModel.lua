-- chunkname: @modules/logic/summon/model/SummonPoolDetailCategoryListModel.lua

module("modules.logic.summon.model.SummonPoolDetailCategoryListModel", package.seeall)

local SummonPoolDetailCategoryListModel = class("SummonPoolDetailCategoryListModel", ListScrollModel)

function SummonPoolDetailCategoryListModel:initCategory()
	local data = {}

	for i = 1, 2 do
		table.insert(data, self:packMo(SummonPoolDetailCategoryListModel.getName(i), SummonPoolDetailCategoryListModel.getNameEn(i), i))
	end

	self:setList(data)
end

function SummonPoolDetailCategoryListModel:packMo(cnName, enName, index)
	self._moList = self._moList or {}

	local t = self._moList[index]

	if not t then
		t = {}
		self._moList[index] = t
		t.enName = enName
		t.resIndex = index
	end

	t.cnName = cnName

	return t
end

function SummonPoolDetailCategoryListModel:setJumpLuckyBag(luckyBagId)
	self._jumpLuckyBagId = luckyBagId
end

function SummonPoolDetailCategoryListModel:getJumpLuckyBag()
	return self._jumpLuckyBagId
end

function SummonPoolDetailCategoryListModel.getName(index)
	SummonPoolDetailCategoryListModel.nameDict = SummonPoolDetailCategoryListModel.nameDict or {
		[1] = "p_summon_pool_detail",
		[2] = "p_summon_pool_probability"
	}

	return luaLang(SummonPoolDetailCategoryListModel.nameDict[index])
end

function SummonPoolDetailCategoryListModel.getNameEn(index)
	SummonPoolDetailCategoryListModel.nameEnDict = SummonPoolDetailCategoryListModel.nameEnDict or {
		[1] = "p_summon_pool_detailEn",
		[2] = "p_summon_pool_probabilityEn"
	}

	return luaLang(SummonPoolDetailCategoryListModel.nameEnDict[index])
end

function SummonPoolDetailCategoryListModel.buildProbUpDict(poolId)
	local poolCo = SummonConfig.instance:getSummonPool(poolId)
	local index2Rare = {
		5,
		4
	}
	local result = {}
	local totalResult = {}
	local hasUpItem = false

	if not string.nilorempty(poolCo.upWeight) then
		local strArr = string.split(poolCo.upWeight, "|")

		for index, str in ipairs(strArr) do
			local rare = index2Rare[index]
			local idArr = string.splitToNumber(str, "#")

			result[rare] = idArr

			tabletool.addValues(totalResult, idArr)

			hasUpItem = true
		end
	end

	return result, totalResult, hasUpItem
end

function SummonPoolDetailCategoryListModel.buildLuckyBagDict(poolId)
	local poolCo = SummonConfig.instance:getSummonPool(poolId)
	local luckyBagIds = SummonConfig.instance:getSummonLuckyBag(poolId)
	local resultIds = {}
	local resultArrs = {}

	for _, luckyBagId in ipairs(luckyBagIds) do
		table.insert(resultIds, luckyBagId)
		table.insert(resultArrs, SummonConfig.instance:getLuckyBagHeroIds(poolId, luckyBagId))
	end

	return resultIds, resultArrs
end

function SummonPoolDetailCategoryListModel.buildCustomPickDict(poolId)
	local result = {}
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)

	if summonServerMO and summonServerMO.customPickMO and summonServerMO.customPickMO.pickHeroIds then
		local len = #summonServerMO.customPickMO.pickHeroIds

		for i = 1, len do
			local heroId = summonServerMO.customPickMO.pickHeroIds[i]

			table.insert(result, heroId)
		end
	end

	return result
end

SummonPoolDetailCategoryListModel.instance = SummonPoolDetailCategoryListModel.New()

return SummonPoolDetailCategoryListModel
