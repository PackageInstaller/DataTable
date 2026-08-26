-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonbase/view/VersionActivity1_2DungeonMapChapterBaseLayout.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapChapterBaseLayout", package.seeall)

local VersionActivity1_2DungeonMapChapterBaseLayout = class("VersionActivity1_2DungeonMapChapterBaseLayout", BaseChildView)

function VersionActivity1_2DungeonMapChapterBaseLayout:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:addEvents()
	return
end

function VersionActivity1_2DungeonMapChapterBaseLayout:removeEvents()
	return
end

function VersionActivity1_2DungeonMapChapterBaseLayout:_editableInitView()
	self.rectTransform = self.viewGO.transform

	local vec = Vector2(0, 1)

	self.rectTransform.pivot = vec
	self.rectTransform.anchorMin = vec
	self.rectTransform.anchorMax = vec
	self.defaultY = 100

	recthelper.setAnchorY(self.rectTransform, self.defaultY)

	self._ContentTransform = self.viewParam[1].transform
	self._rawWidth = recthelper.getWidth(self.rectTransform)
	self._rawHeight = recthelper.getHeight(self.rectTransform)

	recthelper.setSize(self._ContentTransform, self._rawWidth, self._rawHeight)

	self._episodeItemDict = self:getUserDataTb_()
	self._episodeContainerItemList = self:getUserDataTb_()

	local chapterKey = "default"

	self._golevellist = gohelper.findChild(self.viewGO, string.format("%s/go_levellist", chapterKey))
	self._gotemplatenormal = gohelper.findChild(self.viewGO, string.format("%s/go_levellist/#go_templatenormal", chapterKey))
	self._gotemplatesp = gohelper.findChild(self.viewGO, string.format("%s/go_levellist/#go_templatesp", chapterKey))
	self.chapterGo = gohelper.findChild(self.viewGO, chapterKey)

	gohelper.setActive(self.chapterGo, true)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local rightOffsetX = 600

	self._offsetX = (width - rightOffsetX) / 2 + rightOffsetX
	self._constDungeonNormalPosX = width - self._offsetX
	self._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	self._constDungeonNormalDeltaX = 100
	self._timelineAnimation = gohelper.findChildComponent(self.viewGO, "timeline", typeof(UnityEngine.Animation))

	if ViewMgr.instance:isOpening(ViewName.DungeonMapLevelView) then
		self._timelineAnimation:Play("timeline_mask")
	end

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.episodeItemPath = self.viewContainer:getSetting().otherRes[1]
end

function VersionActivity1_2DungeonMapChapterBaseLayout:onRefresh(chapterId, focusEpisodeId)
	self._chapterId = chapterId
	self._episodeItemDict = self:getUserDataTb_()

	local episodeList = tabletool.copy(DungeonConfig.instance:getChapterEpisodeCOList(self._chapterId))

	table.insert(episodeList, 1, episodeList[1])

	local index = 0
	local dungeonMo, episodeContainerItem

	for _, config in ipairs(episodeList) do
		dungeonMo = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil

		if dungeonMo then
			index = index + 1
			episodeContainerItem = self:getEpisodeContainerItem(index)
			self._episodeItemDict[config.id] = episodeContainerItem.episodeItem
			episodeContainerItem.containerTr.name = config.id

			episodeContainerItem.episodeItem:refresh(config, dungeonMo, index)
		end
	end

	local lastContainerItem = self._episodeContainerItemList[index]
	local pos = recthelper.rectToRelativeAnchorPos(lastContainerItem.containerTr.position, self.rectTransform)
	local width = pos.x + self._offsetX

	recthelper.setSize(self._ContentTransform, width, self._rawHeight)

	self._contentWidth = width

	for i = index + 1, #self._episodeContainerItemList do
		gohelper.setActive(self._episodeContainerItemList[i].containerTr.gameObject, false)
	end

	self:setFocusEpisodeId(focusEpisodeId or lastContainerItem.episodeItem:getEpisodeId(), false)
end

function VersionActivity1_2DungeonMapChapterBaseLayout:setFocusItem(focusItemGo, tween)
	if not focusItemGo then
		return
	end

	local pos = recthelper.rectToRelativeAnchorPos(focusItemGo.transform.position, self.rectTransform)
	local offsetX = -pos.x + self._constDungeonNormalPosX

	if tween then
		ZProj.TweenHelper.DOAnchorPosX(self._ContentTransform, offsetX, 0.26)
	else
		recthelper.setAnchorX(self._ContentTransform, offsetX)
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:setFocusEpisodeItem(item, tween)
	local offsetX = -item.scrollContentPosX + self._constDungeonNormalPosX

	if tween then
		if not DungeonMapModel.instance.focusEpisodeTweenDuration then
			local t = 0.26

			DungeonMapModel.instance.focusEpisodeTweenDuration = nil

			ZProj.TweenHelper.DOAnchorPosX(self._ContentTransform, offsetX, t)
		end
	else
		recthelper.setAnchorX(self._ContentTransform, offsetX)
	end

	self._cueSelectIndex = item._index

	local selectConfig = self._episodeContainerItemList[self._cueSelectIndex].episodeItem._config

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.selectEpisodeItem, selectConfig)
end

