-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonTeamLeaderTipsComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonTeamLeaderTipsComp", package.seeall)

local Act183DungeonTeamLeaderTipsComp = class("Act183DungeonTeamLeaderTipsComp", Act183DungeonBaseComp)

function Act183DungeonTeamLeaderTipsComp:init(go)
	Act183DungeonTeamLeaderTipsComp.super.init(self, go)

	self._txtleadertips = gohelper.findChildText(self.go, "txt_LeaderTips")

	SkillHelper.addHyperLinkClick(self._txtleadertips.gameObject)
end

function Act183DungeonTeamLeaderTipsComp:addEventListeners()
	return
end

function Act183DungeonTeamLeaderTipsComp:removeEventListeners()
	return
end

function Act183DungeonTeamLeaderTipsComp:checkIsVisible()
	return Act183Helper.isEpisodeHasTeamLeader(self._episodeId)
end

function Act183DungeonTeamLeaderTipsComp:show()
	Act183DungeonTeamLeaderTipsComp.super.show(self)
	self:refreshLeaderTips()
end

function Act183DungeonTeamLeaderTipsComp:refreshLeaderTips()
	local leaderSkillDesc = Act183Config.instance:getLeaderSkillDesc(self._episodeId)

	self._txtleadertips.text = SkillHelper.buildDesc(leaderSkillDesc)
end

function Act183DungeonTeamLeaderTipsComp:onDestroy()
	Act183DungeonTeamLeaderTipsComp.super.onDestroy(self)
end

return Act183DungeonTeamLeaderTipsComp
