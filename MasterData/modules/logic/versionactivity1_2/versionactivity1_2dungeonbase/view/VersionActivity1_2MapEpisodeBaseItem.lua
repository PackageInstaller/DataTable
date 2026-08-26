-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonbase/view/VersionActivity1_2MapEpisodeBaseItem.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2MapEpisodeBaseItem", package.seeall)

local VersionActivity1_2MapEpisodeBaseItem = class("VersionActivity1_2MapEpisodeBaseItem", BaseChildView)

function VersionActivity1_2MapEpisodeBaseItem:onInitView()
	self._goscale = gohelper.findChild(self.viewGO, "#go_scale")
	self._txtsection = gohelper.findChildText(self.viewGO, "#go_scale/section/#txt_section")
	self._gostaricon = gohelper.findChild(self.viewGO, "#go_scale/star/#go_staricon")
	self._txtsectionname = gohelper.findChildText(self.viewGO, "#go_scale/#txt_sectionname")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_scale/#txt_nameen")
	self._goraycast = gohelper.findChild(self.viewGO, "#go_raycast")
	self._goclickarea = gohelper.findChild(self.viewGO, "#go_clickarea")
	self._golock = gohelper.findChild(self.viewGO, "#go_scale/#go_lock")
	self.txtlocktips = gohelper.findChildText(self.viewGO, "#go_scale/#txt_locktips")
	self.imagesuo = gohelper.findChildImage(self.viewGO, "#go_scale/#txt_locktips/#image_suo")
	self._goprogressitem = gohelper.findChild(self.viewGO, "#go_scale/#go_lock/interactiveprogress/#go_progressitem")
	self._gobeselected = gohelper.findChild(self.viewGO, "#go_beselected")
	self._gointro = gohelper.findChild(self.viewGO, "#go_Intro_section")
	self._goclickintro = gohelper.findChild(self.viewGO, "#go_Intro_section/#btn_intro_section")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_2MapEpisodeBaseItem:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.focusEpisodeItem, self._focusEpisodeItem, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.afterCollectLastShow, self._afterCollectLastShow, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.unlockEpisodeItemByGuide, self._updateLock, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self._beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._endShowRewardView, self)
end

function VersionActivity1_2MapEpisodeBaseItem:removeEvents()
	return
end

function VersionActivity1_2MapEpisodeBaseItem:_focusEpisodeItem(episodeId)
	gohelper.setActive(self._gobeselected, episodeId == self._config.id and self._index ~= 1)
end

function VersionActivity1_2MapEpisodeBaseItem:onClick(showEpisodeId)
	local viewContainer = ViewMgr.instance:getContainer(self:getDungeonMapLevelView())

	if viewContainer then
		viewContainer:stopCloseViewTask()

		if self._layout.selectedEpisodeItem == self then
			ViewMgr.instance:closeView(self:getDungeonMapLevelView())

			return
		end
	end

	if self:isLock() then
		ViewMgr.instance:closeView(self:getDungeonMapLevelView())
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
		DungeonController.instance:openDungeonMapTaskView({
			viewParam = self._config.preEpisode
		})

		return
	end

	ViewMgr.instance:openView(self:getDungeonMapLevelView(), {
		episodeId = showEpisodeId or self._config.id,
		isJump = showEpisodeId and true
	})
	self._layout:setFocusEpisodeItem(self, true)
	self._layout:setSelectEpisodeItem(self)
	self._mapSceneView:changeMap(self:getMapCfg())
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusEpisodeItem, self._config.id)
end

function VersionActivity1_2MapEpisodeBaseItem:getDungeonMapLevelView()
	return ViewName.VersionActivityDungeonMapLevelView
end

function VersionActivity1_2MapEpisodeBaseItem:_onIntroClick()
	StoryController.instance:playStory(200201)
end

function VersionActivity1_2MapEpisodeBaseItem:_editableInitView()
	gohelper.setActive(self._gostaricon, false)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goClick = gohelper.getClick(self._goclickarea)

	self.goClick:AddClickListener(self.onClick, self)

	self.goIntroClick = gohelper.getClick(self._goclickintro)

	self.goIntroClick:AddClickListener(self._onIntroClick, self)
end

function VersionActivity1_2MapEpisodeBaseItem:initViewParam()
	self._contentTransform = self.viewParam[1]
	self._layout = self.viewParam[2]
	self._mapSceneView = self.viewContainer.mapScene
end

function VersionActivity1_2MapEpisodeBaseItem:onUpdateParam()
	self:initViewParam()
end

function VersionActivity1_2MapEpisodeBaseItem:onOpen()
	self:initViewParam()
