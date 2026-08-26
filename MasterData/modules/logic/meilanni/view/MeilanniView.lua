-- chunkname: @modules/logic/meilanni/view/MeilanniView.lua

module("modules.logic.meilanni.view.MeilanniView", package.seeall)

local MeilanniView = class("MeilanniView", BaseView)

function MeilanniView:onInitView()
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#simage_rightbg")
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goeventlist = gohelper.findChild(self.viewGO, "#go_eventlist")
	self._scrolldialog = gohelper.findChildScrollRect(self.viewGO, "top_right/#scroll_dialog")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "top_right/#scroll_dialog/viewport/#go_scrollcontainer/#go_scrollcontent")
	self._goday = gohelper.findChild(self.viewGO, "top_right/#go_day")
	self._imageweather = gohelper.findChildImage(self.viewGO, "top_right/#go_day/#image_weather")
	self._imageweather1 = gohelper.findChildImage(self.viewGO, "top_right/#go_day/#image_weather1")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "top_right/#go_day/#txt_remaintime")
	self._gothreat = gohelper.findChild(self.viewGO, "#go_threat")
	self._goitem1 = gohelper.findChild(self.viewGO, "#go_threat/root/horizontal/#go_item1")
	self._goitem2 = gohelper.findChild(self.viewGO, "#go_threat/root/horizontal/#go_item2")
	self._goitem3 = gohelper.findChild(self.viewGO, "#go_threat/root/horizontal/#go_item3")
	self._goitem4 = gohelper.findChild(self.viewGO, "#go_threat/root/horizontal/#go_item4")
	self._goitem5 = gohelper.findChild(self.viewGO, "#go_threat/root/horizontal/#go_item5")
	self._imageenemyicon = gohelper.findChildImage(self.viewGO, "#go_threat/root/enemy/#image_enemyicon")
	self._btnenemydetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_threat/root/enemy/#btn_enemydetail")
	self._gostar = gohelper.findChild(self.viewGO, "top_right/#go_day/action/actioncount/stars/#go_star")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._goexhibition = gohelper.findChild(self.viewGO, "#go_exhibition")
	self._imageexhibitionicon = gohelper.findChildImage(self.viewGO, "#go_exhibition/root/exhibition/#image_exhibitionicon")
	self._btnexhibitiondetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_exhibition/root/exhibition/#btn_exhibitiondetail")
	self._txtexhibitionname = gohelper.findChildText(self.viewGO, "#go_exhibition/root/#txt_exhibitionname")
	self._simageinfobg1 = gohelper.findChildSingleImage(self.viewGO, "top_right/#simage_infobg1")
	self._simageinfobg2 = gohelper.findChildSingleImage(self.viewGO, "top_right/#simage_infobg2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniView:addEvents()
	self._btnenemydetail:AddClickListener(self._btnenemydetailOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnexhibitiondetail:AddClickListener(self._btnexhibitiondetailOnClick, self)
end

function MeilanniView:removeEvents()
	self._btnenemydetail:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnexhibitiondetail:RemoveClickListener()
end

function MeilanniView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.MeilanniReset, MsgBoxEnum.BoxType.Yes_No, function()
		Activity108Rpc.instance:sendResetMapRequest(MeilanniEnum.activityId, self._mapId, function()
			MeilanniController.instance:statEnd(StatEnum.Result.Reset)
			MeilanniController.instance:statStart()
		end)
	end)
end

function MeilanniView:_btnexhibitiondetailOnClick()
	MeilanniController.instance:openMeilanniEntrustView({
		showExhibits = true,
		mapId = self._mapId
	})
end

function MeilanniView:_btnenemydetailOnClick()
	MeilanniController.instance:openMeilanniBossInfoView({
		mapId = self._mapId
	})
end

function MeilanniView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getMeilanniIcon("heidi_zhehzaoleft"))
	self._simagerightbg:LoadImage(ResUrl.getMeilanniIcon("heidi_zhehzaoright"))
	self._simageinfobg1:LoadImage(ResUrl.getMeilanniIcon("bg_diban"))
	self._simageinfobg2:LoadImage(ResUrl.getMeilanniIcon("bg_diban"))
	gohelper.addUIClickAudio(self._btnenemydetail.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(self._btnexhibitiondetail.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(self._btnreset.gameObject, AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function MeilanniView:_checkFinishMapStory()
	local storyList = MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.finishMap)

	for i, v in ipairs(storyList) do
		if v[2] == self._mapId and MeilanniModel.instance:getMapHighestScore(v[2]) > 0 then
			local config = v[1]
			local storyId = config.story

			if not StoryModel.instance:isStoryFinished(storyId) then
				StoryController.instance:playStory(storyId)

				return true
			end
		end
	end
end

function MeilanniView:onOpen()
	self._mapId = MeilanniModel.instance:getCurMapId()
	self._mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)
	self._actPointItemList = self:getUserDataTb_()

	gohelper.setActive(self._gostar, false)

	self._dayAnimator = self._goday:GetComponent(typeof(UnityEngine.Animator))

	self:_updateInfo()
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, self._episodeInfoUpdate, self, LuaEventSystem.Low)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.getInfo, self._getInfo, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.resetMap, self._resetMap, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.mapFail, self._onMapFail, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.mapSuccess, self._onMapSuccess, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.updateExcludeRules, self._updateExcludeRules, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:_dimBgm(true)
end

