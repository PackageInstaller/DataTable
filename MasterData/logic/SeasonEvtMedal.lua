-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtMedal.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtMedal", package.seeall)

local SeasonEvtMedal = class("SeasonEvtMedal", SeasonEvtBase)

function SeasonEvtMedal:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	self:applyDestroy()
	UIStateManager.instance:push(ViewName.SeasonMedalGridShowView, {
		zoomTargetName = "btnBadge",
		strTitle = langPara("徽章地块(%s,%s)", params.toGridX, params.toGridY),
		strSure = lang("confirm"),
		evtDetailConfig = evtDetailConfig,
		evtConfig = evtConfig,
		sureCallback = function()
			self:showPrize(msg)
		end
	})
end

return SeasonEvtMedal
