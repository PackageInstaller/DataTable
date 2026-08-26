-- chunkname: @modules/logic/dungeon/defines/DungeonJumpGameEvent.lua

module("modules.logic.dungeon.defines.DungeonJumpGameEvent", package.seeall)

local DungeonJumpGameEvent = _M
local _get = GameUtil.getUniqueTb()

DungeonJumpGameEvent.AutoJumpOnMaxDistance = _get()
DungeonJumpGameEvent.JumpGameReStart = _get()
DungeonJumpGameEvent.JumpGameLongPressGuide = _get()
DungeonJumpGameEvent.JumpGameGuideCompleted = _get()
DungeonJumpGameEvent.JumpGameEnter = _get()
DungeonJumpGameEvent.JumpGameCompleted = _get()
DungeonJumpGameEvent.JumpGameArriveNode = _get()
DungeonJumpGameEvent.JumpGameExit = _get()
