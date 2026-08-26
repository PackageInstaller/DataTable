-- chunkname: @modules/logic/towercompose/view/TowerComposeThemeView.lua

module("modules.logic.towercompose.view.TowerComposeThemeView", package.seeall)

local TowerComposeThemeView = class("TowerComposeThemeView", BaseView)

function TowerComposeThemeView:onInitView()
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_category")
	self._goContent = gohelper.findChild(self.viewGO, "Left/#scroll_category/Viewport/#go_Content")
	self._gothemeItem = gohelper.findChild(self.viewGO, "Left/#scroll_category/Viewport/#go_Content/#go_themeItem")
	self._goepisodeItemPool = gohelper.findChild(self.viewGO, "Left/#go_episodeItemPool")
	self._gonormalEpisodeItem = gohelper.findChild(self.viewGO, "Left/#go_episodeItemPool/#go_normalEpisodeItem")
	self._goclickMask = gohelper.findChild(self.viewGO, "#go_clickMask")
	self._txtThemeName = gohelper.findChildText(self.viewGO, "Center/Title/#txt_themeName")
	self._txtThemeNameEn = gohelper.findChildText(self.viewGO, "Center/Title/#txt_themeNameEn")
	self._btnEnvironment = gohelper.findChildButtonWithAudio(self.viewGO, "Center/Title/#btn_environment")
	self._imageEnvironment = gohelper.findChildImage(self.viewGO, "Center/Title/#btn_environment/icon")
	self._goEnter = gohelper.findChild(self.viewGO, "#go_Enter")
	self._simageEnterBg = gohelper.findChildSingleImage(self.viewGO, "#go_Enter/#simage_EnterBG")
	self._txtEnterTitle = gohelper.findChildText(self.viewGO, "#go_Enter/Title/txt_Title")
	self._txtEnterTitleEn = gohelper.findChildText(self.viewGO, "#go_Enter/Title/txt_TitleEn")
	self._gonormalEpisode = gohelper.findChild(self.viewGO, "Center/episode/#go_normalEpisode")
	self._gonormalItem = gohelper.findChild(self.viewGO, "Center/episode/#go_normalEpisode/#go_normalItem")
	self._gonormalItemFinish = gohelper.findChild(self.viewGO, "Center/episode/#go_normalEpisode/#go_normalItem/go_finish")
	self._gonormalItemFinishEffect = gohelper.findChild(self.viewGO, "Center/episode/#go_normalEpisode/#go_normalItem/go_finishEffect")
	self._gocompleted = gohelper.findChild(self.viewGO, "Center/episode/#go_normalEpisode/#go_completed")
	self._gorewardBG = gohelper.findChild(self.viewGO, "Center/episode/#go_normalEpisode/image_RewardBG")
	self._goreward = gohelper.findChild(self.viewGO, "Center/episode/#go_normalEpisode/#go_reward")
	self._gorewardItem = gohelper.findChild(self.viewGO, "Center/episode/#go_normalEpisode/#go_reward/#go_rewardItem")
	self._goplaneEpisode = gohelper.findChild(self.viewGO, "Center/episode/#go_planeEpisode")
	self._gobossPosContent = gohelper.findChild(self.viewGO, "Center/episode/#go_planeEpisode/#go_bossPosContent")
	self._gobossPos = gohelper.findChild(self.viewGO, "Center/episode/#go_planeEpisode/#go_bossPosContent/#go_bossPos")
	self._goprogress = gohelper.findChild(self.viewGO, "Center/episode/#go_planeEpisode/#go_progress")
	self._txtprogresstxt = gohelper.findChildText(self.viewGO, "Center/episode/#go_planeEpisode/#go_progress/#txt_progresstxt")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "Center/episode/#go_planeEpisode/#go_progress/image_bg/#image_progress")
	self._btnrewardbtn = gohelper.findChildButtonWithAudio(self.viewGO, "Center/episode/#go_planeEpisode/#btn_rewardbtn")
	self._btnprogress = gohelper.findChildButtonWithAudio(self.viewGO, "Center/episode/#go_planeEpisode/#btn_progress")
	self._godeadline = gohelper.findChild(self.viewGO, "Center/episode/#go_planeEpisode/#go_deadline")
	self._txttime = gohelper.findChildText(self.viewGO, "Center/episode/#go_planeEpisode/#go_deadline/#txt_time")
	self._txtformat = gohelper.findChildText(self.viewGO, "Center/episode/#go_planeEpisode/#go_deadline/#txt_time/#txt_format")
	self._goresearchReddot = gohelper.findChild(self.viewGO, "Center/episode/#go_planeEpisode/#go_researchReddot")
	self._gotaskReddot = gohelper.findChild(self.viewGO, "Center/episode/#go_planeEpisode/#go_taskReddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeThemeView:addEvents()
	self._btnEnvironment:AddClickListener(self._btnEnvironmentOnClick, self)
	self._btnprogress:AddClickListener(self._btnprogressOnClick, self)
	self._btnrewardbtn:AddClickListener(self._btnrewardbtnOnClick, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectThemeLayer, self.playSelectLayerAnim, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.ResearchProgressUpdate, self.refreshResearchProgress, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.SetPlaneMods, self.refreshPlaneEpisodeUI, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.TowerComposeTaskUpdated, self.refreshReddot, self)
end

function TowerComposeThemeView:removeEvents()
	self._btnEnvironment:RemoveClickListener()
	self._btnprogress:RemoveClickListener()
	self._btnrewardbtn:RemoveClickListener()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectThemeLayer, self.playSelectLayerAnim, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.ResearchProgressUpdate, self.refreshResearchProgress, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.SetPlaneMods, self.refreshPlaneEpisodeUI, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.TowerComposeTaskUpdated, self.refreshReddot, self)
