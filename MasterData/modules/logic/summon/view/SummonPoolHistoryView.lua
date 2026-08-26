-- chunkname: @modules/logic/summon/view/SummonPoolHistoryView.lua

module("modules.logic.summon.view.SummonPoolHistoryView", package.seeall)

local SummonPoolHistoryView = class("SummonPoolHistoryView", BaseView)

SummonPoolHistoryView.PAGE_ITEM_NUM = 10

function SummonPoolHistoryView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagetop = gohelper.findChildSingleImage(self.viewGO, "allbg/#simage_top")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "allbg/#simage_bottom")
	self._txtdes = gohelper.findChildText(self.viewGO, "allbg/top/#txt_des")
	self._goempty = gohelper.findChild(self.viewGO, "allbg/middle/#go_empty")
	self._gobottom = gohelper.findChild(self.viewGO, "allbg/#go_bottom")
	self._btnarrowleft = gohelper.findChildButtonWithAudio(self.viewGO, "allbg/#go_bottom/#btn_arrowleft")
	self._imagearrowleft = gohelper.findChildImage(self.viewGO, "allbg/#go_bottom/#btn_arrowleft/#image_arrowleft")
	self._btnarrowright = gohelper.findChildButtonWithAudio(self.viewGO, "allbg/#go_bottom/#btn_arrowright")
	self._imagearrowright = gohelper.findChildImage(self.viewGO, "allbg/#go_bottom/#btn_arrowright/#image_arrowright")
	self._txtnum = gohelper.findChildText(self.viewGO, "allbg/#go_bottom/#txt_num")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "allbg/#btn_close")
	self._txttime = gohelper.findChildText(self.viewGO, "bottomright/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonPoolHistoryView:addEvents()
	self._btnarrowleft:AddClickListener(self._btnarrowleftOnClick, self)
	self._btnarrowright:AddClickListener(self._btnarrowrightOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SummonPoolHistoryView:removeEvents()
	self._btnarrowleft:RemoveClickListener()
	self._btnarrowright:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function SummonPoolHistoryView:_btncloseOnClick()
	self:closeThis()
end

function SummonPoolHistoryView:_btnarrowleftOnClick()
	if self._curPage > 1 then
		self._curPage = self._curPage - 1

		self:_refreshView()
	end
end

function SummonPoolHistoryView:_btnarrowrightOnClick()
	local maxPage = self:_getMaxPage()

	if maxPage > self._curPage then
		self._curPage = self._curPage + 1

		self:_refreshView()
	end
end

function SummonPoolHistoryView:_editableInitView()
	self._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
	gohelper.addUIClickAudio(self._btnarrowleft.gameObject, AudioEnum.UI.Play_UI_Pool_History_Page_Switch)
	gohelper.addUIClickAudio(self._btnarrowright.gameObject, AudioEnum.UI.Play_UI_Pool_History_Page_Switch)

	self._curPage = 1
	self._poolTypeId = nil

	self:_initListItem()
	self:_initPoolType()
end

function SummonPoolHistoryView:onDestroyView()
	self._simagetop:UnLoadImage()
	self._simagebottom:UnLoadImage()
end

function SummonPoolHistoryView:_initPoolType()
	local poolId = SummonMainModel.instance:getCurId()
	local poolTypeId = SummonPoolHistoryModel.instance:getShowPoolTypeByPoolId(poolId)

	if SummonPoolHistoryModel.instance:isCanShowByPoolTypeId(poolTypeId) then
		self._poolTypeId = poolTypeId
	end
end

function SummonPoolHistoryView:_initListItem()
	if self._historyListItems then
		return
	end

	local itemGo = gohelper.findChild(self.viewGO, "allbg/middle/history/item")
	local parentGO = gohelper.findChild(self.viewGO, "allbg/middle/history")

	self._historyListItems = {}

	table.insert(self._historyListItems, MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, SummonPoolHistoryListItem, self))

	for i = 2, SummonPoolHistoryView.PAGE_ITEM_NUM do
		local cloneGo = gohelper.clone(itemGo, parentGO, "item" .. i)

		table.insert(self._historyListItems, MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, SummonPoolHistoryListItem, self))
	end
end

function SummonPoolHistoryView:_refreshView()
	local maxNum = SummonPoolHistoryModel.instance:getNumByPoolId(self._poolTypeId)

	gohelper.setActive(self._goempty, not (maxNum > 0))
	gohelper.setActive(self._gobottom, maxNum > 0)

	local start = (self._curPage - 1) * #self._historyListItems + 1
	local datas = SummonPoolHistoryModel.instance:getHistoryListByIndexOf(start, #self._historyListItems, self._poolTypeId)

	for index, item in ipairs(self._historyListItems) do
		item:onUpdateMO(datas[index])
	end

	if maxNum > 0 then
		local maxPage = self:_getMaxPage()

		ZProj.UGUIHelper.SetColorAlpha(self._imagearrowleft, self._curPage < 2 and 0.25 or 1)
		ZProj.UGUIHelper.SetColorAlpha(self._imagearrowright, maxPage <= self._curPage and 0.25 or 1)

		self._txtnum.text = self._curPage .. "/" .. maxPage
	end
end

function SummonPoolHistoryView:onUpdateParam()
	return
end

function SummonPoolHistoryView:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onGetSummonPoolHistoryData, self.handleGetHistoryData, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonPoolHistorySelect, self._onHandleHistorySelect, self)
	self:_checkRequese()

	local tSummonPoolHistoryTypeListModel = SummonPoolHistoryTypeListModel.instance

	tSummonPoolHistoryTypeListModel:initPoolType()

	self._poolTypeId = self._poolTypeId or tSummonPoolHistoryTypeListModel:getFirstId()

	tSummonPoolHistoryTypeListModel:setSelectId(self._poolTypeId)
	self:_refreshView()
end

function SummonPoolHistoryView:onClose()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onGetSummonPoolHistoryData, self.handleGetHistoryData, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonPoolHistorySelect, self._onHandleHistorySelect, self)
end

function SummonPoolHistoryView:_onHandleHistorySelect()
	local curselectId = SummonPoolHistoryTypeListModel.instance:getSelectId()

	if self._poolTypeId ~= curselectId then
		self._poolTypeId = curselectId
		self._curPage = 1

		self:_refreshView()
	end
end

function SummonPoolHistoryView:handleGetHistoryData()
	local maxPage = self:_getMaxPage()

	if maxPage < self._curPage then
		self._curPage = math.max(1, maxPage)
	end

	SummonPoolHistoryTypeListModel.instance:initPoolType()
	self:_refreshView()
end

function SummonPoolHistoryView:_getMaxPage()
	local maxNum = SummonPoolHistoryModel.instance:getNumByPoolId(self._poolTypeId)

	return (math.ceil(maxNum / SummonPoolHistoryView.PAGE_ITEM_NUM))
end

function SummonPoolHistoryView:_checkRequese()
	if not SummonPoolHistoryModel.instance:isDataValidity() then
		SummonPoolHistoryController.instance:request()
	end
end

return SummonPoolHistoryView
