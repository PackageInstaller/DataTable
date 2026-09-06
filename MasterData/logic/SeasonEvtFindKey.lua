-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtFindKey.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtFindKey", package.seeall)

local SeasonEvtFindKey = class("SeasonEvtFindKey", SeasonEvtBase)

function SeasonEvtFindKey:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		self:showPrize(msg)
	end

	SeasonModePvePlusAgent.instance:sendPM_SMPVEFindKeyInfoReq()
	SeasonEvtFindKey.super._doServer(self, evtType, params, evtConfig, evtDetailConfig, msg)
end

return SeasonEvtFindKey
