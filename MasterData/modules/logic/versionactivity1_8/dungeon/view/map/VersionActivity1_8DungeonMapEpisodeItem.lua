-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/map/VersionActivity1_8DungeonMapEpisodeItem.lua

module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapEpisodeItem", package.seeall)

local VersionActivity1_8DungeonMapEpisodeItem = class("VersionActivity1_8DungeonMapEpisodeItem", BaseChildView)
local MAX_WIDTH_OFFSET = 30
local HIDE_ALL_ELEMENT_TIP_DELAY = 0.8

function VersionActivity1_8DungeonMapEpisodeItem:onInitView()
	self._goscale = gohelper.findChild(self.viewGO, "#go_scale")
	self._txtsection = gohelper.findChildText(self.viewGO, "#go_scale/section/#txt_section")
	self._gonormaleye = gohelper.findChild(self.viewGO, "#go_scale/#image_normal")
	self._gohardeye = gohelper.findChild(self.viewGO, "#go_scale/#image_hard")
	self._gostaricon = gohelper.findChild(self.viewGO, "#go_scale/star/#go_staricon")
	self._txtsectionname = gohelper.findChildText(self.viewGO, "#go_scale/#txt_sectionname")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	self._gotipcontent = gohelper.findChild(self.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent")
	self._gotipitem = gohelper.findChild(self.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent/#go_tipitem")
	self._goflag = gohelper.findChild(self.viewGO, "#go_scale/#go_flag")
	self._golock = gohelper.findChild(self.viewGO, "#go_scale/#go_lock")
	self._goprogressitem = gohelper.findChild(self.viewGO, "#go_scale/#go_lock/interactiveprogress/#go_progressitem")
	self._gomaxpos = gohelper.findChild(self.viewGO, "#go_maxpos")
	self._goraycast = gohelper.findChild(self.viewGO, "#go_raycast")
	self._goclickarea = gohelper.findChild(self.viewGO, "#go_clickarea")
	self._gobeselected = gohelper.findChild(self.viewGO, "#go_beselected")
	self._txtlocktips = gohelper.findChildText(self.viewGO, "#txt_locktips")
	self._imagesuo = gohelper.findChildImage(self.viewGO, "#txt_locktips/#image_suo")
	self.goClick = gohelper.getClick(self._goclickarea)
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goLockAnimator = self._golock:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, self.onChangeInProgressMissionGroup, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157RepairComponent, self._onRepairComponent, self)
	self.goClick:AddClickListener(self.onClick, self)
end

function VersionActivity1_8DungeonMapEpisodeItem:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, self.onChangeInProgressMissionGroup, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157RepairComponent, self._onRepairComponent, self)
	self.goClick:RemoveClickListener()
end

function VersionActivity1_8DungeonMapEpisodeItem:_onCloseView()
	if self._waitCloseFactoryView then
		local isOpenFactoryMap = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView)
		local isOpenFactoryBlueprint = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView)

		if not isOpenFactoryMap and not isOpenFactoryBlueprint then
			self:_showAllElementTipView()

			self._waitCloseFactoryView = false
		end
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:beginShowRewardView()
	self.beginReward = true
end

function VersionActivity1_8DungeonMapEpisodeItem:endShowRewardView()
	self.beginReward = false

	if self.needPlayUnLockAnimation then
		self:playUnLockAnimation()

		self.needPlayUnLockAnimation = nil
	end

	self:_showAllElementTipView()
end

function VersionActivity1_8DungeonMapEpisodeItem:playUnLockAnimation()
	if not self.goLockAnimator then
		return
	end

	self.goLockAnimator.enabled = true
end

function VersionActivity1_8DungeonMapEpisodeItem:onRemoveElement(elementId)
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

function VersionActivity1_8DungeonMapEpisodeItem:initElementIdList()
	if not self.elementIdList then
		local listStr = self._config.elementList

		if not string.nilorempty(listStr) then
			self.elementIdList = string.splitToNumber(listStr, "#")
		end
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:onChangeInProgressMissionGroup()
	local isUnlockedSideMission = Activity157Model.instance:getIsSideMissionUnlocked()

	if not isUnlockedSideMission then
		return
	end

	self:_showAllElementTipView()