function MeilanniView:_dimBgm(state)
	if state then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_open)
	else
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_close)
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end
end

function MeilanniView:_onCloseViewFinish(viewName)
	if viewName == ViewName.MeilanniSettlementView then
		if not self:_checkFinishMapStory() then
			self:closeThis()
		else
			self._waitCloseStoryView = true
		end
	end

	if viewName == ViewName.StoryView and self._waitCloseStoryView then
		self:closeThis()
	elseif viewName == ViewName.MeilanniBossInfoView and self._oldThreat then
		TaskDispatcher.runDelay(self._closeThreatItemAnim, self, 0.8)
	end
end

function MeilanniView:_updateExcludeRules(params)
	self._oldThreat = params[3]

	MeilanniAnimationController.instance:addDelayCall(self._openMeilanniBossInfoView, self, {
		showExcludeRules = true,
		mapId = self._mapId,
		rulesInfo = params
	}, MeilanniEnum.showExcludeRulesTime, MeilanniAnimationController.excludeRulesLayer)
end

function MeilanniView:_openMeilanniBossInfoView(params)
	MeilanniController.instance:openMeilanniBossInfoView(params)
end

function MeilanniView:_resetMap()
	self:_updateInfo()
end

function MeilanniView:_getInfo()
	if self._mapInfo:checkFinish() then
		MeilanniController.instance:openMeilanniSettlementView(self._mapId)
	end
end

function MeilanniView:_episodeInfoUpdate()
	self:_updateInfo()
end

function MeilanniView:_updateInfo()
	MeilanniAnimationController.instance:addDelayCall(self._changeDay, self, nil, MeilanniEnum.changeWeatherTime, MeilanniAnimationController.changeWeatherLayer)

	if MeilanniAnimationController.instance:isPlaying() and self:_checkUpdateEnemy() then
		MeilanniAnimationController.instance:addDelayCall(self._updateEnemy, self, nil, MeilanniEnum.showEnemyTime, MeilanniAnimationController.enemyLayer)
	elseif not self._oldThreat then
		self:_updateEnemy()
	end
end

function MeilanniView:_changeDay()
	self:_updateDayInfo()
	self:_updateStars()
	self:_updateExhibits()
end

function MeilanniView:_updateExhibits()
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()
	local showExhibits = episodeInfo.episodeConfig.showExhibits == 1

	gohelper.setActive(self._goexhibition, showExhibits)

	if not showExhibits then
		return
	end

	self._mapConfig = lua_activity108_map.configDict[self._mapId]
	self._txtexhibitionname.text = self._mapConfig.title

	UISpriteSetMgr.instance:setMeilanniSprite(self._imageexhibitionicon, self._mapConfig.exhibits)
end

function MeilanniView:_updateDayInfo()
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()
	local episodeConfig = episodeInfo.episodeConfig
	local lastConfig = MeilanniConfig.instance:getLastEpisode(episodeConfig.mapId)

	self._txtremaintime.text = episodeConfig.mapId <= 102 and formatLuaLang("meilannidialogitem_countdown", lastConfig.day - episodeConfig.day + 1) or formatLuaLang("meilannidialogitem_countdown2", episodeConfig.day)

	if self._prevEpisodeConfig == episodeConfig then
		return
	end

	local nightTime = episodeConfig.period == 2

	UISpriteSetMgr.instance:setMeilanniSprite(self._imageweather1, nightTime and "icon_ws" or "icon_bt")

	if not nightTime then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_noise_exhibition_hall)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if self._prevEpisodeConfig then
		gohelper.setActive(self._imageweather, true)
		UISpriteSetMgr.instance:setMeilanniSprite(self._imageweather, self._prevEpisodeConfig.period == 2 and "icon_ws" or "icon_bt")
		self._dayAnimator:Play("switch", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
	else
		gohelper.setActive(self._imageweather, false)
	end

	self._prevEpisodeConfig = episodeConfig
end

function MeilanniView:_updateStars()
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()

	self._curEpisodeInfo = episodeInfo

	local episodeConfig = episodeInfo.episodeConfig

	for i = 1, episodeConfig.actpoint do
		local item = self:_getActItem(i)

		gohelper.setActive(item.go, true)
		gohelper.setActive(item.emptyGo, i > episodeInfo.leftActPoint)

		local showFill = i <= episodeInfo.leftActPoint

		if not showFill then
			item.animator:Play(UIAnimationName.Close)
		else
			item.animator:Play(UIAnimationName.Idle)
		end
	end

	for i = episodeConfig.actpoint + 1, #self._actPointItemList do
		local item = self:_getActItem(i)

		gohelper.setActive(item.go, false)
	end
end

function MeilanniView:_getActItem(index)
	local item = self._actPointItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gostar)
		item.animator = item.go:GetComponent(typeof(UnityEngine.Animator))
		item.fillGo = gohelper.findChild(item.go, "fill")

		gohelper.setActive(item.fillGo, true)

		item.emptyGo = gohelper.findChild(item.go, "empty")
		self._actPointItemList[index] = item
	end

	return item
