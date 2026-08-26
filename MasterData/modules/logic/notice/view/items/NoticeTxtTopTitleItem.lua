-- chunkname: @modules/logic/notice/view/items/NoticeTxtTopTitleItem.lua

module("modules.logic.notice.view.items.NoticeTxtTopTitleItem", package.seeall)

local NoticeTxtTopTitleItem = class("NoticeTxtTopTitleItem", NoticeContentBaseItem)

function NoticeTxtTopTitleItem:init(go, types)
	NoticeTxtTopTitleItem.super.init(self, go, types)

	self.goTopTitle = gohelper.findChild(go, "#go_topTitle")
	self.txtTopTitle = gohelper.findChildText(go, "#go_topTitle/#txt_title")
end

function NoticeTxtTopTitleItem:show()
	gohelper.setActive(self.goTopTitle, true)

	local content = self.mo.content

	self.txtTopTitle.text = "<line-indent=-5>" .. content
end

function NoticeTxtTopTitleItem:hide()
	gohelper.setActive(self.goTopTitle, false)
end

return NoticeTxtTopTitleItem
