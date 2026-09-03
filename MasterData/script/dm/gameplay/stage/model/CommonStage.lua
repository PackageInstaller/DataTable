-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/CommonStage.lua

require("dm.gameplay.stage.model.Stage")
require("dm.gameplay.stage.model.CommonStageMap")

CommonStage = class("CommonStage", Stage, _M)

function CommonStage:initialize()
	super.initialize(self)

	self._systemName = "Normal_Stage"
	self._initMapUnlockState = false
	self._BattlePointStateTab = {}
	self._StoryPointStateTab = {}
end

function CommonStage:sync(data)
	local stageMaps = {}

	if data and data.stageMaps then
		stageMaps = data.stageMaps
	end

	if self._index2Maps == nil then
		self._index2Maps = {}
		self._id2Maps = {}

		local mapIds = ConfigReader:getDataByNameIdAndKey("ConfigValue", self:getMapListKey(), "content")
		local mapCount = #mapIds

		for index = 1, mapCount do
			local mapId = mapIds[index]
			local map = CommonStageMap:new(mapId)

			map:setIndex(index)
			map:setOwner(self)
			map:sync(stageMaps[mapId] or {})

			self._index2Maps[index] = map
			self._id2Maps[mapId] = map
		end

		self:setMapCount(mapCount)
	else
		for mapId, mapData in pairs(stageMaps) do
			local map = self._id2Maps[mapId]

			if map == nil then
				assert(false, "MainStage:sync: mapId unexist : " .. mapId)
			end

			map:sync(mapData)
		end
	end

	if not self._initMapUnlockState then
		self:setUnlockMapIndex(self:getMapCount())
		self:setNewOpenMapIndex(self:getMapCount())

		for index, map in ipairs(self._index2Maps) do
			if not map:isUnlock() then
				self:setUnlockMapIndex(index - 1)
				self:setNewOpenMapIndex(index - 1)

				break
			end
		end

		self:bindPointPassState(2, "M02S01")
		self:bindPointPassState(2, "S02S02")
		self:bindPointPassState(3, "M03S02")
		self:bindPointPassState(3, "M03S04")

		self._initMapUnlockState = true
	else
		self:checkBindPointState()
	end
end

function CommonStage:bindPointPassState(mapIndex, pointId)
	local map = self._index2Maps[mapIndex]
	local point = map:getPointById(pointId)

	if point and not point:isPass() then
		self._BattlePointStateTab[pointId] = {
			point = point,
			isPass = point:isPass()
		}

		return
	end

	point = map:getStoryPointById(pointId)

	if point and not point:isPass() then
		self._StoryPointStateTab[pointId] = {
			point = point,
			isPass = point:isPass()
		}

		return
	end
end

function CommonStage:checkBindPointState()
	for k, v in pairs(self._BattlePointStateTab) do
		local point = v.point
		local oldPassTag = v.isPass

		if not oldPassTag and point:isPass() then
			v.isPass = point:isPass()

			self:submitEvent(k)
		end
	end
end

function CommonStage:checkBindStoryPointState()
	for k, v in pairs(self._StoryPointStateTab) do
		local point = v.point
		local oldPassTag = v.isPass

		if not oldPassTag and point:isPass() then
			v.isPass = point:isPass()

			self:submitEvent(k)
		end
	end
end

function CommonStage:submitEvent(pointId)
	local dispatcher = DmGame:getInstance()

	dispatcher:dispatch(Event:new(EVT_POINT_FIRSTPASS, {
		pointId = pointId
	}))
end

function CommonStage:getMapConfigName()
	return "BlockMap"
end

function CommonStage:getPointConfigName()
	return "BlockPoint"
end

function CommonStage:getMapListKey()
	return "Block_MapList"
end
