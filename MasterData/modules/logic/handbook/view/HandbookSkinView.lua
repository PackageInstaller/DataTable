-- chunkname: @modules/logic/handbook/view/HandbookSkinView.lua

local UIAnimationName = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinView", package.seeall)

local HandbookSkinView = class("HandbookSkinView", BaseView)
local ItemCellHeight = 170
local VisableItemCount = 5
local upTabAnimationName = "up_start"
local downTabAnimationName = "donw_start"

function HandbookSkinView:onInitView()
	self._skinItemRoot = gohelper.findChild(self.viewGO, "#go_scroll/#go_storyStages")
	self._imageBg = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._imageSkinSuitGroupIcon = gohelper.findChildImage(self.viewGO, "Left/#image_Icon")
	self._imageSkinSuitGroupEnIcon = gohelper.findChildImage(self.viewGO, "Left/#image_TitleEn")
	self._textPlayerName = gohelper.findChildText(self.viewGO, "title/#title_name")
	self._txtFloorName = gohelper.findChildText(self.viewGO, "Left/#txt_Name")
	self._goFestivalTitle = gohelper.findChild(self.viewGO, "festival_title")
	self._goFestivalRedDot = gohelper.findChild(self.viewGO, "festival_title/#go_festivalRedDotRoot")
	self._txtFloorThemeDescr = gohelper.findChildText(self.viewGO, "Left/#txt_Descr")
	self._goFloorItemRoot = gohelper.findChild(self.viewGO, "Right/Scroll View/Viewport/Content")
	self._goFloorItem = gohelper.findChild(self.viewGO, "Right/Scroll View/Viewport/Content/Buttnitem")
	self._goSwitch = gohelper.findChild(self.viewGO, "switch")
	self._gopoint = gohelper.findChild(self.viewGO, "#point")
	self._goscroll = gohelper.findChild(self.viewGO, "scroll")
	self._scroll = SLFramework.UGUI.UIDragListener.Get(self._goscroll)
	self._itemScrollRect = gohelper.findChildScrollRect(self.viewGO, "Right/Scroll View")
	self._goContent = gohelper.findChild(self.viewGO, "Right/Scroll View/Viewport/Content")
	self._goScrollListArrow = gohelper.findChild(self.viewGO, "Right/arrow")
	self._btnArrow = gohelper.findChildButton(self.viewGO, "Right/arrow/#go_arrowreddot/#btn_arrow")
	self._goArrowRedDot = gohelper.findChild(self.viewGO, "Right/arrow/#go_arrowreddot")
	self._arrowNewRedDot = RedDotController.instance:addNotEventRedDot(self._goArrowRedDot)

	self._arrowNewRedDot:setShowType(RedDotEnum.Style.Green)
	self._arrowNewRedDot:setCheckShowRedDotFunc(self.refreshArrowRedDot, self)
	self._arrowNewRedDot:refreshRedDot()

	self._arrowAnimator = self._goScrollListArrow:GetComponent(typeof(UnityEngine.Animator))
	self._scrollHeight = recthelper.getHeight(self._itemScrollRect.transform)
	self._viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._viewAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookSkinView:addEvents()
	self.addEventCb(self, self.viewContainer, HandbookEvent.SkinPointChanged, self._refresPoint, self)
	self.addEventCb(self, self.viewContainer, HandbookEvent.OnClickTarotSkinSuit, self._onEnterTarotMode, self)
	self.addEventCb(self, self.viewContainer, HandbookEvent.OnExitTarotSkinSuit, self._onExitTarotMode, self)
	self.addEventCb(self, self.viewContainer, HandbookEvent.OnClickFestivalSkinSuit, self._onEnterFestivalSkinSuit, self)
	self.addEventCb(self, self.viewContainer, HandbookEvent.OnExitFestivalSkinSuit, self._onExitFestivalSkinSuit, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.OnClickSkinSuitFloorItem, self.onClickFloorItem, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, self.refreshSkinRedDot, self)

	if HandbookController.instance:hasAnyHandBookSkinGroupRedDot() then
		self._itemScrollRect:AddOnValueChanged(self._onScrollChange, self)
	end

	self._scroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._scroll:AddDragEndListener(self._onScrollDragEnd, self)
	self._scroll:AddDragListener(self._onScrollDragging, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
end

function HandbookSkinView:removeEvents()
	self._itemScrollRect:RemoveOnValueChanged()
	self._scroll:RemoveDragBeginListener()
	self._scroll:RemoveDragEndListener()
	self._scroll:RemoveDragListener()
	self._btnArrow:RemoveClickListener()
	self.dropClick:RemoveClickListener()
	self._dropFilter:RemoveOnValueChanged()

	if self.dropExtend then
		self.dropExtend:dispose()
	end

	self.removeEventCb(self, HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, self.refreshSkinRedDot, self)
end

function HandbookSkinView:_onScrollChange(value)
	self:refreshTabListArrow()
end

function HandbookSkinView:_onScrollDragBegin(param, eventData)
	self.scrollDragPos = eventData.position
	self._scrollDragOffsetX = 0
	self._scrollDragOffsetY = 0

	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideBegin)
