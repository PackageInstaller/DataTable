-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/controller/TowerV3a7Event.lua

module("modules.logic.versionactivity3_7.towerv3a7.controller.TowerV3a7Event", package.seeall)

local TowerV3a7Event = _M
local _get = GameUtil.getUniqueTb()

TowerV3a7Event.AddChessMan = _get()
TowerV3a7Event.RemoveChessMan = _get()
TowerV3a7Event.SelectChessMan = _get()
TowerV3a7Event.DragFinishChessMan = _get()
TowerV3a7Event.CancelDragChessMan = _get()
TowerV3a7Event.SrcMoveChessMan = _get()
TowerV3a7Event.DstMoveChessMan = _get()
TowerV3a7Event.MoveFinishChessMan = _get()
TowerV3a7Event.DeadChessMan = _get()
TowerV3a7Event.StoryShow = _get()
TowerV3a7Event.StoryAddChessMan = _get()
TowerV3a7Event.StoryDeadChessMan = _get()
TowerV3a7Event.StoryFinishTarget = _get()
TowerV3a7Event.StoryPlay = _get()
TowerV3a7Event.GMModifyChessHp = _get()
TowerV3a7Event.GMRefreshChessManID = _get()
TowerV3a7Event.GameOver = _get()
TowerV3a7Event.GuideGamePause = _get()
TowerV3a7Event.GuidePauseInteraction = _get()
TowerV3a7Event.GuideAddChessMan = _get()
TowerV3a7Event.GuideMoveFinishChessMan = _get()
TowerV3a7Event.GuideDeadChessMan = _get()

return TowerV3a7Event
