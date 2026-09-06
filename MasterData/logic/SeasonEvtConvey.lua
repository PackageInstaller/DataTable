-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtConvey.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtConvey", package.seeall)

local SeasonEvtConvey = class("SeasonEvtConvey", SeasonEvtBase)

function SeasonEvtConvey:doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	self._teamId = teamId
	self._targetPointId = params.id
	self._params = params
	self._evtConfig = evtConfig
	self._evtDetailConfig = evtDetailConfig

	printInfo("............................SeasonEvtConvey:doClient")

	local linkObjIds = evtConfig.linkObjIds

	if not string.nilorempty(linkObjIds) then
		local targetElementId = string.splitToNumber(evtConfig.linkObjIds, ",")[1]
		local targetGridId = SeasonPathFindingDataModel.instance:getGridIdByElementId(targetElementId)
		local cGridX, cGridY = SeasonPathFindingDataModel.instance:id2Grid(targetGridId)
		local content = langPara("传送阵将被激活，使用后将当前小队传送到（%s,%s）处，是否使用？", cGridX, cGridY)

		TipsFacade.instance:openSeasonPopupWindow(lang("tip"), content, function()
			self:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
		end, function()
			self:rollBackPosition()
		end)
	end
end

function SeasonEvtConvey:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	self:applyDestroy()

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.eventsAnimation then
		local fromGridId = msg.targetPointId
		local toGridId = msg.curPointId
		local fromGridX, fromGridY = SeasonPathFindingDataModel.instance:id2Grid(fromGridId)
		local toGridX, toGridY = SeasonPathFindingDataModel.instance:id2Grid(toGridId)

		printInfo("SeasonEvtConvey:_doServer..........", fromGridId, toGridId)

		local teamMo = SeasonTeamsModel.instance:getTeam(msg.teamId)

		teamMo:setStartTransport(toGridId)
		scene.eventsAnimation:transmitGrid2Grid(msg.teamId, fromGridX, fromGridY, toGridX, toGridY, function()
			teamMo:clearTransport()
			scene.leaders:tryDepartTeamsPos()
		end)
	end
end

return SeasonEvtConvey
