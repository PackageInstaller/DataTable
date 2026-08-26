-- chunkname: @modules/logic/sp02/atomic/view/AtomicDataBaseInfoView.lua

module("modules.logic.sp02.atomic.view.AtomicDataBaseInfoView", package.seeall)

local AtomicDataBaseInfoView = class("AtomicDataBaseInfoView", BaseView)

function AtomicDataBaseInfoView:onInitView()
	self.txtPage = gohelper.findChildTextMesh(self.viewGO, "#txt_Num")
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.btnPrev = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_uparrow", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_downarrow", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.goItem = gohelper.findChild(self.viewGO, "viewport/content/#go_landmarkitem")

	gohelper.setActive(self.goItem, false)

	self.goContent = gohelper.findChild(self.viewGO, "viewport/content")
	self._goscroll = gohelper.findChild(self.viewGO, "scroll_landmark")
	self.goPrevNew = gohelper.findChild(self.viewGO, "#btn_uparrow/new")
	self.goNextNew = gohelper.findChild(self.viewGO, "#btn_downarrow/new")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDataBaseInfoView:addEvents()
	self.addClickCb(self, self.btnClose, self._btncloseOnClick, self)
	self.addClickCb(self, self.btnPrev, self._btnprevOnClick, self)
	self.addClickCb(self, self.btnNext, self._btnnextOnClick, self)
	self.addEventCb(self, AtomicDataBaseInfoController.instance, AtomicEvent.DataBaseInfoUpdate, self.refreshView, self)

	self._scroll = SLFramework.UGUI.UIDragListener.Get(self._goscroll)

	self._scroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._scroll:AddDragEndListener(self._onScrollDragEnd, self)

	self._pageWidth = 1440
end

function AtomicDataBaseInfoView:removeEvents()
	self:removeClickCb(self.btnClose)
	self:removeClickCb(self.btnPrev)
	self:removeClickCb(self.btnNext)
	self.removeEventCb(self, AtomicDataBaseInfoController.instance, AtomicEvent.DataBaseInfoUpdate, self.refreshView, self)
	self._scroll:RemoveDragBeginListener()
	self._scroll:RemoveDragEndListener()
end

function AtomicDataBaseInfoView:_editableInitView()
	self:initPageList()
end

function AtomicDataBaseInfoView:_btncloseOnClick()
	self:closeThis()
end

function AtomicDataBaseInfoView:_btnprevOnClick()
	local totalPage = AtomicDataBaseInfoViewModel.instance.totalPage
	local currentPage = AtomicDataBaseInfoViewModel.instance.page

	if currentPage == 1 then
		return
	end

	local targetPage = currentPage - 1

	if targetPage < 1 then
		targetPage = totalPage
	end

	self:_scrollToPage(targetPage)
end

function AtomicDataBaseInfoView:_btnnextOnClick()
	local totalPage = AtomicDataBaseInfoViewModel.instance.totalPage
	local currentPage = AtomicDataBaseInfoViewModel.instance.page

	if currentPage == totalPage then
		return
	end

	local targetPage = currentPage + 1

	if totalPage < targetPage then
		targetPage = 1
	end

	self:_scrollToPage(targetPage)
end

function AtomicDataBaseInfoView:_scrollToPage(targetPage)
	AtomicDataBaseInfoViewModel.instance:setTargetPageIndex(targetPage)

	if not self:isInAnimaing() then
		self:_doScrollToTarget()
	end
end

function AtomicDataBaseInfoView:_doScrollToTarget()
	local targetPage = AtomicDataBaseInfoViewModel.instance:getTargetPageIndex()

	if not targetPage then
		return
	end

	local currentPage = AtomicDataBaseInfoViewModel.instance.page
	local totalPage = AtomicDataBaseInfoViewModel.instance.totalPage
	local diff = targetPage - currentPage

	if diff > totalPage / 2 then
		diff = diff - totalPage
	elseif diff < -totalPage / 2 then
		diff = diff + totalPage
	end

	if diff == 0 then
		AtomicDataBaseInfoViewModel.instance:clearTargetPageIndex()

		return
	end

	local isMoveNext = diff > 0

	self:tweenMove(not isMoveNext, isMoveNext)
end

function AtomicDataBaseInfoView:_onScrollDragBegin(param, eventData)
	local isSinglePage = AtomicDataBaseInfoViewModel.instance:isSinglePage()

	if isSinglePage then
		return
	end

	self._scrollStartPos = eventData.position
	self._dragTime = Time.realtimeSinceStartup
end

