-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonStartBtnComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonStartBtnComp", package.seeall)

local Act183DungeonStartBtnComp = class("Act183DungeonStartBtnComp", Act183DungeonBaseComp)

function Act183DungeonStartBtnComp:init(go)
	Act183DungeonStartBtnComp.super.init(self, go)

	self._btnstart = gohelper.getClickWithDefaultAudio(self.go)
end

function Act183DungeonStartBtnComp:addEventListeners()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function Act183DungeonStartBtnComp:removeEventListeners()
	self._btnstart:RemoveClickListener()
end

function Act183DungeonStartBtnComp:_btnstartOnClick()
	if self._episodeType == Act183Enum.EpisodeType.Boss then
		local isAnyNotFinished = self._groupEpisodeMo:isAnySubEpisodeNotFinished()

		if isAnyNotFinished then
			local isDailyGroup = self._groupType == Act183Enum.GroupType.Daily

			if isDailyGroup then
				if not MessageBoxIdDefine.Act183FightDailyBossEpisode then
					local msgBoxId = MessageBoxIdDefine.Act183FightMainBossEpisode

					GameFacade.showMessageBox(msgBoxId, MsgBoxEnum.BoxType.Yes_No, self.enterBossFightIfSubNotFinish, nil, nil, self)

					return
				end
			end
		end
	end

	self:enterFight()
end

function Act183DungeonStartBtnComp:enterFight()
	local readyUseBadgeNum = self.mgr:getFuncValue(Act183DungeonSelectBadgeComp, "getReadyUseBadgeNum")
	local selectConditionMap = self.mgr:getFuncValue(Act183DungeonRewardRuleComp, "getSelectConditionMap")

	Act183HeroGroupController.instance:enterFight(self._episodeId, readyUseBadgeNum, selectConditionMap)
end

function Act183DungeonStartBtnComp:enterBossFightIfSubNotFinish()
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnPlayEffectDoneIfSubUnfinish, self._onPlayEffectDoneIfSubUnfinish, self)
	Act183Controller.instance:dispatchEvent(Act183Event.FightBossIfSubUnfinish, self._episodeId)
end

function Act183DungeonStartBtnComp:_onPlayEffectDoneIfSubUnfinish(episodeId)
	if self._episodeId ~= episodeId then
		return
	end

	self:enterFight()
	self.removeEventCb(self, Act183Controller.instance, Act183Event.OnPlayEffectDoneIfSubUnfinish, self._onPlayEffectDoneIfSubUnfinish, self)
end

function Act183DungeonStartBtnComp:checkIsVisible()
	return self._status == Act183Enum.EpisodeStatus.Unlocked
end

function Act183DungeonStartBtnComp:show()
	Act183DungeonStartBtnComp.super.show(self)
end

function Act183DungeonStartBtnComp:onDestroy()
	Act183DungeonStartBtnComp.super.onDestroy(self)
end

return Act183DungeonStartBtnComp