end

function VersionActivity1_2MapEpisodeBaseItem:refresh(config, dungeonMo, index)
	self._index = index
	self._config = config
	self._dungeonMo = dungeonMo
	self._levelIndex = VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(self._config.id)
	self.pass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)

	self:refreshUI()
	self:calculatePosInContent()
	self:playAnimation("selected")

	self.isSelected = false

	self:_updateLock()

	if self._index == 1 then
		local transforn = self.viewGO.transform
		local childCount = transforn.childCount

		for i = 0, childCount - 1 do
			gohelper.setActive(transforn:GetChild(i).gameObject, false)
		end

		gohelper.setActive(self._gointro, true)
	end
end

function VersionActivity1_2MapEpisodeBaseItem:_OnUpdateMapElementState()
	self:_updateLock()
end

function VersionActivity1_2MapEpisodeBaseItem:refreshUI()
	self._txtsection.text = string.format("%02d", self._levelIndex)
	self._txtsectionname.text = self._config.name
	self._txtnameen.text = self._config.name_En

	self:refreshStar()
	self:refreshUnlockContent()
end

function VersionActivity1_2MapEpisodeBaseItem:refreshStar()
	self:refreshStoryModeStar()
end

function VersionActivity1_2MapEpisodeBaseItem:isDungeonHardModel()
	return VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[self._config.chapterId] == VersionActivity1_2DungeonEnum.DungeonMode.Hard
end

function VersionActivity1_2MapEpisodeBaseItem:refreshStoryModeStar()
	local episode_list = DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(self._config.id)
	local parent_obj = gohelper.findChild(self.viewGO, "#go_scale/star")

	gohelper.CreateObjList(self, self._onStarItemShow, episode_list, parent_obj, self._gostaricon)
end

function VersionActivity1_2MapEpisodeBaseItem:_onStarItemShow(obj, data, index)
	local episodeId = data
	local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId)
	local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)
	local image_star1 = gohelper.findChildImage(obj, "#image_star1")
	local image_star2 = gohelper.findChildImage(obj, "#image_star2")
	local pass = DungeonModel.instance:hasPassLevelAndStory(episodeId)

	self:setImage(image_star1, pass, self:isDungeonHardModel())

	if string.nilorempty(advancedConditionText) then
		gohelper.setActive(image_star2.gameObject, false)
	else
		gohelper.setActive(image_star2.gameObject, true)
		self:setImage(image_star2, pass and episodeMo and episodeMo.star >= DungeonEnum.StarType.Advanced, self:isDungeonHardModel())
	end
end

function VersionActivity1_2MapEpisodeBaseItem:refreshEpisodeStar(starItem, episodeId, isHard)
	gohelper.setActive(starItem.goStar, true)

	local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId)
	local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)
	local pass = DungeonModel.instance:hasPassLevelAndStory(episodeId)

	self:setImage(starItem.imgStar1, pass, isHard)

	if string.nilorempty(advancedConditionText) then
		gohelper.setActive(starItem.imgStar2.gameObject, false)
	else
		gohelper.setActive(starItem.imgStar2.gameObject, true)
		self:setImage(starItem.imgStar2, pass and episodeMo and episodeMo.star >= DungeonEnum.StarType.Advanced, isHard)
	end
end

function VersionActivity1_2MapEpisodeBaseItem:calculatePosInContent()
	local nameAnchorX = recthelper.getAnchorX(self._txtsectionname.transform)
	local nameEnAnchorX = recthelper.getAnchorX(self._txtnameen.transform)
	local halfWidth1 = nameAnchorX + self._txtsectionname.preferredWidth
	local halfWidth2 = nameEnAnchorX + self._txtsectionname.preferredWidth
	local halfWidth = math.max(halfWidth1, halfWidth2)

	self._maxWidth = math.max(halfWidth * 2, VersionActivityEnum.EpisodeItemMinWidth) + 30

	recthelper.setWidth(self._goclickarea.transform, self._maxWidth)
	gohelper.setActive(self._goraycast, false)

	self.scrollContentPosX = recthelper.rectToRelativeAnchorPos(self.viewGO.transform.position, self._contentTransform).x
end

function VersionActivity1_2MapEpisodeBaseItem:setImage(image, light, isHard)
	if light then
		if isHard then
			UISpriteSetMgr.instance:setVersionActivitySprite(image, "star_0_4")
		else
			UISpriteSetMgr.instance:setVersionActivitySprite(image, "star_0_3")
		end
	else
		UISpriteSetMgr.instance:setVersionActivitySprite(image, "star_0_1")
	end
