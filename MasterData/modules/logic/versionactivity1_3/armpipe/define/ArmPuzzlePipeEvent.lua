-- chunkname: @modules/logic/versionactivity1_3/armpipe/define/ArmPuzzlePipeEvent.lua

module("modules.logic.versionactivity1_3.armpipe.define.ArmPuzzlePipeEvent", package.seeall)

local ArmPuzzlePipeEvent = _M

ArmPuzzlePipeEvent.RefreshMapData = 124001
ArmPuzzlePipeEvent.RefreshEpisode = 124002
ArmPuzzlePipeEvent.RefreshReceiveReward = 124003
ArmPuzzlePipeEvent.PipeGameClear = 124020
ArmPuzzlePipeEvent.MazeDrawGameClear = 124030
ArmPuzzlePipeEvent.ChangeColorGameClear = 124040
ArmPuzzlePipeEvent.InteractClick = 124041
ArmPuzzlePipeEvent.CircuitClick = 124050
ArmPuzzlePipeEvent.GuideClickGrid = 1241001
ArmPuzzlePipeEvent.GuideEntryConnectClear = 1241002
ArmPuzzlePipeEvent.UIPipeDragBegin = 1242001
ArmPuzzlePipeEvent.UIPipeDragIng = 1242002
ArmPuzzlePipeEvent.UIPipeDragEnd = 1242003
ArmPuzzlePipeEvent.PlaceRefreshPipesGrid = 1242010
ArmPuzzlePipeEvent.PlaceItemRefresh = 1242011
ArmPuzzlePipeEvent.EpisodeFiexdAnim = 1242013
ArmPuzzlePipeEvent.ResetGameRefresh = 1242014
ArmPuzzlePipeEvent.GuideOpenGameView = 1249999

return ArmPuzzlePipeEvent
