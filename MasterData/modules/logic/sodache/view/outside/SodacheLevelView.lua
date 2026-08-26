-- chunkname: @modules/logic/sodache/view/outside/SodacheLevelView.lua

module("modules.logic.sodache.view.outside.SodacheLevelView", package.seeall)

local SodacheLevelView = class("SodacheLevelView", BaseView)

function SodacheLevelView:onInitView()
	self._scrollLevel = gohelper.findChildScrollRect(self.viewGO, "#scroll_Level")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_Level/Viewport/#go_Content")
	self._goLevelItem = gohelper.findChild(self.viewGO, "#scroll_Level/Viewport/#go_Content/#go_LevelItem")
	self._goProgress = gohelper.findChild(self.viewGO, "#go_Progress")
	self._imageProgress = gohelper.findChildImage(self.viewGO, "#go_Progress/#image_Progress")
	self._txtProgress = gohelper.findChildText(self.viewGO, "#go_Progress/#txt_Progress")
	self._goMax = gohelper.findChild(self.viewGO, "#go_Progress/#go_Max")
	self._txtDesc = gohelper.findChildText(self.viewGO, "unlock/#txt_Desc")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheLevelView:_editableInitView()
	self.cellW = 250
	self.cellH = 300
	self.cellSpace = 150

	local outsideMo = SodacheModel.instance:getOutsideMo()

	self.level = outsideMo.prop.level
	self.exp = outsideMo.prop.exp
	self.levelCoList = lua_sodache_level.configList
	self.maxLevel = #self.levelCoList

	self:initScrollView()
	self:initLevelItem()

	self.animUnlock = gohelper.findChildAnim(self.viewGO, "unlock")
end

function SodacheLevelView:onOpen()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnClickLevelItem, self.onClickLevelItem, self)
	UpdateBeat:Add(self._update, self)
	self:_onScreenResize()
	self:_onSelectIndex(self.level, true)
end

function SodacheLevelView:onClose()
	UpdateBeat:Remove(self._update, self)
	self._scrollLevel:RemoveOnValueChanged()
	self:_killTween()
end

function SodacheLevelView:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
end

function SodacheLevelView:_onScreenResize()
	local width = recthelper.getWidth(self._scrollViewTrans)
	local offset = Mathf.Round(width * 0.5 - self.cellW * 0.5)

	self._goContentHLayout.padding.left = offset
	self._goContentHLayout.padding.right = offset

	ZProj.UGUIHelper.RebuildLayout(self._goContent.transform)
end

function SodacheLevelView:initScrollView()
	self._scrollViewGo = self._scrollLevel.gameObject
	self._scrollViewTrans = self._scrollViewGo.transform
	self._scrollViewLimitScrollCmp = self._scrollViewGo:GetComponent(gohelper.Type_LimitedScrollRect)
	self._goContentHLayout = self._goContent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self._drag = UIDragListenerHelper.New()

	self._drag:createByScrollRect(self._scrollViewLimitScrollCmp)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBeginHandler, self)
	self._drag:registerCallback(self._drag.EventDragging, self._onDragging, self)
	self._scrollLevel:AddOnValueChanged(self._onScrollValueChanged, self)
end

function SodacheLevelView:initLevelItem()
	self.levelItemList = {}

	for k, config in ipairs(self.levelCoList) do
		local go = gohelper.cloneInPlace(self._goLevelItem, k)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheLevelItem, k)

		item:setData(config)

		self.levelItemList[k] = item
	end

	gohelper.setActive(self._goLevelItem, false)
end

function SodacheLevelView:onClickLevelItem(index)
	self._drag:stopMovement()
	self:_onSelectIndex(index)
end

function SodacheLevelView:_onSelectIndex(index, noAnim)
	if self.selectIndex == index then
		self:_animFocusIndex(index, noAnim)

		return
	end

	self.selectIndex = index

	local desc = self.levelCoList[index].desc

	if string.nilorempty(desc) then
		self.animUnlock:Play("close")
	else
		self._txtDesc.text = SodacheUtil.changeDescColor(desc)

		self.animUnlock:Play("open")
	end

	self:_refreshProgress()
	self:_setScaleAdjacent(index, not noAnim)
	self:_animFocusIndex(index, noAnim)
end

function SodacheLevelView:_refreshProgress()
	if self.selectIndex == self.level then
		if self.level == self.maxLevel then
			self._imageProgress.fillAmount = 1
		else
			local nextCfg = self.levelCoList[self.level + 1]

			self._txtProgress.text = string.format("%s/%s", self.exp, nextCfg.cosume)
			self._imageProgress.fillAmount = self.exp / nextCfg.cosume
		end

		gohelper.setActive(self._goMax, self.level == self.maxLevel)
		gohelper.setActive(self._txtProgress, self.level ~= self.maxLevel)
	end

	gohelper.setActive(self._goProgress, self.selectIndex == self.level)
end