end

function VersionActivity1_2MapEpisodeBaseItem:refreshUnlockContent()
	if self.pass or DungeonModel.instance:isReactivityEpisode(self._config.id) or DungeonModel.instance:isPermanentEpisode(self._config.id) then
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

function VersionActivity1_2MapEpisodeBaseItem:_beginShowRewardView()
	self._showRewardView = true
end

function VersionActivity1_2MapEpisodeBaseItem:_endShowRewardView()
	self._showRewardView = false

	self:_updateLock()
end

function VersionActivity1_2MapEpisodeBaseItem:_afterCollectLastShow()
	if self._config.id == 1210113 then
		self:_updateLock()
	end
end

function VersionActivity1_2MapEpisodeBaseItem:_updateLock()
	if self._showRewardView then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.KeepEpisodeItemLock) then
		return
	end

	local checkLockState = not DungeonModel.instance:isFinishElementList(self._config)
	local lockState = self._lastLockState

	if checkLockState ~= lockState then
		lockState = nil
	end

	self:_updateInteractiveProgress()

	if lockState == false then
		return
	end

	local oldValue = self._lastLockState

	self._lastLockState = not DungeonModel.instance:isFinishElementList(self._config)

	if self._config.id == 1210113 and not DungeonMapModel.instance:elementIsFinished(12101091) then
		self._lastLockState = true
	end

	if oldValue and not self._lastLockState then
		local animator = self._golock:GetComponent(typeof(UnityEngine.Animator))

		if animator then
			animator.enabled = true
		end

		local raycast = gohelper.findChild(self._golock, "raycast")

		gohelper.setActive(raycast, false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	else
		gohelper.setActive(self._golock, self._lastLockState)
	end
end

function VersionActivity1_2MapEpisodeBaseItem:_updateInteractiveProgress()
	if self._lastLockState == false then
		return
	end

	local listStr = self._config.elementList
	local list = string.splitToNumber(listStr, "#")
	local finishCount = 0

	for i, id in ipairs(list) do
		local isFinish = DungeonMapModel.instance:elementIsFinished(id)

		if isFinish then
			finishCount = finishCount + 1
		end
	end

	self:_updateProgressUI(list, finishCount)
end

function VersionActivity1_2MapEpisodeBaseItem:_updateProgressUI(elementList, finishCount)
	gohelper.setActive(self._goprogressitem, false)

	self._progressItemTab = self._progressItemTab or self:getUserDataTb_()

	for i = 1, #elementList do
		local progressItem = self._progressItemTab[i]

		if not progressItem then
			progressItem = gohelper.cloneInPlace(self._goprogressitem, "progress_" .. i)

			table.insert(self._progressItemTab, progressItem)
		end

		local id = elementList[i]

		gohelper.setActive(progressItem, id)

		if id then
			local isFinish = i <= finishCount

			gohelper.setActive(gohelper.findChild(progressItem, "finish"), isFinish)
			gohelper.setActive(gohelper.findChild(progressItem, "unfinish"), not isFinish)
		end
	end

	local allItemCount = #self._progressItemTab

	if self._progressItemTab and allItemCount > #elementList then
		for k = #elementList + 1, allItemCount do
			gohelper.setActive(self._progressItemTab[k], false)
		end
	end
end

function VersionActivity1_2MapEpisodeBaseItem:isLock()
	if self._config.id == 1210113 and not DungeonMapModel.instance:elementIsFinished(12101091) then
		return true
	end

	return not DungeonModel.instance:isFinishElementList(self._config)
end

function VersionActivity1_2MapEpisodeBaseItem:getMaxWidth()
	return self._maxWidth
end

function VersionActivity1_2MapEpisodeBaseItem:showUnlockAnim()
	logWarn("episode item play unlock animation")
end

function VersionActivity1_2MapEpisodeBaseItem:getMapCfg()
	return VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(self._config.id)
end

function VersionActivity1_2MapEpisodeBaseItem:updateSelectStatus(selectedItem)
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

function VersionActivity1_2MapEpisodeBaseItem:playAnimation(animationName)
	self.animator:Play(animationName, 0, 0)
end

function VersionActivity1_2MapEpisodeBaseItem:getEpisodeId()
	return self._config and self._config.id
end

function VersionActivity1_2MapEpisodeBaseItem:onClose()
	self.goClick:RemoveClickListener()
	self.goIntroClick:RemoveClickListener()
end

function VersionActivity1_2MapEpisodeBaseItem:onDestroyView()
	return
end

return VersionActivity1_2MapEpisodeBaseItem