end

function HandbookSkinView:_onScrollDragging(param, eventData)
	self.scrollDragPos = self.scrollDragPos or eventData.position

	local moveOffset = eventData.position - self.scrollDragPos

	self.scrollDragPos = eventData.position

	local skinGroupId = self._skinSuitFloorCfgList[self._curSelectedIdx].id

	if HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Tarot then
		HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlide, moveOffset.x)
	else
		self._scrollDragOffsetX = self._scrollDragOffsetX + moveOffset.x
		self._scrollDragOffsetY = self._scrollDragOffsetY + moveOffset.y

		HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlide, -moveOffset.x, -moveOffset.y)
	end
end

function HandbookSkinView:_onScrollDragEnd(param, eventData)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideEnd)

	self._slideToOtherSuit = false
end

function HandbookSkinView:slideToPre()
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideToPre)
end

function HandbookSkinView:slideToNext()
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideToNext)
end

function HandbookSkinView:_editableInitView()
	self._gopointItem = gohelper.findChild(self.viewGO, "#point/point_item")
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	gohelper.setActive(self._goFloorItem, false)
	gohelper.setActive(self._goSwitch, false)

	self._pointItemTbList = {
		self:_createPointTB(self._gopointItem)
	}
	self._skinSuitFloorCfgList = HandbookConfig.instance:getSkinThemeGroupCfgs(true, true)
	self._festivalRedDot = RedDotController.instance:addNotEventRedDot(self._goFestivalRedDot)

	self._festivalRedDot:setShowType(RedDotEnum.Style.Green)
	self._festivalRedDot:setCheckShowRedDotFunc(self.refreshArrowRedDot, self)
	self._festivalRedDot:refreshRedDot()
end

function HandbookSkinView:onOpen()
	local viewParam = self.viewParam

	if viewParam then
		self._defaultSelectedIdx = viewParam.defaultSelectedIdx or HandbookController.instance:getDefaultHandbookSkinGroupId(self._skinSuitFloorCfgList)
	end

	self._curSelectedIdx = self._defaultSelectedIdx

	self:_createFloorItems()
	self:_refreshDesc()

	local playerName = PlayerModel.instance:getPlayinfo().name

	playerName = playerName and playerName or ""
	self._textPlayerName.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("handbookskinview_playername"), playerName)

	self:initFilterDrop()
	self:refreshSkinRedDot()
end

function HandbookSkinView:onOpenFinish()
	self:refreshTabListArrow()
	self:_scrollToFirstRedDotFloorItem()
end

function HandbookSkinView:refreshArrowRedDot()
	return true
end

function HandbookSkinView:_onClickArrow()
	self:_scrollToNextRedDotFloorItem()
end

function HandbookSkinView:_scrollToNextRedDotFloorItem()
	if not self._skinSuitFloorItems or not self._itemScrollRect then
		return
	end

	local contentTrans = self._goContent.transform
	local curY = contentTrans.localPosition.y
	local visibleBottom = -self._scrollHeight - curY
	local targetItem

	for _, item in ipairs(self._skinSuitFloorItems) do
		if item and item.hasRedDot and item:hasRedDot() then
			local itemY = item.viewGO.transform.localPosition.y

			if itemY < visibleBottom - ItemCellHeight / 2 and (not targetItem or itemY > targetItem.viewGO.transform.localPosition.y) then
				targetItem = item
			end
		end
	end

	if not targetItem then
		return
	end

	local contentHeight = recthelper.getHeight(contentTrans)
	local maxScroll = math.max(0, contentHeight - self._scrollHeight)

	if maxScroll <= 0 then
		return
	end

	local itemY = targetItem.viewGO.transform.localPosition.y
	local targetY = ItemCellHeight - itemY - self._scrollHeight

	targetY = math.max(0, math.min(maxScroll, targetY))
	self._itemScrollRect.verticalNormalizedPosition = 1 - GameUtil.saturate(targetY / maxScroll)

	self:refreshTabListArrow()
	self:clickFloorItemAction(targetItem)