function SodacheLevelView:_setScaleAdjacent(index, isAnim)
	local item = self.levelItemList[index]

	if not item then
		return
	end

	local left = index - 1
	local lItem = self.levelItemList[left]

	if lItem then
		lItem:setScale(SodacheLevelItem.ScalerSelectedAdjacent, isAnim)

		left = left - 1

		local llItem = self.levelItemList[left]

		if llItem then
			llItem:setScale(SodacheLevelItem.ScalerNormal, isAnim)
		end
	end

	local right = index + 1
	local rItem = self.levelItemList[right]

	if rItem then
		rItem:setScale(SodacheLevelItem.ScalerSelectedAdjacent, isAnim)

		right = right + 1

		local rrItem = self.levelItemList[right]

		if rrItem then
			rrItem:setScale(SodacheLevelItem.ScalerNormal, isAnim)
		end
	end
end

function SodacheLevelView:_animFocusIndex(index, noAnim)
	self:_killTween()

	local toPosX = -self:_calcFocusIndexPosX(index)

	if noAnim then
		recthelper.setAnchorX(self._goContent.transform, toPosX)
	else
		self._contentPosXTweenId = ZProj.TweenHelper.DOAnchorPosX(self._goContent.transform, toPosX, 0.2, nil, nil, nil)
	end

	for k, item in ipairs(self.levelItemList) do
		item:setSelect(index == k)
	end
end

function SodacheLevelView:_calcFocusIndexPosX(index)
	local posX = 0
	local maxScrollX = self:_getMaxScrollX()

	if index <= 1 then
		return posX, maxScrollX
	end

	local item = self.levelItemList[index]
	local startOffset = self._goContentHLayout.padding.left
	local halfW = self.cellW * 0.5

	posX = recthelper.getAnchorX(item.transform) - halfW - startOffset

	return posX, maxScrollX
end

function SodacheLevelView:_getMaxScrollX()
	local viewportW = recthelper.getWidth(self._scrollViewTrans)
	local maxContentW = self._goContentHLayout.preferredWidth

	return math.max(0, maxContentW - viewportW)
end

function SodacheLevelView:_onDragBeginHandler()
	self:_killTween()
end

function SodacheLevelView:_onDragging()
	self:_playAudioOnDragging()
end

function SodacheLevelView:_playAudioOnDragging()
	local nearIndex = self:_getIndexFactorInbetween()

	if self._uiAduioLastDragNear == nil then
		self._uiAduioLastDragNear = nearIndex
	elseif self._uiAduioLastDragNear ~= nearIndex then
		self._uiAduioLastDragNear = nearIndex

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_chain_20190314)
	end
end

function SodacheLevelView:_onScrollValueChanged()
	local nearIndex, nearFactor, farIndex, farFactor = self:_getIndexFactorInbetween()
	local nearItem = self.levelItemList[nearIndex]
	local farItem = self.levelItemList[farIndex]

	nearItem:setScale01(nearFactor)
	farItem:setScale01(farFactor)
end

function SodacheLevelView:_getIndexFactorInbetween()
	local step = self.cellW + self.cellSpace
	local contentAbsPosX = recthelper.getAnchorX(self._goContent.transform)

	contentAbsPosX = contentAbsPosX <= 0 and -contentAbsPosX or 0

	local index = math.ceil(contentAbsPosX / step)
	local contentAbsPosXFromZero = contentAbsPosX % step

	contentAbsPosXFromZero = contentAbsPosXFromZero == 0 and step or contentAbsPosXFromZero

	local offset = contentAbsPosXFromZero / (step * 0.5) > 1 and 1 or 0
	local nearIndex = self:_validateIndex(index + offset)
	local farIndex = self:_validateIndex(offset == 1 and index or index + 1)
	local f = GameUtil.saturate(GameUtil.remap01(contentAbsPosXFromZero, 0, step))
	local nearFactor = offset == 1 and f or 1 - f
	local farFactor = 1 - nearFactor

	if nearIndex == farIndex then
		farFactor = 1
		nearFactor = 1
	end

	return nearIndex, nearFactor, farIndex, farFactor
end

function SodacheLevelView:_validateIndex(index)
	local count = #self.levelCoList

	return GameUtil.clamp(index, 1, count)
end

function SodacheLevelView:_killTween()
	GameUtil.onDestroyViewMember_TweenId(self, "_contentPosXTweenId")
end

function SodacheLevelView:_isScrollSlowly()
	local velocity = self._scrollViewLimitScrollCmp.velocity.x

	if not velocity then
		return false
	end

	return math.abs(velocity) < 100
end

function SodacheLevelView:_update()
	if not self._drag:isEndedDrag() then
		return
	end

	if self:_isScrollSlowly() then
		self._drag:clear()

		local nearIndex = self:_getIndexFactorInbetween()

		self:_onSelectIndex(nearIndex)
	end
end

return SodacheLevelView
