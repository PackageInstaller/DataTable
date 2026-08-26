-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_ReviewView.lua

module("modules.logic.rouge2.outside.view.Rouge2_ReviewView", package.seeall)

local Rouge2_ReviewView = class("Rouge2_ReviewView", BaseView)

function Rouge2_ReviewView:onInitView()
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content")
	self._goLeftTop = gohelper.findChild(self.viewGO, "#go_LeftTop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ReviewView:addEvents()
	return
end

function Rouge2_ReviewView:removeEvents()
	return
end

function Rouge2_ReviewView:_initStoryStatus()
	self._unlockStageId = 0

	local storyList = Rouge2_OutSideConfig.instance:getStoryList()

	for i, mo in ipairs(storyList) do
		local isUnlock = false

		if not string.nilorempty(mo.config.eventId) then
			local illustrationId = tonumber(mo.config.eventId)
			local illustrationConfig = Rouge2_OutSideConfig.instance:getIllustrationConfig(illustrationId)

			isUnlock = illustrationConfig and Rouge2_OutsideModel.instance:passedEventId(illustrationConfig.eventId)
		else
			isUnlock = self:_sotryListIsPass(mo.storyIdList)
		end

		if isUnlock then
			self._unlockStageId = mo.config.stageId
		end
	end
end

function Rouge2_ReviewView:_sotryListIsPass(list)
	for i, storyId in ipairs(list) do
		if Rouge2_OutsideModel.instance:storyIsPass(storyId) then
			return true
		end
	end
end

function Rouge2_ReviewView:_initStoryItems()
	local storyList = Rouge2_OutSideConfig.instance:getStoryList()

	self.storyList = storyList

	local path = self.viewContainer:getSetting().otherRes[3]
	local isEnd = false
	local stageList = self:_splitStorysToStageList(storyList)

	if stageList then
		if not #stageList then
			local stageCount = 0

			self._unlockStageCount = self._unlockStageId

			for i = 1, stageCount - 1 do
				local storyMo = stageList[i][1]
				local storyItemGO = self:_getStoryItem(i, path)
				local stageStoryList = stageList[i + 1]

				isEnd = i >= stageCount - 1

				storyItemGO.item:setMaxUnlockStateId(self._unlockStageId)
				storyItemGO.item:onUpdateMO(storyMo, isEnd, self, stageStoryList, path, self._scrollview.gameObject)
			end

			self._isEnd = isEnd
		end
	end
end

function Rouge2_ReviewView:_getStoryItem(i, path)
	local storyItemGO = self._storyItemList[i]

	if not storyItemGO then
		storyItemGO = {
			go = self:getResInst(path, self._gocontent, "item" .. i)
		}
		storyItemGO.item = MonoHelper.addNoUpdateLuaComOnceToGo(storyItemGO.go, Rouge2_ReviewItem)

		storyItemGO.item:setIndex(i)
		table.insert(self._storyItemList, storyItemGO)
	end

	return storyItemGO
end

function Rouge2_ReviewView:_splitStorysToStageList(storyList)
	local stageList = {}
	local curCheckIndex = 1
	local storyListCount = #storyList

	while curCheckIndex <= storyListCount do
		local maxCheckIndex, stages = self:_findNextSameStageStory(curCheckIndex, storyList)

		curCheckIndex = maxCheckIndex + 1

		table.insert(stageList, stages)
	end

	return stageList
end

function Rouge2_ReviewView:_findNextSameStageStory(curCheckIndex, storyList)
	if storyList then
		if not #storyList then
			local storyCount = 0
			local stageStoryList, preStageId

			for i = curCheckIndex, storyCount do
				local curStageId = storyList[i].config.stageId

				if preStageId and preStageId ~= curStageId then
					break
				end

				preStageId = curStageId
				stageStoryList = stageStoryList or {}

				table.insert(stageStoryList, storyList[i])
			end

			if stageStoryList then
				if not #stageStoryList then
					local stageStoryCount = 0
					local maxCheckIndex = curCheckIndex + stageStoryCount - 1

					if not stageStoryCount or stageStoryCount <= 0 then
						maxCheckIndex = maxCheckIndex + 1
					end

					return maxCheckIndex, stageStoryList
				end
			end
		end
	end
end

function Rouge2_ReviewView:_editableInitView()
	self._initX = 220
	self._initY = -450
	self._itemContentWidth = 700
	self._itemIconWidth = 400
	self._storyItemList = self:getUserDataTb_()
	self._horizontalLayoutGroup = self._gocontent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)

	self:_initStoryStatus()
	self:_initStoryItems()

	if not self._isEnd then
		local offsetMax = self._scrollview.transform.offsetMax

		offsetMax.x = -670
		self._scrollview.transform.offsetMax = offsetMax
	end
end

function Rouge2_ReviewView:_resetPos()
	self._rootWidth = recthelper.getWidth(self.viewGO.transform)
	self._viewportWidth = recthelper.getWidth(self._scrollview.transform)
	self._curViewportWidth = self._viewportWidth

	ZProj.UGUIHelper.RebuildLayout(self._gocontent.transform)
end

function Rouge2_ReviewView:onOpen()
	self.animator:Play("open", 0, 0)

	self._scrollview.horizontalNormalizedPosition = 1
	self._scrollX = 1

	self:_resetPos()

	local targetPos = (self._unlockStageId - 1) * -640

	self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._gocontent.transform, targetPos, 0.1, self.onResetPos, self)

	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio2)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function Rouge2_ReviewView:onResetPos()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._scrollview:AddOnValueChanged(self._onScrollRectValueChanged, self)
	self:_onScrollRectValueChanged()
end

function Rouge2_ReviewView:_onScrollRectValueChanged(scrollX, scrollY)
	if self._curViewportWidth == recthelper.getWidth(self._scrollview.transform) then
		self._scrollX = scrollX
	end

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a2_Rouge_Review_AVG_Tab, 0) then
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnAVGScrollViewValueChanged)
	end
end

function Rouge2_ReviewView:_onScreenSizeChange()
	self:_resetPos()

	self._scrollview.horizontalNormalizedPosition = self._scrollX
end

function Rouge2_ReviewView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._scrollview:RemoveOnValueChanged()
	self.animator:Play("close", 0, 0)
end

function Rouge2_ReviewView:onDestroyView()
	return
end

return Rouge2_ReviewView
