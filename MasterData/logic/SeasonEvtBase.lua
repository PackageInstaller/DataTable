-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/SeasonEvtBase.lua

module("logic.extensions.season.model.evt.SeasonEvtBase", package.seeall)

local SeasonEvtBase = class("SeasonEvtBase")

function SeasonEvtBase:ctor()
	return
end

function SeasonEvtBase:reset()
	self._teamId = nil
	self._targetPointId = nil
end

function SeasonEvtBase:doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	self._teamId = teamId
	self._targetPointId = params.id
	self._params = params
	self._evtConfig = evtConfig
	self._evtDetailConfig = evtDetailConfig

	printInfo("............................SeasonEvtBase:doClient")
	self:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
end

function SeasonEvtBase:doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	printInfo("............................SeasonEvtBase:doServer")
	self:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
end

function SeasonEvtBase:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	self:applySendHandlerEvent()
end

function SeasonEvtBase:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	self:applyDestroy()
end

function SeasonEvtBase:applySendHandlerEvent(params)
	local teamId = self._teamId
	local jsonStr = ""
	local form

	if params then
		form = params.form
		params.form = nil

		local teamIndex = params.teamIndex

		params.teamIndex = nil

		if teamIndex ~= nil then
			local teams = SeasonTeamsModel.instance:getTeams()
			local teamMo = teams[teamIndex]

			if teamMo then
				teamId = teamMo.teamId
			end
		end

		jsonStr = GameUtil.jsonToString(params)
	end

	teamId = teamId or self._teamId

	SeasonModePveAgent.instance:sendPM_SMPVEHandleEventReq(teamId, self._targetPointId, jsonStr, form)
end

function SeasonEvtBase:onServerFail()
	SeasonController.instance:reqSingleMapInfo({
		self._targetPointId
	})
end

function SeasonEvtBase:applyDestroy()
	SeasonEvtHandler.instance:removeImpl(self._targetPointId)
	self:dispose()
end

function SeasonEvtBase:dispose()
	return
end

function SeasonEvtBase:showPrize(msg)
	if msg.changeSetId then
		MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
	end
end

function SeasonEvtBase:rollBackPosition()
	SeasonEvtHandler.instance:rollBackPosition(self._teamId)
end

return SeasonEvtBase
