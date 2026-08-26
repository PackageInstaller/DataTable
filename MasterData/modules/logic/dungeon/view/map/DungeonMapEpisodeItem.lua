-- chunkname: @modules/logic/dungeon/view/map/DungeonMapEpisodeItem.lua

module("modules.logic.dungeon.view.map.DungeonMapEpisodeItem", package.seeall)

local DungeonMapEpisodeItem = class("DungeonMapEpisodeItem", BaseChildView)

function DungeonMapEpisodeItem:onInitView()
	self._goscale = gohelper.findChild(self.viewGO, "#go_scale")
	self._gostar = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#go_star")
	self._imagemapstate = gohelper.findChildImage(self.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate")
	self._gomapstatescale = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate/#go_mapstatescale")
	self._imagemapbeselectedbg = gohelper.findChildImage(self.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate/#go_mapstatescale/#image_mapbeselectedbg")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate/#go_mapstatescale/#btn_click")
	self._txtsection = gohelper.findChildText(self.viewGO, "#go_scale/#go_gray/#txt_section")
	self._txtsectionname = gohelper.findChildText(self.viewGO, "#go_scale/#go_gray/#txt_sectionname")
	self._gotipcontent = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#txt_sectionname/#go_tipcontent")
	self._gotipitem = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#txt_sectionname/#go_tipcontent/#go_tipitem")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_scale/#go_gray/#txt_sectionname/#txt_nameen")
	self._goflag = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#go_flag")
	self._gofall = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#go_fall")
	self._gofallbg = gohelper.findChild(self._gofall, "#go_fallbg")
	self._simagefall = gohelper.findChildSingleImage(self._gofall, "#go_fallbg/#simage_fall")
	self._goraycast = gohelper.findChild(self.viewGO, "#go_scale/#go_raycast")
	self._gomaxpos = gohelper.findChild(self.viewGO, "#go_maxpos")
	self._txttime = gohelper.findChildText(self.viewGO, "#txt_time")
	self._txtlocktips = gohelper.findChildText(self.viewGO, "#txt_locktips")
	self._imagesuo = gohelper.findChildImage(self.viewGO, "#txt_locktips/#image_suo")
	self._gobeselected = gohelper.findChild(self.viewGO, "#go_beselected")
	self._golock = gohelper.findChild(self.viewGO, "#go_scale/#go_lock")
	self._goprogressitem = gohelper.findChild(self.viewGO, "#go_scale/#go_lock/interactiveprogress/#go_progressitem")
	self._gosimplestarbg = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#go_star/#go_atorystarbg")
	self._gonormalstarbg = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#go_star/#go_normalstarbg")
	self._gohardstarbg = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#go_star/#go_hardstarbg")
	self._gogray = gohelper.findChild(self.viewGO, "#go_scale/#go_gray")
	self._goboss = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#go_boss")
	self._gonormaleye = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#go_boss/#go_normaleye")
	self._gohardeye = gohelper.findChild(self.viewGO, "#go_scale/#go_gray/#go_boss/#go_hardeye")
	self._imagedecorate = gohelper.findChildImage(self.viewGO, "#go_scale/#go_gray/#image_decorate")
	self._gostorytrace = gohelper.findChild(self.viewGO, "#go_trace")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapEpisodeItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self._refreshTraced, self)
end

function DungeonMapEpisodeItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self._refreshTraced, self)
end

function DungeonMapEpisodeItem:_btnclickOnClick()
	return
end

function DungeonMapEpisodeItem:_changeMap()
	if not self._mapIsUnlock then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMap, {
		self._map,
		self._config
	})
end

function DungeonMapEpisodeItem:_btnraycastOnClick()
	return
end

function DungeonMapEpisodeItem:showUnlockAnim()
	self._unlockAnimation = self._unlockAnimation or self._goscale:GetComponent(typeof(UnityEngine.Animation))

	self._unlockAnimation:Play()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_deblockingmap)
end

function DungeonMapEpisodeItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._click = gohelper.getClickWithAudio(self._goraycast, AudioEnum.UI.play_ui_checkpoint_pagesopen)
	self._lockClick = gohelper.getClick(gohelper.findChild(self._golock, "raycast"))
	self.elementItemList = {}

	self:_initStar()
	self:onUpdateParam()
	self:calcPosInContent()

	self._init = true

	gohelper.setActive(self._gonormaleye, true)
	gohelper.setActive(self._gohardeye, false)
	gohelper.setActive(self._gotipitem, false)
