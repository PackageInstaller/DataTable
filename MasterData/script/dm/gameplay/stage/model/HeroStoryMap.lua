-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/HeroStoryMap.lua

require("dm.gameplay.stage.model.HeroStoryPoint")

HeroStoryMap = class("HeroStoryMap")

HeroStoryMap:has("_mapId", {
	is = "rw"
})
HeroStoryMap:has("_pointCount", {
	is = "rw"
})

function HeroStoryMap:initialize(mapId)
	self._mapId = mapId
	self._config = ConfigReader:getRecordById("HeroStoryMap", mapId)
	self._idToPoints = nil
	self._indexToPoints = nil
	self._pointCount = 0

	self:initMapBoxData()
end

function HeroStoryMap:sync(data)
	if not data.levels then
		local pointsData = {}

		if self._idToPoints == nil then
			self._indexToPoints = {}
			self._idToPoints = {}

			local subPoint = self._config.SubPoint

			for i = 1, #subPoint do
				local pointId = subPoint[i]
				local point = HeroStoryPoint:new(pointId)

				point:setIndex(i)
				point:setOwner(self)

				local pointData = pointsData[pointId]

				if pointData then
					if pointData.star and next(pointData.star) ~= nil then
						pointData.isPass = true
					end

					point:sync(pointData)
				end

				self._indexToPoints[i] = point
				self._idToPoints[pointId] = point
			end

			self:setPointCount(#subPoint)
		else
			for pointId, pointData in pairs(pointsData) do
				local point = self._idToPoints[pointId]

				if pointData.star and next(pointData.star) ~= nil then
					pointData.isPass = true
				end

				point:sync(pointData)
			end
		end

		if not data.starRewards then
			local mapBoxData = {}

			if self._mapBoxData then
				local revertBoxData = {}

				for _, starCount in pairs(mapBoxData) do
					revertBoxData[starCount] = true
				end

				local currentStarCount = self:getCurrentStarCount()

				for _, boxData in pairs(self._mapBoxData) do
					if revertBoxData[boxData.stars] then
						boxData.lastState = boxData.boxState
						boxData.boxState = StageBoxState.kHasReceived
					elseif boxData.boxState ~= StageBoxState.kHasReceived then
						if currentStarCount >= boxData.stars then
							boxData.lastState = boxData.boxState
							boxData.boxState = StageBoxState.kCanReceive
						else
							boxData.lastState = boxData.boxState
							boxData.boxState = StageBoxState.kCannotReceive
						end
					end
				end
			end
		end
	end
end

function HeroStoryMap:initMapBoxData()
	local mapBoxConfig = self._config.StarBoxReward

	if mapBoxConfig and mapBoxConfig ~= "" then
		self._mapBoxData = {}

		for key, value in pairs(mapBoxConfig) do
			local stars = tonumber(key)
			local rewardId = value

			self._mapBoxData[#self._mapBoxData + 1] = {
				stars = stars,
				rewardId = rewardId
			}
		end

		table.sort(self._mapBoxData, function(a, b)
			return a.stars < b.stars
		end)
	end
end

function HeroStoryMap:getCurrentStarCount()
	local currentStarCount = 0

	for _, point in ipairs(self._indexToPoints) do
		currentStarCount = currentStarCount + point:getStarCount()
	end

	return currentStarCount
end

function HeroStoryMap:getMapBoxState(stars)
	local mapBoxData = self._mapBoxData

	if not mapBoxData then
		return
	end

	for _, boxData in pairs(mapBoxData) do
		if boxData.stars == stars then
			return boxData.boxState
		end
	end
end

function HeroStoryMap:setMapBoxReceived(stars)
	local mapBoxData = self._mapBoxData

	if not mapBoxData then
		return
	end

	for _, boxData in pairs(mapBoxData) do
		if boxData.stars == stars then
			boxData.boxState = StageBoxState.kHasReceived

			return
		end
	end
end

function HeroStoryMap:getHeroStoryPointById(pointId)
	return self._idToPoints[pointId]
end

function HeroStoryMap:getBackground()
	return self._config.Background
end

function HeroStoryMap:getBGM()
	return self._config.BGM
end
