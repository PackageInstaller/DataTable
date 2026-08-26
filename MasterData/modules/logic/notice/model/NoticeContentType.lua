-- chunkname: @modules/logic/notice/model/NoticeContentType.lua

module("modules.logic.notice.model.NoticeContentType", package.seeall)

local NoticeContentType = _M

NoticeContentType.LangType = 0
NoticeContentType.TxtTopTitle = 1
NoticeContentType.TxtContent = 3
NoticeContentType.ImgInner = 4
NoticeContentType.ImgTitle = 5
NoticeContentType.Align = {}
NoticeContentType.Align.Left = 1
NoticeContentType.Align.Center = 2
NoticeContentType.Align.Right = 3
NoticeContentType.LinkType = {}
NoticeContentType.LinkType.InnerLink = 1
NoticeContentType.LinkType.OutLink = 2
NoticeContentType.LinkType.DeepLink = 3
NoticeContentType.LinkType.Time = 4
NoticeContentType.Anchor = {}
NoticeContentType.Anchor.LeftAnchor = Vector2.New(0, 0)
NoticeContentType.Anchor.CenterAnchor = Vector2.New(0.5, 0)
NoticeContentType.Anchor.RightAnchor = Vector2.New(1, 0)

return NoticeContentType