end

function DungeonMapEpisodeItem:calcPosInContent()
	recthelper.setAnchorX(self._gomaxpos.transform, self._maxWidth)

	local pos = recthelper.rectToRelativeAnchorPos(self._gomaxpos.transform.position, self._contentTransform)

	self.scrollVisiblePosX = -pos.x
	pos = recthelper.rectToRelativeAnchorPos(self.viewGO.transform.position, self._contentTransform)
	self.scrollContentPosX = pos.x
end

function DungeonMapEpisodeItem:getEpisodeId()
	return self._config.id
end

function DungeonMapEpisodeItem:onUpdateParam()
	self._config = self.viewParam[1]
	self._info = self.viewParam[2]
	self._levelIndex = self.viewParam[4]
	self._contentTransform = self.viewParam[3]
	self._txtsection.text = string.format("%02d", self._levelIndex)
	self._txtsectionname.text = self._config.name
	self._txtnameen.text = self._config.name_En

	local simpleEpisodeId = self._config.chainEpisode

	if simpleEpisodeId ~= 0 then
		gohelper.setActive(self._goflag, not DungeonModel.instance:hasPassLevelAndStory(simpleEpisodeId))
	else
		gohelper.setActive(self._goflag, not DungeonModel.instance:hasPassLevelAndStory(self._config.id))
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(self._config.chapterId)

	self:_updateLock()
	self:_showMap()

	local isLock = self:refreshLockTip()
	local isResourceType = DungeonModel.instance:chapterListIsResType(chapterConfig.type)

	self._isResourceTypeLock = isResourceType and isLock

	self:_refreshUI(isResourceType, isLock)
	self:showStatus()
	self:_showAllElementTipView()
	self:refreshV1a7Fall()

	if DungeonModel.isBattleEpisode(self._config) and chapterConfig.type == DungeonEnum.ChapterType.Normal then
		local iconParam = string.splitToNumber(self._config.icon, "#")
		local iconType = iconParam[1]
		local iconId = iconParam[2]
		local config, icon

		if iconType and iconId then
			config, icon = ItemModel.instance:getItemConfigAndIcon(iconType, iconId)
		end

		gohelper.setActive(self._gofallbg, true)
		self:setFallIconPos(GameUtil.utf8len(self._config.name))

		if not string.nilorempty(icon) then
			self._simagefall:LoadImage(icon)
		end
	end

	self._maxWidth = self._maxWidth or recthelper.getAnchorX(self._txtsectionname.transform) + self._txtsectionname.preferredWidth + 30

	self:_refreshTraced()
end

function DungeonMapEpisodeItem:refreshLockTip()
	local isLock = self:hasUnlockContent()

	if isLock then
		self:_showUnlockContent()
		self:_showBeUnlockEpisode()

		if not self.hasUnlockContentText then
			gohelper.setActive(self._txtlocktips.gameObject, self.hasUnlockContentText)
			gohelper.setActive(self._txttime.gameObject, not self.hasUnlockContentText)
		end
	else
		gohelper.setActive(self._txtlocktips.gameObject, false)
		gohelper.setActive(self._txttime.gameObject, true)
	end

	return isLock
end

function DungeonMapEpisodeItem:initV1a7Node()
	self.goV1a7Fall = self.goV1a7Fall or gohelper.findChild(self._gofall, "#go_v1a7fallbg")
	self.simageV1a7Icon = self.simageV1a7Icon or gohelper.findChildSingleImage(self._gofall, "#go_v1a7fallbg/#simage_fall")
	self.txtV1a7Time = self.txtV1a7Time or gohelper.findChildTextMesh(self._gofall, "#go_v1a7fallbg/#txt_time")
end

