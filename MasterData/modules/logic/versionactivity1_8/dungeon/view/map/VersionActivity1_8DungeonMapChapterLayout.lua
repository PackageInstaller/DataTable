-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/map/VersionActivity1_8DungeonMapChapterLayout.lua

module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapChapterLayout", package.seeall)

local VersionActivity1_8DungeonMapChapterLayout = class("VersionActivity1_8DungeonMapChapterLayout", BaseChildView)
local CHAPTER_KEY = "default"
local RIGHT_OFFSET_X = 600
local CONST_DUNGEON_NORMAL_DELTA_X = 100
local TWEEN_TIME = 0.26

function VersionActivity1_8DungeonMapChapterLayout:onInitView()
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

function VersionActivity1_8DungeonMapChapterLayout:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)

	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyUp, self._onGamepadKeyUp, self)
		self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, self._onChangeFocusEpisodeItem, self)
	end
end

function VersionActivity1_8DungeonMapChapterLayout:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
	self.removeEventCb(self, GamepadController.instance, GamepadEvent.KeyUp, self._onGamepadKeyUp, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, self._onChangeFocusEpisodeItem, self)
end

function VersionActivity1_8DungeonMapChapterLayout:_onOpenView(viewName)
	if viewName == ViewName.VersionActivity1_8DungeonMapLevelView then
		self._timelineAnimation:Play("timeline_mask")
		self:setSelectEpisodeItem(self._episodeItemDict[self.activityDungeonMo.episodeId])
	end
end

function VersionActivity1_8DungeonMapChapterLayout:_onCloseView(viewName)
	if viewName == ViewName.VersionActivity1_8DungeonMapLevelView then
		self._timelineAnimation:Play("timeline_reset")
		self:setSelectEpisodeItem(nil)
	end
end

function VersionActivity1_8DungeonMapChapterLayout:onActivityDungeonMoChange()
	self:updateFocusStatus()
	self:setFocusEpisodeId(self.activityDungeonMo.episodeId, true)
end

function VersionActivity1_8DungeonMapChapterLayout:updateFocusStatus()
	for _, episodeItem in pairs(self._episodeItemDict) do
		episodeItem:refreshFocusStatus()
	end
end

function VersionActivity1_8DungeonMapChapterLayout:_onGamepadKeyUp(key)
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if topView ~= ViewName.VersionActivity1_8DungeonMapView and topView ~= ViewName.VersionActivity1_8DungeonMapLevelView then
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

function VersionActivity1_8DungeonMapChapterLayout:_onChangeFocusEpisodeItem(item)
	if GamepadController.instance:isOpen() then
		for i, v in ipairs(self._episodeContainerItemList) do
			if v.episodeItem == item then
				self._focusIndex = i
			end
		end
	end
end

function VersionActivity1_8DungeonMapChapterLayout:_editableInitView()
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

	self._offsetX = (width - RIGHT_OFFSET_X) / 2 + RIGHT_OFFSET_X
	self._constDungeonNormalPosX = width - self._offsetX
	self._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	self._constDungeonNormalDeltaX = CONST_DUNGEON_NORMAL_DELTA_X

	if ViewMgr.instance:isOpening(ViewName.VersionActivity1_8DungeonMapLevelView) then
		self._timelineAnimation:Play("timeline_mask")
	end
end

function VersionActivity1_8DungeonMapChapterLayout:onUpdateParam()
	return
end

function VersionActivity1_8DungeonMapChapterLayout:onOpen()
	return
end

function VersionActivity1_8DungeonMapChapterLayout:refreshEpisodeNodes()
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

function VersionActivity1_8DungeonMapChapterLayout:getEpisodeContainerItem(index)
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

function VersionActivity1_8DungeonMapChapterLayout:setFocusEpisodeId(episodeId, tween)
	local focusItemGo = self._episodeItemDict[episodeId]

	if focusItemGo and focusItemGo.viewGO then
		self:setFocusItem(focusItemGo.viewGO, tween)
	end

	if focusItemGo then
		self:_onChangeFocusEpisodeItem(focusItemGo)
	end
end

function VersionActivity1_8DungeonMapChapterLayout:setFocusItem(focusItemGo, tween)
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

function VersionActivity1_8DungeonMapChapterLayout:setFocusEpisodeItem(item, tween)
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

function VersionActivity1_8DungeonMapChapterLayout:setSelectEpisodeItem(episodeItem)
	self.selectedEpisodeItem = episodeItem

	for _, _episodeItem in pairs(self._episodeItemDict) do
		_episodeItem:updateSelectStatus(self.selectedEpisodeItem)
	end
end

function VersionActivity1_8DungeonMapChapterLayout:playAnimation(aniName)
	self.animator:Play(aniName, 0, 0)
end

function VersionActivity1_8DungeonMapChapterLayout:playEpisodeItemAnimation(aniName)
	for _, episodeContainerItem in ipairs(self._episodeContainerItemList) do
		episodeContainerItem.episodeItem:playAnimation(aniName)
	end
end

function VersionActivity1_8DungeonMapChapterLayout:setSelectEpisodeId(episodeId, skipAni)
	self.selectedEpisodeItem = self._episodeItemDict[episodeId]

	for _, episodeItem in pairs(self._episodeItemDict) do
		episodeItem:updateSelectStatus(self.selectedEpisodeItem, skipAni)
	end
end

function VersionActivity1_8DungeonMapChapterLayout:isSelectedEpisodeRightEpisode(episodeItem)
	local result = false

	if not self.selectedEpisodeItem then
		return result
	end

	local episodeItemConfig = episodeItem._config
	local curSelectEpisodeConfig = self.selectedEpisodeItem._config

	if not episodeItemConfig then
		return result
	end

	local index = DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeItemConfig.chapterId, episodeItemConfig._config.id)
	local curIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(curSelectEpisodeConfig.chapterId, curSelectEpisodeConfig.id)

	if curIndex < index then
		result = true
	end

	return result
end

function VersionActivity1_8DungeonMapChapterLayout:onClose()
	for i, v in pairs(self._episodeContainerItemList) do
		v.episodeItem:destroyView()
	end
end

function VersionActivity1_8DungeonMapChapterLayout:onDestroyView()
	return
end

return VersionActivity1_8DungeonMapChapterLayout
