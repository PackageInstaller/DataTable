-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonPVES1BossController.lua

module("logic.extensions.season.controller.SeasonPVES1BossController", package.seeall)

local SeasonPVES1BossController = class("SeasonPVES1BossController", SeasonPVEBossDefultController)

function SeasonPVES1BossController:_doAfterLogic(config)
	if self._bossPhaseId == self._bossMo.phaseId then
		local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(self:getBossReadOnlyPointId())

		SeasonOpHandler.instance:handle(SeasonGridEvtTypes.EVT_CHALLENGE, gridX, gridY)
	end

	SeasonPVES1BossController.super._doAfterLogic(self, config)
end

SeasonPVES1BossController.instance = SeasonPVES1BossController.New()

return SeasonPVES1BossController
