-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/map/VersionActivity2_4DungeonMapEpisodeItem.lua

module("modules.logic.versionactivity2_4.dungeon.view.map.VersionActivity2_4DungeonMapEpisodeItem", package.seeall)

local VersionActivity2_4DungeonMapEpisodeItem = class("VersionActivity2_4DungeonMapEpisodeItem", BaseChildView)

function VersionActivity2_4DungeonMapEpisodeItem:onInitView()
	self._goscale = gohelper.findChild(self.viewGO, "#go_scale")
	self._txtsection = gohelper.findChildText(self.viewGO, "#go_scale/section/#txt_section")
	self._gostaricon = gohelper.findChild(self.viewGO, "#go_scale/star/#go_staricon")
	self._txtsectionname = gohelper.findChildText(self.viewGO, "#go_scale/#txt_sectionname")
	self._gotipcontent = gohelper.findChild(self.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent")
	self._gotipitem = gohelper.findChild(self.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent/#go_tipitem")
	self._goflag = gohelper.findChild(self.viewGO, "#go_scale/#go_flag")
	self._gobgicon1 = gohelper.findChild(self.viewGO, "#go_scale/section/#go_bgicon1")
	self._gobgicon2 = gohelper.findChild(self.viewGO, "#go_scale/section/#go_bgicon2")
	self._gonormaleye = gohelper.findChild(self.viewGO, "#go_scale/#image_normal")
	self._gohardeye = gohelper.findChild(self.viewGO, "#go_scale/#image_hard")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	self._goraycast = gohelper.findChild(self.viewGO, "#go_raycast")
	self._goclickarea = gohelper.findChild(self.viewGO, "#go_clickarea")
	self.goSelected = gohelper.findChild(self.viewGO, "#go_beselected")
	self.txtlocktips = gohelper.findChildText(self.viewGO, "#txt_locktips")
	self.imagesuo = gohelper.findChildImage(self.viewGO, "#txt_locktips/#image_suo")
	self.goLock = gohelper.findChild(self.viewGO, "#go_scale/#go_lock")
	self.goLockAnimator = self.goLock:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4DungeonMapEpisodeItem:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
end

function VersionActivity2_4DungeonMapEpisodeItem:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
end

function VersionActivity2_4DungeonMapEpisodeItem:onClick()
	if self.isLock then
		ViewMgr.instance:openView(ViewName.DungeonMapTaskView, {
			viewParam = self._config.preEpisode
		})

		return
	end

	local viewContainer = ViewMgr.instance:getContainer(ViewName.VersionActivity2_4DungeonMapLevelView)

	if viewContainer then
		viewContainer:stopCloseViewTask()

		if viewContainer:getOpenedEpisodeId() == self._config.id then
			ViewMgr.instance:closeView(ViewName.VersionActivity2_4DungeonMapLevelView)

			return
		end
	end

	self.activityDungeonMo:changeEpisode(self:getEpisodeId())
	self._layout:setSelectEpisodeItem(self)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4DungeonMapLevelView, {
		episodeId = self._config.id
	})
end

function VersionActivity2_4DungeonMapEpisodeItem:_editableInitView()
	gohelper.setActive(self._gostaricon, false)
	gohelper.setActive(self._goflag, false)
	gohelper.setActive(self._gotipitem, false)
	gohelper.setActive(self._gonormaleye, false)
	gohelper.setActive(self._gohardeye, false)
	gohelper.setActive(self._gobgicon1, true)
	gohelper.setActive(self._gobgicon2, false)

	self.starItemList = {}
	self.elementItemList = {}

	table.insert(self.starItemList, self:createStarItem(self._gostaricon))

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goClick = gohelper.getClick(self._goclickarea)

	self.goClick:AddClickListener(self.onClick, self)
end

function VersionActivity2_4DungeonMapEpisodeItem:_showEye()
	local showEye = self._config.displayMark == 1

	if not showEye then
		gohelper.setActive(self._gonormaleye, false)
		gohelper.setActive(self._gohardeye, false)

		return
	end

	gohelper.setActive(self._gobgicon1, not showEye)
	gohelper.setActive(self._gobgicon2, showEye)

	local isHard = self._config.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Hard

	gohelper.setActive(self._gonormaleye, not isHard)
	gohelper.setActive(self._gohardeye, isHard)
end

function VersionActivity2_4DungeonMapEpisodeItem:initViewParam()
	self._contentTransform = self.viewParam[1]
	self._layout = self.viewParam[2]
	self._mapSceneView = self.viewContainer.mapScene
end

function VersionActivity2_4DungeonMapEpisodeItem:onUpdateParam()
	self:initViewParam()
	self:_showAllElementTipView()
end

function VersionActivity2_4DungeonMapEpisodeItem:onOpen()
	self:initViewParam()
end

function VersionActivity2_4DungeonMapEpisodeItem:getMapAllElementList()
	return (VersionActivity2_4DungeonModel.instance:getElementCoList(self._map.id))
end

function VersionActivity2_4DungeonMapEpisodeItem:_showAllElementTipView()
	if not self._map or self._config.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Hard then
		gohelper.setActive(self._gotipcontent, false)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	local finishElementCoList, mapAllElementList = VersionActivity2_4DungeonModel.instance:getElementCoListWithFinish(self._map.id)

	if not mapAllElementList or #mapAllElementList < 1 then
		gohelper.setActive(self._gotipcontent, false)

		self._showAllElementTip = false
	else
		local finishCount = GameUtil.getTabLen(finishElementCoList)
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

			if self.pass then
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

		self._showAllElementTip = self.pass and finishCount ~= #mapAllElementList

		if oldStatus and not self._showAllElementTip then
			TaskDispatcher.cancelTask(self._hideAllElementTip, self)
			TaskDispatcher.runDelay(self._hideAllElementTip, self, 0.8)
		else
			gohelper.setActive(self._gotipcontent, self._showAllElementTip)
		end
	end
end

function VersionActivity2_4DungeonMapEpisodeItem:_hideAllElementTip()
	gohelper.setActive(self._gotipcontent, false)
end

function VersionActivity2_4DungeonMapEpisodeItem:refresh(config, dungeonMo)
	self._config = config
	self._dungeonMo = dungeonMo
	self._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(self._config)
	self.pass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)
	self._map = VersionActivity2_4DungeonConfig.instance:getEpisodeMapConfig(self._config.id)

	self:refreshUI()
	self:calculatePosInContent()
	self:playAnimation("selected")

	self.isSelected = false
