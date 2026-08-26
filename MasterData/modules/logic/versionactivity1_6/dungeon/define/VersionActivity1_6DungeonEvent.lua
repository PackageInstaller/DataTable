-- chunkname: @modules/logic/versionactivity1_6/dungeon/define/VersionActivity1_6DungeonEvent.lua

module("modules.logic.versionactivity1_6.dungeon.define.VersionActivity1_6DungeonEvent", package.seeall)

local VersionActivity1_6DungeonEvent = _M

VersionActivity1_6DungeonEvent.OnMapPosChanged = 10
VersionActivity1_6DungeonEvent.OnClickElement = 11
VersionActivity1_6DungeonEvent.OnHideInteractUI = 12
VersionActivity1_6DungeonEvent.FocusElement = 13
VersionActivity1_6DungeonEvent.OnAddOneElement = 14
VersionActivity1_6DungeonEvent.OnRemoveElement = 15
VersionActivity1_6DungeonEvent.OnRecycleAllElement = 16
VersionActivity1_6DungeonEvent.DungeonBossFightScoreChange = 21
VersionActivity1_6DungeonEvent.DungeonBossInfoUpdated = 22
VersionActivity1_6DungeonEvent.DungeonBossOrder = 23
VersionActivity1_6DungeonEvent.SkillPointReturnBack = 31
VersionActivity1_6DungeonEvent.SetSkillBtnActive = 901
VersionActivity1_6DungeonEvent.SetBossBtnActive = 902

return VersionActivity1_6DungeonEvent
