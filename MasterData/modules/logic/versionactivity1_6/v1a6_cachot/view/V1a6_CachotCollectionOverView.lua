-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionOverView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionOverView", package.seeall)

local V1a6_CachotCollectionOverView = class("V1a6_CachotCollectionOverView", BaseView)

function V1a6_CachotCollectionOverView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._gounlockeditem = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem")
	self._simageframe = gohelper.findChildSingleImage(self.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#simage_frame")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#simage_collection")
	self._gogrid1 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid1")
	self._simageget = gohelper.findChildSingleImage(self.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid1/#simage_get")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid1/#simage_get/#simage_icon")
	self._gogrid2 = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid2")
	self._txtdec = gohelper.findChildText(self.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#txt_dec")
	self._txtname = gohelper.findChildText(self.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#txt_name")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._golayout = gohelper.findChild(self.viewGO, "#go_tips/#go_layout")
	self._txtcollectionname = gohelper.findChildText(self.viewGO, "#go_tips/#go_layout/top/#txt_collectionname")
	self._goeffectcontainer = gohelper.findChild(self.viewGO, "#go_tips/#go_layout/#go_effectcontainer")
	self._goskills = gohelper.findChild(self.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_skills")
	self._goskilldescitem = gohelper.findChild(self.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_skills/#go_skilldescitem")
	self._gospdescs = gohelper.findChild(self.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_spdescs")
	self._gospdescitem = gohelper.findChild(self.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_spdescs/#go_spdescitem")
	self._btncloseTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tips/#btn_closetips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionOverView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncloseTips:AddClickListener(self._btnclosetipsOnClick, self)
end

function V1a6_CachotCollectionOverView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btncloseTips:RemoveClickListener()
end

function V1a6_CachotCollectionOverView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotCollectionOverView:_btnclosetipsOnClick()
	gohelper.setActive(self._gotips, false)
end

function V1a6_CachotCollectionOverView:_editableInitView()
	gohelper.setActive(self._gotips, false)
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnClickCachotOverItem, self.onClickCachotOverItem, self)
end

function V1a6_CachotCollectionOverView:onUpdateParam()
	return
end

function V1a6_CachotCollectionOverView:onOpen()
	V1a6_CachotCollectionOverListModel.instance:onInitData()
	self:initScrollInfo()
end

function V1a6_CachotCollectionOverView:onClickCachotOverItem(collectionMOId)
	local collectionMO = V1a6_CachotCollectionOverListModel.instance:getById(collectionMOId)
	local collectionCfgId = collectionMO and collectionMO.cfgId
	local collectionConfig = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectionCfgId)

	if collectionConfig then
		self._txtcollectionname.text = collectionConfig.name

		V1a6_CachotCollectionHelper.refreshSkillDesc(collectionConfig, self._goskills, self._goskilldescitem)
		V1a6_CachotCollectionHelper.refreshEnchantDesc(collectionConfig, self._gospdescs, self._gospdescitem)
		self:setCollectionTipsPos(collectionMOId)
	end
end

function V1a6_CachotCollectionOverView:initScrollInfo()
	self._luaListScrollView = self.viewContainer:getScrollView()
	self._csScrollView = self._luaListScrollView:getCsListScroll()
	self._scrollLineCount = self._luaListScrollView._param.lineCount
	self._scrollCellWidth = self._luaListScrollView._param.cellWidth
	self._scrollCellHeight = self._luaListScrollView._param.cellHeight
	self._singleItemHeightAndSpace = self._scrollCellHeight + self._luaListScrollView._param.cellSpaceV
	self._singleItemWidthAndSpace = self._scrollCellWidth + self._luaListScrollView._param.cellSpaceH
	self._scrollStartSpace = self._luaListScrollView._param.startSpace
	self._scrollHeight = recthelper.getHeight(self._scrollview.transform)
	self._scrollWidth = recthelper.getWidth(self._scrollview.transform)
	self._scrollDir = self._luaListScrollView._param.scrollDir
end

local moveScrollDurationPerPixel = 0.001

function V1a6_CachotCollectionOverView:setCollectionTipsPos(collectionId)
	local mo = V1a6_CachotCollectionOverListModel.instance:getById(collectionId)
	local index = V1a6_CachotCollectionOverListModel.instance:getIndex(mo)

	if index and index > 0 then
		self._lineIndex = math.ceil(index / self._scrollLineCount)
		self._countIndex = index - (self._lineIndex - 1) * self._scrollLineCount

		local collectionItemRect = self:getCollectionItemRectValue(index)
		local cutoutPixelRect = self:getCutOutPixelRect(collectionItemRect)
		local isNeedMoveScroll = cutoutPixelRect.z > 0 or cutoutPixelRect.w > 0

		if isNeedMoveScroll then
			self:onMoveScroll2Focus(collectionItemRect, cutoutPixelRect)
		else
			self:onScrollContentFinishedCallBack()
		end
	end
end

function V1a6_CachotCollectionOverView:onMoveScroll2Focus(collectionItemRect, cutoutPixelRect)
	UIBlockMgr.instance:startBlock("V1a6_CachotCollectionOverView")
	UIBlockMgrExtend.instance.setNeedCircleMv(false)

	local needScrollPixel = self:getNeedMoveScrollPixel(collectionItemRect, cutoutPixelRect)
	local duration, curScrollPixel, targetScrollPixel = self:getTragetScrollPixelAndDuration(needScrollPixel)

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(curScrollPixel, targetScrollPixel, duration, self.onScrollContentCallBack, self.onScrollContentFinishedCallBack, self, nil, EaseType.Linear)
end

function V1a6_CachotCollectionOverView:getCutOutPixelRect(collectionItemRect)
	local rectMinX, rectMaxX, rectMinY, rectMaxY = collectionItemRect.x, collectionItemRect.y, collectionItemRect.z, collectionItemRect.w
	local cellWidth = rectMaxX - rectMinX
	local cellHeight = rectMaxY - rectMinY
	local minViewRectX, maxViewRectX, minViewRectY, maxViewRectY = self:getScrollViewRect()
	local bothAreaMinX = rectMinX < minViewRectX and minViewRectX or rectMinX
	local bothAreaMaxX = maxViewRectX < rectMaxX and maxViewRectX or rectMaxX
	local bothAreaMinY = rectMinY < minViewRectY and minViewRectY or rectMinY
	local bothAreaMaxY = maxViewRectY < rectMaxY and maxViewRectY or rectMaxY
	local bothAreaWidth = bothAreaMaxX - bothAreaMinX
	local bothAreaHeight = bothAreaMaxY - bothAreaMinY

	if bothAreaWidth > 0 then
		if not (cellWidth - bothAreaWidth) then
			local clipAreaWidth = cellWidth

			if bothAreaHeight > 0 then
				if not (cellHeight - bothAreaHeight) then
					local clipAreaHeight = cellHeight

					return Vector4(bothAreaMinX, bothAreaMinY, clipAreaWidth, clipAreaHeight)
				end
			end
		end
	end
end

function V1a6_CachotCollectionOverView:getScrollViewRect()
	local minViewRectX, maxViewRectX, minViewRectY, maxViewRectY = 0, 0, 0, 0

	if self._scrollDir == ScrollEnum.ScrollDirV then
		minViewRectY = self._csScrollView.VerticalScrollPixel
		maxViewRectY = self._csScrollView.VerticalScrollPixel + self._scrollHeight
	else
		minViewRectX = self._csScrollView.HorizontalScrollPixel
		maxViewRectX = self._csScrollView.HorizontalScrollPixel + self._scrollWidth
	end

	return minViewRectX, maxViewRectX, minViewRectY, maxViewRectY
end

function V1a6_CachotCollectionOverView:getCollectionItemRectValue()
	if self._scrollDir == ScrollEnum.ScrollDirH then
		if not self._scrollStartSpace then
			local rectMinX = 0

			if self._scrollDir == ScrollEnum.ScrollDirV then
				if not self._scrollStartSpace then
					local rectMinY = 0

					rectMinY = rectMinY + (self._lineIndex - 1) * self._singleItemHeightAndSpace

					local rectMaxY = rectMinY + self._singleItemHeightAndSpace

					rectMinX = rectMinX + self._singleItemWidthAndSpace * self._countIndex

					local rectMaxX = rectMinX + self._singleItemWidthAndSpace

					return Vector4(rectMinX, rectMaxX, rectMinY, rectMaxY)
				end
			end
		end
	end
end

function V1a6_CachotCollectionOverView:getNeedMoveScrollPixel(collectionItemRect, cutoutPixelRect)
	return self._scrollDir == ScrollEnum.ScrollDirV and (collectionItemRect.z < cutoutPixelRect.y and -cutoutPixelRect.w or cutoutPixelRect.w) or collectionItemRect.x < cutoutPixelRect.x and -cutoutPixelRect.z or cutoutPixelRect.z
end

function V1a6_CachotCollectionOverView:getTragetScrollPixelAndDuration(needScrollPixel)
	if self._scrollDir == ScrollEnum.ScrollDirV then
		if not self._csScrollView.VerticalScrollPixel then
			local curScrollPixel = self._csScrollView.HorizontalScrollPixel
			local targetScrollPixel = curScrollPixel + needScrollPixel
			local duration = math.abs(needScrollPixel) * moveScrollDurationPerPixel

			return duration, curScrollPixel, targetScrollPixel
		end
	end
end

function V1a6_CachotCollectionOverView:onScrollContentCallBack(value)
	if self._scrollDir == ScrollEnum.ScrollDirV then
		self._csScrollView.VerticalScrollPixel = value
	else
		self._csScrollView.HorizontalScrollPixel = value
	end
end

function V1a6_CachotCollectionOverView:onScrollContentFinishedCallBack()
	self:showCollectionTips()
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionOverView")
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
end

V1a6_CachotCollectionOverView.TipPosXOffset = -1144

function V1a6_CachotCollectionOverView:showCollectionTips()
	local scrollPosX, scrollPosY = recthelper.getAnchor(self._scrollview.transform)
	local itemStartPosY = (self._lineIndex - 1) * self._singleItemHeightAndSpace
	local scrollOffset = itemStartPosY - Mathf.Clamp(self._csScrollView.VerticalScrollPixel, 0, self._csScrollView.VerticalScrollPixel)
	local tipPosY = scrollPosY - scrollOffset

	if self._countIndex >= self._scrollLineCount then
		if not V1a6_CachotCollectionOverView.TipPosXOffset then
			local tipPosXOffset = 0
			local tipPosX = self._singleItemWidthAndSpace * self._countIndex + scrollPosX + tipPosXOffset

			gohelper.setActive(self._gotips, true)
			recthelper.setAnchor(self._golayout.transform, tipPosX, tipPosY)
			gohelper.fitScreenOffset(self._golayout.transform)
		end
	end
end

function V1a6_CachotCollectionOverView:onClose()
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionOverView")
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
end

function V1a6_CachotCollectionOverView:onDestroyView()
	return
end

return V1a6_CachotCollectionOverView
