-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonRestartBtnComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRestartBtnComp", package.seeall)

local Act183DungeonRestartBtnComp = class("Act183DungeonRestartBtnComp", Act183DungeonBaseComp)
local RestartBtnSize_HasRerpress = {
	785,
	-425,
	340,
	104
}
local RestartBtnSize_NotRerpress = {
	697,
	-425,
	560,
	104
}

function Act183DungeonRestartBtnComp:init(go)
	Act183DungeonRestartBtnComp.super.init(self, go)

	self._btnrestart = gohelper.getClickWithDefaultAudio(self.go)
end

function Act183DungeonRestartBtnComp:addEventListeners()
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function Act183DungeonRestartBtnComp:removeEventListeners()
	self._btnrestart:RemoveClickListener()
end

function Act183DungeonRestartBtnComp:updateInfo(episodeMo)
	Act183DungeonRestartBtnComp.super.updateInfo(self, episodeMo)

	self._isCanRestart = self._groupEpisodeMo:isEpisodeCanRestart(self._episodeId)
end

function Act183DungeonRestartBtnComp:_btnrestartOnClick()
	local readyUseBadgeNum = self.mgr:getFuncValue(Act183DungeonSelectBadgeComp, "getReadyUseBadgeNum")
	local selectConditionMap = self.mgr:getFuncValue(Act183DungeonRewardRuleComp, "getSelectConditionMap")

	Act183HeroGroupController.instance:enterFight(self._episodeId, readyUseBadgeNum, selectConditionMap)
end

function Act183DungeonRestartBtnComp:checkIsVisible()
	return self._isCanRestart
end

function Act183DungeonRestartBtnComp:show()
	Act183DungeonRestartBtnComp.super.show(self)
	self:_setPosition()
end

function Act183DungeonRestartBtnComp:_setPosition()
	local isRepressBtnVisible = self.mgr:isCompVisible(Act183DungeonRepressBtnComp)

	if isRepressBtnVisible then
		if not RestartBtnSize_HasRerpress then
			local btnCo = RestartBtnSize_NotRerpress

			recthelper.setSize(self._btnrestart.transform, btnCo[3], btnCo[4])
			recthelper.setAnchor(self._btnrestart.transform, btnCo[1], btnCo[2])
		end
	end
end

function Act183DungeonRestartBtnComp:onDestroy()
	Act183DungeonRestartBtnComp.super.onDestroy(self)
end

return Act183DungeonRestartBtnComp
