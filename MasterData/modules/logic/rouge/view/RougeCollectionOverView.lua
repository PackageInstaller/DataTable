-- chunkname: @modules/logic/rouge/view/RougeCollectionOverView.lua

module("modules.logic.rouge.view.RougeCollectionOverView", package.seeall)

local RougeCollectionOverView = class("RougeCollectionOverView", RougeBaseDLCViewComp)

function RougeCollectionOverView:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionOverView:addEvents()
	return
end

function RougeCollectionOverView:removeEvents()
	return
end

function RougeCollectionOverView:_editableInitView()
	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function RougeCollectionOverView:onOpen()
	RougeCollectionOverView.super.onOpen(self)
	RougeCollectionOverListModel.instance:onInitData()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_store_open)
end

function RougeCollectionOverView:refreshUI()
	local collectionCount = RougeCollectionOverListModel.instance:getCount()

	gohelper.setActive(self._goempty, collectionCount <= 0)
	gohelper.setActive(self._scrollview.gameObject, collectionCount > 0)
end

function RougeCollectionOverView:_onSwitchCollectionInfoType()
	RougeCollectionOverListModel.instance:onModelUpdate()
end

function RougeCollectionOverView:onClose()
	ViewMgr.instance:closeView(ViewName.CommonBuffTipView)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

return RougeCollectionOverView