function VersionActivity1_2DungeonMapChapterBaseLayout:setFocusEpisodeId(episodeId, tween)
	local focusItemGo = self._episodeItemDict[episodeId]

	if focusItemGo and focusItemGo.viewGO then
		self._cueSelectIndex = focusItemGo._index

		self:setFocusItem(focusItemGo.viewGO, tween)
		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusEpisodeItem, episodeId)

		local selectConfig = self._episodeContainerItemList[self._cueSelectIndex].episodeItem._config

		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.selectEpisodeItem, selectConfig)
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:getEpisodeContainerItem(index)
	local episodeContainerItem = self._episodeContainerItemList[index]

	if episodeContainerItem then
		gohelper.setActive(episodeContainerItem.containerTr.gameObject, true)

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
	local episodeItem = self:getEpisodeItemClass()

	episodeItem.viewContainer = self.viewContainer

	episodeItem:initView(episodeItemViewGo, {
		self._ContentTransform,
		self
	})

	episodeContainerItem.episodeItem = episodeItem

	table.insert(self._episodeContainerItemList, episodeContainerItem)

	return episodeContainerItem
end

function VersionActivity1_2DungeonMapChapterBaseLayout:getEpisodeItemClass()
	return VersionActivity1_2MapEpisodeBaseItem.New()
end

function VersionActivity1_2DungeonMapChapterBaseLayout:updateEpisodeItemsSelectedStatus()
	local selectedEpisodeItem = self._episodeItemDict[VersionActivity1_2DungeonController.instance:getDungeonSelectedEpisodeId()]

	if self._episodeItemDict then
		for _, episodeItem in pairs(self._episodeItemDict) do
			episodeItem:updateSelectStatus(selectedEpisodeItem)
		end
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:onUpdateParam()
	return
end

function VersionActivity1_2DungeonMapChapterBaseLayout:onOpen()
	self._ContentTransform = self.viewParam[1].transform

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyUp, self._onGamepadKeyUp, self)
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:_onGamepadKeyUp(key)
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if (topView == ViewName.VersionActivity1_2DungeonView or topView == ViewName.VersionActivity1_2DungeonMapLevelView) and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (key == GamepadEnum.KeyCode.LB or key == GamepadEnum.KeyCode.RB) then
		local offset = key == GamepadEnum.KeyCode.LB and -1 or 1
		local index = self._cueSelectIndex + offset

		if index > 1 and index <= #self._episodeContainerItemList then
			local item = self._episodeContainerItemList[index].episodeItem

			item:onClick()
		end
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:_onOpenView(viewName)
	if viewName == self:getDungeonMapLevelView() then
		self._timelineAnimation:Play("timeline_mask")
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:_onCloseView(viewName)
	if viewName == self:getDungeonMapLevelView() then
		self._timelineAnimation:Play("timeline_reset")
		self:setSelectEpisodeItem(nil)
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:getDungeonMapLevelView()
	return ViewName.VersionActivityDungeonMapLevelView
end

function VersionActivity1_2DungeonMapChapterBaseLayout:playAnimation(aniName)
	self.animator:Play(aniName, 0, 0)
end

function VersionActivity1_2DungeonMapChapterBaseLayout:playEpisodeItemAnimation(aniName)
	for _, episodeContainerItem in ipairs(self._episodeContainerItemList) do
		episodeContainerItem.episodeItem:playAnimation(aniName)
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:setSelectEpisodeItem(episodeItem)
	self.selectedEpisodeItem = episodeItem

	for _, episodeContainerItem in ipairs(self._episodeContainerItemList) do
		episodeContainerItem.episodeItem:updateSelectStatus(self.selectedEpisodeItem)
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:isSelectedEpisodeRightEpisode(episodeItem)
	if self.selectedEpisodeItem and episodeItem._index > self.selectedEpisodeItem._index then
		return true
	end

	return false
end

function VersionActivity1_2DungeonMapChapterBaseLayout:onClose()
	for i, v in ipairs(self._episodeContainerItemList) do
		v.episodeItem:destroyView()
	end
end

function VersionActivity1_2DungeonMapChapterBaseLayout:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end
end

return VersionActivity1_2DungeonMapChapterBaseLayout
