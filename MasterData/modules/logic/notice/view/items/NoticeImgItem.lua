-- chunkname: @modules/logic/notice/view/items/NoticeImgItem.lua

module("modules.logic.notice.view.items.NoticeImgItem", package.seeall)

local NoticeImgItem = class("NoticeImgItem", NoticeContentBaseItem)

function NoticeImgItem:init(go, types)
	NoticeImgItem.super.init(self, go, types)

	self.btnImg = gohelper.findChildButtonWithAudio(go, "#img_inner")
	self.goImg = self.btnImg.gameObject
	self.trImg = self.goImg:GetComponent(gohelper.Type_RectTransform)
end

function NoticeImgItem:addEventListeners()
	self.btnImg:AddClickListener(self.onClickImg, self)
end

function NoticeImgItem:removeEventListeners()
	self.btnImg:RemoveClickListener()
end

function NoticeImgItem:onClickImg()
	if not string.nilorempty(self.mo.link) then
		self:jump(self.mo.linkType, self.mo.link, self.mo.link1, self.mo.useWebView == 1, self.mo.recordUser == 1)
		StatController.instance:track(StatEnum.EventName.ClickNoticeImage, {
			[StatEnum.EventProperties.NoticeType] = NoticeContentListModel.instance:getCurSelectNoticeTypeStr(),
			[StatEnum.EventProperties.NoticeTitle] = NoticeContentListModel.instance:getCurSelectNoticeTitle()
		})
	end
end

function NoticeImgItem:show()
	gohelper.setActive(self.goImg, true)

	local mo = self.mo
	local content = mo.content
	local noticeImage = MonoHelper.addNoUpdateLuaComOnceToGo(self.goImg, NoticeImage)
	local isSuccessLoaded = noticeImage:load(content)

	if isSuccessLoaded then
		if not mo.width then
			mo.width, mo.height = NoticeModel.instance:getSpriteCacheDefaultSize(SLFramework.FileHelper.GetFileName(string.gsub(content, "?.*", ""), true))
		end

		recthelper.setSize(self.trImg, mo.width, mo.height)
	else
		recthelper.setSize(self.trImg, NoticeEnum.IMGDefaultWidth, NoticeEnum.IMGDefaultHeight)
	end

	if mo.align == NoticeContentType.Align.Left then
		self.trImg.anchorMin = NoticeContentType.Anchor.LeftAnchor
		self.trImg.anchorMax = NoticeContentType.Anchor.LeftAnchor

		recthelper.setAnchor(self.trImg, mo.width / 2, 0)
	elseif mo.align == NoticeContentType.Align.Center then
		self.trImg.anchorMin = NoticeContentType.Anchor.CenterAnchor
		self.trImg.anchorMax = NoticeContentType.Anchor.CenterAnchor

		recthelper.setAnchor(self.trImg, 0, 0)
	elseif mo.align == NoticeContentType.Align.Right then
		self.trImg.anchorMin = NoticeContentType.Anchor.RightAnchor
		self.trImg.anchorMax = NoticeContentType.Anchor.RightAnchor

		recthelper.setAnchor(self.trImg, -mo.width / 2, 0)
	else
		self.trImg.anchorMin = NoticeContentType.Anchor.LeftAnchor
		self.trImg.anchorMax = NoticeContentType.Anchor.LeftAnchor

		recthelper.setAnchor(self.trImg, mo.width / 2, 0)
	end
end

function NoticeImgItem:hide()
	gohelper.setActive(self.goImg, false)
end

return NoticeImgItem