function DungeonMapEpisodeItem:refreshV1a7Fall()
	gohelper.setActive(self.goV1a7Fall, false)

	do return end

	TaskDispatcher.cancelTask(self.refreshV1a7Fall, self)

	local actId = self:_getDropActId()

	if not actId then
		gohelper.setActive(self.goV1a7Fall, false)

		return
	end

	local cost = string.splitToNumber(self._config.cost, "#")[3]

	if not cost or cost <= 0 then
		gohelper.setActive(self.goV1a7Fall, false)

		return
	end

	self:initV1a7Node()
	gohelper.setActive(self.goV1a7Fall, true)
	TaskDispatcher.runDelay(self.refreshV1a7Fall, self, TimeUtil.OneMinuteSecond)

	local actInfo = ActivityModel.instance:getActMO(actId)

	if actInfo then
		local offset = actInfo:getRealEndTimeStamp() - ServerTime.now()
		local time, timeFormat = TimeUtil.secondToRoughTime(offset, true)

		self.txtV1a7Time.text = string.format(time .. timeFormat)
	end

	local type, id = CommonConfig.instance:getAct155EpisodeDisplay()
	local _, icon = ItemModel.instance:getItemConfigAndIcon(type, id)

	if not string.nilorempty(icon) then
		self.simageV1a7Icon:LoadImage(icon)
	end
end

function DungeonMapEpisodeItem:_getDropActId()
	local curChapterId = self._config.chapterId

	for _, co in ipairs(lua_activity155_drop.configList) do
		if curChapterId == co.chapterId then
			local actId = co.activityId
			local status = ActivityHelper.getActivityStatus(actId, true)

			if status == ActivityEnum.ActivityStatus.Normal then
				return actId
			end
		end
	end
end

function DungeonMapEpisodeItem:_showAllElementTipView()
	if not self._map then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	if self._config.chainEpisode ~= 0 then
		if not self._config.chainEpisode then
			local episodeId = self._config.id

			self._pass = DungeonModel.instance:hasPassLevelAndStory(episodeId)

			local mapId = self._map.id
			local mapAllElementList = DungeonConfig.instance:getMapElements(mapId)

			if not mapAllElementList or #mapAllElementList < 1 then
				gohelper.setActive(self._gotipcontent, false)

				self._showAllElementTip = false
			else
				local finishCount = 0
				local noShowCo

				for i, v in ipairs(mapAllElementList) do
					if DungeonMapModel.instance:elementIsFinished(v.id) then
						finishCount = finishCount + 1
					end

					if ToughBattleConfig.instance:isActEleCo(v) then
						noShowCo = v
					end

					if DungeonMapModel.instance:isImplicitElementType(v.type) then
						noShowCo = v
					end
				end

				if noShowCo then
					mapAllElementList = tabletool.copy(mapAllElementList)

					tabletool.removeValue(mapAllElementList, noShowCo)
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
	end
end

function DungeonMapEpisodeItem:_hideAllElementTip()
	gohelper.setActive(self._gotipcontent, false)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	local targetPosX = self:_getFallIconTargetPos(GameUtil.utf8len(self._config.name))

	if targetPosX then
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._gofall.transform, targetPosX, 0.26, self._tweenEnd, self)
	else
		self:_tweenEnd()
	end
end

function DungeonMapEpisodeItem:_tweenEnd()
	self:setFallIconPos(GameUtil.utf8len(self._config.name))
end

function DungeonMapEpisodeItem:_getElementTipWidth(chapterNameCount)
	if self._map then
		local mapAllElementList = DungeonConfig.instance:getMapElements(self._map.id)

		if self._showAllElementTip then
			if chapterNameCount > 3 then
				return 20 * #mapAllElementList + 2 * (#mapAllElementList - 1) - 12
			elseif #mapAllElementList < 3 then
				return 43
			else
				return 20 * #mapAllElementList + 2 * (#mapAllElementList - 1) - 12
			end
		end
	end

	return 0
end

function DungeonMapEpisodeItem:_refreshUI(isResourceType, isLock)
	UISpriteSetMgr.instance:setUiFBSprite(self._imagesuo, isResourceType and isLock and "bg_suo_fuben" or "bg_kaisuo_fuben", true)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtlocktips, isResourceType and isLock and "#A64B47" or "#D88147")
	UISpriteSetMgr.instance:setUiFBSprite(self._imagedecorate, isResourceType and isLock and "bg_fenge" or "zhangjiefenge_005")
	ZProj.UGUIHelper.SetColorAlpha(self._txtsection, isResourceType and isLock and 0.65 or 1)
	ZProj.UGUIHelper.SetColorAlpha(self._txtsectionname, isResourceType and isLock and 0.65 or 1)
end