end

function HandbookSkinView:_scrollToFirstRedDotFloorItem()
	if not self._skinSuitFloorItems or not self._itemScrollRect then
		return
	end

	local targetItem

	for _, item in ipairs(self._skinSuitFloorItems) do
		if item and item.hasRedDot and item:hasRedDot() then
			targetItem = item

			break
		end
	end

	if not targetItem then
		return
	end

	local contentTrans = self._goContent.transform
	local contentHeight = recthelper.getHeight(contentTrans)
	local maxScroll = math.max(0, contentHeight - self._scrollHeight)

	if maxScroll <= 0 then
		return
	end

	local itemY = targetItem.viewGO.transform.localPosition.y
	local targetY = ItemCellHeight - itemY - self._scrollHeight

	targetY = math.max(0, math.min(maxScroll, targetY))
	self._itemScrollRect.verticalNormalizedPosition = 1 - GameUtil.saturate(targetY / maxScroll)

	self:refreshTabListArrow()
	self:clickFloorItemAction(targetItem)
end

function HandbookSkinView:refreshTabListArrow()
	self._contentHeight = recthelper.getHeight(self._goContent.transform)

	local itemCount = self._floorNum

	if itemCount <= VisableItemCount then
		gohelper.setActive(self._goScrollListArrow, false)
	else
		local hasRedDot = false
		local bottomY = 0

		for idx, skinFloorItem in ipairs(self._skinSuitFloorItems) do
			if skinFloorItem:hasRedDot() then
				local tabTrans = skinFloorItem.viewGO.transform
				local y = tabTrans.localPosition.y

				bottomY = math.min(y, bottomY)
				hasRedDot = true
			end
		end

		local deepestRedDotHeight = math.abs(bottomY)
		local contentTrans = self._goContent.transform
		local y = contentTrans.localPosition.y
		local hasUnShowItem = y - self._scrollHeight < ItemCellHeight
		local showArrowEffect = deepestRedDotHeight - self._scrollHeight - y > ItemCellHeight / 2

		if showArrowEffect then
			self._arrowAnimator:Play(UIAnimationName.Loop)
		else
			self._arrowAnimator:Play(UIAnimationName.Idle)
		end

		gohelper.setActive(self._goScrollListArrow, hasUnShowItem)
		gohelper.setActive(self._goArrowRedDot, hasRedDot and showArrowEffect)
	end
end

function HandbookSkinView:_refreshDesc()
	local suitSceneType = HandbookEnum.SkinSuitId2SceneType[self._skinThemeCfg.id]

	if not suitSceneType then
		gohelper.setActive(self._txtFloorThemeDescr.gameObject, true)
		gohelper.setActive(self._txtFloorName.gameObject, true)
		gohelper.setActive(self._imageSkinSuitGroupEnIcon.gameObject, true)
		gohelper.setActive(self._imageSkinSuitGroupIcon.gameObject, true)

		self._txtFloorThemeDescr.text = self._skinThemeCfg.des
		self._txtFloorName.text = self._skinThemeCfg.name

		UISpriteSetMgr.instance:setSkinHandbook(self._imageSkinSuitGroupEnIcon, self._skinThemeCfg.nameRes, true)
		UISpriteSetMgr.instance:setSkinHandbook(self._imageSkinSuitGroupIcon, self._skinThemeCfg.iconRes, true)
	else
		gohelper.setActive(self._txtFloorThemeDescr.gameObject, false)
		gohelper.setActive(self._txtFloorName.gameObject, false)
		gohelper.setActive(self._imageSkinSuitGroupEnIcon.gameObject, false)
		gohelper.setActive(self._imageSkinSuitGroupIcon.gameObject, false)
	end

	gohelper.setActive(self._goFestivalTitle, suitSceneType == HandbookEnum.SkinSuitSceneType.Festival)
