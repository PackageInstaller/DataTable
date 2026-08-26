-- chunkname: @modules/logic/explore/controller/steps/ExploreBattleStep.lua

module("modules.logic.explore.controller.steps.ExploreBattleStep", package.seeall)

local ExploreBattleStep = class("ExploreBattleStep", ExploreStepBase)

function ExploreBattleStep:onStart()
	local config = ExploreConfig.instance:getMapIdConfig(ExploreModel.instance:getMapId())

	DungeonFightController.instance:enterFightByBattleId(config.chapterId, config.episodeId, self._data.battleId)
	self:onDone()
end

return ExploreBattleStep
