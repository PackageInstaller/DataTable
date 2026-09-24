-- chunkname: @modules/logic/versionactivity4_0/sonnet/controller/SonnetInterchapterEvent.lua

module("modules.logic.versionactivity4_0.sonnet.controller.SonnetInterchapterEvent", package.seeall)

local SonnetInterchapterEvent = _M
local _get = GameUtil.getUniqueTb()

SonnetInterchapterEvent.OnClickAllTaskFinish = _get()
SonnetInterchapterEvent.InitWords = _get()
SonnetInterchapterEvent.FinishElement = _get()
SonnetInterchapterEvent.ClickNewWord = _get()

return SonnetInterchapterEvent