end

TowerComposeThemeView.EnterAnimTime = 3
TowerComposeThemeView.EnterNormalAnimTime = 1.5

function TowerComposeThemeView:_btnEnvironmentOnClick()
	local param = {}

	param.themeId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	param.planeId = TowerComposeModel.instance:getCurSelectPlaneId()

	TowerComposeController.instance:openTowerComposeEnvView(param)
end

function TowerComposeThemeView:_btnprogressOnClick()
	local param = {}

	param.themeId = TowerComposeModel.instance:getCurThemeIdAndLayer()

	TowerComposeController.instance:openTowerComposeResearchView(param)
end

function TowerComposeThemeView:_btnrewardbtnOnClick()
	TowerComposeController.instance:openTowerComposeTaskView()
end

function TowerComposeThemeView:_editableInitView()
	self.themeItemMap = self:getUserDataTb_()
	self.normalEpisodeItemPoolMap = self:getUserDataTb_()
	self.normalEpisodeItemPoolList = self:getUserDataTb_()
	self.normalRewardItemList = self:getUserDataTb_()
	self.guiBossSpineList = self:getUserDataTb_()

	gohelper.setActive(self._gothemeItem, false)
	gohelper.setActive(self._gonormalEpisodeItem, false)
	gohelper.setActive(self._goclickMask, false)
	gohelper.setActive(self._goepisodeItemPool, false)
	recthelper.setAnchorX(self._goepisodeItemPool.transform, -10000)

	self.initBossPosX, self.initBossPosY = recthelper.getAnchor(self._gobossPos.transform)
	self.viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("switch", self.refreshUI, self)

	self._animCompleted = self._gocompleted:GetComponent(gohelper.Type_Animator)

	self:checkGuideSelectPlaneLayer()
end

function TowerComposeThemeView:onUpdateParam()
	if self.viewParam and self.viewParam.isJump then
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.JumpThemeLayer, self.viewParam)
		self:refreshUI()
	end
end

function TowerComposeThemeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_bubbles)

	local themeId, layerId = TowerComposeModel.instance:getCurThemeIdAndLayer()

	if self.viewParam then
		self.curThemeId = self.viewParam.themeId or themeId
	end

	if self.viewParam then
		self.curLayerId = self.viewParam.layerId or layerId
	end

	TowerComposeModel.instance:setCurUnfoldThemeId(self.curThemeId)
	self:refreshAndCreateThemeItem()
	self:refreshUI()

	if self.viewParam and self.viewParam.jumpId then
		self.viewAnim:Play("opennormal", 0, 0)
		self.viewAnim:Update(0)
	else
		self.viewAnim:Play("openenter", 0, 0)
		self.viewAnim:Update(0)
		TaskDispatcher.runDelay(self.checkAutoPopupEnvView, self, TowerComposeThemeView.EnterAnimTime)
	end

	if TowerComposeModel.instance:isFightPassNewLayer(self.curThemeId) then
		gohelper.setActive(self._gocompleted, false)
	end

	TaskDispatcher.runDelay(self.playFinishEffect, self, 1)
end

function TowerComposeThemeView:checkGuideSelectPlaneLayer()
	local themeId, layerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local isFirstPlaneGuideFinish = GuideModel.instance:isGuideFinish(TowerComposeEnum.FirstPlaneGuide)
	local isSecondPlaneGuideFinish = GuideModel.instance:isGuideFinish(TowerComposeEnum.SecondPlaneGuide)

	if themeId == 1 and layerId == 1 then
		local passLayerId = TowerComposeModel.instance:getThemePassLayer(themeId)
		local curUnlockPlaneLayerId, planeLayerIdList = TowerComposeModel.instance:getCurUnlockPlaneLayerId(themeId, passLayerId)

		if curUnlockPlaneLayerId > 0 and curUnlockPlaneLayerId == planeLayerIdList[1] and not isFirstPlaneGuideFinish or curUnlockPlaneLayerId == planeLayerIdList[2] and not isSecondPlaneGuideFinish then
			TowerComposeModel.instance:setCurThemeIdAndLayer(themeId, curUnlockPlaneLayerId)
		end
	end
end

function TowerComposeThemeView:playFinishEffect()
	local fightFinishParam = TowerComposeModel.instance:getFightFinishParam()

	if TowerComposeModel.instance:isFightPassNewLayer(self.curThemeId) then
		gohelper.setActive(self._goclickMask, true)
		gohelper.setActive(self._gocompleted, true)
		self._animCompleted:Play("in", 0, 0)

		for index, rewardItem in pairs(self.normalRewardItemList) do
			gohelper.setActive(rewardItem.goHasGet, true)
			rewardItem.animHasGet:Play("go_hasget_in", 0, 0)
		end

		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.ShowUnlockWordAnim)
		TaskDispatcher.runDelay(self.selectNextLayer, self, 1)
	end

	TowerComposeModel.instance:clearFightFinishParam()
end

function TowerComposeThemeView:selectNextLayer()
	local curPassTowerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(self.curThemeId, self.passLayerId)

	if curPassTowerEpisodeConfig.nextLayerId > 0 then
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.SelectTargetThemeLayer, curPassTowerEpisodeConfig.nextLayerId)
	end

	gohelper.setActive(self._goclickMask, false)
end

function TowerComposeThemeView:refreshAndCreateThemeItem()
	self.allThemeCoList = TowerComposeConfig.instance:getAllThemeConfig()

	for _, themeCo in ipairs(self.allThemeCoList) do
		local isOnline = TowerComposeConfig.instance:isThemeConfigCanOpen(themeCo.id)

		if isOnline then
			local themeItem = self.themeItemMap[themeCo.id]

			if not themeItem then
				themeItem = {
					go = gohelper.clone(self._gothemeItem, self._goContent, "themeItem" .. themeCo.id)
				}
				themeItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(themeItem.go, TowerComposeThemeItem, {
					themeView = self,
					themeCo = themeCo,
					scrollCategory = self._scrollcategory
				})
				self.themeItemMap[themeCo.id] = themeItem
			end

			gohelper.setActive(themeItem.go, true)
			themeItem.comp:refreshUI()
		end
	end
