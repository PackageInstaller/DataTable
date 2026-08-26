-- chunkname: @modules/logic/notice/view/NoticeTitleItem.lua

module("modules.logic.notice.view.NoticeTitleItem", package.seeall)

local NoticeTitleItem = class("NoticeTitleItem", ListScrollCell)

function NoticeTitleItem:init(go)
	self._go = go
	self._click = gohelper.getClickWithAudio(go, AudioEnum.UI.UI_Common_Click)
	self._redtipGO = gohelper.findChild(go, "#go_redtip")
	self._normalGO = gohelper.findChild(go, "#go_normal")
	self._selectGO = gohelper.findChild(go, "#go_select")
	self._txtTitle1 = gohelper.findChildText(self._normalGO, "title")
	self._txtTitle2 = gohelper.findChildText(self._selectGO, "title")
end

function NoticeTitleItem:addEventListeners()
	self._click:AddClickListener(self._onClickItem, self)
	self._click:AddClickDownListener(self._onClickItemDown, self)
	self._click:AddClickUpListener(self._onClickItemUp, self)
end

function NoticeTitleItem:removeEventListeners()
	self._click:RemoveClickListener()
	self._click:RemoveClickUpListener()
	self._click:RemoveClickDownListener()
end

function NoticeTitleItem:onUpdateMO(mo)
	self._mo = mo
	self._txtTitle1.text = mo:getTitle()
	self._txtTitle2.text = mo:getTitle()

	gohelper.setActive(self._redtipGO, not NoticeModel.instance:getNoticeMoIsRead(self._mo))
end

function NoticeTitleItem:onSelect(isSelect)
	if isSelect then
		gohelper.setActive(self._redtipGO, false)
		NoticeModel.instance:readNoticeMo(self._mo)
		NoticeController.instance:dispatchEvent(NoticeEvent.OnSelectNoticeItem, self._mo)
	end

	gohelper.setActive(self._selectGO, isSelect)
	gohelper.setActive(self._normalGO, not isSelect)
end

function NoticeTitleItem:_onClickItem()
	local index = NoticeModel.instance:getIndex(self._mo)

	if index == self._view.lastSelectIndex then
		return
	end

	self._view:selectCell(index, true)

	self._view.lastSelectIndex = index
end

function NoticeTitleItem:_onClickItemDown()
	self:_setItemPressState(true)
end

function NoticeTitleItem:_onClickItemUp()
	self:_setItemPressState(false)
end

function NoticeTitleItem:_setItemPressState(press)
	if not self._itemContainer then
		self._itemContainer = self:getUserDataTb_()

		local images = self._go:GetComponentsInChildren(gohelper.Type_Image, true)

		self._itemContainer.images = images

		local tmps = self._go:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		self._itemContainer.tmps = tmps
		self._itemContainer.compColor = {}

		local iter = images:GetEnumerator()

		while iter:MoveNext() do
			self._itemContainer.compColor[iter.Current] = iter.Current.color
		end

		iter = tmps:GetEnumerator()

		while iter:MoveNext() do
			self._itemContainer.compColor[iter.Current] = iter.Current.color
		end
	end

	if self._itemContainer then
		UIColorHelper.setUIPressState(self._itemContainer.images, self._itemContainer.compColor, press)
		UIColorHelper.setUIPressState(self._itemContainer.tmps, self._itemContainer.compColor, press)
	end
end

return NoticeTitleItem
