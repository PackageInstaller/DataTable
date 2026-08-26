-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeonbase/view/VersionActivity1_3DungeonBaseEpisodeItem.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeonbase.view.VersionActivity1_3DungeonBaseEpisodeItem", package.seeall)

local VersionActivity1_3DungeonBaseEpisodeItem = class("VersionActivity1_3DungeonBaseEpisodeItem", BaseChildView)

function VersionActivity1_3DungeonBaseEpisodeItem:onInitView()
	self._goscale = gohelper.findChild(self.viewGO, "#go_scale")
	self._txtsection = gohelper.findChildText(self.viewGO, "#go_scale/section/#txt_section")
	self._gostaricon = gohelper.findChild(self.viewGO, "#go_scale/star/#go_staricon")
	self._txtsectionname = gohelper.findChildText(self.viewGO, "#go_scale/#txt_sectionname")
	self._gotipcontent = gohelper.findChild(self.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent")
	self._gotipitem = gohelper.findChild(self.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent/#go_tipitem")
	self._goflag = gohelper.findChild(self.viewGO, "#go_scale/#go_flag")
	self._gonormaleye = gohelper.findChild(self.viewGO, "#go_scale/#image_normal")
	self._gohardeye = gohelper.findChild(self.viewGO, "#go_scale/#image_hard")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	self._goraycast = gohelper.findChild(self.viewGO, "#go_raycast")
	self._goclickarea = gohelper.findChild(self.viewGO, "#go_clickarea")
	self.goSelected = gohelper.findChild(self.viewGO, "#go_beselected")
	self.txtlocktips = gohelper.findChildText(self.viewGO, "#txt_locktips")
	self.imagesuo = gohelper.findChildImage(self.viewGO, "#txt_locktips/#image_suo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3DungeonBaseEpisodeItem:addEvents()
	return
end

function VersionActivity1_3DungeonBaseEpisodeItem:removeEvents()
	return
end

function VersionActivity1_3DungeonBaseEpisodeItem:onClick()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.VersionActivity1_3DungeonMapLevelView)

	if viewContainer then
		viewContainer:stopCloseViewTask()

		if self._layout.selectedEpisodeItem == self then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)

			return
		end
	end

	if self:isLock() then
		ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)
		DungeonController.instance:openDungeonMapTaskView({
			viewParam = self._config.preEpisode
		})

		return
	end

	self.activityDungeonMo:changeEpisode(self:getEpisodeId())
	self._mapSceneView:refreshMap()
	self._layout:updateFocusStatus(self)
	self._layout:setFocusEpisodeItem(self, true)

	if GamepadController.instance:isOpen() then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, self)
	end

	self._needShowMapLevelView = true

	if self:_promptlyShow() then
		self:_showMapLevelView()
	else
		ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)
	end
end

function VersionActivity1_3DungeonBaseEpisodeItem:isLock()
	return not DungeonModel.instance:isFinishElementList(self._config)
end

function VersionActivity1_3DungeonBaseEpisodeItem:_promptlyShow()
	return true
end

function VersionActivity1_3DungeonBaseEpisodeItem:_showMapLevelView()
	self._needShowMapLevelView = false

	ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapLevelView, {
		episodeId = self._config.id
	})
	self._layout:setSelectEpisodeItem(self)
end

function VersionActivity1_3DungeonBaseEpisodeItem:_editableInitView()
	gohelper.setActive(self._gostaricon, false)
	gohelper.setActive(self._goflag, false)
	gohelper.setActive(self._gotipitem, false)
	gohelper.setActive(self._gonormaleye, false)
	gohelper.setActive(self._gohardeye, false)

	self.starItemList = {}
	self.elementItemList = {}

	table.insert(self.starItemList, self:createStarItem(self._gostaricon))

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goClick = gohelper.getClick(self._goclickarea)

	self.goClick:AddClickListener(self.onClick, self)
end

function VersionActivity1_3DungeonBaseEpisodeItem:_showEye()
	local showEye = self._config.displayMark == 1

	if not showEye then
		gohelper.setActive(self._gonormaleye, false)
		gohelper.setActive(self._gohardeye, false)

		return
	end

	local isHard = self._config.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard

	gohelper.setActive(self._gonormaleye, not isHard)
	gohelper.setActive(self._gohardeye, isHard)
end

function VersionActivity1_3DungeonBaseEpisodeItem:initViewParam()
	self._contentTransform = self.viewParam[1]
	self._layout = self.viewParam[2]
	self._mapSceneView = self.viewContainer.mapScene
end

function VersionActivity1_3DungeonBaseEpisodeItem:onUpdateParam()
	self:initViewParam()
end

function VersionActivity1_3DungeonBaseEpisodeItem:onOpen()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self.refreshElements, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._endShowRewardView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:initViewParam()
end

function VersionActivity1_3DungeonBaseEpisodeItem:_onCloseViewFinish(viewName)
	return
end

