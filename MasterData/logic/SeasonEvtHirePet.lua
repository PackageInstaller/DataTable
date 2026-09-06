-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtHirePet.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtHirePet", package.seeall)

local SeasonEvtHirePet = class("SeasonEvtHirePet", SeasonEvtBase)

function SeasonEvtHirePet:ctor()
	self.resultParamObj = nil
end

function SeasonEvtHirePet:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	local boo = SeasonAutoFightController.instance:isAutoFight()

	if boo then
		SeasonAutoFightController.instance:setNextTargetId(self._teamId, params.toGridX, params.toGridY)
		SeasonFmtController.instance:sendFightRightNow(self._teamId, self._evtConfig.eventType, self._evtConfig.eventId, self._evtConfig.id)
	else
		local hightLowBuffId = 0
		local teamMo = SeasonTeamsModel.instance:getTeam(self._teamId)

		if teamMo and teamMo.clientLastGridId then
			local seasonId = SeasonModel.instance:getSeasonId()
			local cfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, teamMo.clientLastGridId) or {}

			if SeasonConfig.instance:getOffsetLevel(cfg.id) > SeasonConfig.instance:getOffsetLevel(evtConfig.id) then
				hightLowBuffId = SeasonConfig.instance:getCommonValue("HIGH_FIGHT_LOW_BUFF")
			elseif SeasonConfig.instance:getOffsetLevel(cfg.id) < SeasonConfig.instance:getOffsetLevel(evtConfig.id) then
				hightLowBuffId = SeasonConfig.instance:getCommonValue("LOW_FIGHT_HIGH_DEBUFF")
			end
		end

		UIStateManager.instance:push(ViewName.SeasonHirePetGridShowView, {
			strSure = lang("挑战"),
			hightLowFightBuffId = hightLowBuffId,
			evtConfig = evtConfig,
			evtDetailConfig = evtDetailConfig,
			teamId = teamId,
			sureCallback = function()
				self:_doEnterFightPrepare()
			end
		})
	end

	self:rollBackPosition()
end

function SeasonEvtHirePet:_doEnterFightPrepare()
	printInfo(".......................SeasonEvtHirePet:_doEnterFightPrepare")
	SeasonFmtController.instance:showFightView(self._teamId, self._evtConfig.eventType, self._evtConfig.eventId, self._evtConfig.id)
end

function SeasonEvtHirePet:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	if SeasonAutoFightController.instance:isAutoFight() then
		MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
	end

	if not string.nilorempty(msg.resultParam) then
		local resultJson = GameUtil.jsonToTable(msg.resultParam)

		self.resultParamObj = resultJson

		SeasonFmtController.instance:regFightEnd(self.resultParamObj)

		if resultJson and resultJson.isWin ~= nil then
			BattleSettlementModel.instance:setRewardChangeSetId(msg.changeSetId)
			self:applyDestroy()
		end
	end
end

return SeasonEvtHirePet
