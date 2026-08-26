-- chunkname: @modules/logic/weekwalk/view/WeekWalkLayerPage.lua

module("modules.logic.weekwalk.view.WeekWalkLayerPage", package.seeall)

local WeekWalkLayerPage = class("WeekWalkLayerPage", BaseChildView)

function WeekWalkLayerPage:onInitView()
	self._simagebgimg = gohelper.findChildSingleImage(self.viewGO, "#simage_bgimg")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#simage_line")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content")
	self._gopos5 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_pos5")
	self._gopos3 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_pos3")
	self._gotopblock = gohelper.findChild(self.viewGO, "#go_topblock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkLayerPage:addEvents()
	self._scrollview:AddOnValueChanged(self._setEdgFadeStrengthen, self)
end

function WeekWalkLayerPage:removeEvents()
	self._scrollview:RemoveOnValueChanged()
end

function WeekWalkLayerPage:_editableInitView()
	self._simageline:LoadImage(ResUrl.getWeekWalkBg("hw2.png"))

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._bgAnimation = self._simagebgimg.gameObject:GetComponent(typeof(UnityEngine.Animation))
end

function WeekWalkLayerPage:removeScrollDragListener(drag)
	drag:RemoveDragBeginListener()
	drag:RemoveDragEndListener()
	drag:RemoveDragListener()
end

function WeekWalkLayerPage:initScrollDragListener(drag, scroll)
	drag:AddDragBeginListener(self._onDragBegin, self, scroll)
	drag:AddDragListener(self._onDrag, self, scroll)
	drag:AddDragEndListener(self._onDragEnd, self, scroll)
end

function WeekWalkLayerPage:_onScrollValueChanged(x, y)
	if not self._curScroll then
		return
	end

	local scrollNormalizePos = self._curScroll.horizontalNormalizedPosition

	if self._curNormalizedPos and scrollNormalizePos >= 0 and scrollNormalizePos <= 1 then
		local delta = scrollNormalizePos - self._curNormalizedPos

		if math.abs(delta) >= self._cellCenterPos then
			self._curNormalizedPos = delta > 0 and self._curNormalizedPos + self._cellCenterPos or self._curNormalizedPos - self._cellCenterPos
			self._curNormalizedPos = scrollNormalizePos

			if delta <= -self._cellCenterPos and scrollNormalizePos <= 0 then
				return
			end

			AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_slip)
		end
	end
end

function WeekWalkLayerPage:_onDragBegin(scroll, pointerEventData)
	self._beginDragScrollNormalizePos = scroll.horizontalNormalizedPosition
	self._beginDrag = true

	self:initNormalizePos(scroll)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_slipmap)
end

function WeekWalkLayerPage:initNormalizePos(scroll)
	local contentWidth = recthelper.getWidth(scroll.content)
	local scrollWidth = recthelper.getWidth(scroll.transform)
	local transform = scroll.content
	local itemCount = transform.childCount

	if itemCount == 0 then
		return
	end

	local child = transform:GetChild(itemCount - 1)
	local childWidth = recthelper.getWidth(child)
	local deltaWidth = contentWidth - scrollWidth

	if deltaWidth > 0 then
		local showNum = deltaWidth / childWidth
		local cellWidth = 1 / showNum

		self._cellCenterPos = cellWidth / 3
		self._curNormalizedPos = scroll.horizontalNormalizedPosition

		if self._curScroll then
			self._curScroll = nil
		end

		self._curScroll = scroll
	else
		self._curNormalizedPos = nil
	end
end

function WeekWalkLayerPage:_onDrag(scroll, pointerEventData)
	if self._beginDrag then
		self._beginDrag = false

		return
	end

	if self._beginDragScrollNormalizePos then
		self._beginDragScrollNormalizePos = nil
	end
end

function WeekWalkLayerPage:_onDragEnd(scroll, pointerEventData)
	self._beginDrag = false
	self._beginDragScrollNormalizePos = nil
end

function WeekWalkLayerPage:playAnim(name)
	if not self._animatorPlayer then
		return
	end

	self._animName = name

	self._animatorPlayer:Play(name, self._animDone, self)
	gohelper.setActive(self._gotopblock, true)
	TaskDispatcher.cancelTask(self._hideBlock, self)
	TaskDispatcher.runDelay(self._hideBlock, self, 0.5)
end

function WeekWalkLayerPage:_hideBlock()
	gohelper.setActive(self._gotopblock, false)
end

function WeekWalkLayerPage:playBgAnim(name)
	self._bgAnimation:Play(name)
end

function WeekWalkLayerPage:_animDone()
	if self._animName == "weekwalklayerpage_in" then
		self:_changeRightBtnVisible()
	end

	if self._visible then
		for i, v in ipairs(self._itemList) do
			v:updateUnlockStatus()
		end
	end
end

function WeekWalkLayerPage:onUpdateParam()
	return
end

function WeekWalkLayerPage:setVisible(value)
	self._visible = value
end

function WeekWalkLayerPage:getVisible()
	return self._visible
end