end

function MeilanniView:_getConfigBattleId(interactParam)
	for i, v in ipairs(interactParam) do
		if v[1] == MeilanniEnum.ElementType.Battle then
			local param = v[2]

			return tonumber(param)
		end
	end
end

function MeilanniView.getMonsterId(battleId)
	local battleConfig = lua_battle.configDict[battleId]
	local monsterGroupIds = string.splitToNumber(battleConfig.monsterGroupIds, "#")
	local id

	for i, groupId in ipairs(monsterGroupIds) do
		local monsterGroupConfig = lua_monster_group.configDict[groupId]
		local monsterIds = string.splitToNumber(monsterGroupConfig.monster, "#")

		for _, monsterId in ipairs(monsterIds) do
			id = monsterId

			if FightHelper.isBossId(monsterGroupConfig.bossId, monsterId) then
				return monsterId
			end
		end
	end

	return id
end

function MeilanniView:_updateEnemy()
	local lastEventConfig = MeilanniConfig.instance:getLastEvent(self._mapId)
	local interactParam = GameUtil.splitString2(lastEventConfig.interactParam, true, "|", "#")
	local battleId = self:_getConfigBattleId(interactParam)
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()
	local showEmeny = episodeInfo.episodeConfig.showBoss == 1
	local lastConfig = MeilanniConfig.instance:getLastEpisode(self._mapId)
	local episodeConfig = episodeInfo.episodeConfig

	if showEmeny and self._mapInfo.score > 0 and episodeConfig.day == lastConfig.day and episodeInfo.isFinish then
		showEmeny = false
	end

	gohelper.setActive(self._gothreat, showEmeny)

	if showEmeny and self._showEmeny == false then
		local animator = self._gothreat:GetComponent(typeof(UnityEngine.Animator))

		animator:Play("open")
	end

	self._showEmeny = showEmeny

	if not showEmeny then
		return
	end

	local threat = self._mapInfo:getThreat()

	self:_showThreatItems(showEmeny, threat)

	local monsterId = MeilanniView.getMonsterId(battleId)

	if not monsterId then
		return
	end

	local monsterConfig = lua_monster.configDict[monsterId]
	local skinConfig = lua_monster_skin.configDict[monsterConfig.skinId]

	gohelper.getSingleImage(self._imageenemyicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))
end

function MeilanniView:_checkUpdateEnemy()
	local lastEventConfig = MeilanniConfig.instance:getLastEvent(self._mapId)
	local interactParam = GameUtil.splitString2(lastEventConfig.interactParam, true, "|", "#")
	local battleId = self:_getConfigBattleId(interactParam)
	local episodeInfo = self._mapInfo:getCurEpisodeInfo()
	local showEmeny = episodeInfo.episodeConfig.showBoss == 1

	if not showEmeny then
		return
	end

	local monsterId = MeilanniView.getMonsterId(battleId)

	if not monsterId then
		return
	end

	return not self._showEmeny
end

function MeilanniView:_showThreatItems(showEmeny, threat)
	if not showEmeny then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.MeilanniBossInfoView) then
		return
	end

	for i = 1, MeilanniEnum.threatNum do
		local item = self["_goitem" .. i]

		gohelper.setActive(item, i <= threat)
	end
end

function MeilanniView:_closeThreatItemAnim()
	local threat = self._mapInfo:getThreat() + 1

	if not self._oldThreat then
		self._oldThreat = nil

		for i = threat, self._oldThreat do
			local item = self["_goitem" .. i]

			if item then
				gohelper.setActive(item, true)

				local animator = item:GetComponent(typeof(UnityEngine.Animator))

				animator.enabled = true

				animator:Play("close", 0, 0)
			end
		end
	end
end

function MeilanniView:_onMapFail()
	MeilanniController.instance:statEnd(StatEnum.Result.Fail)
end

function MeilanniView:_onMapSuccess()
	MeilanniController.instance:statEnd(StatEnum.Result.Success)
end

function MeilanniView:onClose()
	if self.viewContainer:isManualClose() then
		MeilanniController.instance:statEnd(StatEnum.Result.Abort)
	end

	TaskDispatcher.cancelTask(self._closeThreatItemAnim, self)
	self:_dimBgm(false)
end

function MeilanniView:onDestroyView()
	self._simagerightbg:UnLoadImage()
	self._simageleftbg:UnLoadImage()
	self._simageinfobg1:UnLoadImage()
	self._simageinfobg2:UnLoadImage()
end

return MeilanniView