end

function VersionActivity1_8DungeonMapEpisodeItem:_onRepairComponent()
	local isOpenFactoryMap = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView)
	local isOpenFactoryBlueprint = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView)

	if isOpenFactoryMap or isOpenFactoryBlueprint then
		self._waitCloseFactoryView = true
	else
		self:_showAllElementTipView()
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:onClick()
	if self.isLock then
		return
	end

	local viewContainer = ViewMgr.instance:getContainer(ViewName.VersionActivity1_8DungeonMapLevelView)

	if viewContainer then
		viewContainer:stopCloseViewTask()

		if viewContainer:getOpenedEpisodeId() == self._config.id then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_8DungeonMapLevelView)

			return
		end
	end

	local episodeId = self:getEpisodeId()

	self.activityDungeonMo:changeEpisode(episodeId)
	self._layout:setSelectEpisodeItem(self)
	ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
		episodeId = self._config.id
	})
end

function VersionActivity1_8DungeonMapEpisodeItem:getEpisodeId()
	return self._config and self._config.id
end

function VersionActivity1_8DungeonMapEpisodeItem:_editableInitView()
	gohelper.setActive(self._gostaricon, false)
	gohelper.setActive(self._goflag, false)
	gohelper.setActive(self._gotipitem, false)
	gohelper.setActive(self._gonormaleye, false)
	gohelper.setActive(self._gohardeye, false)

	self.starItemList = {}
	self.elementItemList = {}

	table.insert(self.starItemList, self:createStarItem(self._gostaricon))
end

function VersionActivity1_8DungeonMapEpisodeItem:onUpdateParam()
	self:initViewParam()
	self:_showAllElementTipView()
end

function VersionActivity1_8DungeonMapEpisodeItem:onOpen()
	self:initViewParam()
end

function VersionActivity1_8DungeonMapEpisodeItem:initViewParam()
	self._contentTransform = self.viewParam[1]
	self._layout = self.viewParam[2]
	self._mapSceneView = self.viewContainer.mapScene
end

function VersionActivity1_8DungeonMapEpisodeItem:refresh(config, dungeonMo)
	self._config = config
	self._dungeonMo = dungeonMo
	self._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(self._config)
	self.pass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)
	self._map = VersionActivity1_8DungeonConfig.instance:getEpisodeMapConfig(self._config.id)

	self:refreshUI()
	self:calculatePosInContent()
	self:playAnimation("selected")

	self.isSelected = false
end

function VersionActivity1_8DungeonMapEpisodeItem:refreshUI()
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

