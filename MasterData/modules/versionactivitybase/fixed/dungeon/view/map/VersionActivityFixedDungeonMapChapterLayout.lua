-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/map/VersionActivityFixedDungeonMapChapterLayout.lua

module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapChapterLayout", package.seeall)

local VersionActivityFixedDungeonMapChapterLayout = class("VersionActivityFixedDungeonMapChapterLayout", BaseChildView)
local CHAPTER_KEY = "default"
local RIGHT_OFFSET_X = 600
local CONST_DUNGEON_NORMAL_DELTA_X = 100
local TWEEN_TIME = 0.26

function VersionActivityFixedDungeonMapChapterLayout:onInitView()
	self.rectTransform = self.viewGO.transform
	self.contentTransform = self.viewParam.goChapterContent.transform
	self._golevellist = gohelper.findChild(self.viewGO, string.format("%s/go_levellist", CHAPTER_KEY))
	self._gotemplatenormal = gohelper.findChild(self.viewGO, string.format("%s/go_levellist/#go_templatenormal", CHAPTER_KEY))
	self.chapterGo = gohelper.findChild(self.viewGO, CHAPTER_KEY)

	gohelper.setActive(self.chapterGo, true)

	self._timelineAnimation = gohelper.findChildComponent(self.viewGO, "timeline", typeof(UnityEngine.Animation))
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedDungeonMapChapterLayout:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
	self.addEventCb(self, VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance, VersionActivityFixedDungeonEvent.GuideShowElement, self._GuideShowElement, self)

	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyUp, self._onGamepadKeyUp, self)
		self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, self._onChangeFocusEpisodeItem, self)
	end
end

function VersionActivityFixedDungeonMapChapterLayout:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
	self.removeEventCb(self, GamepadController.instance, GamepadEvent.KeyUp, self._onGamepadKeyUp, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, self._onChangeFocusEpisodeItem, self)
	self.removeEventCb(self, VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance, VersionActivityFixedDungeonEvent.GuideShowElement, self._GuideShowElement, self)
end

function VersionActivityFixedDungeonMapChapterLayout:_onOpenView(viewName)
	if viewName == VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion) then
		self._timelineAnimation:Play("timeline_mask")
		self:setSelectEpisodeItem(self._episodeItemDict[self.activityDungeonMo.episodeId])
	end
end

function VersionActivityFixedDungeonMapChapterLayout:_onCloseView(viewName)
	if viewName == VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion) then
		self._timelineAnimation:Play("timeline_reset")
		self:setSelectEpisodeItem(nil)
	end
end

function VersionActivityFixedDungeonMapChapterLayout:onActivityDungeonMoChange()
	self:updateFocusStatus()
	self:setFocusEpisodeId(self.activityDungeonMo.episodeId, true)
end

function VersionActivityFixedDungeonMapChapterLayout:updateFocusStatus()
	for _, episodeItem in pairs(self._episodeItemDict) do
		episodeItem:refreshFocusStatus()
	end
end

function VersionActivityFixedDungeonMapChapterLayout:_onGamepadKeyUp(key)
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if topView ~= VersionActivityFixedHelper.getVersionActivityDungeonMapViewName(self._bigVersion, self._smallVersion) and topView ~= VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion) then
		return
	end

	local isKeyLB = key == GamepadEnum.KeyCode.LB
	local isKeyLBOrRB = isKeyLB or key == GamepadEnum.KeyCode.RB
	local interactiveItemVisible = DungeonMapModel.instance:getMapInteractiveItemVisible()

	if self._focusIndex and not interactiveItemVisible and isKeyLBOrRB then
		local offset = isKeyLB and -1 or 1
		local index = self._focusIndex + offset

		index = math.max(1, index)
		index = math.min(index, #self._episodeContainerItemList)

		if index > 0 and index <= #self._episodeContainerItemList then
			local item = self._episodeContainerItemList[index].episodeItem

			item:onClick(true)
		end
	end
end

function VersionActivityFixedDungeonMapChapterLayout:_onChangeFocusEpisodeItem(item)
	if GamepadController.instance:isOpen() then
		for i, v in ipairs(self._episodeContainerItemList) do
			if v.episodeItem == item then
				self._focusIndex = i
			end
		end
	end
end

function VersionActivityFixedDungeonMapChapterLayout:_editableInitView()
	self._focusIndex = 0
	self._episodeItemDict = self:getUserDataTb_()
	self._episodeContainerItemList = self:getUserDataTb_()
	self.episodeItemPath = self.viewContainer:getSetting().otherRes[1]

	local vec = Vector2(0, 1)

	self.rectTransform.pivot = vec
	self.rectTransform.anchorMin = vec
	self.rectTransform.anchorMax = vec
	self.defaultY = self.activityDungeonMo:getLayoutOffsetY()

	recthelper.setAnchorY(self.rectTransform, self.defaultY)

	self._rawWidth = recthelper.getWidth(self.rectTransform)
	self._rawHeight = recthelper.getHeight(self.rectTransform)

	recthelper.setSize(self.contentTransform, self._rawWidth, self._rawHeight)

	local uiRootTran = ViewMgr.instance:getUIRoot().transform
	local width = recthelper.getWidth(uiRootTran)

	self.viewWidth = width
	self._offsetX = (width - RIGHT_OFFSET_X) / 2 + RIGHT_OFFSET_X
	self._constDungeonNormalPosX = width - self._offsetX
	self._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	self._constDungeonNormalDeltaX = CONST_DUNGEON_NORMAL_DELTA_X
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	if ViewMgr.instance:isOpening(VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion)) then
		self._timelineAnimation:Play("timeline_mask")
	end
