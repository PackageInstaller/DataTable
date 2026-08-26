-- chunkname: @modules/logic/sp02/atomic/view/AtomicAvgPlayView.lua

module("modules.logic.sp02.atomic.view.AtomicAvgPlayView", package.seeall)

local AtomicAvgPlayView = class("AtomicAvgPlayView", BaseView)

function AtomicAvgPlayView:onInitView()
	self.goBg = gohelper.findChild(self.viewGO, "BG")
	self.bgRectTransform = self.goBg.transform
	self.goContent = gohelper.findChild(self.viewGO, "img_txtlist")
	self.animContent = gohelper.findChildAnim(self.viewGO, "img_txtlist")

	self:setContentShow(false)

	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "img_txtlist/#txt_desc")
	self.btnCloseDesc = gohelper.findChildButtonWithAudio(self.viewGO, "img_txtlist/#txt_desc/#btn_close")
	self.btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_left")
	self.btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_right")
	self.btnGreen = gohelper.findChildButtonWithAudio(self.viewGO, "#go_green")
	self.btnRed = gohelper.findChildButtonWithAudio(self.viewGO, "#go_red")
	self.anim = gohelper.findComponentAnim(self.viewGO)
	self.chessRoot = gohelper.findChild(self.viewGO, "BG/chessRoot")
	self.chessRectTransform = self.chessRoot.transform

	self:initChess()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicAvgPlayView:addEvents()
	self.addClickCb(self, self.btnLeft, self.onLeftClick, self)
	self.addClickCb(self, self.btnRight, self.onRightClick, self)
	self.addClickCb(self, self.btnCloseDesc, self.onCloseDescClick, self)
	self.addClickCb(self, self.btnGreen, self.onGreenClick, self)
	self.addClickCb(self, self.btnRed, self.onRedClick, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenView, self)
end

function AtomicAvgPlayView:removeEvents()
	self:removeClickCb(self.btnLeft)
	self:removeClickCb(self.btnRight)
	self:removeClickCb(self.btnCloseDesc)
	self:removeClickCb(self.btnGreen)
	self:removeClickCb(self.btnRed)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenView, self)
end

function AtomicAvgPlayView:_editableInitView()
	return
end

function AtomicAvgPlayView:onOpenView(viewName)
	if viewName == self._waitViewName then
		self:closeThis()
	end
end

function AtomicAvgPlayView:onClickClose()
	self:playLastStory()
end

function AtomicAvgPlayView:onGreenClick()
	return
end

function AtomicAvgPlayView:onRedClick()
	if self.isContentShow then
		self:showNextContent()
	else
		self:setContentShow(true)
	end
end

function AtomicAvgPlayView:onLeftClick()
	self:showBgIndex(self.curBgIndex - 1, true)
end

function AtomicAvgPlayView:onRightClick()
	self:showBgIndex(self.curBgIndex + 1, true)
end

function AtomicAvgPlayView:onCloseDescClick()
	self:setContentShow(false)
end

function AtomicAvgPlayView:_onScreenResize()
	self:showBgIndex(self.curBgIndex)
end

function AtomicAvgPlayView:onUpdateParam()
	return
end

function AtomicAvgPlayView:onOpen()
	self:initData()
	self:showBgIndex(self.curBgIndex)
end

function AtomicAvgPlayView:onClose()
	return
end

function AtomicAvgPlayView:initChess()
	self.chessList = {}

	for i = 1, 4 do
		local item = self:getUserDataTb_()

		item.index = i
		item.go = gohelper.findChild(self.chessRoot, string.format("Chess_item%d", i))
		item.anim = gohelper.findComponentAnim(item.go)
		item.goPos1 = gohelper.findChild(item.go, "Chess")
		item.goPos2 = gohelper.findChild(item.go, "Chess2")

		table.insert(self.chessList, item)
	end

	self.chessRootPos = {
		1237,
		2737,
		4388
	}
end

function AtomicAvgPlayView:initData()
	local dataList = {}
	local list = AtomicConfig.instance:getAvgGameList()

	for i, v in ipairs(list) do
		local data = {}

		data.config = v
		data.contentIndex = 0
		data.contentList = string.split(v.content, "#")
		data.contentCount = #data.contentList
		data.hasPlayStory = false

		table.insert(dataList, data)
	end

	self.dataList = dataList
	self.dataCount = #self.dataList
	self.curBgIndex = 3
end

function AtomicAvgPlayView:refreshView()
	self:refreshUI()
	self:refreshContent()
	self:refreshChessPos()
end

