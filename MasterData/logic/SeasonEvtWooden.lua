-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtWooden.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtWooden", package.seeall)

local SeasonEvtWooden = class("SeasonEvtWooden", SeasonEvtBase)

function SeasonEvtWooden:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	UIStateManager.instance:push(ViewName.SeasonWoodenGridShowView, {
		strSure = lang("挑战"),
		evtDetailConfig = evtDetailConfig,
		evtConfig = evtConfig,
		teamId = teamId,
		strDesc = evtDetailConfig.desc,
		sureCallback = function()
			self:_doEnterFightPrepare()
		end
	})
	self:rollBackPosition()
end

function SeasonEvtWooden:_doEnterFightPrepare()
	printInfo(".......................SeasonEvtWooden:_doEnterFightPrepare")
	SeasonFmtController.instance:showFightView(self._teamId, self._evtConfig.eventType, self._evtConfig.eventId, self._evtConfig.id)
end

function SeasonEvtWooden:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	if not string.nilorempty(msg.resultParam) then
		local resultJson = GameUtil.jsonToTable(msg.resultParam)

		if resultJson and resultJson.cur_damage ~= nil then
			local battleParams = {}

			battleParams.damage = checknumber(resultJson.cur_damage)

			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
			BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.GodARuiShi, battleParams)
			self:applyDestroy()
		end
	end
end

return SeasonEvtWooden
