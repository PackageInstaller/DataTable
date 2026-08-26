-- chunkname: @modules/logic/versionactivity3_5/puzzle/controller/V3a5PuzzleEvent.lua

module("modules.logic.versionactivity3_5.puzzle.controller.V3a5PuzzleEvent", package.seeall)

local V3a5PuzzleEvent = _M
local _get = GameUtil.getUniqueTb()

V3a5PuzzleEvent.onStartDialog = _get()
V3a5PuzzleEvent.onFinishDialog = _get()

return V3a5PuzzleEvent