end

function HandbookSkinView:_createFloorItems()
	self._skinSuitFloorItems = {}
	self._skinSuitFloorCfgList = HandbookConfig.instance:getSkinThemeGroupCfgs(true, true)
	self._floorNum = #self._skinSuitFloorCfgList

	gohelper.CreateObjList(self, self._createFloorItem, self._skinSuitFloorCfgList, self._goFloorItemRoot, self._goFloorItem, HandbookSkinFloorItem)
end

function HandbookSkinView:_createFloorItem(itemComp, data, index)
	itemComp:onUpdateData(data, index)
	itemComp:refreshRedDot()
	itemComp:refreshSelectState(index == self._curSelectedIdx)
	itemComp:refreshFloorView()
	itemComp:setClickAction(self.clickFloorItemAction, self)
	itemComp:refreshCurSuitIdx()

	if self._curSelectedIdx == index then
		local cfg = self._skinSuitFloorCfgList[index]

		self._skinThemeCfg = cfg

		HandbookController.instance:statSkinTab((cfg or nil) and (cfg.id or index))
	end

	self._skinSuitFloorItems[index] = itemComp
end

function HandbookSkinView:clickFloorItemAction(item)
	if self._tarotMode then
		return
	end

	HandbookController.instance:dispatchEvent(HandbookEvent.OnClickSkinSuitFloorItem, item:getIdx())
end

function HandbookSkinView:onClickFloorItem(index)
	if self._curSelectedIdx == index then
		return
	end

	if index > self._curSelectedIdx then
		self._isUp = true

		self._viewAnimatorPlayer:Play(downTabAnimationName, self.onClickFloorAniDone, self)
	else
		self._isUp = false

		self._viewAnimatorPlayer:Play(upTabAnimationName, self.onClickFloorAniDone, self)
	end

	self._curSelectedIdx = index

	local floorItem = self._skinSuitFloorItems[index]

	self._needSelectRedDotSuit = floorItem and floorItem:hasRedDot() or false

	self:refreshSkinRedDot()
end

function HandbookSkinView:refreshSkinRedDot()
	self:refreshTabListArrow()

	local showFestivalRedDot = HandbookController.instance:isHandbookSkinSuitNewRedDotShow(HandbookEnum.SkinSuitLowEnum.Festival)

	gohelper.setActive(self._goFestivalRedDot.gameObject, showFestivalRedDot)
end

function HandbookSkinView:onClickFloorAniDone()
	for i, item in ipairs(self._skinSuitFloorItems) do
		item:refreshSelectState(i == self._curSelectedIdx)
	end

	local cfg = self._skinSuitFloorCfgList[self._curSelectedIdx]

	self._skinThemeCfg = cfg

	HandbookController.instance:statSkinTab((cfg or nil) and (cfg.id or self._curSelectedIdx))
	self:_refreshDesc()
	TaskDispatcher.runDelay(self.onSwitchFloorDone, self, 0.1)
	self:updateFilterDrop()
end

function HandbookSkinView:onSwitchFloorDone()
	local switchDoneAni = self._isUp and "donw_end" or "up_end"

	self._viewAnimatorPlayer:Play(switchDoneAni)
	HandbookController.instance:dispatchEvent(HandbookEvent.SwitchSkinSuitFloorDone)
end

function HandbookSkinView:_refresPoint(idx, num)
	idx = idx or 1
	num = num or 0

	for i = #self._pointItemTbList + 1, num do
		local go = gohelper.cloneInPlace(self._gopointItem)
		local itemTb = self:_createPointTB(go, i)

		table.insert(self._pointItemTbList, itemTb)
	end

	for i = 1, #self._pointItemTbList do
		local itemTb = self._pointItemTbList[i]

		gohelper.setActive(itemTb.golight, i == idx)
		gohelper.setActive(itemTb.go, i <= num and num > 1)
	end

	if self._dropFilter then
		self._dropFilter:SetValue(#self._suitCfgList - idx)
	end
end

function HandbookSkinView:_createPointTB(go, idx)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.golight = gohelper.findChild(go, "light")

	return tb
end

function HandbookSkinView:_clickToSuit(idx)
	idx = idx and idx or 1

	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideByClick, idx)
