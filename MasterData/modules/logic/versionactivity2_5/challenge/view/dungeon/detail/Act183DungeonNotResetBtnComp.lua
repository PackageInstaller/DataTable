-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonNotResetBtnComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonNotResetBtnComp", package.seeall)

local Act183DungeonNotResetBtnComp = class("Act183DungeonNotResetBtnComp", Act183DungeonBaseComp)

function Act183DungeonNotResetBtnComp:updateInfo(episodeMo)
	Act183DungeonNotResetBtnComp.super.updateInfo(self, episodeMo)

	self._isSimulate = self._episodeMo:isSimulate()
end

function Act183DungeonNotResetBtnComp:checkIsVisible()
	return self._isSimulate and self._episodeType ~= Act183Enum.EpisodeType.Boss
end

return Act183DungeonNotResetBtnComp
