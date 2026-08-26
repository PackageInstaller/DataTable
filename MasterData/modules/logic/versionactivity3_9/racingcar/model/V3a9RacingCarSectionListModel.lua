-- chunkname: @modules/logic/versionactivity3_9/racingcar/model/V3a9RacingCarSectionListModel.lua

module("modules.logic.versionactivity3_9.racingcar.model.V3a9RacingCarSectionListModel", package.seeall)

local V3a9RacingCarSectionListModel = class("V3a9RacingCarSectionListModel", ListScrollModel)

function V3a9RacingCarSectionListModel:reInit()
	V3a9RacingCarSectionListModel.super.reInit(self)

	self._selectedCellIndex = nil
end

function V3a9RacingCarSectionListModel:initList()
	local moList = {}
	local index = 1
	local actId = V3a9RacingCarModel.instance:getActId()

	for i, co in ipairs(lua_243_episode.configList) do
		if actId == co.activityId then
			table.insert(moList, {
				index = i,
				config = co
			})

			if V3a9RacingCarEpisodeModel.instance:getEpisodeInfo(co.episodeId) then
				index = i
			end
		end
	end

	self:setList(moList)
	self:setSelectedCell(index)
end

function V3a9RacingCarSectionListModel:setSelectedCell(index)
	self._selectedCellIndex = index

	if not index then
		logError("V3a9RacingCarSectionListModel:setSelectedCell index nil")

		return
	end

	self:selectCell(index, true)
	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnSelectRacingLevel)
end

function V3a9RacingCarSectionListModel:getSelectedConfig()
	local mo = self:getByIndex(self._selectedCellIndex)

	return mo and mo.config
end

function V3a9RacingCarSectionListModel:getSelectedConfigIndex()
	local mo = self:getByIndex(self._selectedCellIndex)

	return mo and mo.index
end

V3a9RacingCarSectionListModel.instance = V3a9RacingCarSectionListModel.New()

return V3a9RacingCarSectionListModel