end

function TowerComposeThemeView:createOrGetPoolEpisodeItem(config, clickCallBack, obj)
	local normalEpisodeItem = self.normalEpisodeItemPoolMap[config.layerId]

	if not normalEpisodeItem then
		normalEpisodeItem = {
			go = gohelper.clone(self._gonormalEpisodeItem, self._goepisodeItemPool, "normalEpisodeItem" .. config.layerId)
		}
		normalEpisodeItem.goSelect = gohelper.findChild(normalEpisodeItem.go, "go_select")
		normalEpisodeItem.goNormal = gohelper.findChild(normalEpisodeItem.go, "go_normal")
		normalEpisodeItem.goFinish = gohelper.findChild(normalEpisodeItem.go, "go_finish")
		normalEpisodeItem.txtName = gohelper.findChildText(normalEpisodeItem.go, "txt_name")
		normalEpisodeItem.btnClick = gohelper.findChildButtonWithAudio(normalEpisodeItem.go, "btn_click")
		self.normalEpisodeItemPoolMap[config.layerId] = normalEpisodeItem

		table.insert(self.normalEpisodeItemPoolList, normalEpisodeItem)
	end

	normalEpisodeItem.config = config

	normalEpisodeItem.btnClick:AddClickListener(clickCallBack, obj, config)

	return normalEpisodeItem
end

function TowerComposeThemeView:recycleNormalEpisodeItem(layerIndex)
	for i = layerIndex + 1, #self.normalEpisodeItemPoolList do
		local episodeItem = self.normalEpisodeItemPoolList[i]

		if episodeItem then
			gohelper.setActive(self.normalEpisodeItemPoolList[i].go, false)
			self.normalEpisodeItemPoolList[i].go.transform:SetParent(self._goepisodeItemPool.transform, false)
			recthelper.setAnchor(self.normalEpisodeItemPoolList[i].go.transform, 0, 0)
		end
	end
end

function TowerComposeThemeView:setClickMaskState(state)
	gohelper.setActive(self._goclickMask, state)
end

function TowerComposeThemeView:refreshUI()
	self.curThemeId, self.curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	self.themeConfig = TowerComposeConfig.instance:getThemeConfig(self.curThemeId)
	self._txtThemeName.text = self.themeConfig.name
	self._txtThemeNameEn.text = self.themeConfig.nameEn
	self._txtEnterTitle.text = self.themeConfig.name
	self._txtEnterTitleEn.text = self.themeConfig.nameEn

	local planeId = TowerComposeModel.instance:getCurSelectPlaneId()
	local curEnvModId = TowerComposeModel.instance:getCurThemeEnvModId(self.curThemeId, planeId)
	local envModConfig = TowerComposeConfig.instance:getComposeModConfig(curEnvModId)

	UISpriteSetMgr.instance:setTower2Sprite(self._imageEnvironment, self.themeConfig.pointIcon)

	self.curEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(self.curThemeId, self.curLayerId)
	self.passLayerId = TowerComposeModel.instance:getThemePassLayer(self.curThemeId)

	gohelper.setActive(self._gonormalEpisode, self.curEpisodeConfig.plane == 0)
	gohelper.setActive(self._goplaneEpisode, self.curEpisodeConfig.plane > 0)
	self:refreshPlaneEpisodeUI()
	self:refreshNormalEpisodeUI()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)

	if self.curEpisodeConfig.plane > 0 then
		TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
	end
end

function TowerComposeThemeView:checkAutoPopupEnvView()
	gohelper.setActive(self._goEnter, false)

	local curThemeId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local saveThemeEnvPopUpState = TowerComposeModel.instance:getLocalSaveData(TowerComposeEnum.LocalPrefsKey.PopUpThemeEnvView, curThemeId, 0)

	if saveThemeEnvPopUpState == 0 then
		self:_btnEnvironmentOnClick()
		TowerComposeModel.instance:setLocalSaveDataMap(TowerComposeEnum.LocalPrefsKey.PopUpThemeEnvView, curThemeId, 1)
	end