function VersionActivity1_3DungeonBaseEpisodeItem:getMapAllElementList()
	local mapId = self._map.id
	local mapAllElementList = DungeonConfig.instance:getMapElements(mapId)

	if not mapAllElementList then
		return
	end

	local list = {}

	for i, v in ipairs(mapAllElementList) do
		if v.type ~= DungeonEnum.ElementType.DailyEpisode then
			table.insert(list, v)
		end
	end

	return list
end

function VersionActivity1_3DungeonBaseEpisodeItem:_showAllElementTipView()
	if not self._map then
		gohelper.setActive(self._gotipcontent, false)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	self._pass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)

	local mapAllElementList = self:getMapAllElementList()

	if not mapAllElementList or #mapAllElementList < 1 then
		gohelper.setActive(self._gotipcontent, false)

		self._showAllElementTip = false
	else
		local finishCount = 0

		for i, v in ipairs(mapAllElementList) do
			if DungeonMapModel.instance:elementIsFinished(v.id) then
				finishCount = finishCount + 1
			end
		end

		local elementItem

		for index, _ in ipairs(mapAllElementList) do
			elementItem = self.elementItemList[index]

			if not self.elementItemList[index] then
				elementItem = self:getUserDataTb_()
				elementItem.go = gohelper.cloneInPlace(self._gotipitem)
				elementItem.goNotFinish = gohelper.findChild(elementItem.go, "type1")
				elementItem.goFinish = gohelper.findChild(elementItem.go, "type2")
				elementItem.animator = elementItem.go:GetComponent(typeof(UnityEngine.Animator))
				elementItem.status = nil

				table.insert(self.elementItemList, elementItem)
			end

			gohelper.setActive(elementItem.go, true)

			if self._pass then
				local isFinish = index <= finishCount

				gohelper.setActive(elementItem.goNotFinish, not isFinish)
				gohelper.setActive(elementItem.goFinish, isFinish)

				if elementItem.status == false and isFinish then
					gohelper.setActive(elementItem.goNotFinish, true)
					elementItem.animator:Play("switch", 0, 0)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
				end

				elementItem.status = isFinish
			end
		end

		local oldStatus = self._showAllElementTip

		self._showAllElementTip = self._pass and finishCount ~= #mapAllElementList

		if oldStatus and not self._showAllElementTip then
			TaskDispatcher.cancelTask(self._hideAllElementTip, self)
			TaskDispatcher.runDelay(self._hideAllElementTip, self, 0.8)
		else
			gohelper.setActive(self._gotipcontent, self._showAllElementTip)
		end
	end
end

function VersionActivity1_3DungeonBaseEpisodeItem:_hideAllElementTip()
	gohelper.setActive(self._gotipcontent, false)
end

function VersionActivity1_3DungeonBaseEpisodeItem:refresh(config, dungeonMo)
	self._config = config
	self._dungeonMo = dungeonMo
	self._levelIndex = self._config.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard and DungeonConfig.instance:getChapterEpisodeIndexWithSP(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, self._config.id - 10000) or DungeonConfig.instance:getChapterEpisodeIndexWithSP(self._config.chapterId, self._config.id)
	self.pass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)
	self._map = DungeonMapEpisodeItem.getMap(self._config)

	self:refreshUI()
	self:calculatePosInContent()
	self:playAnimation("selected")

	self.isSelected = false

	self:_showEye()
end

function VersionActivity1_3DungeonBaseEpisodeItem:refreshUI()
	self._txtsection.text = string.format("%02d", self._levelIndex)
	self._txtsectionname.text = self._config.name
	self._txtnameen.text = self._config.name_En

	self:refreshStar()
	self:refreshFlag()
	self:refreshUnlockContent()
	self:refreshFocusStatus()
	self:refreshElements()
	self:_showAllElementTipView()
end

function VersionActivity1_3DungeonBaseEpisodeItem:refreshStar()
	if self.activityDungeonMo:isHardMode() then
		self:refreshHardModeStar()
	else
		self:refreshStoryModeStar()
	end
end

function VersionActivity1_3DungeonBaseEpisodeItem:refreshFlag()
	gohelper.setActive(self._goflag, not self.pass)
end

function VersionActivity1_3DungeonBaseEpisodeItem:refreshUnlockContent()
	if self.pass or DungeonModel.instance:isReactivityEpisode(self._config.id) then
		gohelper.setActive(self.txtlocktips.gameObject, false)

		return
	end

	local openList = OpenConfig.instance:getOpenShowInEpisode(self._config.id)

	if openList and #openList > 0 then
		gohelper.setActive(self.txtlocktips.gameObject, true)

		local unLockContentList = DungeonModel.instance:getUnlockContentList(self._config.id)

		if unLockContentList and #unLockContentList > 0 then
			self.txtlocktips.text = unLockContentList[1] or ""
		end

		UISpriteSetMgr.instance:setUiFBSprite(self.imagesuo, "unlock", true)
	else
		gohelper.setActive(self.txtlocktips.gameObject, false)
	end
