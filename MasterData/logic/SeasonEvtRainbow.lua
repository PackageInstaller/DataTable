-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtRainbow.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtRainbow", package.seeall)

local SeasonEvtRainbow = class("SeasonEvtRainbow", SeasonEvtBase)

function SeasonEvtRainbow:doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	self._teamId = teamId
	self._targetPointId = params.id
	self._params = params
	self._evtConfig = evtConfig
	self._evtDetailConfig = evtDetailConfig

	printInfo("............................SeasonEvtRainbow:doClient")

	local linkObjIds = evtConfig.linkObjIds

	if not string.nilorempty(linkObjIds) then
		local targetElementId = string.splitToNumber(evtConfig.linkObjIds, ",")[1]
		local targetGridId = SeasonPathFindingDataModel.instance:getGridIdByElementId(targetElementId)
		local cGridX, cGridY = SeasonPathFindingDataModel.instance:id2Grid(targetGridId)
		local content = langPara("彩虹桥已被激活，使用后将当前小队传送到（%s,%s）处，是否使用？", cGridX, cGridY)

		TipsFacade.instance:openSeasonPopupWindow(lang("tip"), content, function()
			self:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
		end, function()
			self:rollBackPosition()
		end)
	end
end

function SeasonEvtRainbow:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	self:applyDestroy()

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.eventsAnimation then
		local controller = SeasonPathFindingDataModel.instance
		local fromGridId = msg.targetPointId
		local toGridId = msg.curPointId
		local fromGridX, fromGridY = controller:id2Grid(fromGridId)
		local toGridX, toGridY = controller:id2Grid(toGridId)

		printInfo("SeasonEvtRainbow:_doServer..........", fromGridId, toGridId)

		local teamMo = SeasonTeamsModel.instance:getTeam(msg.teamId)

		teamMo:setStartTransport(toGridId)
		scene.eventsAnimation:playRainbowAnim(msg.teamId, fromGridX, fromGridY, toGridX, toGridY, function()
			teamMo:clearTransport()
			scene.leaders:tryDepartTeamsPos()
		end)
	end
end

return SeasonEvtRainbow
