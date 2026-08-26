-- chunkname: @modules/logic/versionactivity3_5/lamona/controller/LamonaEvent.lua

module("modules.logic.versionactivity3_5.lamona.controller.LamonaEvent", package.seeall)

local LamonaEvent = _M
local _get = GameUtil.getUniqueTb()

LamonaEvent.AddUnit = _get()
LamonaEvent.RemoveUnit = _get()
LamonaEvent.RefreshGame = _get()
LamonaEvent.PlayUnitMove = _get()
LamonaEvent.PlayUnitListMove = _get()
LamonaEvent.PlayGhostShockBeforeMove = _get()
LamonaEvent.OnGhostMoveEnd = _get()
LamonaEvent.OnGhostAddPropEffect = _get()
LamonaEvent.CatchGhosts = _get()
LamonaEvent.OnUseProp = _get()
LamonaEvent.OnAddRound = _get()
LamonaEvent.GuideOnEnterGame = _get()
LamonaEvent.GuideOnGhostMoveEnd = _get()

return LamonaEvent
