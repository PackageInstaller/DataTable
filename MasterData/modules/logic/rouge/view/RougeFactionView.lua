-- chunkname: @modules/logic/rouge/view/RougeFactionView.lua

module("modules.logic.rouge.view.RougeFactionView", package.seeall)

local RougeFactionView = class("RougeFactionView", BaseView)

function RougeFactionView:onInitView()
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_Content")
	self._gorougepageprogress = gohelper.findChild(self.viewGO, "#go_rougepageprogress")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_start")
	self._godifficultytips = gohelper.findChild(self.viewGO, "#go_difficultytips")
	self._txtDifficultyTiitle = gohelper.findChildText(self.viewGO, "#go_difficultytips/#txt_DifficultyTiitle")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._goblock = gohelper.findChild(self.viewGO, "#go_block")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function RougeFactionView:removeEvents()
	self._btnstart:RemoveClickListener()
end

local kBlockKey = "RougeFactionView:_btnstartOnClick"

function RougeFactionView:_btnstartOnClick()
	if not self._lastSelectedIndex then
		return
	end

	UIBlockHelper.instance:startBlock(kBlockKey, 1, self.viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_preparation_open_20190325)

	local season = RougeConfig1.instance:season()
	local style = self:_selectedStyle()
	local isAnimDone = false
	local isRpcReplyed = false
	local lastItem = self._itemList[self._lastSelectedIndex]

	lastItem:setOnCloseEndCb(function()
		isAnimDone = true

		if not isRpcReplyed then
			return
		end

		UIBlockHelper.instance:endBlock(kBlockKey)
		RougeController.instance:openRougeInitTeamView()
	end)

	for _, item in ipairs(self._itemList) do
		item:playClose()
	end

	RougeRpc.instance:sendEnterRougeSelectStyleRequest(season, style, function(_, resultCode)
		if resultCode ~= 0 then
			logError("RougeFactionView:_btnstartOnClick resultCode=" .. tostring(resultCode))

			return
		end

		isRpcReplyed = true

		if not isAnimDone then
			return
		end

		UIBlockHelper.instance:endBlock(kBlockKey)
		RougeController.instance:openRougeInitTeamView()
	end)
end

function RougeFactionView:_editableInitView()
	self._btnstartGo = self._btnstart.gameObject

	self:_initScrollView()
	self:_setActiveBtnStart(false)
end

function RougeFactionView:_initScrollView()
	self._scrollViewGo = self._scrollview.gameObject
	self._scrollViewTrans = self._scrollViewGo.transform
	self._scrollViewLimitScrollCmp = self._scrollViewGo:GetComponent(gohelper.Type_LimitedScrollRect)
	self._goContentHLayout = self._goContent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self._drag = UIDragListenerHelper.New()

	self._drag:createByScrollRect(self._scrollViewLimitScrollCmp)
	self._drag:registerCallback(self._drag.EventDragging, self._onDragging, self)
end

function RougeFactionView:onUpdateParam()
	self:_setActiveBlock(false)
	self:_refresh()
end

