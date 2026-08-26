-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/EliminateMapEvent.lua

module("modules.logic.versionactivity2_2.eliminate.controller.EliminateMapEvent", package.seeall)

local EliminateMapEvent = _M

EliminateMapEvent.OnSelectChapterChange = GameUtil.getEventId()
EliminateMapEvent.UnlockChapterAnimDone = GameUtil.getEventId()
EliminateMapEvent.OnUpdateEpisodeInfo = GameUtil.getEventId()
EliminateMapEvent.ClickCharacter = GameUtil.getEventId()
EliminateMapEvent.UpdateTask = GameUtil.getEventId()
EliminateMapEvent.SelectChessMen = GameUtil.getEventId()
EliminateMapEvent.ChangeChessMen = GameUtil.getEventId()
EliminateMapEvent.QuickSelectChessMen = GameUtil.getEventId()
EliminateMapEvent.ClickEpisode = GameUtil.getEventId()

return EliminateMapEvent
