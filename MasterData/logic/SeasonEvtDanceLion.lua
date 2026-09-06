-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtDanceLion.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtDanceLion", package.seeall)

local SeasonEvtDanceLion = class("SeasonEvtDanceLion", SeasonEvtBase)

function SeasonEvtDanceLion:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	self:rollBackPosition()

	local mapMo = SeasonModel.instance:getMapInfoById(params.id)
	local array = mapMo:getLionUnlockArray()

	array = SeasonOpHandler.instance:getOnALineObjects(params.id, array, mapMo:getRotateDir())

	if #array > 0 then
		self._fogObj = {
			array[1]
		}

		local obj = {}

		obj.fogObj = self._fogObj

		self:applySendHandlerEvent(obj)
	else
		self:applyDestroy()
	end
end

function SeasonEvtDanceLion:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	self:applyDestroy()

	if msg ~= nil then
		local scene = SceneMgr.instance:getCurScene()
		local fromGridId = msg.targetPointId
		local toGridId = self._fogObj[1]
		local mapMo = SeasonModel.instance:getMapInfoById(fromGridId)
		local paramsJson = GameUtil.jsonToTable(msg.param)

		if paramsJson and paramsJson.fogObj then
			if not paramsJson.fogObj then
				do
					local fogObj = {}

					for i, toGridId in ipairs(fogObj) do
						mapMo:addDanceLionState(toGridId)
					end
				end

				if scene and scene.eventsAnimation then
					local fromGridX, fromGridY = SeasonPathFindingDataModel.instance:id2Grid(fromGridId)
					local toGridX, toGridY = SeasonPathFindingDataModel.instance:id2Grid(toGridId)

					scene.eventsAnimation:playLaunchFire(fromGridX, fromGridY, toGridX, toGridY, function()
						return
					end)
				end
			end
		end
	end
end

return SeasonEvtDanceLion