function VersionActivity1_8DungeonMapEpisodeItem:refreshStar()
	if self.activityDungeonMo:isHardMode() then
		self:refreshHardModeStar()
	else
		self:refreshStoryModeStar()
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:refreshHardModeStar()
	self:refreshEpisodeStar(self.starItemList[1], self._config.id)

	for i = 2, #self.starItemList do
		gohelper.setActive(self.starItemList[i].goStar, false)
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:refreshEpisodeStar(starItem, episodeId)
	gohelper.setActive(starItem.goStar, true)

	local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if self.pass and episodeMo then
		::label_22_0::

		local isStar1Light = episodeMo.star > DungeonEnum.StarType.None

		self:setStarImage(starItem.imgStar1, isStar1Light, episodeId)

		local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId)

		if string.nilorempty(advancedConditionText) then
			gohelper.setActive(starItem.imgStar2.gameObject, false)
		elseif self.pass and episodeMo then
			::label_22_1::

			local isStar2Light = episodeMo.star >= DungeonEnum.StarType.Advanced

			gohelper.setActive(starItem.imgStar2.gameObject, true)
			self:setStarImage(starItem.imgStar2, isStar2Light, episodeId)
		end
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:setStarImage(image, light, episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local starTypeData = VersionActivity1_8DungeonEnum.EpisodeStarType[episodeConfig.chapterId]

	if light then
		local starType = starTypeData.light

		UISpriteSetMgr.instance:setV1a8DungeonSprite(image, starType)
	else
		local starType = starTypeData.empty

		UISpriteSetMgr.instance:setV1a8DungeonSprite(image, starType)
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:refreshStoryModeStar()
	local episodeList = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(self._config)

	for index, episodeCo in ipairs(episodeList) do
		local starItem = self.starItemList[index]

		if not starItem then
			local starGo = gohelper.cloneInPlace(self._gostaricon)

			starItem = self:createStarItem(starGo)

			table.insert(self.starItemList, starItem)
		end

		self:refreshEpisodeStar(starItem, episodeCo.id)
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:createStarItem(goStar)
	local starItem = self:getUserDataTb_()

	starItem.goStar = goStar
	starItem.imgStar1 = gohelper.findChildImage(goStar, "starLayout/#image_star1")
	starItem.imgStar2 = gohelper.findChildImage(goStar, "starLayout/#image_star2")

	return starItem
end

function VersionActivity1_8DungeonMapEpisodeItem:refreshFlag()
	gohelper.setActive(self._goflag, false)
end

function VersionActivity1_8DungeonMapEpisodeItem:refreshUnlockContent()
	local isReactivityEpisode = DungeonModel.instance:isReactivityEpisode(self._config.id)

	if self.pass or isReactivityEpisode then
		gohelper.setActive(self._txtlocktips.gameObject, false)

		return
	end

	local openList = OpenConfig.instance:getOpenShowInEpisode(self._config.id)

	if openList and #openList > 0 then
		gohelper.setActive(self._txtlocktips.gameObject, true)

		local unLockContentList = DungeonModel.instance:getUnlockContentList(self._config.id)

		if unLockContentList and #unLockContentList > 0 then
			self._txtlocktips.text = unLockContentList[1] or ""
		end

		UISpriteSetMgr.instance:setUiFBSprite(self._imagesuo, "unlock", true)
	else
		gohelper.setActive(self._txtlocktips.gameObject, false)
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:refreshFocusStatus()
	gohelper.setActive(self._gobeselected, self._config.id == self.activityDungeonMo.episodeId)
end

function VersionActivity1_8DungeonMapEpisodeItem:_showAllElementTipView()
	local isFuncUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip)

	if not isFuncUnlock or not self._map then
		gohelper.setActive(self._gotipcontent, false)

		return
	end

	local isHardMode = self.activityDungeonMo:isHardMode()
	local mapAllElementList = VersionActivity1_8DungeonModel.instance:getElementCoListWithFinish(self._map.id, true)

	if isHardMode or not mapAllElementList or #mapAllElementList < 1 then
		self._showAllElementTip = false

		gohelper.setActive(self._gotipcontent, false)

		return
	end

	local finishCount = 0
	local showElementList = {}

	for _, elementCo in ipairs(mapAllElementList) do
		local actId = Activity157Model.instance:getActId()
		local elementId = elementCo.id
		local act157MissionId = Activity157Config.instance:getMissionIdByElementId(actId, elementId)

		if act157MissionId then
			::label_29_0::

			local isSideMission = Activity157Config.instance:isSideMission(actId, act157MissionId)
			local isFinishElement = DungeonMapModel.instance:elementIsFinished(elementId)

			if isSideMission then
				local act157MissionGroupId = Activity157Config.instance:getMissionGroup(actId, act157MissionId)
				local isFinishMissionGroup = Activity157Model.instance:isFinishAllMission(act157MissionGroupId)

				if not isFinishMissionGroup then
					showElementList[#showElementList + 1] = elementId

					if isFinishElement then
						finishCount = finishCount + 1
					end
				end
			else
				showElementList[#showElementList + 1] = elementId

				if isFinishElement then
					finishCount = finishCount + 1
				end
			end
		end
	end

	local isUnlockedSideMission = Activity157Model.instance:getIsSideMissionUnlocked()

	if isUnlockedSideMission then
		local inProgressMissionGroupId = Activity157Model.instance:getInProgressMissionGroup()

		if self._lastProgressGroupId and self._lastProgressGroupId ~= 0 and self._lastProgressGroupId ~= inProgressMissionGroupId then
			for _, elementItem in ipairs(self.elementItemList) do
				elementItem.status = nil

				elementItem.animator:Play("idle", 0, 1)
				gohelper.setActive(elementItem.go, false)
			end
		end

		self._lastProgressGroupId = inProgressMissionGroupId
	end

	for index, _ in ipairs(showElementList) do
		local elementItem = self.elementItemList[index]

		if not elementItem then
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

	local allElementCount = #showElementList
	local elementItemCount = #self.elementItemList

	if allElementCount < elementItemCount then
		for i = allElementCount + 1, elementItemCount do
			local elementItem = self.elementItemList[i]

			if elementItem then
				elementItem.status = nil

				elementItem.animator:Play("idle", 0, 1)
				gohelper.setActive(elementItem.go, false)
			end
		end
	end

	local oldStatus = self._showAllElementTip

	self._showAllElementTip = self.pass and finishCount ~= #showElementList

	if oldStatus and not self._showAllElementTip then
		TaskDispatcher.cancelTask(self._hideAllElementTip, self)
		TaskDispatcher.runDelay(self._hideAllElementTip, self, HIDE_ALL_ELEMENT_TIP_DELAY)
	else
		gohelper.setActive(self._gotipcontent, self._showAllElementTip)
	end
end

function VersionActivity1_8DungeonMapEpisodeItem:_hideAllElementTip()
	gohelper.setActive(self._gotipcontent, false)
end

function VersionActivity1_8DungeonMapEpisodeItem:_showEye()
	local showEye = self._config.displayMark == 1

	if not showEye then
		gohelper.setActive(self._gonormaleye, false)
		gohelper.setActive(self._gohardeye, false)

		return
	end

	local isHard = self._config.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.Hard

	gohelper.setActive(self._gonormaleye, not isHard)
	gohelper.setActive(self._gohardeye, isHard)
end

function VersionActivity1_8DungeonMapEpisodeItem:refreshLock()
	self.isLock = self:checkLock()

	gohelper.setActive(self._golock, self.isLock)
end

function VersionActivity1_8DungeonMapEpisodeItem:checkLock()
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

function VersionActivity1_8DungeonMapEpisodeItem:updateSelectStatus(selectedItem, ignoreAni)
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

function VersionActivity1_8DungeonMapEpisodeItem:calculatePosInContent()
	local nameAnchorX = recthelper.getAnchorX(self._txtsectionname.transform)
	local nameEnAnchorX = recthelper.getAnchorX(self._txtnameen.transform)
	local halfWidth1 = nameAnchorX + self._txtsectionname.preferredWidth
	local halfWidth2 = nameEnAnchorX + self._txtsectionname.preferredWidth
	local halfWidth = math.max(halfWidth1, halfWidth2)

	self._maxWidth = math.max(halfWidth * 2, VersionActivity1_3DungeonEnum.EpisodeItemMinWidth) + MAX_WIDTH_OFFSET

	recthelper.setWidth(self._goclickarea.transform, self._maxWidth)
	recthelper.setWidth(self._goraycast.transform, self._maxWidth + self._layout._constDungeonNormalDeltaX)

	self.scrollContentPosX = recthelper.rectToRelativeAnchorPos(self.viewGO.transform.position, self._contentTransform).x
end

function VersionActivity1_8DungeonMapEpisodeItem:playAnimation(animationName)
	if self.prePlayAnimName == animationName then
		return
	end

	self.prePlayAnimName = animationName

	self.animator:Play(animationName, 0, 0)
end

function VersionActivity1_8DungeonMapEpisodeItem:getMaxWidth()
	return self._maxWidth
end

function VersionActivity1_8DungeonMapEpisodeItem:clearElementIdList()
	self.elementIdList = nil
end

function VersionActivity1_8DungeonMapEpisodeItem:onClose()
	TaskDispatcher.cancelTask(self._hideAllElementTip, self)
end

function VersionActivity1_8DungeonMapEpisodeItem:onDestroyView()
	return
end

return VersionActivity1_8DungeonMapEpisodeItem
