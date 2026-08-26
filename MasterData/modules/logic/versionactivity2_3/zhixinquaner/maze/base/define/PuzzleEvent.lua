-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/base/define/PuzzleEvent.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.define.PuzzleEvent", package.seeall)

local PuzzleEvent = _M
local _uid = 1

local function E(name)
	assert(PuzzleEvent[name] == nil, "[PuzzleEvent] error redefined RougeEvent." .. name)

	PuzzleEvent[name] = _uid
	_uid = _uid + 1
end

E("InitGameDone")
E("OnBeginDragPawn")
E("OnEndDragPawn")
E("SimulatePlane")
E("SwitchLineState")
E("RecyclePlane")
E("OnGameFinished")
E("OnStartDialog")
E("OnFinishDialog")
E("GuideStart")
E("OnSimulatePlaneDone")
E("OnTriggerEffectDone")
E("EnableTriggerEffect")

return PuzzleEvent
