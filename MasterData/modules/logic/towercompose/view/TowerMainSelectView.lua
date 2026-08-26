-- chunkname: @modules/logic/towercompose/view/TowerMainSelectView.lua

module("modules.logic.towercompose.view.TowerMainSelectView", package.seeall)

local TowerMainSelectView = class("TowerMainSelectView", BaseView)

function TowerMainSelectView:onInitView()
	self._goheroTrial = gohelper.findChild(self.viewGO, "heroTrial")
	self._btnheroTrial = gohelper.findChildButtonWithAudio(self.viewGO, "heroTrial/#btn_heroTrial")
	self._goheroTrialNew = gohelper.findChild(self.viewGO, "heroTrial/#go_heroTrialNew")
	self._goheroTrialNewEffect = gohelper.findChild(self.viewGO, "heroTrial/#saoguang")
	self._imageticket = gohelper.findChildImage(self.viewGO, "ticket/#image_ticket")
	self._txtticketNum = gohelper.findChildText(self.viewGO, "ticket/#txt_ticketNum")
	self._gomopupReddot = gohelper.findChild(self.viewGO, "ticket/#go_mopupReddot")
	self._btnmopup = gohelper.findChildButtonWithAudio(self.viewGO, "ticket/#btn_mopup")
	self._btnoldEntrance = gohelper.findChildButtonWithAudio(self.viewGO, "oldEntrance/#btn_oldEntrance")
	self._simagerewardIcon = gohelper.findChildSingleImage(self.viewGO, "oldEntrance/reward/#simage_rewardIcon")
	self._gohasGet = gohelper.findChild(self.viewGO, "oldEntrance/reward/#go_hasGet")
	self._txtrewardNum = gohelper.findChildText(self.viewGO, "oldEntrance/reward/#txt_rewardNum")
	self._txtprogressOld = gohelper.findChildText(self.viewGO, "oldEntrance/#txt_progressOld")
	self._txtprogressCompose = gohelper.findChildText(self.viewGO, "composeEntrance/#txt_progressCompose")
	self._btncomposeEntrance = gohelper.findChildButtonWithAudio(self.viewGO, "composeEntrance/#btn_composeEntrance")
	self._goupdateTag = gohelper.findChild(self.viewGO, "composeEntrance/#go_updateTag")
	self._simagerewardIconCompose = gohelper.findChildSingleImage(self.viewGO, "composeEntrance/reward/#simage_rewardIconCompose")
	self._gohasGetCompose = gohelper.findChild(self.viewGO, "composeEntrance/reward/#go_hasGetCompose")
	self._txtrewardNumCompose = gohelper.findChildText(self.viewGO, "composeEntrance/reward/#txt_rewardNumCompose")
	self._gochangeTime = gohelper.findChild(self.viewGO, "composeEntrance/#go_changetime")
	self._txtTime = gohelper.findChildText(self.viewGO, "composeEntrance/#go_changetime/#txt_time")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gooldReddot = gohelper.findChild(self.viewGO, "oldEntrance/#go_oldReddot")
	self._gocomposeReddot = gohelper.findChild(self.viewGO, "composeEntrance/#go_composeReddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerMainSelectView:addEvents()
	self._btnheroTrial:AddClickListener(self._btnheroTrialOnClick, self)
	self._btnmopup:AddClickListener(self._btnmopupOnClick, self)
	self._btnoldEntrance:AddClickListener(self._btnoldEntranceOnClick, self)
	self._btncomposeEntrance:AddClickListener(self._btncomposeEntranceOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerMopUp, self.refreshMopUpInfo, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.onDailyReresh, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshHeroTrialNew, self.refreshHeroTrialNew, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.LocalKeyChange, self.onLocalKeyChange, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectThemeLayer, self.refreshComposeEntranceInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
end

function TowerMainSelectView:removeEvents()
	self._btnheroTrial:RemoveClickListener()
	self._btnmopup:RemoveClickListener()
	self._btnoldEntrance:RemoveClickListener()
	self._btncomposeEntrance:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerMopUp, self.refreshMopUpInfo, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.onDailyReresh, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshHeroTrialNew, self.refreshHeroTrialNew, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.LocalKeyChange, self.onLocalKeyChange, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectThemeLayer, self.refreshComposeEntranceInfo, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
end

function TowerMainSelectView:_btncomposeEntranceOnClick()
	local param = {}

	param.targetModeType = TowerComposeEnum.TowerMainType.NewTower
	param.needCloseViewName = ViewName.TowerMainView
	param.param = self.viewParam

	self.viewAnim:Play("change_new", 0, 0)
	self.viewAnim:Update(0)
	TowerComposeController.instance:openTowerModeChangeView(param)
end

function TowerMainSelectView:_btnheroTrialOnClick()
	TowerController.instance:openTowerHeroTrialView()
	self:saveHeroTrialNew()
	gohelper.setActive(self._goheroTrialNew, false)
end

function TowerMainSelectView:_btnmopupOnClick()
	TowerController.instance:openTowerMopUpView()
end

function TowerMainSelectView:_btnoldEntranceOnClick()
	local param = {}

	param.targetModeType = TowerComposeEnum.TowerMainType.OldTower
	param.needCloseViewName = ViewName.TowerMainView
	param.param = self.viewParam

	self.viewAnim:Play("change_old", 0, 0)
	self.viewAnim:Update(0)
	TowerComposeController.instance:openTowerModeChangeView(param)
end

function TowerMainSelectView:_editableInitView()
	gohelper.setActive(self._goheroTrial, false)
	gohelper.setActive(self._goheroTrialNewEffect, false)

	self.viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goticket = gohelper.findChild(self.viewGO, "ticket")
end

function TowerMainSelectView:onUpdateParam()
	return
end

function TowerMainSelectView:onDailyReresh()
	self:refreshUI()
end

function TowerMainSelectView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_utim_open)

	self.mainType = self.viewParam and self.viewParam.mainType

	RedDotController.instance:addRedDot(self._gooldReddot, RedDotEnum.DotNode.TowerEnter)
	RedDotController.instance:addRedDot(self._gocomposeReddot, RedDotEnum.DotNode.TowerComposeEnter)
	self:refreshUI()
	self:checkJump()
	TaskDispatcher.runDelay(self.checkShowEffect, self, 0.6)
end

function TowerMainSelectView:checkJump()
	if self.mainType == TowerComposeEnum.TowerMainType.OldTower then
		self:_btnoldEntranceOnClick()
	elseif self.mainType == TowerComposeEnum.TowerMainType.NewTower then
		self:_btncomposeEntranceOnClick()
	end
end

function TowerMainSelectView:refreshUI()
	self:refreshMopUpInfo()
	self:refreshReddot()
	self:refreshHeroTrialNew()
	self:refreshOldEntranceInfo()
	self:refreshComposeEntranceInfo()
	self:refreshUpdateTime()
	TaskDispatcher.cancelTask(self.refreshUpdateTime, self)
	TaskDispatcher.runRepeat(self.refreshUpdateTime, self, 1)
end

function TowerMainSelectView:refreshMopUpInfo()
	local permanentPassLayerNum = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local mopUpOpenLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)

	gohelper.setActive(self._goticket, permanentPassLayerNum >= tonumber(mopUpOpenLayerNum))

	local curMopUpTimes = TowerModel.instance:getMopUpTimes()
	local maxMopUpTimes = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	self._txtticketNum.text = string.format("<color=#EA9465>%s</color>/%s", curMopUpTimes, maxMopUpTimes)

	local ticketId = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageticket, ticketId .. "_1", true)
