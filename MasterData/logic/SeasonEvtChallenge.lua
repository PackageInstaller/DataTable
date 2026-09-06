-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtChallenge.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtChallenge", package.seeall)

local SeasonEvtChallenge = class("SeasonEvtChallenge", SeasonEvtBase)

function SeasonEvtChallenge:ctor()
	self.resultParamObj = nil
end

function SeasonEvtChallenge:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
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

			if cfg.id and SeasonConfig.instance:getOffsetLevel(cfg.id) > SeasonConfig.instance:getOffsetLevel(evtConfig.id) then
				local buffValue = SeasonConfig.instance:getCommonValue("HIGH_FIGHT_LOW_BUFF", false)
				local buff = string.split(buffValue, ":")

				hightLowBuffId = checknumber(buff[1])
			elseif cfg.id and SeasonConfig.instance:getOffsetLevel(cfg.id) < SeasonConfig.instance:getOffsetLevel(evtConfig.id) then
				local buffValue = SeasonConfig.instance:getCommonValue("LOW_FIGHT_HIGH_DEBUFF", false)
				local buff = string.split(buffValue, ":")

				hightLowBuffId = checknumber(buff[1])
			end
		end

		if evtDetailConfig.isElite == true then
			UIStateManager.instance:push(ViewName.SeasonEliteChallengeGridShowView, {
				strSure = lang("挑战"),
				hightLowFightBuffId = hightLowBuffId,
				evtConfig = evtConfig,
				evtDetailConfig = evtDetailConfig,
				teamId = teamId,
				sureCallback = function()
					self:_doEnterFightPrepare()
				end
			})
		else
			UIStateManager.instance:push(ViewName.SeasonChallengeGridShowView, {
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
	end

	self:rollBackPosition()
end

function SeasonEvtChallenge:_doEnterFightPrepare()
	printInfo(".......................SeasonEvtChallenge:_doEnterFightPrepare")
	SeasonFmtController.instance:showFightView(self._teamId, self._evtConfig.eventType, self._evtConfig.eventId, self._evtConfig.id)
end

function SeasonEvtChallenge:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	if SeasonAutoFightController.instance:isAutoFight() then
		MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
	end

	if not string.nilorempty(msg.resultParam) then
		local resultJson = GameUtil.jsonToTable(msg.resultParam)

		self.resultParamObj = resultJson

		SeasonFmtController.instance:regFightEnd(self.resultParamObj)

		if resultJson and resultJson.isWin ~= nil then
			local infos = {}
			local seasonId = SeasonModel.instance:getSeasonId()
			local fragmentId = evtDetailConfig.fragmentId
			local medalId = evtDetailConfig.medalId

			if checknumber(medalId) > 0 then
				local medalConf = SeasonMainCampConfig.instance:getBadgeConfig(seasonId, medalId)
				local mtype, id, num = MaterialMgr.getMatParams(medalConf.fakeItem)
				local info = {}

				info.materialType = mtype
				info.items = {}

				local item = {}

				item.id = id
				item.num = num

				table.insert(info.items, item)
				table.insert(infos, info)
			end

			if checknumber(fragmentId) > 0 then
				local cfg = SeasonConfig.instance:getSeasonFragmentConfig(seasonId, fragmentId)
				local mtype, id, num = MaterialMgr.getMatParams(cfg.fakeItem)
				local info = {}

				info.materialType = mtype
				info.items = {}

				local item = {}

				item.id = id
				item.num = num

				table.insert(info.items, item)
				table.insert(infos, info)
			end

			MaterialModel.instance:addChangeSetItems(msg.changeSetId, infos)
			BattleSettlementModel.instance:setRewardChangeSetId(msg.changeSetId)
			self:applyDestroy()
		end
	end
end

return SeasonEvtChallenge
