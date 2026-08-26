-- chunkname: @modules/logic/notice/controller/NoticeEvent.lua

module("modules.logic.notice.controller.NoticeEvent", package.seeall)

local NoticeEvent = _M

NoticeEvent.OnGetNoticeInfo = 1001
NoticeEvent.OnGetNoticeInfoFail = 1002
NoticeEvent.OnSelectNoticeItem = 1003
NoticeEvent.OnRefreshRedDot = 1004
NoticeEvent.StartEdit = 2001

return NoticeEvent