end

function TowerComposeThemeView:refreshNormalEpisodeUI()
	gohelper.setActive(self._gonormalItemFinish, self.curLayerId <= self.passLayerId)
	gohelper.setActive(self._gonormalItemFinishEffect, self.curLayerId <= self.passLayerId)
	gohelper.setActive(self._gocompleted, self.curLayerId <= self.passLayerId)

	local dungeonEpisodeConfig = DungeonConfig.instance:getEpisodeCO(self.curEpisodeConfig.episodeId)

	gohelper.setActive(self._gorewardBG, dungeonEpisodeConfig.firstBonus > 0)
	gohelper.setActive(self._goreward, dungeonEpisodeConfig.firstBonus > 0)

	if dungeonEpisodeConfig.firstBonus > 0 then
		local rewardList = DungeonConfig.instance:getRewardItems(dungeonEpisodeConfig.firstBonus)

		gohelper.CreateObjList(self, self.rewardItemShow, rewardList, self._goreward, self._gorewardItem)
	end
end

function TowerComposeThemeView:rewardItemShow(obj, data, index)
	local rewardItem = self.normalRewardItemList[index]

	if not rewardItem then
		rewardItem = {
			itemPos = gohelper.findChild(obj, "go_rewardPos"),
			goHasGet = gohelper.findChild(obj, "go_rewardGet")
		}
		rewardItem.animHasGet = gohelper.findChild(obj, "go_rewardGet/icon/go_hasget"):GetComponent(gohelper.Type_Animator)
		rewardItem.item = IconMgr.instance:getCommonPropItemIcon(rewardItem.itemPos)
		self.normalRewardItemList[index] = rewardItem
	end

	rewardItem.item:setMOValue(data[1], data[2], data[3])
	rewardItem.item:setHideLvAndBreakFlag(true)
	rewardItem.item:hideEquipLvAndBreak(true)
	rewardItem.item:setCountFontSize(51)
	gohelper.setActive(rewardItem.goHasGet, self.curLayerId <= self.passLayerId)
end

function TowerComposeThemeView:refreshPlaneEpisodeUI()
	if self.curEpisodeConfig.plane == 0 then
		return
	end

	local spineOffsetList = string.splitToNumber(self.themeConfig.spineOffset, "#")
	local spineOderLayerList = string.splitToNumber(self.themeConfig.orderLayer, "|")

	recthelper.setAnchor(self._gobossPosContent.transform, spineOffsetList[1], spineOffsetList[2])
	transformhelper.setLocalScale(self._gobossPosContent.transform, spineOffsetList[3], spineOffsetList[3], spineOffsetList[3])

	local modOffsetList = GameUtil.splitString2(self.themeConfig.modOffset, true)

	self.bossSkinCoList = {}

	local bossMonsterGroupId = self.themeConfig.monsterGroupId
	local monsterIdList = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[bossMonsterGroupId].monster, "#")

	for _, monsterId in ipairs(monsterIdList) do
		local monsterCo = lua_monster.configDict[monsterId]
		local skinCo = lua_monster_skin.configDict[monsterCo.skinId]

		table.insert(self.bossSkinCoList, skinCo)
	end

	local planeId = TowerComposeModel.instance:getCurSelectPlaneId()
	local curBossSkinCoList = TowerComposeModel.instance:getPlaneBossSkinCoList(self.curThemeId, planeId, self.bossSkinCoList)

	for index, bossSkinCo in ipairs(curBossSkinCoList) do
		local guiBossSpine = self.guiBossSpineList[index]

		if not guiBossSpine then
			guiBossSpine = {
				index = index,
				pos = gohelper.clone(self._gobossPos, self._gobossPosContent, "pos_" .. index)
			}
			guiBossSpine.comp = MonoHelper.addNoUpdateLuaComOnceToGo(guiBossSpine.pos, TowerComposeThemeSpineComp)
			self.guiBossSpineList[index] = guiBossSpine
		end

		guiBossSpine.bossSkinCo = bossSkinCo

		gohelper.setActive(guiBossSpine.pos, true)

		local param = {
			bossSkinCo = bossSkinCo,
			index = index,
			modOffsetList = modOffsetList
		}

		guiBossSpine.comp:refreshSpine(param)
	end

	for _, guiBossSpine in ipairs(self.guiBossSpineList) do
		guiBossSpine.pos.transform:SetSiblingIndex(spineOderLayerList[guiBossSpine.index])
	end

	for index = #self.bossSkinCoList + 1, #self.guiBossSpineList do
		gohelper.setActive(self.guiBossSpineList[index].pos, false)
	end

	self:refreshResearchProgress()
	self:refreshReddot()
	self:refreshRemainTime()
