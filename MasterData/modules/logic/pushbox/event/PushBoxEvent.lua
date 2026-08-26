-- chunkname: @modules/logic/pushbox/event/PushBoxEvent.lua

module("modules.logic.pushbox.event.PushBoxEvent", package.seeall)

local PushBoxEvent = _M

PushBoxEvent.Move = 1
PushBoxEvent.StepFinished = 2
PushBoxEvent.RevertStep = 3
PushBoxEvent.StartElement = 4
PushBoxEvent.RefreshElement = 5
PushBoxEvent.RefreshWarningNum = 6
PushBoxEvent.GameWin = 7
PushBoxEvent.GameOver = 8
PushBoxEvent.RefreshFanElement = 9
PushBoxEvent.PlayTaskFinishTween = 10
PushBoxEvent.DataEvent = {
	FinishEpisodeReply = 101,
	RefreshActivityData = 100,
	ReceiveTaskRewardReply = 102
}

return PushBoxEvent