end

function VersionActivity2_4DungeonMapEpisodeItem:refreshUI()
	self._txtsection.text = string.format("%02d", self._levelIndex)
	self._txtsectionname.text = self._config.name
	self._txtnameen.text = self._config.name_En

	self:refreshStar()
	self:refreshFlag()
	self:refreshUnlockContent()
	self:refreshFocusStatus()
	self:_showAllElementTipView()
	self:_showEye()
	self:refreshLock()
end

function VersionActivity2_4DungeonMapEpisodeItem:refreshLock()
	self.isLock = self:checkLock()

	gohelper.setActive(self.goLock, self:checkLock())
end

function VersionActivity2_4DungeonMapEpisodeItem:initElementIdList()
	if not self.elementIdList then
		local listStr = self._config.elementList

		if not string.nilorempty(listStr) then
			self.elementIdList = string.splitToNumber(listStr, "#")
		end
	end
end

function VersionActivity2_4DungeonMapEpisodeItem:clearElementIdList()
	self.elementIdList = nil
end

function VersionActivity2_4DungeonMapEpisodeItem:checkLock()
	self:initElementIdList()

	if not self.elementIdList then
		return false
	end

	for _, elementId in ipairs(self.elementIdList) do
		if not DungeonMapModel.instance:elementIsFinished(elementId) then
			return true
		end
	end

	return false
end

function VersionActivity2_4DungeonMapEpisodeItem:refreshStar()
	if self.activityDungeonMo:isHardMode() then
		self:refreshHardModeStar()
	else
		self:refreshStoryModeStar()
	end
end

function VersionActivity2_4DungeonMapEpisodeItem:refreshFlag()
	gohelper.setActive(self._goflag, false)
end

function VersionActivity2_4DungeonMapEpisodeItem:refreshUnlockContent()
	if self.pass then
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

function VersionActivity2_4DungeonMapEpisodeItem:refreshHardModeStar()
	self:refreshEpisodeStar(self.starItemList[1], self._config.id)

	for i = 2, #self.starItemList do
		gohelper.setActive(self.starItemList[i].goStar, false)
	end
end

function VersionActivity2_4DungeonMapEpisodeItem:refreshStoryModeStar()
	local starItem
	local episodeList = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(self._config)

	for index, episodeCo in ipairs(episodeList) do
		starItem = self.starItemList[index]

		if not self.starItemList[index] then
			starItem = self:createStarItem(gohelper.cloneInPlace(self._gostaricon))

			table.insert(self.starItemList, starItem)
		end

		self:refreshEpisodeStar(starItem, episodeCo.id)
	end
end

function VersionActivity2_4DungeonMapEpisodeItem:refreshEpisodeStar(starItem, episodeId)
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

