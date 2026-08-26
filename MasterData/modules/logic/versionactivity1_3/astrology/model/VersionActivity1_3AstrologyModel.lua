-- chunkname: @modules/logic/versionactivity1_3/astrology/model/VersionActivity1_3AstrologyModel.lua

module("modules.logic.versionactivity1_3.astrology.model.VersionActivity1_3AstrologyModel", package.seeall)

local VersionActivity1_3AstrologyModel = class("VersionActivity1_3AstrologyModel", BaseModel)

function VersionActivity1_3AstrologyModel:onInit()
	self._planetList = {}
end

function VersionActivity1_3AstrologyModel:reInit()
	self._planetList = {}
	self._rewardList = nil
	self._exchangeList = nil
end

function VersionActivity1_3AstrologyModel:initData()
	local starProgress = Activity126Model.instance:getStarProgressStr()

	if string.nilorempty(starProgress) then
		starProgress = Activity126Config.instance:getConst(VersionActivity1_3Enum.ActivityId.Act310, Activity126Enum.constId.initAngle).value2
	end

	local angleList = string.splitToNumber(starProgress, "#")

	for id = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local itemId = VersionActivity1_3AstrologyEnum.PlanetItem[id]
		local num = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, itemId)

		self:_addPlanetData(id, angleList[id - 1] or 0, num)
	end
end

function VersionActivity1_3AstrologyModel:_addPlanetData(id, angle, num)
	if not self._planetList[id] then
		local mo = VersionActivity1_3AstrologyPlanetMo.New()

		self._planetList[id]:init({
			id = id,
			angle = angle,
			previewAngle = angle,
			num = num
		})

		self._planetList[id] = self._planetList[id]
	end
end

function VersionActivity1_3AstrologyModel:getQuadrantResult()
	local quadrantInfoMap = {}
	local quadrantMap = {}

	for id, v in pairs(self._planetList) do
		local quadrant = v:getQuadrant()

		if not quadrantInfoMap[quadrant] then
			local quadrantInfo = {
				minId = 100,
				num = 0,
				quadrant = quadrant,
				planetList = {}
			}

			quadrantInfo.num = quadrantInfo.num + 1

			if id < quadrantInfo.minId then
				quadrantInfo.minId = id
			end

			quadrantInfoMap[quadrant] = quadrantInfo
			quadrantMap[id] = quadrant
		end
	end

	local quadrant = quadrantMap[VersionActivity1_3AstrologyEnum.Planet.yueliang]

	if quadrant == 7 or quadrant == 8 then
		return quadrant
	end

	local list = {}

	for k, v in pairs(quadrantInfoMap) do
		table.insert(list, v)
	end

	table.sort(list, self._sortResult)

	return list[1].quadrant
end

function VersionActivity1_3AstrologyModel._sortResult(a, b)
	if a.num == b.num then
		return a.minId < b.minId
	end

	return a.num > b.num
end

function VersionActivity1_3AstrologyModel:generateStarProgressStr()
	local result

	for id = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local planet = self._planetList[id]
		local angle = planet.previewAngle

		result = string.nilorempty(result) and string.format("%s", angle) or string.format("%s#%s", result, angle)
	end

	return result
end

function VersionActivity1_3AstrologyModel:generateStarProgressCost()
	local result = {}
	local planetList = {}

	for id = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local planet = self._planetList[id]
		local costNum = planet:getCostNum()

		if costNum > 0 then
			planetList[id] = true

			for i = 1, costNum do
				table.insert(result, VersionActivity1_3AstrologyEnum.PlanetItem[id])
			end
		end
	end

	return result, planetList
end

function VersionActivity1_3AstrologyModel:getPlanetMo(id)
	return self._planetList[id]
end

function VersionActivity1_3AstrologyModel:hasAdjust()
	for k, v in pairs(self._planetList) do
		if v:hasAdjust() then
			return true
		end
	end
end

function VersionActivity1_3AstrologyModel:isEffectiveAdjust()
	local num = Activity126Model.instance:getStarNum()

	if num >= 10 then
		return false
	end

	return self:hasAdjust()
end

function VersionActivity1_3AstrologyModel:getAdjustNum()
	local num = 0

	for k, v in pairs(self._planetList) do
		num = num + v:getCostNum()
	end

	return num
end

function VersionActivity1_3AstrologyModel:setStarReward(list)
	self._rewardList = list
end

function VersionActivity1_3AstrologyModel:getStarReward()
	return self._rewardList
end

function VersionActivity1_3AstrologyModel:setExchangeList(list)
	self._exchangeList = list
end

function VersionActivity1_3AstrologyModel:getExchangeList()
	return self._exchangeList
end

VersionActivity1_3AstrologyModel.instance = VersionActivity1_3AstrologyModel.New()

return VersionActivity1_3AstrologyModel
