-- chunkname: @modules/logic/versionactivity3_3/igor/define/IgorEvent.lua

module("modules.logic.versionactivity3_3.igor.define.IgorEvent", package.seeall)

local IgorEvent = _M
local _get = GameUtil.getUniqueTb()

IgorEvent.OnGameInited = _get()
IgorEvent.OnGameFrameUpdate = _get()
IgorEvent.OnGamePause = _get()
IgorEvent.OnGameReset = _get()
IgorEvent.OnGameCostChange = _get()
IgorEvent.OnEntityAdd = _get()
IgorEvent.OnEntityDel = _get()
IgorEvent.OnEntityHpChange = _get()
IgorEvent.OnEntityLevChange = _get()
IgorEvent.OnUseTransferSkill = _get()
IgorEvent.OnCampAttrChange = _get()
IgorEvent.OnUpdateTempEntityPos = _get()
IgorEvent.OnGuidePause = _get()

return IgorEvent