function RougeFactionView:onOpen()
	self._lastSelectedIndex = false
	self._dataList = RougeOutsideModel.instance:getStyleInfoList(self:_versionList())

	self:_initDifficultyTips()
	self:_initPageProgress()
	self:onUpdateParam()
	self:_onSelectIndex(nil)
	self.viewContainer:registerCallback(RougeEvent.RougeFactionView_OnSelectIndex, self._onSelectIndex, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function RougeFactionView:onOpenFinish()
	self:_onScreenResize()
	self:_tweenOpenAnim()
	ViewMgr.instance:closeView(ViewName.RougeDifficultyView)
	ViewMgr.instance:closeView(ViewName.RougeCollectionGiftView)
end

function RougeFactionView:_getNewUnlockStateList()
	local res = {}
	local firstUnlockIndex

	for i, itemData in ipairs(self._dataList) do
		local style = itemData.style
		local isUnlockNewLayer = RougeOutsideModel.instance:getIsNewUnlockStyle(style)

		res[i] = isUnlockNewLayer

		if not firstUnlockIndex and isUnlockNewLayer then
			firstUnlockIndex = i
		end
	end

	return res, firstUnlockIndex
end

function RougeFactionView:_tweenOpenAnim()
	UIBlockHelper.instance:startBlock("RougeFactionView:_tweenOpenAnim", 1, self.viewName)

	local itemList = self:_getItemList()
	local newUnlockStateList, openFocusIndex = self:_getNewUnlockStateList()

	openFocusIndex = openFocusIndex or 1

	local firstItem = itemList[openFocusIndex]

	local function _animDoneCb()
		UIBlockHelper.instance:endBlock("RougeFactionView:_tweenOpenAnim")
	end

	self:_focusIndex(openFocusIndex)
	firstItem:setOnOpenEndCb(_animDoneCb)

	if newUnlockStateList[openFocusIndex] then
		firstItem:setOnOpenEndCb(nil)
		firstItem:setOnUnlockEndCb(_animDoneCb)
	else
		firstItem:setOnOpenEndCb(_animDoneCb)
	end

	for i, item in ipairs(itemList) do
		if i == 1 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)
		end

		if newUnlockStateList then
			if not newUnlockStateList[i] then
				local isNewUnlock

				if isNewUnlock ~= nil then
					local itemData = self._dataList[i]
					local style = itemData.style

					item:playOpen(isNewUnlock)

					if isNewUnlock then
						RougeOutsideModel.instance:setIsNewUnlockStyle(style, false)
					end
				else
					item:playOpen()
				end
			end
		end
	end
end

function RougeFactionView:onClose()
	self:_clearTweenId()
	self.viewContainer:unregisterCallback(RougeEvent.RougeFactionView_OnSelectIndex, self._onSelectIndex, self)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function RougeFactionView:onDestroyView()
	self:_clearTweenId()
	GameUtil.onDestroyViewMember(self, "_drag")
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

function RougeFactionView:_difficulty()
	if not self.viewParam then
		return RougeModel.instance:getDifficulty()
	end

	return self.viewParam.selectedDifficulty or RougeModel.instance:getDifficulty()
end

function RougeFactionView:_versionList()
	if not self.viewParam then
		return RougeModel.instance:getVersion()
	end

	return self.viewParam.versionList or RougeModel.instance:getVersion()
end

function RougeFactionView:_getDataList()
	self._dataList = self._dataList or RougeOutsideModel.instance:getStyleInfoList(self:_versionList())

	return self._dataList
end

function RougeFactionView:_getDataListCount()
	return #self:_getDataList()
end

function RougeFactionView:_validateIndex(index)
	local count = self:_getDataListCount()

	return GameUtil.clamp(index, 1, count)
end

function RougeFactionView:_getItemList()
	if not self._itemList then
		self:_refreshList()
	end

	return self._itemList
end

function RougeFactionView:_refresh()
	self:_refreshList()
end

function RougeFactionView:_refreshList()
	local dataList = self:_getDataList()

	self._itemDataList = dataList
	self._itemList = self._itemList or {}

	for i, mo in ipairs(dataList) do
		local item = self._itemList[i]

		if not item then
			item = self:_create_RougeFactionItem()

			item:setIndex(i)
			table.insert(self._itemList, item)
		end

		item:setData(mo)
		item:playIdle()
		item:setSelected(self._lastSelectedIndex == i)
	end
end

function RougeFactionView:_onSelectIndex(index)
	if not self._itemList then
		return
	end

	if self._lastSelectedIndex then
		local lastItem = self._itemList[self._lastSelectedIndex]

		lastItem:setSelected(false)
	end

	if self._lastSelectedIndex == index then
		index = nil

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190321)
	end

	if index then
		local curItem = self._itemList[index]

		curItem:setSelected(true)
		self.viewContainer:rebuildLayout()
		self:_focusIndex(index, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190321)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_help_switch_20190322)
	end

	self._lastSelectedIndex = index

	self:_setActiveBtnStart(index and true or false)
end

function RougeFactionView:_setActiveBtnStart(isActive)
	gohelper.setActive(self._btnstartGo, isActive)
end

function RougeFactionView:_clearTweenId()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
end

function RougeFactionView:_create_RougeFactionItem()
	local itemClass = RougeFactionItem
	local go = self.viewContainer:getResInst(RougeEnum.ResPath.rougefactionitem, self._goContent, itemClass.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass, {
		parent = self,
		baseViewContainer = self.viewContainer
	})