function DungeonMapEpisodeItem:_updateLock()
	local checkLockState = not DungeonModel.instance:isFinishElementList(self._config)
	local lockState = self._isLock

	if checkLockState ~= lockState then
		lockState = nil
	end

	self:_updateInteractiveProgress()

	if lockState == false then
		return
	end

	local oldValue = self._isLock

	self._isLock = not DungeonModel.instance:isFinishElementList(self._config)

	if oldValue and not self._isLock then
		local animator = self._golock:GetComponent(typeof(UnityEngine.Animator))

		if animator then
			animator.enabled = true
		end

		local raycast = gohelper.findChild(self._golock, "raycast")

		gohelper.setActive(raycast, false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	else
		gohelper.setActive(self._golock, self._isLock)
	end

	if not self._graphics then
		local temp = self._gogray:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

		self._graphics = self:getUserDataTb_()

		local iter = temp:GetEnumerator()

		while iter:MoveNext() do
			table.insert(self._graphics, iter.Current.gameObject)
		end
	end

	if self._graphics then
		for k, v in ipairs(self._graphics) do
			ZProj.UGUIHelper.SetGrayscale(v, self._isLock)
		end
	end
end

function DungeonMapEpisodeItem:_updateInteractiveProgress()
	return
end

function DungeonMapEpisodeItem:_updateProgressUI(elementList, finishCount)
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

function DungeonMapEpisodeItem:isLock()
	return self._isLock
end

function DungeonMapEpisodeItem.getMap(config)
	if not config then
		return nil
	end

	local preEpisode = config.preEpisode

	if preEpisode > 0 then
		local preEpisodeConfig = DungeonConfig.instance:getEpisodeCO(preEpisode)

		if preEpisodeConfig.chapterId ~= config.chapterId then
			preEpisode = 0
		end
	end

	return (DungeonConfig.instance:getChapterMapCfg(config.chapterId, preEpisode))
end

function DungeonMapEpisodeItem:_showMap()
	self._map = DungeonMapEpisodeItem.getMap(self._config)

	local oldState = self._mapIsUnlock

	self._mapIsUnlock = self._map and DungeonMapModel.instance:mapIsUnlock(self._map.id)

	if self._init and not oldState and self._mapIsUnlock and not self._isLock then
		self:_changeMap()
	end

	if not self._mapIsUnlock then
		self._txttime.text = ""

		gohelper.setActive(self._imagemapstate.gameObject, false)

		return
	end

	self._txttime.text = self._map.desc

	self:_updateMapElementState()
end

function DungeonMapEpisodeItem:_updateMapElementState()
	local elementsList = DungeonMapModel.instance:getElements(self._map.id)

	self.unfinishedMap = false

	for i, config in ipairs(elementsList) do
		if config.hidden == 0 then
			self.unfinishedMap = true

			break
		end
	end

	gohelper.setActive(self._imagemapstate.gameObject, false)
end

function DungeonMapEpisodeItem:_initStar()
	gohelper.setActive(self._gostar, true)

	self._starImgList = self:getUserDataTb_()

	table.insert(self._starImgList, gohelper.findChildImage(self._gosimplestarbg, "0"))
	table.insert(self._starImgList, gohelper.findChildImage(self._gonormalstarbg, "1"))
	table.insert(self._starImgList, gohelper.findChildImage(self._gonormalstarbg, "2"))
	table.insert(self._starImgList, gohelper.findChildImage(self._gohardstarbg, "3"))
	table.insert(self._starImgList, gohelper.findChildImage(self._gohardstarbg, "4"))
end

function DungeonMapEpisodeItem:showStatus()
	local normalEpisodeId = self._config.id
	local hardOpen = DungeonModel.instance:isOpenHardDungeon(self._config.chapterId)

	if normalEpisodeId then
		::label_29_0::

		local passStory = DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)
		local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)
		local normalEpisodeInfo = self._info
		local hardEpisodeConfig = DungeonConfig.instance:getHardEpisode(self._config.id)

		if hardEpisodeConfig then
			::label_29_1::

			local hardEpisodeInfo = DungeonModel.instance:getEpisodeInfo(hardEpisodeConfig.id)
			local starImg4 = self._starImgList[5]
			local starImg3 = self._starImgList[4]
			local starImg2 = self._starImgList[3]

			self:_setStar(self._starImgList[2], normalEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory, 1)
			gohelper.setActive(starImg2, false)
			gohelper.setActive(starImg3, false)
			gohelper.setActive(starImg4, false)
			gohelper.setActive(self._gonormalstarbg, true)
			gohelper.setActive(self._gohardstarbg, false)

			self.starNum2 = nil
			self.starNum3 = nil
			self.starNum4 = nil

			gohelper.setActive(self._goboss, self._config.displayMark == 1)

			if not string.nilorempty(advancedConditionText) then
				local starNum2 = normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and passStory

				self.starNum2 = starNum2

				self:_setStar(starImg2, starNum2, 2)
				gohelper.setActive(starImg2.gameObject, true)

				if hardEpisodeInfo and normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and hardOpen and passStory then
					local starNum3 = hardEpisodeInfo.star >= DungeonEnum.StarType.Normal

					self.starNum3 = starNum3

					self:_setStar(starImg3, starNum3, 3)
					gohelper.setActive(starImg3.gameObject, true)

					self.starNum4 = hardEpisodeInfo.star >= DungeonEnum.StarType.Advanced

					self:_setStar(starImg4, self.starNum4, 4)
					gohelper.setActive(starImg4.gameObject, true)
					gohelper.setActive(self._gohardstarbg, true)
				end
			end

			local simpleConfig = DungeonConfig.instance:getSimpleEpisode(self._config)

			gohelper.setActive(self._gosimplestarbg, simpleConfig)

			if simpleConfig then
				local showSimpleStar = DungeonModel.instance:hasPassLevelAndStory(simpleConfig.id)

				if showSimpleStar then
					SLFramework.UGUI.GuiHelper.SetColor(self._starImgList[1], "#efb974")
				else
					SLFramework.UGUI.GuiHelper.SetColor(self._starImgList[1], "#87898C")
				end
			end
		end
	end
