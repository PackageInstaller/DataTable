-- chunkname: @modules/logic/rouge/view/RougeCollectionHandBookFavoriteView.lua

module("modules.logic.rouge.view.RougeCollectionHandBookFavoriteView", package.seeall)

local RougeCollectionHandBookFavoriteView = class("RougeCollectionHandBookFavoriteView", RougeCollectionHandBookView)

function RougeCollectionHandBookFavoriteView:onInitView()
	self._btnLayout = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_layout")
	self._goUnselectLayout = gohelper.findChild(self._btnLayout.gameObject, "unselected")
	self._goSelectLayout = gohelper.findChild(self._btnLayout.gameObject, "selected")

	RougeCollectionHandBookFavoriteView.super.onInitView(self)
end

function RougeCollectionHandBookFavoriteView:addEvents()
	RougeCollectionHandBookFavoriteView.super.addEvents(self)
	self._btnLayout:AddClickListener(self._btnLayoutOnClick, self)
end

function RougeCollectionHandBookFavoriteView:removeEvents()
	RougeCollectionHandBookFavoriteView.super.removeEvents(self)
	self._btnLayout:RemoveClickListener()
end

function RougeCollectionHandBookFavoriteView:_editableInitView()
	RougeCollectionHandBookFavoriteView.super._editableInitView(self)
	gohelper.setActive(self._btnLayout, true)
	self:_setFilterSelected(false)
end

function RougeCollectionHandBookFavoriteView:_btnLayoutOnClick()
	if self._isAllSelected then
		return
	end

	self:_setFilterSelected(false)
end

function RougeCollectionHandBookFavoriteView:_setFilterSelected(value)
	RougeCollectionHandBookFavoriteView.super._setFilterSelected(self, value)
	self:_setAllSelected(not value)
end

function RougeCollectionHandBookFavoriteView:_setAllSelected(value)
	self._isAllSelected = value

	gohelper.setActive(self._goSelectLayout, value)
	gohelper.setActive(self._goUnselectLayout, not value)

	if self._isAllSelected then
		self._baseTagSelectMap = {}
		self._extraTagSelectMap = {}

		RougeCollectionHandBookListModel.instance:onInitData()
	end
end

return RougeCollectionHandBookFavoriteView