end

function VersionActivityFixedDungeonMapChapterLayout:onUpdateParam()
	return
end

function VersionActivityFixedDungeonMapChapterLayout:onOpen()
	return
end

function VersionActivityFixedDungeonMapChapterLayout:refreshEpisodeNodes()
	self._episodeItemDict = self:getUserDataTb_()

	local index = 0
	local dungeonMo, episodeContainerItem
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.activityDungeonMo.chapterId)

	for _, config in ipairs(episodeList) do
		dungeonMo = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil

		if dungeonMo then
			index = index + 1
			episodeContainerItem = self:getEpisodeContainerItem(index)
			self._episodeItemDict[config.id] = episodeContainerItem.episodeItem
			episodeContainerItem.containerTr.name = config.id

			episodeContainerItem.episodeItem:refresh(config, dungeonMo)
			self:_setEpisodeItemAnchorX(index, episodeContainerItem)
		end
	end

	local lastContainerItem = self._episodeContainerItemList[index]
	local pos = recthelper.rectToRelativeAnchorPos(lastContainerItem.containerTr.position, self.rectTransform)
	local width = pos.x + self._offsetX

	recthelper.setSize(self.contentTransform, width, self._rawHeight)

	self._contentWidth = width
	self._showEpisodeCount = index
	self._allEpisodeCount = #episodeList

	for i = index + 1, #self._episodeContainerItemList do
		gohelper.setActive(self._episodeContainerItemList[i].containerTr.gameObject, false)
	end

	self:setFocusEpisodeId(self.activityDungeonMo.episodeId, false)
end

function VersionActivityFixedDungeonMapChapterLayout:getEpisodeContainerItem(index)
	local episodeContainerItem = self._episodeContainerItemList[index]

	if episodeContainerItem then
		gohelper.setActive(episodeContainerItem.containerTr.gameObject, true)
		episodeContainerItem.episodeItem:clearElementIdList()

		return episodeContainerItem
	end

	episodeContainerItem = self:getUserDataTb_()

	local go = gohelper.cloneInPlace(self._gotemplatenormal, tostring(index))

	gohelper.setActive(go, true)

	episodeContainerItem.containerTr = go.transform

	recthelper.setAnchorY(episodeContainerItem.containerTr, self._constDungeonNormalPosY)

	local episodeItemViewGo = self.viewContainer:getResInst(self.episodeItemPath, go)
	local episodeItem = self.activityDungeonMo:getEpisodeItemClass().New()

	episodeItem.viewContainer = self.viewContainer
	episodeItem.activityDungeonMo = self.activityDungeonMo

	episodeItem:initView(episodeItemViewGo, {
		self.contentTransform,
		self
	})

	episodeContainerItem.episodeItem = episodeItem

	table.insert(self._episodeContainerItemList, episodeContainerItem)

	return episodeContainerItem
end