end

function TowerComposeThemeView:refreshResearchProgress()
	local allResearchNum = TowerComposeConfig.instance:getMaxResearchNum(self.curThemeId)
	local themeMo = TowerComposeModel.instance:getThemeMo(self.curThemeId)
	local curProgress = Mathf.Min(themeMo.researchProgress, allResearchNum)

	self._txtprogresstxt.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towercomposetheme_progress"), curProgress, allResearchNum)
	self._imageprogress.fillAmount = curProgress / allResearchNum
end

function TowerComposeThemeView:refreshReddot()
	local researchCanShowReddot = TowerComposeTaskModel.instance:canShowReddot(TowerComposeEnum.TaskType.Research, self.curThemeId)
	local normalCanShowReddot = TowerComposeTaskModel.instance:canShowReddot(TowerComposeEnum.TaskType.Normal)
	local limitCanShowReddot = TowerComposeTaskModel.instance:canShowReddot(TowerComposeEnum.TaskType.LimitTime)

	gohelper.setActive(self._goresearchReddot, self.curEpisodeConfig.plane > 0 and researchCanShowReddot)
	gohelper.setActive(self._gotaskReddot, self.curEpisodeConfig.plane > 0 and (normalCanShowReddot or limitCanShowReddot))

	for _, themeItem in pairs(self.themeItemMap) do
		themeItem.comp:refreshReddot()
	end
end

function TowerComposeThemeView:refreshRemainTime()
	local timeStamp = TowerComposeTaskModel.instance:getTaskLimitTime()

	gohelper.setActive(self._godeadline, timeStamp and timeStamp > 0)

	if timeStamp and timeStamp > 0 then
		local date, dateformate = TimeUtil.secondToRoughTime2(timeStamp, true)

		self._txttime.text = date
		self._txtformat.text = dateformate
	end
end

function TowerComposeThemeView:playSelectLayerAnim(isChangeTheme)
	if isChangeTheme then
		self.viewAnim:Play("opennormal", 0, 0)
		self.viewAnim:Update(0)
		self:refreshUI()
		TaskDispatcher.runDelay(self.checkAutoPopupEnvView, self, TowerComposeThemeView.EnterNormalAnimTime)
	else
		self.viewAnim:Play("switch", 0, 0)
		self.viewAnim:Update(0)
	end
end

function TowerComposeThemeView:cleanJumpId()
	if self.viewParam and self.viewParam.jumpId then
		self.viewParam.jumpId = nil
	end
end

function TowerComposeThemeView:onClose()
	TaskDispatcher.cancelTask(self.checkAutoPopupEnvView, self)
	TaskDispatcher.cancelTask(self.playFinishEffect, self)
	TaskDispatcher.cancelTask(self.selectNextLayer, self)
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TowerComposeModel.instance:clearFightFinishParam()
	self:cleanJumpId()
end

function TowerComposeThemeView:onDestroyView()
	for _, episodeItem in pairs(self.normalEpisodeItemPoolMap) do
		episodeItem.btnClick:RemoveClickListener()
	end

	self._animEventWrap:RemoveAllEventListener()
end

return TowerComposeThemeView