function AtomicAvgPlayView:refreshUI()
	local inTween = self._tweenId ~= nil

	if inTween then
		gohelper.setActive(self.btnLeft, false)
		gohelper.setActive(self.btnRight, false)
		gohelper.setActive(self.btnGreen, false)
		gohelper.setActive(self.btnRed, false)

		return
	end

	local isShowLeft = self:isCanShowIndex(self.curBgIndex - 1)
	local isShowRight = self:isCanShowIndex(self.curBgIndex + 1)

	gohelper.setActive(self.btnLeft, isShowLeft)
	gohelper.setActive(self.btnRight, isShowRight)

	local isIndexFinish = self:isIndexFinish(self.curBgIndex)

	gohelper.setActive(self.btnGreen, isIndexFinish)
	gohelper.setActive(self.btnRed, not isIndexFinish)
end

function AtomicAvgPlayView:isCanShowIndex(index)
	if index < 1 then
		return false
	end

	return true
end

function AtomicAvgPlayView:isIndexFinish(index)
	local data = self.dataList[index]

	if not data then
		return true
	end

	return data.contentIndex >= data.contentCount
end

function AtomicAvgPlayView:getDataCount()
	return self.dataCount
end

function AtomicAvgPlayView:showBgIndex(index, tween)
	if index < 1 then
		return
	end

	self.lastIndex = self.curBgIndex
	self.curBgIndex = index

	if index > self:getDataCount() then
		self:onClickClose()

		return
	end

	local offsetX = self:getBgPosByIndex(index)

	self:clearTween()

	if tween then
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self.bgRectTransform, offsetX, 0.5, self._tweenPosFinish, self, nil, EaseType.OutCubic)
	else
		recthelper.setAnchorX(self.bgRectTransform, offsetX)
	end

	self:refreshView()
end

function AtomicAvgPlayView:refreshChessPos()
	local index = self.curBgIndex
	local pos = self.chessRootPos[index]

	recthelper.setAnchorX(self.chessRectTransform, pos)

	for i, v in ipairs(self.chessList) do
		v.anim:Play("switch", 0, 0)
	end
end

function AtomicAvgPlayView:playLastStory()
	local data = self.dataList[#self.dataList]

	if not data then
		return
	end

	if data.hasPlayStory then
		return
	end

	data.hasPlayStory = true

	local storyId = data.config.storyId

	if storyId and storyId > 0 then
		self._waitViewName = ViewName.StoryView

		StoryController.instance:playStory(storyId)
	end
end

function AtomicAvgPlayView:showDesc(desc)
	self.txtDesc.text = desc
end

function AtomicAvgPlayView:setContentShow(isShow)
	if self.isContentShow == isShow then
		return
	end

	self.isContentShow = isShow

	gohelper.setActive(self.goContent, true)
	self.animContent:Play(isShow and "open" or "close", 0, 0)

	if isShow then
		local data = self.dataList[self.curBgIndex]

		if data and data.contentIndex == 0 then
			self:showNextContent()
		end
	end
end

function AtomicAvgPlayView:showNextContent()
	local data = self.dataList[self.curBgIndex]

	if not data then
		return
	end

	if data.contentIndex >= data.contentCount then
		return
	end

	data.contentIndex = data.contentIndex + 1

	local desc = data.contentList[data.contentIndex]

	self:showDesc(desc)
	self:refreshUI()
end

function AtomicAvgPlayView:refreshContent()
	if self._tweenId then
		self:setContentShow(false)

		return
	end

	local data = self.dataList[self.curBgIndex]

	if not data then
		return
	end

	local content = data.contentList[data.contentIndex]

	self:setContentShow(content ~= nil)

	if content then
		self.txtDesc.text = content
	end
end

function AtomicAvgPlayView:_tweenPosFinish()
	self:clearTween()
	self:refreshUI()
	self:refreshContent()
end

function AtomicAvgPlayView:clearTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function AtomicAvgPlayView:getBgPosByIndex(index)
	local bgTotalWidth = recthelper.getWidth(self.bgRectTransform)
	local uiRoot = ViewMgr.instance:getUIRoot()
	local screenWidth = recthelper.getWidth(uiRoot.transform)
	local bgCount = self:getDataCount()
	local scrollRange = math.floor(bgTotalWidth - screenWidth)

	if scrollRange <= 0 or bgCount <= 1 then
		return 0
	end

	return -scrollRange * (index - 1) / (bgCount - 1)
end

function AtomicAvgPlayView:onDestroyView()
	self:clearTween()
end

return AtomicAvgPlayView