end

function DungeonMapEpisodeItem:_setHardModeState(param)
	local index = param.index
	local isHardMode = param.isHardMode

	if self._levelIndex == index then
		gohelper.setActive(self._gonormaleye, not isHardMode)
		gohelper.setActive(self._gohardeye, isHardMode)
	end
end

function DungeonMapEpisodeItem:_setStar(image, light, index)
	if self._isResourceTypeLock then
		SLFramework.UGUI.GuiHelper.SetColor(image, "#e5e5e5")
		ZProj.UGUIHelper.SetColorAlpha(image, 0.75)
	else
		if light then
			SLFramework.UGUI.GuiHelper.SetColor(image, index < 3 and "#F77040" or "#FF4343")
		else
			SLFramework.UGUI.GuiHelper.SetColor(image, "#87898C")
		end

		ZProj.UGUIHelper.SetColorAlpha(image, 1)
	end
end

function DungeonMapEpisodeItem:_onLockClickHandler()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
	DungeonController.instance:openDungeonMapTaskView({
		isMain = true,
		viewParam = self._config.preEpisode
	})
end

function DungeonMapEpisodeItem:onClickHandler()
	self:_onClickHandler()
end

function DungeonMapEpisodeItem:_onClickHandler()
	if self._isLock then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) and self._isSelected then
		return
	end

	if not DungeonModel.isBattleEpisode(self._config) then
		local toastParam = DungeonModel.instance:getCantChallengeToast(self._config)

		if toastParam then
			GameFacade.showToast(ToastEnum.CantChallengeToast, toastParam)

			return
		end
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, self)

	if not ViewMgr.instance:isOpen(ViewName.DungeonChangeMapStatusView) then
		self:_showMapLevelView(true)
	else
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, self)
	end
end

function DungeonMapEpisodeItem:_showMapLevelView(needDispatch)
	local sectionId = DungeonConfig.instance:getChapterDivideSectionId(self._config.chapterId)

	if sectionId and sectionId > 1 and not DungeonMainStoryModel.instance:sectionChapterAllPassed(sectionId - 1) then
		DungeonModel.instance:setLastSelectMode(DungeonEnum.ChapterType.Simple)
	end

	DungeonController.instance:enterLevelView(self.viewParam)

	if needDispatch then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, self)
	end
end