end

function RougeFactionView:_selectedStyle()
	if not self._lastSelectedIndex then
		return
	end

	local item = self._itemList[self._lastSelectedIndex]

	return item:style()
end

function RougeFactionView:_initPageProgress()
	local itemClass = RougePageProgress
	local go = self.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, self._gorougepageprogress, itemClass.__cname)

	self._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._pageProgress:setData()
end

function RougeFactionView:_initDifficultyTips()
	local difficulty = self:_difficulty()

	self._txtDifficultyTiitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougefactionview_txtDifficultyTiitle"), RougeConfig1.instance:getDifficultyCOTitle(difficulty))

	local styleIndex = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(difficulty)
	local red = gohelper.findChild(self._godifficultytips, "red")
	local orange = gohelper.findChild(self._godifficultytips, "orange")
	local green = gohelper.findChild(self._godifficultytips, "green")

	gohelper.setActive(green, styleIndex == 1)
	gohelper.setActive(orange, styleIndex == 2)
	gohelper.setActive(red, styleIndex == 3)
end

function RougeFactionView:_focusIndex(index, isAnim, duration)
	duration = duration or 0.3

	local scrollContentTran = self.viewContainer:getScrollContentTranform()
	local posX = self:_calcFocusIndexPosX(index)

	if isAnim then
		self:_clearTweenId()

		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(scrollContentTran, -posX, duration)
	else
		recthelper.setAnchorX(scrollContentTran, -posX)
	end
end

function RougeFactionView:_calcFocusIndexPosX(index)
	local posX = 0
	local maxScrollX = self:_getMaxScrollX()

	if index <= 1 then
		return posX, maxScrollX
	end

	local item = self._itemList[index]
	local startOffset = self._goContentHLayout.padding.left
	local viewPortWidth = self:_getViewportW()
	local offset = viewPortWidth * 0.5

	posX = GameUtil.clamp(item:posX() - startOffset - offset, 0, maxScrollX)

	return posX, maxScrollX
end

function RougeFactionView:_getViewportW()
	return recthelper.getWidth(self._scrollViewTrans)
end

function RougeFactionView:_getViewportH()
	return recthelper.getHeight(self._scrollViewTrans)
end

function RougeFactionView:_getViewportWH()
	return self:_getViewportW(), self:_getViewportH()
end

function RougeFactionView:_getMaxScrollX()
	local viewportW = self:_getViewportWH()
	local maxContentW = self:_calcContentWidth()

	return math.max(0, maxContentW - viewportW)
end

function RougeFactionView:_calcContentWidth()
	return recthelper.getWidth(self.viewContainer:getScrollContentTranform())
end

function RougeFactionView:_setActiveBlock(isActive)
	gohelper.setActive(self._goblock, isActive)
end

function RougeFactionView:_onScreenResize()
	self.viewContainer:rebuildLayout()

	if self._lastSelectedIndex then
		self:_focusIndex(self._lastSelectedIndex, true, 0.1)
	end
end

function RougeFactionView:_calcSpaceOffset()
	local listScrollParam = self.viewContainer:getListScrollParam()
	local width = self:_getViewportW()
	local cellWidth = listScrollParam.cellWidth
	local startSpace = listScrollParam.startSpace
	local res = width * 0.5 - cellWidth * 0.5 - startSpace

	return math.max(0, res)
end

function RougeFactionView:_contentPosX()
	return recthelper.getAnchorX(self.viewContainer:getScrollContentTranform())
end

local kLeftOffset = 139

function RougeFactionView:_onDragging()
	local step = self.viewContainer:getListScrollParamStep()
	local contentPosX = self:_contentPosX()

	if contentPosX >= 0 then
		return
	end

	local posX = GameUtil.clamp(-contentPosX, 0, self:_getMaxScrollX())

	if posX < kLeftOffset then
		return
	end

	posX = posX - kLeftOffset

	local index = math.ceil(posX / step)

	if self._lastScrollIndex == nil then
		self._lastScrollIndex = index
	elseif self._lastScrollIndex ~= index then
		self._lastScrollIndex = index

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_chain_20190320)
	end
end

return RougeFactionView
