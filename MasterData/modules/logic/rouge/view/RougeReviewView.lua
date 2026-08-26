-- chunkname: @modules/logic/rouge/view/RougeReviewView.lua

module("modules.logic.rouge.view.RougeReviewView", package.seeall)

local RougeReviewView = class("RougeReviewView", BaseView)

function RougeReviewView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content")
	self._goMask = gohelper.findChild(self.viewGO, "#go_Mask")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#go_Mask/#simage_Mask")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_Mask/#txt_Tips")
	self._goLeftTop = gohelper.findChild(self.viewGO, "#go_LeftTop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeReviewView:addEvents()
	return
end

function RougeReviewView:removeEvents()
	return
end

function RougeReviewView:_initStoryStatus()
	self._unlockStageId = 0

	local storyList = RougeFavoriteConfig.instance:getStoryList()

	for i, v in ipairs(storyList) do
		if self:_sotryListIsPass(v.storyIdList) then
			self._unlockStageId = v.config.stageId
		end
	end
end

function RougeReviewView:_sotryListIsPass(list)
	for i, storyId in ipairs(list) do
		if RougeOutsideModel.instance:storyIsPass(storyId) then
			return true
		end
	end
end

function RougeReviewView:_initStoryItems()
	local storyList = RougeFavoriteConfig.instance:getStoryList()

	self.storyList = storyList

	local path = self.viewContainer:getSetting().otherRes[1]
	local isEnd = false
	local stageList = self:_splitStorysToStageList(storyList)

	if stageList then
		if not #stageList then
			local stageCount = 0

			self._unlockStageCount = 0

			for i = 1, stageCount - 1 do
				local storyMo = stageList[i][1]
				local storyItemGO = self:_getStoryItem(i, path)
				local stageStoryList = stageList[i + 1]

				isEnd = i >= stageCount - 1

				storyItemGO.item:setMaxUnlockStateId(self._unlockStageId)
				storyItemGO.item:onUpdateMO(storyMo, isEnd, self, stageStoryList, path)

				if not storyItemGO.item:isUnlock() then
					isEnd = false

					break
				end

				self._unlockStageCount = self._unlockStageCount + 1
			end

			gohelper.setActive(self._goMask, not isEnd)

			self._isEnd = isEnd
		end
	end
end

function RougeReviewView:_getStoryItem(i, path)
	local storyItemGO = self._storyItemList[i]

	if not storyItemGO then
		storyItemGO = {
			go = self:getResInst(path, self._gocontent, "item" .. i)
		}
		storyItemGO.item = MonoHelper.addNoUpdateLuaComOnceToGo(storyItemGO.go, RougeReviewItem)

		storyItemGO.item:setIndex(i)
		table.insert(self._storyItemList, storyItemGO)
	end

	return storyItemGO
end

function RougeReviewView:_splitStorysToStageList(storyList)
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

function RougeReviewView:_findNextSameStageStory(curCheckIndex, storyList)
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

function RougeReviewView:_editableInitView()
	self._initX = 220
	self._initY = -450
	self._itemContentWidth = 700
	self._itemIconWidth = 400
	self._storyItemList = self:getUserDataTb_()
	self._horizontalLayoutGroup = self._gocontent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
end

function RougeReviewView:_resetPos()
	self._rootWidth = recthelper.getWidth(self.viewGO.transform)
	self._viewportWidth = recthelper.getWidth(self._scrollview.transform)
	self._curViewportWidth = self._viewportWidth

	local contentWidth = (self._unlockStageCount - 1) * self._itemContentWidth + self._itemIconWidth
	local offsetX = math.max(self._viewportWidth - contentWidth, 0)

	contentWidth = contentWidth + offsetX

	if self._isEnd then
		contentWidth = contentWidth + self._itemContentWidth + self._itemIconWidth
	end

	for i, v in ipairs(self._storyItemList) do
		local go = v.go

		recthelper.setAnchor(go.transform, (i - 1) * self._itemContentWidth + self._initX + offsetX, self._initY)
	end

	recthelper.setWidth(self._gocontent.transform, contentWidth)
end

function RougeReviewView:onUpdateParam()
	return
end

function RougeReviewView:onOpen()
	self:_initStoryStatus()
	self:_initStoryItems()

	if not self._isEnd then
		local offsetMax = self._scrollview.transform.offsetMax

		offsetMax.x = -670
		self._scrollview.transform.offsetMax = offsetMax
	end

	self:_resetPos()

	self._scrollview.horizontalNormalizedPosition = 1
	self._scrollX = 1

	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio2)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollview:AddOnValueChanged(self._onScrollRectValueChanged, self)
end

function RougeReviewView:_onScrollRectValueChanged(scrollX, scrollY)
	if self._curViewportWidth == recthelper.getWidth(self._scrollview.transform) then
		self._scrollX = scrollX
	end
end

function RougeReviewView:_onScreenSizeChange()
	self:_resetPos()

	self._scrollview.horizontalNormalizedPosition = self._scrollX
end

function RougeReviewView:onClose()
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Story) > 0 then
		local season = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(season, RougeEnum.FavoriteType.Story, 0)
	end

	self._scrollview:RemoveOnValueChanged()
end

function RougeReviewView:onDestroyView()
	return
end

return RougeReviewView