function AtomicDataBaseInfoView:_onScrollDragEnd(param, eventData)
	if not self._scrollStartPos then
		return
	end

	local deltaX = eventData.position.x - self._scrollStartPos.x
	local deltaY = eventData.position.y - self._scrollStartPos.y

	self._scrollStartPos = nil

	if math.abs(deltaX) < math.abs(deltaY) then
		return
	end

	local dragDuration = Time.realtimeSinceStartup - self._dragTime
	local speedX = deltaX / math.max(dragDuration, 0.01)
	local offsetThreshold = self._pageWidth * 0.3
	local speedThreshold = 300
	local isMovePre = offsetThreshold < deltaX or speedThreshold < speedX
	local isMoveNext = deltaX < -offsetThreshold or speedX < -speedThreshold

	if isMovePre or isMoveNext then
		if isMovePre then
			self:_btnprevOnClick()
		else
			self:_btnnextOnClick()
		end
	end
end

function AtomicDataBaseInfoView:onUpdateParam()
	return
end

function AtomicDataBaseInfoView:onOpen()
	AtomicDataBaseInfoController.instance:onOpenView(self.viewParam)
	self:refreshView()
end

function AtomicDataBaseInfoView:onClose()
	AtomicDataBaseInfoViewModel.instance:clearTargetPageIndex()
	AtomicDataBaseInfoController.instance:onCloseView()
end

function AtomicDataBaseInfoView:refreshView()
	local data = AtomicDataBaseInfoViewModel.instance:getData()

	if not data then
		return
	end

	self.txtPage.text = string.format("%d/%d", data.page, data.totalPage)

	self:refreshPageList(data.dataList)
	self:refreshBtn()
end

function AtomicDataBaseInfoView:clearNewTag(id)
	if not id then
		return
	end

	AtomicDataBaseViewModel.instance:clearLibraryNew(id)
end

function AtomicDataBaseInfoView:refreshBtn()
	local isSinglePage = AtomicDataBaseInfoViewModel.instance:isSinglePage()

	if isSinglePage then
		gohelper.setActive(self.btnPrev, not isSinglePage)
		gohelper.setActive(self.btnNext, not isSinglePage)

		return
	end

	local currentPage = AtomicDataBaseInfoViewModel.instance.page
	local totalPage = AtomicDataBaseInfoViewModel.instance.totalPage
	local isFirst = currentPage == 1
	local isLast = currentPage == totalPage

	gohelper.setActive(self.btnPrev, not isFirst)
	gohelper.setActive(self.btnNext, not isLast)
end

function AtomicDataBaseInfoView:tweenMove(isMovePre, isMoveNext)
	if not isMoveNext and not isMovePre then
		return
	end

	if isMovePre then
		AtomicDataBaseInfoViewModel.instance:tryPrevPage()
	elseif isMoveNext then
		AtomicDataBaseInfoViewModel.instance:tryNextPage()
	end

	self:clearTween()

	if isMoveNext then
		if not -self._pageWidth then
			local movePosX = self._pageWidth

			self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self.goContent.transform, movePosX, 0.35, self._tweenPosFinish, self)

			self:refreshBtn()
		end
	end
end

function AtomicDataBaseInfoView:_tweenPosFinish()
	self:clearTween()
	recthelper.setAnchorX(self.goContent.transform, 0)
	self:refreshView()

	local targetPage = AtomicDataBaseInfoViewModel.instance:getTargetPageIndex()

	if targetPage then
		self:_doScrollToTarget()
	end
end

function AtomicDataBaseInfoView:initPageList()
	self.pageList = {}

	for i = 1, 3 do
		local go = gohelper.cloneInPlace(self.goItem, tostring(i))
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, AtomicDataBaseInfoItem)

		table.insert(self.pageList, item)
	end
end

function AtomicDataBaseInfoView:refreshPageList(dataList)
	for i, v in ipairs(self.pageList) do
		v:refreshView(dataList[i])
	end

	local preData = dataList[1]

	if preData then
		local isNew = AtomicDataBaseViewModel.instance:isLibraryNew(preData.id)

		gohelper.setActive(self.goPrevNew, isNew)
	else
		gohelper.setActive(self.goPrevNew, false)
	end

	local nextData = dataList[3]

	if nextData then
		local isNew = AtomicDataBaseViewModel.instance:isLibraryNew(nextData.id)

		gohelper.setActive(self.goNextNew, isNew)
	else
		gohelper.setActive(self.goNextNew, false)
	end

	local curData = dataList[2]

	if curData then
		self:clearNewTag(curData.id)
	end
end

function AtomicDataBaseInfoView:clearTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function AtomicDataBaseInfoView:isInAnimaing()
	return self._tweenId ~= nil
end

function AtomicDataBaseInfoView:onDestroyView()
	AtomicDataBaseInfoViewModel.instance:clearTargetPageIndex()
	self:clearTween()
end

return AtomicDataBaseInfoView
