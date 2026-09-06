-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtMaterial.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtMaterial", package.seeall)

local SeasonEvtMaterial = class("SeasonEvtMaterial", SeasonEvtBase)

function SeasonEvtMaterial:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	self:showPrize(msg)

	local strengthPrize = checknumber(evtDetailConfig.strengthPrize)

	if strengthPrize and strengthPrize > 0 then
		FloatWordMgr.instance:show(langPara("获得%s体力", strengthPrize))
	end

	SeasonEvtMaterial.super._doServer(self, evtType, params, evtConfig, evtDetailConfig, msg)
end

return SeasonEvtMaterial
