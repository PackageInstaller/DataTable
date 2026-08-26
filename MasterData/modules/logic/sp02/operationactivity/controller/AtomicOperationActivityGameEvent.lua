-- chunkname: @modules/logic/sp02/operationactivity/controller/AtomicOperationActivityGameEvent.lua

module("modules.logic.sp02.operationactivity.controller.AtomicOperationActivityGameEvent", package.seeall)

local AtomicOperationActivityGameEvent = _M
local _get = GameUtil.getUniqueTb()

AtomicOperationActivityGameEvent.InitGame = _get()
AtomicOperationActivityGameEvent.ChangeState = _get()
AtomicOperationActivityGameEvent.RemoveTarget = _get()
AtomicOperationActivityGameEvent.AddTarget = _get()
AtomicOperationActivityGameEvent.StartGame = _get()
AtomicOperationActivityGameEvent.EndGame = _get()

return AtomicOperationActivityGameEvent
