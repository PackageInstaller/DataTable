-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/model/TowerV3a7Model.lua

module("modules.logic.versionactivity3_7.towerv3a7.model.TowerV3a7Model", package.seeall)

local TowerV3a7Model = class("TowerV3a7Model", BaseModel)

function TowerV3a7Model:onInit()
	self:reInit()
end

function TowerV3a7Model:reInit()
	self._elementId = nil
	self._mapConfig = nil
	self._chessList = nil
	self._storyList = nil
	self._pause = false
	self._pauseInteraction = false
	self._time = 0
	self._delayExecuteList = {}
	self._win = false
end

function TowerV3a7Model:inFirstMap()
	return self._mapConfig and self._mapConfig.id == TowerV3a7Enum.FirstMapId
end

function TowerV3a7Model:updateTime()
	if self._pause then
		return
	end

	self._time = self._time + Time.deltaTime

	TowerV3a7ChessManModel.instance:update()

	if not self._pause and #self._delayExecuteList > 0 then
		local func = table.remove(self._delayExecuteList, 1)

		if func then
			func()
		end
	end
end

function TowerV3a7Model:addDelayExecute(func)
	table.insert(self._delayExecuteList, func)
end

function TowerV3a7Model:setWin(value)
	self._win = value
end

function TowerV3a7Model:getWin()
	return self._win
end

function TowerV3a7Model:setPause(value)
	self._pause = value
end

function TowerV3a7Model:getPause()
	return self._pause
end

function TowerV3a7Model:pauseInteraction(value)
	self._pauseInteraction = value
end

function TowerV3a7Model:getPauseInteraction()
	return self._pauseInteraction
end

function TowerV3a7Model:getTime()
	return self._time
end

function TowerV3a7Model:initMapParams(elementId, mapConfig)
	self._elementId = elementId
	self._mapConfig = mapConfig
	self._time = 0
	self._pause = false
	self._pauseInteraction = false
	self._delayExecuteList = {}
	self._win = false

	if not self._mapConfig then
		return
	end

	TowerV3a7RoomModel.instance:initRoom(self._mapConfig.map)

	local chessList = TowerV3a7Config.instance:getChessByMapId(self._mapConfig.id)

	TowerV3a7ChessManModel.instance:initChess(chessList)

	local storyList = string.splitToNumber(self._mapConfig.story, "#")

	self._storyList = {}

	for i, id in ipairs(storyList) do
		if id ~= TowerV3a7Enum.ManualTriggerStoryId then
			local storyConfig, triggerParams = TowerV3a7Config.getStoryConfig(id)

			if storyConfig and triggerParams then
				table.insert(self._storyList, {
					id = id,
					storyConfig = storyConfig,
					triggerParams = triggerParams
				})
			end
		end
	end

	self._finishTargetParams = string.splitToNumber(self._mapConfig.quest, "#")
end

function TowerV3a7Model:getElementId()
	return self._elementId
end

function TowerV3a7Model:getMapConfig()
	return self._mapConfig
end

function TowerV3a7Model:getStoryList()
	return self._storyList
end

function TowerV3a7Model:getFinishTargetParams()
	return self._finishTargetParams
end

TowerV3a7Model.instance = TowerV3a7Model.New()

return TowerV3a7Model