function WeekWalkLayerPage:resetPos(mapId)
	if mapId then
		for i, v in ipairs(self._layerList) do
			if v.id == mapId then
				self:focusPos(i)

				return
			end
		end
	end

	for i, v in ipairs(self._layerList) do
		local mapInfo = WeekWalkModel.instance:getMapInfo(v.id)

		if mapInfo and mapInfo.isFinish <= 0 then
			self:focusPos(i)

			return
		end

		if not mapInfo and i == 1 then
			self._scrollview.horizontalNormalizedPosition = 0

			return
		end
	end

	for i, v in ipairs(self._layerList) do
		local mapInfo = WeekWalkModel.instance:getMapInfo(v.id)

		if mapInfo then
			local cur, total = mapInfo:getStarInfo()

			if cur ~= total then
				self:focusPos(i)

				return
			end
		end
	end

	self._scrollview.horizontalNormalizedPosition = 1
end

function WeekWalkLayerPage:focusPos(index)
	local item = self._itemList[index]

	if not item then
		return
	end

	local pos = item._relativeAnchorPos

	recthelper.setAnchorX(self._gocontent.transform, -pos.x + 300)
end

function WeekWalkLayerPage:onOpen()
	self._layerView = self.viewParam[1]
	self._pageIndex = self.viewParam[2]
	self._layerList = self.viewParam[3]
	self._itemList = self:getUserDataTb_()

	self:_initItems()

	if WeekWalkLayerView.isShallowPage(self._pageIndex) then
		if self._pageIndex <= 1 then
			self._simagebgimg:LoadImage(ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_1"))
		else
			self._simagebgimg:LoadImage(ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_2"))
		end
	else
		self._simagebgimg:LoadImage(ResUrl.getWeekWalkLayerIcon("full/bg_choose_deep"))
	end

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollview.gameObject)

	self:initScrollDragListener(self._drag, self._scrollview)
	gohelper.setActive(self._goshallowicon, WeekWalkLayerView.isShallowPage(self._pageIndex))
	gohelper.setActive(self._godeepicon, not WeekWalkLayerView.isShallowPage(self._pageIndex))
	self:_setEdgFadeStrengthen()
end

function WeekWalkLayerPage:updateLayerList(layerList)
	self._layerList = layerList

	self:_initItems()
end

function WeekWalkLayerPage:_initItems()
	gohelper.setActive(self._gopos3, false)
	gohelper.setActive(self._gopos5, false)

	local isDeep = #self._layerList ~= WeekWalkEnum.ShallowLayerMaxNum
	local go = self._gopos5
	local isNewDeep = #self._layerList == WeekWalkEnum.NewDeepLayerMaxNum

	gohelper.setActive(go, true)

	local transform = go.transform

	for i, v in ipairs(self._layerList) do
		local childGo = transform:GetChild(i - 1).gameObject

		self:_addItem(childGo, v, i)
	end

	if isDeep then
		if isNewDeep then
			recthelper.setWidth(self._gocontent.transform, 3932)
		else
			recthelper.setWidth(self._gocontent.transform, 3400)
		end
	end
end

function WeekWalkLayerPage:_addItem(parentGo, itemCfg, index)
	if self._itemList[index] then
		return
	end

	local path = self._layerView.viewContainer:getSetting().otherRes[2]
	local itemGo = self._layerView.viewContainer:getResInst(path, parentGo)

	itemGo.name = "weekwalklayerpageitem" .. itemCfg.layer

	local pageItem = MonoHelper.addLuaComOnceToGo(itemGo, WeekWalkLayerPageItem, {
		itemCfg,
		self._pageIndex,
		self
	})

	pageItem._relativeAnchorPos = recthelper.rectToRelativeAnchorPos(itemGo.transform.position, self._gocontent.transform)
	self._itemList[index] = pageItem
end

function WeekWalkLayerPage:_setEdgFadeStrengthen(x, y)
	if self._scrollview.horizontalNormalizedPosition < 0.01 then
		self._scrollview.horizontalNormalizedPosition = 0
	end

	local value = Mathf.Clamp(Mathf.Abs(self._scrollview.horizontalNormalizedPosition * 8), 0, 1)

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnScrollPage, value, self._pageIndex)
	self:_changeRightBtnVisible()
	self:_onScrollValueChanged(x, y)
end

function WeekWalkLayerPage:_changeRightBtnVisible()
	if not WeekWalkLayerView.isShallowPage(self._pageIndex) or not self._visible or not self._scrollview then
		return
	end

	local pos = self._scrollview.horizontalNormalizedPosition

	if pos >= 0.95 then
		self._showRightBtn = true

		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnChangeRightBtnVisible, self._showRightBtn)
	elseif pos <= 0.5 and self._showRightBtn then
		self._showRightBtn = false

		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnChangeRightBtnVisible, self._showRightBtn)
	end
end

function WeekWalkLayerPage:onClose()
	TaskDispatcher.cancelTask(self._hideBlock, self)
	self._animatorPlayer:Stop()

	if self._drag then
		self:removeScrollDragListener(self._drag)
	end

	for i, v in ipairs(self._itemList) do
		v:onDestroy()
	end
end

function WeekWalkLayerPage:onDestroyView()
	self._simagebgimg:UnLoadImage()
	self._simageline:UnLoadImage()
end

return WeekWalkLayerPage