function VersionActivity2_4DungeonMapEpisodeItem:refreshFocusStatus()
	gohelper.setActive(self.goSelected, self._config.id == self.activityDungeonMo.episodeId)
end

function VersionActivity2_4DungeonMapEpisodeItem:beginShowRewardView()
	self.beginReward = true
end

function VersionActivity2_4DungeonMapEpisodeItem:endShowRewardView()
	self.beginReward = false

	if self.needPlayUnLockAnimation then
		self:playUnLockAnimation()

		self.needPlayUnLockAnimation = nil
	end

	self:_showAllElementTipView()
end

function VersionActivity2_4DungeonMapEpisodeItem:calculatePosInContent()
	local nameAnchorX = recthelper.getAnchorX(self._txtsectionname.transform)
	local nameEnAnchorX = recthelper.getAnchorX(self._txtnameen.transform)
	local halfWidth1 = nameAnchorX + self._txtsectionname.preferredWidth
	local halfWidth2 = nameEnAnchorX + self._txtsectionname.preferredWidth
	local halfWidth = math.max(halfWidth1, halfWidth2)

	self._maxWidth = math.max(halfWidth * 2, VersionActivity2_4DungeonEnum.EpisodeItemMinWidth) + 30

	recthelper.setWidth(self._goclickarea.transform, self._maxWidth)
	recthelper.setWidth(self._goraycast.transform, self._maxWidth + self._layout._constDungeonNormalDeltaX)

	self.scrollContentPosX = recthelper.rectToRelativeAnchorPos(self.viewGO.transform.position, self._contentTransform).x
end

function VersionActivity2_4DungeonMapEpisodeItem:setImage(image, light, episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local starType = VersionActivity2_4DungeonEnum.EpisodeStarType[episodeConfig.chapterId]

	if light then
		if not starType.light then
			local lightStateIcon = starType.empty

			UISpriteSetMgr.instance:setV2a4DungeonSprite(image, lightStateIcon)
		end
	end
end

function VersionActivity2_4DungeonMapEpisodeItem:getMaxWidth()
	return self._maxWidth
end

function VersionActivity2_4DungeonMapEpisodeItem:updateSelectStatus(selectedItem, ignoreAni)
	if not selectedItem then
		if not self.isSelected and self.playLeftAnimation then
			self:playAnimation("restore")
		end

		self.isSelected = false

		return
	end

	self.isSelected = selectedItem._config.id == self._config.id

	if ignoreAni then
		return
	end

	if selectedItem._config.id == self._config.id then
		self:playAnimation("selected")
	else
		self.playLeftAnimation = true

		self:playAnimation("notselected")
	end
end

function VersionActivity2_4DungeonMapEpisodeItem:onRemoveElement(elementId)
	if not self.beginReward then
		self:_showAllElementTipView()
	end

	self:initElementIdList()

	if not self.elementIdList then
		return
	end

	for _, _elementId in ipairs(self.elementIdList) do
		if _elementId == elementId then
			local newIsLock = self:checkLock()

			if newIsLock == self.isLock then
				break
			end

			if newIsLock then
				self:refreshLock()

				break
			else
				self.isLock = newIsLock

				if self.beginReward then
					self.needPlayUnLockAnimation = true
				else
					self:playUnLockAnimation()
				end
			end
		end
	end
end

function VersionActivity2_4DungeonMapEpisodeItem:playUnLockAnimation()
	local animator = self.goLock:GetComponent(typeof(UnityEngine.Animator))

	animator.enabled = true
end

function VersionActivity2_4DungeonMapEpisodeItem:playAnimation(animationName)
	if self.prePlayAnimName == animationName then
		return
	end

	self.prePlayAnimName = animationName

	self.animator:Play(animationName, 0, 0)
end

function VersionActivity2_4DungeonMapEpisodeItem:getEpisodeId()
	return self._config and self._config.id
end

function VersionActivity2_4DungeonMapEpisodeItem:createStarItem(goStar)
	local starItem = self:getUserDataTb_()

	starItem.goStar = goStar
	starItem.imgStar1 = gohelper.findChildImage(goStar, "starLayout/#image_star1")
	starItem.imgStar2 = gohelper.findChildImage(goStar, "starLayout/#image_star2")

	return starItem
end

function VersionActivity2_4DungeonMapEpisodeItem:onClose()
	TaskDispatcher.cancelTask(self._hideAllElementTip, self)
end

function VersionActivity2_4DungeonMapEpisodeItem:onDestroyView()
	self.goClick:RemoveClickListener()
end

return VersionActivity2_4DungeonMapEpisodeItem
