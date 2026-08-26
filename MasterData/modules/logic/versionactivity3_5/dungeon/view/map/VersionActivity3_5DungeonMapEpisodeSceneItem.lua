-- chunkname: @modules/logic/versionactivity3_5/dungeon/view/map/VersionActivity3_5DungeonMapEpisodeSceneItem.lua

module("modules.logic.versionactivity3_5.dungeon.view.map.VersionActivity3_5DungeonMapEpisodeSceneItem", package.seeall)

local VersionActivity3_5DungeonMapEpisodeSceneItem = class("VersionActivity3_5DungeonMapEpisodeSceneItem", BaseChildView)

function VersionActivity3_5DungeonMapEpisodeSceneItem:onInitView()
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

function VersionActivity3_5DungeonMapEpisodeSceneItem:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivity3_5DungeonEvent.V3a2CameraSizeChange, self._onCameraSizeChange, self)
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:_onCameraSizeChange()
	self._uiFollower = self._uiFollower or self.viewGO:GetComponent(typeof(ZProj.UIFollower))

	self._uiFollower:ForceUpdate()
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:onClick()
	if VersionActivity3_5DungeonLogicController.instance:isInDragFrame() then
		return
	end

	if self.isLock then
		ViewMgr.instance:openView(ViewName.DungeonMapTaskView, {
			viewParam = self._config.preEpisode
		})

		return
	end

	local viewContainer = ViewMgr.instance:getContainer(VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion))

	if viewContainer then
		viewContainer:stopCloseViewTask()

		if viewContainer:getOpenedEpisodeId() == self._config.id then
			ViewMgr.instance:closeView(VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion))

			return
		end
	end

	self.activityDungeonMo:changeEpisode(self:getEpisodeId())
	ViewMgr.instance:openView(VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion), {
		episodeId = self._config.id
	})
	VersionActivity3_5DungeonLogicController.instance:setDragFrameFlag()
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:_editableInitView()
	gohelper.setActive(self._gostaricon, false)
	gohelper.setActive(self._goflag, false)
	gohelper.setActive(self._gotipitem, false)
	gohelper.setActive(self._gonormaleye, false)
	gohelper.setActive(self._gohardeye, false)
	gohelper.setActive(self._gobgicon1, true)
	gohelper.setActive(self._gobgicon2, false)

	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	self.starItemList = {}
	self.elementItemList = {}

	table.insert(self.starItemList, self:createStarItem(self._gostaricon))

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goClick = gohelper.getClick(self._goclickarea)

	self.goClick:AddClickListener(self.onClick, self)
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:_showEye()
	local showEye = self._config.displayMark == 1

	if not showEye then
		gohelper.setActive(self._gonormaleye, false)
		gohelper.setActive(self._gohardeye, false)

		return
	end

	gohelper.setActive(self._gobgicon1, not showEye)
	gohelper.setActive(self._gobgicon2, showEye)

	local isHard = self._config.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).DungeonChapterId.Hard

	gohelper.setActive(self._gonormaleye, not isHard)
	gohelper.setActive(self._gohardeye, isHard)
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:initViewParam()
	self._contentTransform = self.viewParam[1]
	self._layout = self.viewParam[2]
	self._mapSceneView = self.viewContainer.mapScene
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:onUpdateParam()
	self:initViewParam()
	self:_showAllElementTipView()
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:onOpen()
	self:initViewParam()
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:getMapAllElementList()
	return (VersionActivityFixedDungeonModel.instance:getElementCoList(self._map.id))
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:_showAllElementTipView()
	if not self._map or self._config.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).DungeonChapterId.Hard then
		gohelper.setActive(self._gotipcontent, false)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	local finishElementCoList, mapAllElementList = VersionActivityFixedDungeonModel.instance:getElementCoListWithFinish(self._map.id)

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

function VersionActivity3_5DungeonMapEpisodeSceneItem:_hideAllElementTip()
	gohelper.setActive(self._gotipcontent, false)
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:refresh(config, dungeonMo)
	self._config = config
	self._dungeonMo = dungeonMo
	self._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(self._config)
	self.pass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)
	self._map = VersionActivityFixedDungeonConfig.instance:getEpisodeMapConfig(self._config.id)

	self:refreshUI()
	self:calculatePosInContent()
	self:playAnimation("selected")

	self.isSelected = false
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:refreshUI()
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

