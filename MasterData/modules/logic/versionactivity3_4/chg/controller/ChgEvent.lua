-- chunkname: @modules/logic/versionactivity3_4/chg/controller/ChgEvent.lua

module("modules.logic.versionactivity3_4.chg.controller.ChgEvent", package.seeall)

local ChgEvent = _M
local _get = GameUtil.getUniqueTb()

ChgEvent.OnGameFinished = _get()
ChgEvent.GuideStart = _get()

return ChgEvent