function VersionActivityFixedDungeonMapChapterLayout:_setEpisodeItemAnchorX(index, item)
	if index > 1 then
		local preEpisodeContainerItem = self._episodeContainerItemList[index - 1]
		local prePosX = recthelper.getAnchorX(preEpisodeContainerItem.containerTr) or 0
		local prevItem = preEpisodeContainerItem.episodeItem

		recthelper.setAnchorX(item.containerTr, prePosX + prevItem:getMaxWidth() + self._constDungeonNormalDeltaX)
	else
		recthelper.setAnchorX(item.containerTr, self._constDungeonNormalPosX)
	end
end

function VersionActivityFixedDungeonMapChapterLayout:setFocusEpisodeId(episodeId, tween)
	local focusItemGo = self._episodeItemDict[episodeId]

	if focusItemGo and focusItemGo.viewGO then
		self:setFocusItem(focusItemGo.viewGO, tween)
	end

	if focusItemGo then
		self:_onChangeFocusEpisodeItem(focusItemGo)
	end
end

function VersionActivityFixedDungeonMapChapterLayout:setFocusItem(focusItemGo, tween)
	if not focusItemGo then
		return
	end

	local pos = recthelper.rectToRelativeAnchorPos(focusItemGo.transform.position, self.rectTransform)
	local offsetX = -pos.x + self._constDungeonNormalPosX

	if tween then
		ZProj.TweenHelper.DOAnchorPosX(self.contentTransform, offsetX, TWEEN_TIME)
	else
		recthelper.setAnchorX(self.contentTransform, offsetX)
	end
end

function VersionActivityFixedDungeonMapChapterLayout:setFocusEpisodeItem(item, tween)
	local offsetX = -item.scrollContentPosX + self._constDungeonNormalPosX

	if tween then
		if not DungeonMapModel.instance.focusEpisodeTweenDuration then
			DungeonMapModel.instance.focusEpisodeTweenDuration = nil

			ZProj.TweenHelper.DOAnchorPosX(self.contentTransform, offsetX, DungeonMapModel.instance.focusEpisodeTweenDuration)
		end
	else
		recthelper.setAnchorX(self.contentTransform, offsetX)
	end
end

function VersionActivityFixedDungeonMapChapterLayout:setSelectEpisodeItem(episodeItem)
	self.selectedEpisodeItem = episodeItem

	for _, _episodeItem in pairs(self._episodeItemDict) do
		_episodeItem:updateSelectStatus(self.selectedEpisodeItem)
	end
end

function VersionActivityFixedDungeonMapChapterLayout:playAnimation(aniName)
	self.animator:Play(aniName, 0, 0)
end

function VersionActivityFixedDungeonMapChapterLayout:playEpisodeItemAnimation(aniName)
	for _, episodeContainerItem in ipairs(self._episodeContainerItemList) do
		episodeContainerItem.episodeItem:playAnimation(aniName)
	end
end

function VersionActivityFixedDungeonMapChapterLayout:setSelectEpisodeId(episodeId, skipAni)
	self.selectedEpisodeItem = self._episodeItemDict[episodeId]

	for _, episodeItem in pairs(self._episodeItemDict) do
		episodeItem:updateSelectStatus(self.selectedEpisodeItem, skipAni)
	end
end

function VersionActivityFixedDungeonMapChapterLayout:isSelectedEpisodeRightEpisode(episodeItem)
	local result = false

	if not self.selectedEpisodeItem then
		return result
	end

	local episodeItemConfig = episodeItem._config
	local curSelectEpisodeConfig = self.selectedEpisodeItem._config

	if not episodeItemConfig then
		return result
	end

	local index = DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeItemConfig.chapterId, episodeItemConfig.id)
	local curIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(curSelectEpisodeConfig.chapterId, curSelectEpisodeConfig.id)

	if curIndex < index then
		result = true
	end

	return result
end

function VersionActivityFixedDungeonMapChapterLayout:_GuideShowElement(elementId)
	local id = tonumber(elementId)
	local elementCo = DungeonConfig.instance:getChapterMapElement(id)

	if elementCo then
		local episodeId = elementCo.mapId
		local item = self._episodeItemDict[episodeId]

		if self.selectedEpisodeItem ~= item then
			self.activityDungeonMo:changeEpisode(episodeId)
			self:setSelectEpisodeItem(item)
		end

		VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.FocusElement, id)
	end
end

function VersionActivityFixedDungeonMapChapterLayout:onClose()
	for i, v in pairs(self._episodeContainerItemList) do
		v.episodeItem:destroyView()
	end
end

function VersionActivityFixedDungeonMapChapterLayout:onDestroyView()
	return
end

return VersionActivityFixedDungeonMapChapterLayout
