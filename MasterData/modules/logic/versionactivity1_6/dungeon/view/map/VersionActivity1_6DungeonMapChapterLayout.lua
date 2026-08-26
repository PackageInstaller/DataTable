-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/map/VersionActivity1_6DungeonMapChapterLayout.lua

module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapChapterLayout", package.seeall)

local VersionActivity1_6DungeonMapChapterLayout = class("VersionActivity1_6DungeonMapChapterLayout", BaseChildView)

function VersionActivity1_6DungeonMapChapterLayout:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6DungeonMapChapterLayout:addEvents()
	return
end

function VersionActivity1_6DungeonMapChapterLayout:removeEvents()
	return
end

function VersionActivity1_6DungeonMapChapterLayout:_editableInitView()
	self._focusIndex = 0
	self.rectTransform = self.viewGO.transform

	local vec = Vector2(0, 1)

	self.rectTransform.pivot = vec
	self.rectTransform.anchorMin = vec
	self.rectTransform.anchorMax = vec
	self.defaultY = self.activityDungeonMo:getLayoutOffsetY()

	recthelper.setAnchorY(self.rectTransform, self.defaultY)

	self.contentTransform = self.viewParam.goChapterContent.transform
	self._rawWidth = recthelper.getWidth(self.rectTransform)
	self._rawHeight = recthelper.getHeight(self.rectTransform)

	recthelper.setSize(self.contentTransform, self._rawWidth, self._rawHeight)

	self._episodeItemDict = self:getUserDataTb_()
	self._episodeContainerItemList = self:getUserDataTb_()

	local chapterKey = "default"

	self._golevellist = gohelper.findChild(self.viewGO, string.format("%s/go_levellist", chapterKey))
	self._gotemplatenormal = gohelper.findChild(self.viewGO, string.format("%s/go_levellist/#go_templatenormal", chapterKey))
	self.chapterGo = gohelper.findChild(self.viewGO, chapterKey)

	gohelper.setActive(self.chapterGo, true)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local rightOffsetX = 600

	self._offsetX = (width - rightOffsetX) / 2 + rightOffsetX
	self._constDungeonNormalPosX = width - self._offsetX
	self._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	self._constDungeonNormalDeltaX = 100
	self._timelineAnimation = gohelper.findChildComponent(self.viewGO, "timeline", typeof(UnityEngine.Animation))

	if ViewMgr.instance:isOpening(ViewName.VersionActivity1_6DungeonMapLevelView) then
		self._timelineAnimation:Play("timeline_mask")
	end

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.episodeItemPath = self.viewContainer:getSetting().otherRes[1]
end

function VersionActivity1_6DungeonMapChapterLayout:setSelectEpisodeId(episodeId, skipAni)
	self.selectedEpisodeItem = self._episodeItemDict[episodeId]

	for _, episodeItem in pairs(self._episodeItemDict) do
		episodeItem:updateSelectStatus(self.selectedEpisodeItem, skipAni)
	end
end

function VersionActivity1_6DungeonMapChapterLayout:_onChangeFocusEpisodeItem(item)
	if GamepadController.instance:isOpen() then
		for i, v in ipairs(self._episodeContainerItemList) do
			if v.episodeItem == item then
				self._focusIndex = i
			end
		end
	end
end

function VersionActivity1_6DungeonMapChapterLayout:_onGamepadKeyUp(key)
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if (topView == ViewName.VersionActivity1_6DungeonMapView or topView == ViewName.VersionActivity1_6DungeonMapLevelView) and self._focusIndex and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (key == GamepadEnum.KeyCode.LB or key == GamepadEnum.KeyCode.RB) then
		local offset = key == GamepadEnum.KeyCode.LB and -1 or 1
		local index = self._focusIndex + offset

		index = math.max(1, index)
		index = math.min(index, #self._episodeContainerItemList)

		if index > 0 and index <= #self._episodeContainerItemList then
			local item = self._episodeContainerItemList[index].episodeItem

			item:onClick(true)
		end
	end
end

function VersionActivity1_6DungeonMapChapterLayout:refreshEpisodeNodes()
	self._episodeItemDict = self:getUserDataTb_()

	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.activityDungeonMo.chapterId)
	local index = 0
	local dungeonMo, episodeContainerItem

	for _, config in ipairs(episodeList) do
		dungeonMo = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil

		if dungeonMo then
			index = index + 1
			episodeContainerItem = self:getEpisodeContainerItem(index)
			self._episodeItemDict[config.id] = episodeContainerItem.episodeItem
			episodeContainerItem.containerTr.name = config.id

			episodeContainerItem.episodeItem:refresh(config, dungeonMo)
		end
	end

	local lastContainerItem = self._episodeContainerItemList[index]
	local pos = recthelper.rectToRelativeAnchorPos(lastContainerItem.containerTr.position, self.rectTransform)
	local width = pos.x + self._offsetX

	recthelper.setSize(self.contentTransform, width, self._rawHeight)

	self._contentWidth = width

	for i = index + 1, #self._episodeContainerItemList do
		gohelper.setActive(self._episodeContainerItemList[i].containerTr.gameObject, false)
	end

	self:setFocusEpisodeId(self.activityDungeonMo.episodeId, false)