function DungeonMapEpisodeItem:setFallIconPos(chapterNameCount)
	local targetPosX = self:_getFallIconTargetPos(chapterNameCount)

	if targetPosX then
		recthelper.setAnchorX(self._gofall.transform, targetPosX)
	end

	local x1 = recthelper.getAnchorX(self._gofall.transform)
	local x2 = 0
	local x3 = self:_getElementTipWidth(chapterNameCount)

	if self.goV1a7Fall and self.goV1a7Fall.activeSelf then
		x2 = x2 + recthelper.getWidth(self.goV1a7Fall.transform)
	end

	if self._gofallbg.activeSelf then
		x2 = x2 + recthelper.getWidth(self._gofallbg.transform)
	end

	self._maxWidth = x1 + x2 + x3
end

function DungeonMapEpisodeItem:_getFallIconTargetPos(chapterNameCount)
	if chapterNameCount >= 4 then
		local preferredWidth = self._txtsectionname.preferredWidth

		return recthelper.getAnchorX(self._txtsectionname.transform) + preferredWidth + 70 + self:_getElementTipWidth(chapterNameCount)
	end
end

function DungeonMapEpisodeItem:getMaxWidth()
	return self._maxWidth
end

function DungeonMapEpisodeItem:hasUnlockContent()
	local openList = OpenConfig.instance:getOpenShowInEpisode(self._config.id)
	local unlockEpisodeList = DungeonConfig.instance:getUnlockEpisodeList(self._config.id)
	local openGroupList = OpenConfig.instance:getOpenGroupShowInEpisode(self._config.id)

	if openList or unlockEpisodeList or openGroupList then
		::label_39_0::

		local showContent = not DungeonModel.instance:hasPassLevelAndStory(self._config.id)
		local showEpisode = self._config.unlockEpisode > 0 and not DungeonModel.instance:hasPassLevelAndStory(self._config.unlockEpisode)

		return showContent or showEpisode
	end
end

function DungeonMapEpisodeItem:_showUnlockContent()
	local list = DungeonModel.instance:getUnlockContentList(self._config.id)

	for i, v in ipairs(list) do
		UISpriteSetMgr.instance:setUiFBSprite(self._imagesuo, "unlock", true)

		self._txtlocktips.text = v
		self.hasUnlockContentText = true

		return
	end

	self.hasUnlockContentText = false
end

function DungeonMapEpisodeItem:_showBeUnlockEpisode()
	if self._config.unlockEpisode <= 0 or DungeonModel.instance:hasPassLevelAndStory(self._config.unlockEpisode) then
		self.hasUnlockEpisodeText = false

		return
	end

	UISpriteSetMgr.instance:setUiFBSprite(self._imagesuo, "lock", true)

	local strUnlock = DungeonModel.instance:getChallengeUnlockText(self._config)

	if self._config.unlockEpisode == 9999 then
		strUnlock = strUnlock or luaLang("level_limit_4RD_unlock")
	end

	if string.nilorempty(strUnlock) then
		self.hasUnlockEpisodeText = false
		self._txtlocktips.text = ""

		return
	end

	self.hasUnlockEpisodeText = true
	self._txtlocktips.text = formatLuaLang("dungeon_unlock_episode_mode", strUnlock)
end

function DungeonMapEpisodeItem:onOpen()
	self._click:AddClickListener(self._onClickHandler, self)
	self._lockClick:AddClickListener(self._onLockClickHandler, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, self._onChangeFocusEpisodeItem, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self._beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.SwitchHardMode, self._setHardModeState, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function DungeonMapEpisodeItem:_OnChangeMap(mapCfg)
	return
end

function DungeonMapEpisodeItem:_beginShowRewardView()
	self._showRewardView = true
end

function DungeonMapEpisodeItem:_endShowRewardView()
	self._showRewardView = false

	self:_showAllElementTipView()

	local oldValue = self._isLock
	local newValue = not DungeonModel.instance:isFinishElementList(self._config)

	if oldValue and not newValue then
		self._startBlock = true

		UIBlockMgr.instance:endAll()
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("DungeonMapEpisodeItem showUnlock")
		TaskDispatcher.runDelay(self._moveEpisode, self, DungeonEnum.MoveEpisodeTimeAfterShowReward)
		TaskDispatcher.runDelay(self._updateLock, self, DungeonEnum.UpdateLockTimeAfterShowReward)
		TaskDispatcher.runDelay(self._changeEpisodeMap, self, DungeonEnum.UpdateLockTimeAfterShowReward)

		return
	end

	self:_updateInteractiveProgress()
end

function DungeonMapEpisodeItem:_moveEpisode()
	DungeonMapModel.instance.focusEpisodeTweenDuration = 0.8

	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, self)