end

function HandbookSkinView:_onEnterTarotMode()
	self._tarotMode = true

	self._viewAnimatorPlayer:Play(UIAnimationName.Close)
end

function HandbookSkinView:_onExitTarotMode()
	self._tarotMode = false

	self._viewAnimatorPlayer:Play(UIAnimationName.Back)
end

function HandbookSkinView:_onEnterFestivalSkinSuit()
	self._viewAnimatorPlayer:Play(UIAnimationName.Close)
end

function HandbookSkinView:_onExitFestivalSkinSuit()
	self._viewAnimatorPlayer:Play(UIAnimationName.Back)
end

function HandbookSkinView:initFilterDrop()
	if not self._dropFilter then
		self._dropFilter = gohelper.findChildDropdown(self.viewGO, "Left/#drop_filter")
		self._goDrop = self._dropFilter.gameObject
		self.dropArrowTr = gohelper.findChildComponent(self._goDrop, "Arrow", gohelper.Type_Transform)
		self.dropClick = gohelper.getClick(self._goDrop)
		self.dropExtend = DropDownExtend.Get(self._goDrop)

		self.dropExtend:init(self.onDropShow, self.onDropHide, self)
		self.dropClick:AddClickListener(function()
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
		end, self)
	end

	self._curskinSuitGroupCfg = self._skinSuitFloorCfgList[self._curSelectedIdx]
	self._curSuitGroupId = self._curskinSuitGroupCfg.id
	self._suitCfgList = HandbookConfig.instance:getSkinSuitCfgListInGroup(self._curskinSuitGroupCfg.id)

	table.sort(self._suitCfgList, function(a, b)
		if a.show == 1 and b.show == 0 then
			return false
		elseif a.show == 0 and b.show == 1 then
			return true
		else
			return a.id < b.id
		end
	end)

	local dropStrList = {}

	for i, cfg in ipairs(self._suitCfgList) do
		if cfg.show == 1 then
			if not self._suitCfgList[i].name then
				local suitName = luaLang("skinhandbook_lock_suit")

				table.insert(dropStrList, suitName)
			end
		end
	end

	self._dropFilter:ClearOptions()
	self._dropFilter:AddOptions(dropStrList)
	self._dropFilter:SetValue(#self._suitCfgList - 1)
	self._dropFilter:AddOnValueChanged(self.onDropValueChanged, self)
end

function HandbookSkinView:updateFilterDrop()
	self._curskinSuitGroupCfg = self._skinSuitFloorCfgList[self._curSelectedIdx]
	self._curSuitGroupId = self._curskinSuitGroupCfg.id
	self._suitCfgList = HandbookConfig.instance:getSkinSuitCfgListInGroup(self._curskinSuitGroupCfg.id)

	table.sort(self._suitCfgList, function(a, b)
		if a.show == 1 and b.show == 0 then
			return false
		elseif a.show == 0 and b.show == 1 then
			return true
		else
			return a.id < b.id
		end
	end)
	gohelper.setActive(self._goDrop, #self._suitCfgList > 1)

	local dropStrList = {}

	for i, cfg in ipairs(self._suitCfgList) do
		if cfg.show == 1 then
			if not self._suitCfgList[i].name then
				local suitName = luaLang("skinhandbook_lock_suit")

				table.insert(dropStrList, suitName)
			end
		end
	end

	self._dropFilter:ClearOptions()
	self._dropFilter:AddOptions(dropStrList)

	local targetIdx = #self._suitCfgList

	if self._needSelectRedDotSuit then
		for i, cfg in ipairs(self._suitCfgList) do
			if HandbookController.instance:isHandbookSkinSuitNewRedDotShow(cfg.id) then
				targetIdx = i - 1

				break
			end
		end
	end

	self._needSelectRedDotSuit = nil

	self._dropFilter:SetValue(targetIdx)
end

function HandbookSkinView:onDropHide()
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookDropListOpen, false)
end

function HandbookSkinView:onDropShow()
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookDropListOpen, true)
end

function HandbookSkinView:onDropValueChanged(index)
	index = #self._suitCfgList - index

	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideByClick, index)
end

function HandbookSkinView:onClose()
	return
end

function HandbookSkinView:onDestroyView()
	return
end

return HandbookSkinView