end

function VersionActivity1_3DungeonBaseEpisodeItem:refreshHardModeStar()
	self:refreshEpisodeStar(self.starItemList[1], self._config.id)

	for i = 2, #self.starItemList do
		gohelper.setActive(self.starItemList[i].goStar, false)
	end
end

function VersionActivity1_3DungeonBaseEpisodeItem:refreshStoryModeStar()
	local starItem

	for index, episodeCo in ipairs(DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(self._config)) do
		starItem = self.starItemList[index]

		if not self.starItemList[index] then
			starItem = self:createStarItem(gohelper.cloneInPlace(self._gostaricon))

			table.insert(self.starItemList, starItem)
		end

		self:refreshEpisodeStar(starItem, episodeCo.id)
	end
end

function VersionActivity1_3DungeonBaseEpisodeItem:refreshEpisodeStar(starItem, episodeId)
	gohelper.setActive(starItem.goStar, true)

	local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId)
	local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)

	self:setImage(starItem.imgStar1, self.pass and episodeMo and episodeMo.star > DungeonEnum.StarType.None, episodeId)

	if string.nilorempty(advancedConditionText) then
		gohelper.setActive(starItem.imgStar2.gameObject, false)
	else
		gohelper.setActive(starItem.imgStar2.gameObject, true)
		self:setImage(starItem.imgStar2, self.pass and episodeMo and episodeMo.star >= DungeonEnum.StarType.Advanced, episodeId)
	end
end

function VersionActivity1_3DungeonBaseEpisodeItem:refreshFocusStatus()
	gohelper.setActive(self.goSelected, self._config.id == self.activityDungeonMo.episodeId)
end

function VersionActivity1_3DungeonBaseEpisodeItem:refreshElements()
	return
end

function VersionActivity1_3DungeonBaseEpisodeItem:_endShowRewardView()
	self:_showAllElementTipView()
end

function VersionActivity1_3DungeonBaseEpisodeItem:calculatePosInContent()
	local nameAnchorX = recthelper.getAnchorX(self._txtsectionname.transform)
	local nameEnAnchorX = recthelper.getAnchorX(self._txtnameen.transform)
	local halfWidth1 = nameAnchorX + self._txtsectionname.preferredWidth
	local halfWidth2 = nameEnAnchorX + self._txtsectionname.preferredWidth
	local halfWidth = math.max(halfWidth1, halfWidth2)

	self._maxWidth = math.max(halfWidth * 2, VersionActivity1_3DungeonEnum.EpisodeItemMinWidth) + 30

	recthelper.setWidth(self._goclickarea.transform, self._maxWidth)
	recthelper.setWidth(self._goraycast.transform, self._maxWidth + self._layout._constDungeonNormalDeltaX)

	self.scrollContentPosX = recthelper.rectToRelativeAnchorPos(self.viewGO.transform.position, self._contentTransform).x
end

function VersionActivity1_3DungeonBaseEpisodeItem:setImage(image, light, episodeId)
	if light then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local starType = VersionActivity1_3DungeonEnum.EpisodeStarType[episodeConfig.chapterId]

		UISpriteSetMgr.instance:setVersionActivity1_3Sprite(image, starType)
	else
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local starType = VersionActivity1_3DungeonEnum.EpisodeStarEmptyType[episodeConfig.chapterId]

		UISpriteSetMgr.instance:setVersionActivity1_3Sprite(image, starType)
	end
end

function VersionActivity1_3DungeonBaseEpisodeItem:getMaxWidth()
	return self._maxWidth
end

function VersionActivity1_3DungeonBaseEpisodeItem:updateSelectStatus(selectedItem)
	if not selectedItem then
		if not self.isSelected and self.playLeftAnimation then
			self:playAnimation("restore")
		end

		self.isSelected = false

		return
	end

	self.isSelected = selectedItem._config.id == self._config.id

	if selectedItem._config.id == self._config.id then
		self:playAnimation("selected")
	else
		self.playLeftAnimation = true

		self:playAnimation("notselected")
	end
end

function VersionActivity1_3DungeonBaseEpisodeItem:playAnimation(animationName)
	self.animator:Play(animationName, 0, 0)
end

function VersionActivity1_3DungeonBaseEpisodeItem:getEpisodeId()
	return self._config and self._config.id
end

function VersionActivity1_3DungeonBaseEpisodeItem:createStarItem(goStar)
	local starItem = self:getUserDataTb_()

	starItem.goStar = goStar
	starItem.imgStar1 = gohelper.findChildImage(goStar, "starLayout/#image_star1")
	starItem.imgStar2 = gohelper.findChildImage(goStar, "starLayout/#image_star2")

	return starItem
end

function VersionActivity1_3DungeonBaseEpisodeItem:onClose()
	return
end

function VersionActivity1_3DungeonBaseEpisodeItem:onDestroyView()
	self.goClick:RemoveClickListener()
end

return VersionActivity1_3DungeonBaseEpisodeItem