end

function DungeonMapEpisodeItem:_changeEpisodeMap()
	self._startBlock = false

	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("DungeonMapEpisodeItem showUnlock")
end

function DungeonMapEpisodeItem:_OnUpdateMapElementState(mapId)
	if mapId == self._map.id then
		self:_updateMapElementState()
	end

	if not self._showRewardView then
		self:_updateLock()
	end
end

function DungeonMapEpisodeItem:_onChangeFocusEpisodeItem(item)
	local go = item.viewGO
	local oldState = self._isSelected

	self._isSelected = go == self.viewGO

	if self._isSelected then
		if not oldState then
			self:_changeMap()
		end

		gohelper.setActive(self._gobeselected, true)
		self._animator:Play(UIAnimationName.Selected)
	else
		gohelper.setActive(self._gobeselected, false)

		if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
			self:_setUnselectedState(item)
		else
			self:_resetUnselectedState()
		end
	end
end

function DungeonMapEpisodeItem:_onCloseView(viewName)
	if viewName == ViewName.DungeonMapLevelView and not self._isSelected then
		self:_resetUnselectedState()

		return
	end

	if viewName == ViewName.DungeonChangeMapStatusView and self._needShowMapLevelView then
		self:_showMapLevelView()
	end
end

function DungeonMapEpisodeItem:_onCloseViewFinish(viewName)
	return
end

function DungeonMapEpisodeItem:_setUnselectedState(item)
	local hardMode = false

	if item._info.star == DungeonEnum.StarType.Advanced then
		local hardEpisode = DungeonConfig.instance:getHardEpisode(item._config.id)
		local hardOpen = DungeonModel.instance:isOpenHardDungeon(self._config.chapterId)

		hardMode = hardEpisode ~= nil and hardOpen
	end

	local forceShow = true

	if forceShow then
		self._animator:Play("notselected")

		self._resetName = "restore"

		return
	end

	self._animator:Play("right")

	self._resetName = "right_reset"
end

function DungeonMapEpisodeItem:_resetUnselectedState()
	self._animator:Play(self._resetName or "restore")
end

function DungeonMapEpisodeItem:getIndex()
	return self._levelIndex
end

function DungeonMapEpisodeItem:onClose()
	self._click:RemoveClickListener()
	self._lockClick:RemoveClickListener()
	TaskDispatcher.cancelTask(self._moveEpisode, self)
	TaskDispatcher.cancelTask(self._updateLock, self)
	TaskDispatcher.cancelTask(self._changeEpisodeMap, self)
	TaskDispatcher.cancelTask(self._hideAllElementTip, self)
	TaskDispatcher.cancelTask(self.refreshV1a7Fall, self)

	if self._startBlock then
		self._startBlock = false

		UIBlockMgr.instance:endBlock("DungeonMapEpisodeItem showUnlock")
	end
end

function DungeonMapEpisodeItem:_onRefreshActivityState(actId)
	self:refreshLockTip()
	self:refreshV1a7Fall()
end

function DungeonMapEpisodeItem:_refreshTraced()
	self:_refreshTracedIcon()
end

function DungeonMapEpisodeItem:_refreshTracedIcon()
	if not self._config then
		return
	end

	if self:isLock() then
		return
	end

	local isTrade = CharacterRecommedModel.instance:isTradeEpisode(self:getEpisodeId())

	if isTrade then
		local tradeIconPrefab = CharacterRecommedController.instance:getTradeIcon()

		if not tradeIconPrefab then
			return
		end

		self._tracedIcon = self._tracedIcon or gohelper.clone(tradeIconPrefab, self._gostorytrace)
	end

	if self._tracedIcon then
		gohelper.setActive(self._tracedIcon, isTrade)
	end
end

function DungeonMapEpisodeItem:onDestroyView()
	if self._graphics then
		for k, v in ipairs(self._graphics) do
			ZProj.UGUIHelper.DisableGrayKey(v)
		end
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self.simageV1a7Icon then
		self.simageV1a7Icon:UnLoadImage()
	end
end

return DungeonMapEpisodeItem