function VersionActivity3_5DungeonMapEpisodeSceneItem:refreshLock()
	self.isLock = self:checkLock()

	gohelper.setActive(self.goLock, self:checkLock())
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:initElementIdList()
	if not self.elementIdList then
		local listStr = self._config.elementList

		if not string.nilorempty(listStr) then
			self.elementIdList = string.splitToNumber(listStr, "#")
		end
	end
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:clearElementIdList()
	self.elementIdList = nil
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:checkLock()
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

function VersionActivity3_5DungeonMapEpisodeSceneItem:refreshStar()
	if self.activityDungeonMo:isHardMode() then
		self:refreshHardModeStar()
	else
		self:refreshStoryModeStar()
	end
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:refreshFlag()
	gohelper.setActive(self._goflag, false)
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:refreshUnlockContent()
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

function VersionActivity3_5DungeonMapEpisodeSceneItem:refreshHardModeStar()
	self:refreshEpisodeStar(self.starItemList[1], self._config.id)

	for i = 2, #self.starItemList do
		gohelper.setActive(self.starItemList[i].goStar, false)
	end
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:refreshStoryModeStar()
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

function VersionActivity3_5DungeonMapEpisodeSceneItem:refreshEpisodeStar(starItem, episodeId)
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

function VersionActivity3_5DungeonMapEpisodeSceneItem:refreshFocusStatus()
	gohelper.setActive(self.goSelected, self._config.id == self.activityDungeonMo.episodeId)
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:beginShowRewardView()
	self.beginReward = true
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:endShowRewardView()
	self.beginReward = false

	if self.needPlayUnLockAnimation then
		self:playUnLockAnimation()

		self.needPlayUnLockAnimation = nil
	end

	self:_showAllElementTipView()
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:calculatePosInContent()
	local nameAnchorX = recthelper.getAnchorX(self._txtsectionname.transform)
	local nameEnAnchorX = recthelper.getAnchorX(self._txtnameen.transform)
	local nameWidth = self._txtsectionname.preferredWidth
	local nameEnWidth = self._txtnameen.preferredWidth

	if self.elementItemList then
		if not (#self.elementItemList * 20) then
			local elementWidth = 0
			local halfWidth1 = nameAnchorX + nameWidth + elementWidth
			local halfWidth2 = nameEnAnchorX + nameEnWidth - nameWidth * 0.5 - elementWidth

			if self.starItemList then
				if not #self.starItemList then
					local starCount = 1
					local starWidth = starCount * 70 + 80 - nameWidth - elementWidth
					local oversize = math.max(starWidth, halfWidth2)

					if oversize > 0 then
						if not (halfWidth1 + oversize) then
							local width = halfWidth1

							self._maxWidth = width + VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).EpisodeItemMinWidth

							recthelper.setWidth(self._goclickarea.transform, self._maxWidth)
						end
					end
				end
			end
		end
	end
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:setImage(image, light, episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local starType = VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).EpisodeStarType[episodeConfig.chapterId]

	if light then
		if not starType.light then
			local lightStateIcon = starType.empty

			VersionActivityFixedHelper.setDungeonSprite(image, lightStateIcon, true, self._bigVersion, self._smallVersion)
		end
	end
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:getMaxWidth()
	return self._maxWidth
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:updateSelectStatus(selectedItem, ignoreAni)
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

function VersionActivity3_5DungeonMapEpisodeSceneItem:onRemoveElement(elementId)
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

function VersionActivity3_5DungeonMapEpisodeSceneItem:playUnLockAnimation()
	local animator = self.goLock:GetComponent(typeof(UnityEngine.Animator))

	animator.enabled = true
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:playAnimation(animationName)
	if self.prePlayAnimName == animationName then
		return
	end

	self.prePlayAnimName = animationName

	self.animator:Play(animationName, 0, 0)
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:getEpisodeId()
	return self._config and self._config.id
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:createStarItem(goStar)
	local starItem = self:getUserDataTb_()

	starItem.goStar = goStar
	starItem.imgStar1 = gohelper.findChildImage(goStar, "starLayout/#image_star1")
	starItem.imgStar2 = gohelper.findChildImage(goStar, "starLayout/#image_star2")

	return starItem
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:onClose()
	TaskDispatcher.cancelTask(self._hideAllElementTip, self)
end

function VersionActivity3_5DungeonMapEpisodeSceneItem:onDestroyView()
	self.goClick:RemoveClickListener()
end

return VersionActivity3_5DungeonMapEpisodeSceneItem