end

function TowerMainSelectView:refreshReddot()
	RedDotController.instance:addRedDot(self._gomopupReddot, RedDotEnum.DotNode.TowerMopUp)
end

function TowerMainSelectView:checkShowEffect()
	local saveShowTrialHeroEffect = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.TowerMainHeroTrialEffect, 0)
	local canShowTrialHeroEffect = saveShowTrialHeroEffect == 0

	gohelper.setActive(self._goheroTrialNewEffect, canShowTrialHeroEffect)
end

function TowerMainSelectView:saveHeroTrialNew()
	local trialSeason = TowerModel.instance:getTrialHeroSeason()

	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, trialSeason)
	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.RefreshHeroTrialNew)
end

function TowerMainSelectView:refreshHeroTrialNew()
	local saveSeason = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, 0)
	local curSeason = TowerModel.instance:getTrialHeroSeason()

	gohelper.setActive(self._goheroTrial, false)
	gohelper.setActive(self._goheroTrialNew, saveSeason ~= curSeason and curSeason > 0)
end

function TowerMainSelectView:refreshOldEntranceInfo()
	local curMaxPassEpisodeId = TowerPermanentModel.instance:getCurPassEpisodeId()

	if curMaxPassEpisodeId == 0 then
		self._txtprogressOld.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_defaultlayer"), {
			0
		})
	else
		local maxDeepHigh = TowerPermanentDeepModel.instance:getCurMaxDeepHigh()
		local defaultDeep = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)
		local isOpenEndless = TowerPermanentDeepModel.instance.isOpenEndless

		if defaultDeep < maxDeepHigh or isOpenEndless then
			self._txtprogressOld.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towermain_deeplayer"), maxDeepHigh)
		else
			local episodeConfig = DungeonConfig.instance:getEpisodeCO(curMaxPassEpisodeId)

			self._txtprogressOld.text = episodeConfig.name
		end
	end

	local hasNewBossOpen = TowerModel.instance:hasNewBossOpen()
	local isBossTowerOpenLayer = TowerController.instance:isBossTowerOpen()
	local isBossTowerStateOpen = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)

	gohelper.setActive(self._gobossHasNew, hasNewBossOpen and isBossTowerOpenLayer and isBossTowerStateOpen)