end

function VersionActivity1_6DungeonMapChapterLayout:setFocusItem(focusItemGo, tween)
	if not focusItemGo then
		return
	end

	local pos = recthelper.rectToRelativeAnchorPos(focusItemGo.transform.position, self.rectTransform)
	local offsetX = -pos.x + self._constDungeonNormalPosX

	if tween then
		ZProj.TweenHelper.DOAnchorPosX(self.contentTransform, offsetX, 0.26)
	else
		recthelper.setAnchorX(self.contentTransform, offsetX)
	end
end

function VersionActivity1_6DungeonMapChapterLayout:setFocusEpisodeItem(item, tween)
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

function VersionActivity1_6DungeonMapChapterLayout:setFocusEpisodeId(episodeId, tween)
	local focusItemGo = self._episodeItemDict[episodeId]

	if focusItemGo and focusItemGo.viewGO then
		self:setFocusItem(focusItemGo.viewGO, tween)
	end

	if focusItemGo then
		self:_onChangeFocusEpisodeItem(focusItemGo)
	end
end

function VersionActivity1_6DungeonMapChapterLayout:getEpisodeContainerItem(index)
	local episodeContainerItem = self._episodeContainerItemList[index]

	if episodeContainerItem then
		gohelper.setActive(episodeContainerItem.containerTr.gameObject, true)
		episodeContainerItem.episodeItem:clearElementIdList()

		return episodeContainerItem
	end

	local go = gohelper.cloneInPlace(self._gotemplatenormal, tostring(index))

	gohelper.setActive(go, true)

	episodeContainerItem = self:getUserDataTb_()
	episodeContainerItem.containerTr = go.transform

	if index > 1 then
		local preEpisodeContainerItem = self._episodeContainerItemList[index - 1]
		local prePosX = recthelper.getAnchorX(preEpisodeContainerItem.containerTr) or 0
		local prevItem = preEpisodeContainerItem.episodeItem

		recthelper.setAnchorX(episodeContainerItem.containerTr, prePosX + prevItem:getMaxWidth() + self._constDungeonNormalDeltaX)
	else
		recthelper.setAnchorX(episodeContainerItem.containerTr, self._constDungeonNormalPosX)
	end

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

function VersionActivity1_6DungeonMapChapterLayout:onUpdateParam()
	return
end

function VersionActivity1_6DungeonMapChapterLayout:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)

	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyUp, self._onGamepadKeyUp, self)
		self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, self._onChangeFocusEpisodeItem, self)
	end
end

function VersionActivity1_6DungeonMapChapterLayout:_onOpenView(viewName)
	if viewName == ViewName.VersionActivity1_6DungeonMapLevelView then
		self._timelineAnimation:Play("timeline_mask")
		self:setSelectEpisodeItem(self._episodeItemDict[self.activityDungeonMo.episodeId])
	end
end

function VersionActivity1_6DungeonMapChapterLayout:_onCloseView(viewName)
	if viewName == ViewName.VersionActivity1_6DungeonMapLevelView then
		self._timelineAnimation:Play("timeline_reset")
		self:setSelectEpisodeItem(nil)
	end
end

function VersionActivity1_6DungeonMapChapterLayout:playAnimation(aniName)
	self.animator:Play(aniName, 0, 0)
end

function VersionActivity1_6DungeonMapChapterLayout:playEpisodeItemAnimation(aniName)
	for _, episodeContainerItem in ipairs(self._episodeContainerItemList) do
		episodeContainerItem.episodeItem:playAnimation(aniName)
	end
end

function VersionActivity1_6DungeonMapChapterLayout:setSelectEpisodeItem(episodeItem)
	self.selectedEpisodeItem = episodeItem

	for _, _episodeItem in pairs(self._episodeItemDict) do
		_episodeItem:updateSelectStatus(self.selectedEpisodeItem)
	end
end

function VersionActivity1_6DungeonMapChapterLayout:updateFocusStatus()
	for _, episodeItem in pairs(self._episodeItemDict) do
		episodeItem:refreshFocusStatus()
	end
end

function VersionActivity1_6DungeonMapChapterLayout:isSelectedEpisodeRightEpisode(episodeItem)
	if not self.selectedEpisodeItem then
		return false
	end

	local index = DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeItem._config.chapterId, episodeItem._config.id)
	local curIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(self.selectedEpisodeItem._config.chapterId, self.selectedEpisodeItem._config.id)

	if curIndex < index then
		return true
	end

	return false
end

function VersionActivity1_6DungeonMapChapterLayout:onActivityDungeonMoChange()
	self:updateFocusStatus()
	self:setFocusEpisodeId(self.activityDungeonMo.episodeId, true)
end

function VersionActivity1_6DungeonMapChapterLayout:onClose()
	for i, v in pairs(self._episodeContainerItemList) do
		v.episodeItem:destroyView()
	end
end

function VersionActivity1_6DungeonMapChapterLayout:onDestroyView()
	return
end

return VersionActivity1_6DungeonMapChapterLayout
