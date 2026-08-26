-- chunkname: @modules/logic/handbook/view/HandbookCGView.lua

module("modules.logic.handbook.view.HandbookCGView", package.seeall)

local HandbookCGView = class("HandbookCGView", BaseView)

function HandbookCGView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagelbwz4 = gohelper.findChildSingleImage(self.viewGO, "icon/#simage_lbwz4")
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_change")
	self._scrollcg = gohelper.findChildScrollRect(self.viewGO, "#scroll_cg")
	self._goitemcontent = gohelper.findChild(self.viewGO, "#scroll_btnlist/viewport/content/")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_btnlist/viewport/content/item")
	self.verticalScrollPixelList = {}
	self._lastSelectId = nil
	self._ischanged = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookCGView:addEvents()
	self._scrollcg:AddOnValueChanged(self._onValueChange, self)
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
end

function HandbookCGView:removeEvents()
	self._scrollcg:RemoveOnValueChanged()
	self._btnchange:RemoveClickListener()
end

function HandbookCGView:_btnchangeOnClick()
	HandbookController.instance:openStoryView()
end

function HandbookCGView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getHandbookBg("full/bg_lb"))
	self._simagelbwz4:LoadImage(ResUrl.getHandbookBg("bg_lbwz4"))
	gohelper.addUIClickAudio(self._btnchange.gameObject, AudioEnum.UI.play_ui_screenplay_plot_switch)

	self._selectItemList = {}
end

function HandbookCGView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)

	self._csScroll = self.viewContainer:getCsScroll()._csMixScroll

	self:_refreshBtnList()

	self._scrollcg.verticalNormalizedPosition = 1
end

function HandbookCGView:_refreshBtnList()
	local configList = HandbookConfig.instance:getChapterTypeConfigList()

	for i = 1, #configList do
		local co = configList[i]
		local selectItem = self._selectItemList[i]

		if not selectItem then
			selectItem = self:getUserDataTb_()
			selectItem.go = gohelper.clone(self._goitem, self._goitemcontent, co.typeId)
			selectItem.gobeselected = gohelper.findChild(selectItem.go, "beselected")
			selectItem.gounselected = gohelper.findChild(selectItem.go, "unselected")
			selectItem.chapternamecn1 = gohelper.findChildText(selectItem.go, "beselected/chapternamecn")
			selectItem.chapternameen1 = gohelper.findChildText(selectItem.go, "beselected/chapternameen")
			selectItem.chapternamecn2 = gohelper.findChildText(selectItem.go, "unselected/chapternamecn")
			selectItem.chapternameen2 = gohelper.findChildText(selectItem.go, "unselected/chapternameen")
			selectItem.btnclick = gohelper.findChildButtonWithAudio(selectItem.go, "btnclick", AudioEnum.UI.Play_UI_Universal_Click)

			selectItem.btnclick:AddClickListener(self._btnclickOnClick, self, selectItem)

			selectItem.chapternamecn1.text = co.name
			selectItem.chapternamecn2.text = co.name
			selectItem.chapternameen1.text = co.nameEn
			selectItem.chapternameen2.text = co.nameEn

			gohelper.setActive(selectItem.go, true)
			table.insert(self._selectItemList, selectItem)
		end

		selectItem.selectId = i

		gohelper.setActive(selectItem.go, true)
	end

	if #self._selectItemList > 0 then
		self:_btnclickOnClick(self._selectItemList[1])
	else
		HandbookCGTripleListModel.instance:clearStoryList()
	end
end

function HandbookCGView:_btnclickOnClick(selectItem)
	self._ischanged = true

	local selectId = selectItem.selectId

	if self._lastSelectId == selectId then
		return
	else
		self._lastSelectId = selectId
	end

	local list = {}

	list.cgList = HandbookConfig.instance:getCGList(selectId)
	list.cgType = selectId

	HandbookCGTripleListModel.instance:setCGList(list)

	for _, selectItem in ipairs(self._selectItemList) do
		gohelper.setActive(selectItem.gobeselected, selectId == selectItem.selectId)
		gohelper.setActive(selectItem.gounselected, selectId ~= selectItem.selectId)
	end

	local value = self.verticalScrollPixelList[self._lastSelectId]

	if value then
		self._csScroll.VerticalScrollPixel = value
	else
		self._scrollcg.verticalNormalizedPosition = 1
	end

	self._ischanged = false
end

function HandbookCGView:_onValueChange()
	if self._ischanged then
		return
	end

	self.verticalScrollPixelList[self._lastSelectId] = self._csScroll.VerticalScrollPixel
end

function HandbookCGView:_onOpenViewFinish(viewName)
	if viewName == ViewName.HandbookStoryView then
		ViewMgr.instance:closeView(ViewName.HandbookCGView, true)
	end
end

function HandbookCGView:onClose()
	return
end

function HandbookCGView:onDestroyView()
	for _, v in ipairs(self._selectItemList) do
		v.btnclick:RemoveClickListener()
	end

	self._simagebg:UnLoadImage()
	self._simagelbwz4:UnLoadImage()
end

return HandbookCGView
