-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonLockBtnComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonLockBtnComp", package.seeall)

local Act183DungeonLockBtnComp = class("Act183DungeonLockBtnComp", Act183DungeonBaseComp)

function Act183DungeonLockBtnComp:init(go)
	Act183DungeonLockBtnComp.super.init(self, go)
end

function Act183DungeonLockBtnComp:addEventListeners()
	return
end

function Act183DungeonLockBtnComp:removeEventListeners()
	return
end

function Act183DungeonLockBtnComp:checkIsVisible()
	return self._status == Act183Enum.EpisodeStatus.Locked
end

function Act183DungeonLockBtnComp:show()
	Act183DungeonLockBtnComp.super.show(self)
end

function Act183DungeonLockBtnComp:onDestroy()
	Act183DungeonLockBtnComp.super.onDestroy(self)
end

return Act183DungeonLockBtnComp
