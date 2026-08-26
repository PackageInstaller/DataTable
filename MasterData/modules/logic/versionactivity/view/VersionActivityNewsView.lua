-- chunkname: @modules/logic/versionactivity/view/VersionActivityNewsView.lua

module("modules.logic.versionactivity.view.VersionActivityNewsView", package.seeall)

local VersionActivityNewsView = class("VersionActivityNewsView", BaseView)

function VersionActivityNewsView:onInitView()
	self._goclose = gohelper.findChild(self.viewGO, "#go_close")
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._goinfoitem = gohelper.findChild(self.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityNewsView:addEvents()
	return
end

function VersionActivityNewsView:removeEvents()
	return
end

VersionActivityNewsView.ParagraphDelimiter = "{p}"
VersionActivityNewsView.ImageString = "{img}"
VersionActivityNewsView.ImageStringLen = #VersionActivityNewsView.ImageString
VersionActivityNewsView.Anchor = {
	Left = Vector2.New(0, 1),
	Center = Vector2.New(0.5, 1),
	Right = Vector2.New(1, 1)
}
VersionActivityNewsView.Align = {
	Right = 3,
	Left = 1,
	Center = 2
}

function VersionActivityNewsView:closeViewOnClick()
	self:closeThis()
end

function VersionActivityNewsView:_editableInitView()
	gohelper.setActive(self._goinfoitem, false)

	self.closeViewClick = gohelper.getClick(self._goclose)

	self.closeViewClick:AddClickListener(self.closeViewOnClick, self)

	self.contentItemList = {}
end

function VersionActivityNewsView:onUpdateParam()
	return
end

function VersionActivityNewsView:onOpen()
	local fragmentId = self.viewParam.fragmentId

	self.fragmentCo = lua_chapter_map_fragment.configDict[fragmentId]

	if not self.fragmentCo then
		logError("not found fragment : " .. fragmentId)
		self:closeThis()

		return
	end

	self:refreshUI()
end

function VersionActivityNewsView:refreshUI()
	self._txttitle.text = self.fragmentCo.title

	local contentList = string.split(self.fragmentCo.content, VersionActivityNewsView.ParagraphDelimiter)
	local count = 0
	local contentItem, isImgType

	for _, content in ipairs(contentList) do
		if not string.nilorempty(content) then
			count = count + 1
			content = string.trim(content)
			contentItem = self.contentItemList[count] or self:createContentItem()

			gohelper.setActive(contentItem.go, true)

			isImgType = not not string.find(content, VersionActivityNewsView.ImageString)

			gohelper.setActive(contentItem.goPlainText, not isImgType)
			gohelper.setActive(contentItem.goImgText, isImgType)

			if isImgType then
				local align = self:getImageAlign(content)

				content = string.gsub(content, VersionActivityNewsView.ImageString, "")
				contentItem.txtImgText.text = content

				contentItem.simageIcon:LoadImage(ResUrl.getVersionActivityIcon(self.fragmentCo.res))

				local iconWidth = recthelper.getWidth(contentItem.iconRectTr)

				if align == VersionActivityNewsView.Align.Left then
					contentItem.iconRectTr.anchorMin = VersionActivityNewsView.Anchor.Left
					contentItem.iconRectTr.anchorMax = VersionActivityNewsView.Anchor.Left

					recthelper.setAnchor(contentItem.iconRectTr, iconWidth / 2, 0)
				elseif align == VersionActivityNewsView.Align.Center then
					contentItem.iconRectTr.anchorMin = VersionActivityNewsView.Anchor.Center
					contentItem.iconRectTr.anchorMax = VersionActivityNewsView.Anchor.Center

					recthelper.setAnchor(contentItem.iconRectTr, 0, 0)
				elseif align == VersionActivityNewsView.Align.Right then
					contentItem.iconRectTr.anchorMin = VersionActivityNewsView.Anchor.Right
					contentItem.iconRectTr.anchorMax = VersionActivityNewsView.Anchor.Right

					recthelper.setAnchor(contentItem.iconRectTr, -iconWidth / 2, 0)
				end
			else
				contentItem.txtPlainText.text = content
			end
		end
	end

	for i = count + 1, #self.contentItemList do
		gohelper.setActive(self.contentItemList[i].go, false)
	end
end

function VersionActivityNewsView:checkIsImageType(content)
	return string.find(content, VersionActivityNewsView.ImageString)
end

function VersionActivityNewsView:getImageAlign(content)
	local startIndex, endIndex = string.find(content, VersionActivityNewsView.ImageString)

	if not startIndex then
		return VersionActivityNewsView.Align.Right
	end

	if startIndex ~= 1 then
		return VersionActivityNewsView.Align.Right
	end

	if string.nilorempty(string.sub(content, endIndex + 1, endIndex + 1)) then
		return VersionActivityNewsView.Align.Center
	end

	return VersionActivityNewsView.Align.Left
end

function VersionActivityNewsView:createContentItem()
	local contentItem = self:getUserDataTb_()

	contentItem.go = gohelper.cloneInPlace(self._goinfoitem)
	contentItem.goPlainText = gohelper.findChild(contentItem.go, "type1")
	contentItem.txtPlainText = gohelper.findChildText(contentItem.go, "type1")
	contentItem.goImgText = gohelper.findChild(contentItem.go, "type2")
	contentItem.txtImgText = gohelper.findChildText(contentItem.go, "type2/info")
	contentItem.simageIcon = gohelper.findChildSingleImage(contentItem.go, "type2/icon")
	contentItem.iconRectTr = contentItem.simageIcon.gameObject.transform

	return contentItem
end

function VersionActivityNewsView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	for _, contentItem in ipairs(self.contentItemList) do
		contentItem.simageIcon:UnLoadImage()
	end

	if self.viewParam and self.viewParam.isRecheck then
		local elementId = self.viewParam.elementId

		DungeonController.instance:onAgainOpenRecheckView(elementId)
	end
end

function VersionActivityNewsView:onDestroyView()
	self.closeViewClick:RemoveClickListener()
end

return VersionActivityNewsView