end

function TowerMainSelectView:onLocalKeyChange()
	local hasNew = TowerModel.instance:hasNewBossOpen()

	gohelper.setActive(self._gobossHasNew, hasNew)
end

function TowerMainSelectView:refreshComposeEntranceInfo()
	local curThemeId, curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local episodeConfig = TowerComposeConfig.instance:getEpisodeConfig(curThemeId, curLayerId)
	local themeConfig = TowerComposeConfig.instance:getThemeConfig(curThemeId)

	self._txtprogressCompose.text = themeConfig.name

	local isNewThemeUpdate = TowerComposeModel.instance:checkLocalThemeUpdate()

	gohelper.setActive(self._goupdateTag, isNewThemeUpdate)
end

function TowerMainSelectView:refreshUpdateTime()
	local timeStamp = TowerComposeTaskModel.instance:getTaskLimitTime(true)

	gohelper.setActive(self._gochangeTime, timeStamp and timeStamp > 0)

	if timeStamp and timeStamp > 0 then
		local timeStr = TimeUtil.SecondToActivityTimeFormat(timeStamp)

		self._txtTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity204entranceview_open"), timeStr)
	else
		self._txtTime.text = ""
	end
end

function TowerMainSelectView:_onCloseView(viewName)
	if viewName == ViewName.TowerComposeMainView or viewName == ViewName.TowerMainView then
		self.viewAnim:Play("open", 0, 0)
		self.viewAnim:Update(0)
		AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_utim_open)
	end

	if viewName == ViewName.TowerComposeThemeView then
		self:refreshComposeEntranceInfo()
	end
end

function TowerMainSelectView:onClose()
	TaskDispatcher.cancelTask(self.checkShowEffect, self)
	TaskDispatcher.cancelTask(self.refreshUpdateTime, self)
end

function TowerMainSelectView:onDestroyView()
	return
end

return TowerMainSelectView
