-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtBossDoppelganger.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtBossDoppelganger", package.seeall)

local SeasonEvtBossDoppelganger = class("SeasonEvtBossDoppelganger", SeasonEvtBase)

function SeasonEvtBossDoppelganger:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	UIStateManager.instance:push(ViewName.SeasonBossDetailView, {
		strSure = lang("挑战"),
		evtConfig = evtConfig,
		evtDetailConfig = evtDetailConfig,
		sureCallback = function()
			self:_doEnterFightPrepare()
		end
	})
	self:rollBackPosition()
end

function SeasonEvtBossDoppelganger:_doEnterFightPrepare()
	printInfo(".......................SeasonEvtBossDoppelganger:_doEnterFightPrepare")
	SeasonFmtController.instance:showFightView(self._teamId, self._evtConfig.eventType, self._evtConfig.eventId, self._evtConfig.id)
end

function SeasonEvtBossDoppelganger:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	if not string.nilorempty(msg.resultParam) then
		local resultJson = GameUtil.jsonToTable(msg.resultParam)

		if resultJson and resultJson.isWin ~= nil then
			BattleSettlementModel.instance:setRewardChangeSetId(msg.changeSetId)
			self:applyDestroy()
		end
	end
end

return SeasonEvtBossDoppelganger
