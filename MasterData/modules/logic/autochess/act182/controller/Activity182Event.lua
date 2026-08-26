-- chunkname: @modules/logic/autochess/act182/controller/Activity182Event.lua

module("modules.logic.autochess.act182.controller.Activity182Event", package.seeall)

local Activity182Event = _M
local _get = GameUtil.getUniqueTb()

Activity182Event.UpdateInfo = _get()
Activity182Event.RandomMasterReply = _get()
Activity182Event.RefreshBossReply = _get()

return Activity182Event
