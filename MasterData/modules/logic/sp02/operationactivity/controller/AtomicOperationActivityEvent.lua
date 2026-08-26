-- chunkname: @modules/logic/sp02/operationactivity/controller/AtomicOperationActivityEvent.lua

module("modules.logic.sp02.operationactivity.controller.AtomicOperationActivityEvent", package.seeall)

local AtomicOperationActivityEvent = _M
local _get = GameUtil.getUniqueTb()

AtomicOperationActivityEvent.OnPreparationInfoUpdate = _get()

return AtomicOperationActivityEvent
