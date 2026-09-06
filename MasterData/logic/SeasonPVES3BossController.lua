-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonPVES3BossController.lua

module("logic.extensions.season.controller.SeasonPVES3BossController", package.seeall)

local SeasonPVES3BossController = class("SeasonPVES3BossController", SeasonPVEBossDefultController)

function SeasonPVES3BossController:_doAfterLogic(config)
	if self._bossPhaseId == self._bossMo.phaseId then
		local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(self:getBossReadOnlyPointId())

		SeasonOpHandler.instance:handle(SeasonGridEvtTypes.EVT_CHALLENGE, gridX, gridY)
	end

	SeasonPVES3BossController.super._doAfterLogic(self, config)
end

function SeasonPVES3BossController:_doLogicAnim(config, callback)
	local function doNext()
		GameUtil.callBack(callback)
	end

	local scene = SceneMgr.instance:getCurScene()

	if self._bossPhaseId == self._bossMo.phaseId then
		if scene and scene.eventsAnimation then
			scene.eventsAnimation:playDoppelganger2Boss(function()
				doNext()
			end)
		else
			doNext()
		end
	else
		doNext()
	end
end

SeasonPVES3BossController.instance = SeasonPVES3BossController.New()

return SeasonPVES3BossController
