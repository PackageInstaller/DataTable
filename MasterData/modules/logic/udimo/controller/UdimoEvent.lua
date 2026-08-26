-- chunkname: @modules/logic/udimo/controller/UdimoEvent.lua

module("modules.logic.udimo.controller.UdimoEvent", package.seeall)

local UdimoEvent = _M
local _get = GameUtil.getUniqueTb()

UdimoEvent.OnSceneLateInitDone = _get()
UdimoEvent.OnGetUdimoInfo = _get()
UdimoEvent.OnGetWeatherInfo = _get()
UdimoEvent.OnEnterUdimoPlayMode = _get()
UdimoEvent.Switch2UdimoLockMode = _get()
UdimoEvent.OnSelectInfoHeadItem = _get()
UdimoEvent.OnSelectDecorationItem = _get()
UdimoEvent.OnClickDecorationEntity = _get()
UdimoEvent.OnChangeUidmoShow = _get()
UdimoEvent.OnChangeBg = _get()
UdimoEvent.OnChangeDecoration = _get()
UdimoEvent.OnDraggingUdimo = _get()
UdimoEvent.PlayUdimoAnimation = _get()
UdimoEvent.RefreshDecorationSelectPos = _get()
UdimoEvent.OnUdimoCameraTweening = _get()
UdimoEvent.UdimoBeginWalk = _get()
UdimoEvent.UdimoWalkFinish = _get()
UdimoEvent.OnPickUpUdimo = _get()
UdimoEvent.OnPickUpUdimoOver = _get()
UdimoEvent.UdimoWaitInteractOverTime = _get()
UdimoEvent.BeginInetract = _get()
UdimoEvent.InteractFinished = _get()

return UdimoEvent
