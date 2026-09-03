-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/CommonStageMap.lua

require("dm.gameplay.stage.model.CommonStagePoint")
require("dm.gameplay.stage.model.StageMap")

CommonStageMap = class("CommonStageMap", StageMap, _M)

function CommonStageMap:initialize(mapId)
	super.initialize(self, mapId)
end

function CommonStageMap:sync(mapData)
	if mapData then
		if not mapData.points then
			local mapPointData = {}
			local config = self:_getConfig()

			if self._index2Points == nil then
				self._index2Points = {}
				self._id2Points = {}

				local pointIds = config.SubPoint
				local pointCount = #pointIds

				for index = 1, pointCount do
					local pointId = pointIds[index]
					local point = CommonStagePoint:new(pointId)

					point:setIndex(index)
					point:setOwner(self)

					local pointData = mapPointData[pointId]

					if pointData then
						if pointData.stars and next(pointData.stars) ~= nil then
							pointData.isPass = true
						end

						point:sync(pointData)
					end

					self._index2Points[index] = point
					self._id2Points[pointId] = point
				end

				self:setPointCount(pointCount)
			else
				for pointId, pointData in pairs(mapPointData) do
					local point = self._id2Points[pointId]

					if pointData.stars and next(pointData.stars) ~= nil then
						pointData.isPass = true
					end

					point:sync(pointData)
				end
			end

			self:initStoryPointMap()
			self:initPracticePointMap()

			for k, v in pairs(self._id2PracticePoint) do
				local prePointId = ConfigReader:getDataByNameIdAndKey("BlockPracticePoint", v:getId(), "PrePoint")
				local index

				for i, point in ipairs(self._index2Points) do
					if point:getId() == prePointId then
						index = i + 1

						break
					end
				end

				local _point = self._index2Points[index]

				if _point then
					_point:setPrePracPoint(v:getId())
				end
			end

			if mapData then
				if not mapData.starRewards then
					local mapBoxData = {}

					if self._mapBoxData and mapBoxData then
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
	end
end

function CommonStageMap:isPass()
	local points = self._index2Points
	local finalPoint = points[#points]
	local storyPoints = self._index2StoryPoint

	if storyPoints and #storyPoints > 0 then
		local finalStoryPoint = storyPoints[#storyPoints]

		return finalPoint:isPass() and finalStoryPoint:isPass()
	end

	return finalPoint:isPass()
end

function CommonStageMap:isBattlePointPass()
	local points = self._index2Points
	local finalPoint = points[#points]

	return finalPoint:isPass()
end
