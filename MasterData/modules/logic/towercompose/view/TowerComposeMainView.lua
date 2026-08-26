-- chunkname: @modules/logic/towercompose/view/TowerComposeMainView.lua

module("modules.logic.towercompose.view.TowerComposeMainView", package.seeall)

local TowerComposeMainView = class("TowerComposeMainView", BaseView)

function TowerComposeMainView:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "centerTitle/#txt_title")
	self._txttitleEn = gohelper.findChildText(self.viewGO, "centerTitle/#txt_titleEn")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "centerTitle/#simage_Title")
	self._simageTitle1 = gohelper.findChildSingleImage(self.viewGO, "centerTitle/#simage_Title1")
	self._btnheroTrial = gohelper.findChildButtonWithAudio(self.viewGO, "heroTrial/#btn_heroTrial")
	self._goheroTrialNew = gohelper.findChild(self.viewGO, "heroTrial/#go_heroTrialNew")
	self._gobossHasNew = gohelper.findChild(self.viewGO, "themeEntrance/#go_bossHasNew")
	self._txtstate = gohelper.findChildText(self.viewGO, "themeEntrance/#go_bossHasNew/#txt_state")
	self._txtepisodeName = gohelper.findChildText(self.viewGO, "themeEntrance/progress/#txt_episodeName")
	self._btnthemeEntrance = gohelper.findChildButtonWithAudio(self.viewGO, "themeEntrance/#btn_themeEntrance")
	self._gopermanentReddot = gohelper.findChild(self.viewGO, "themeEntrance/#btn_themeEntrance/#go_permanentReddot")
	self._gochangeTime = gohelper.findChild(self.viewGO, "themeEntrance/#go_changetime")
	self._txtTime = gohelper.findChildText(self.viewGO, "themeEntrance/#go_changetime/#txt_time")
	self._gothemeReddot = gohelper.findChild(self.viewGO, "themeEntrance/#go_themeReddot")
	self._btntower = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tower")
	self._gostore = gohelper.findChild(self.viewGO, "store")
	self._gostoreTime = gohelper.findChild(self.viewGO, "store/time")
	self._txtstoreTime = gohelper.findChildText(self.viewGO, "store/time/#txt_storeTime")
	self._txtstoreName = gohelper.findChildText(self.viewGO, "store/#txt_storeName")
	self._txtcoinNum = gohelper.findChildText(self.viewGO, "store/#txt_coinNum")
	self._imagecoin = gohelper.findChildImage(self.viewGO, "store/#txt_coinNum/#image_coin")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "store/#btn_store")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeMainView:addEvents()
	self._btnheroTrial:AddClickListener(self._btnheroTrialOnClick, self)
	self._btnthemeEntrance:AddClickListener(self._btnthemeEntranceOnClick, self)
	self._btntower:AddClickListener(self._btntowerOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectThemeLayer, self.refreshEntranceInfo, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshHeroTrialNew, self.refreshHeroTrialNew, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStore, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self.refreshStore, self)
end

function TowerComposeMainView:removeEvents()
	self._btnheroTrial:RemoveClickListener()
	self._btnthemeEntrance:RemoveClickListener()
	self._btntower:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectThemeLayer, self.refreshEntranceInfo, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshHeroTrialNew, self.refreshHeroTrialNew, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStore, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self.refreshStore, self)
	TaskDispatcher.cancelTask(self.refreshUpdateTime, self)
end

function TowerComposeMainView:_btnheroTrialOnClick()
	TowerController.instance:openTowerHeroTrialView({
		trialType = TowerEnum.HeroTrialEntranceType.Compose
	})
	self:saveHeroTrialNew()
	gohelper.setActive(self._goheroTrialNew, false)
end

function TowerComposeMainView:_btnthemeEntranceOnClick()
	TowerComposeController.instance:openTowerThemeView(self.viewParam)
	TowerComposeModel.instance:saveLocalTheme()
end

function TowerComposeMainView:_btntowerOnClick()
	local param = {}

	param.targetModeType = TowerComposeEnum.TowerMainType.OldTower
	param.needCloseViewName = ViewName.TowerComposeMainView

	self.viewAnim:Play("change", 0, 0)
	self.viewAnim:Update(0)
	TowerComposeController.instance:openTowerModeChangeView(param)
end

function TowerComposeMainView:_btnstoreOnClick()
	TowerController.instance:openTowerStoreView()
end

function TowerComposeMainView:_editableInitView()
	self.viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function TowerComposeMainView:onUpdateParam()
	return
end

function TowerComposeMainView:onDailyReresh()
	self:refreshUI()
end

function TowerComposeMainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_tujianskin_amb_loop)
	RedDotController.instance:addRedDot(self._gothemeReddot, RedDotEnum.DotNode.TowerComposeEnter)
	self:checkJump()
	self:refreshUI()
	TaskDispatcher.runDelay(self.checkShowEffect, self, 0.6)

	if ViewMgr.instance:isOpen(ViewName.TowerModeChangeView) then
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.CloseModeChangeView)
	end
end

function TowerComposeMainView:checkJump()
	if self.viewParam then
		if self.viewParam and self.viewParam == TowerComposeEnum.JumpId.TowerComposeTheme or self.viewParam == TowerComposeEnum.JumpId.TowerComposeModEquip then
			TowerComposeModel.instance:setCurThemeIdAndLayer(self.viewParam.themeId, self.viewParam.layerId)
			self:_btnthemeEntranceOnClick()
		end
	end
end

function TowerComposeMainView:refreshUI()
	self:refreshReddot()
	self:refreshHeroTrialNew()
	self:refreshEntranceInfo()
	self:refreshTaskInfo()
	self:refreshUpdateTime()
	self:refreshStore()
	TaskDispatcher.cancelTask(self.refreshUpdateTime, self)
	TaskDispatcher.runRepeat(self.refreshUpdateTime, self, 1)
end

function TowerComposeMainView:refreshReddot()
	return
end

function TowerComposeMainView:checkShowEffect()
	local saveShowTrialHeroEffect = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.TowerMainHeroTrialEffect, 0)
	local canShowTrialHeroEffect = saveShowTrialHeroEffect == 0

	gohelper.setActive(self._goheroTrialNewEffect, canShowTrialHeroEffect)
end

function TowerComposeMainView:saveHeroTrialNew()
	local trialSeason = TowerModel.instance:getTrialHeroSeason()

	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, trialSeason)
	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.RefreshHeroTrialNew)
end

function TowerComposeMainView:refreshHeroTrialNew()
	local saveSeason = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, 0)
	local curSeason = TowerModel.instance:getTrialHeroSeason()
	local heroTrialList = TowerHeroTrialListModel.instance:getEntranceHeroTrialList(TowerEnum.HeroTrialEntranceType.Compose)

	gohelper.setActive(self._goheroTrial, #heroTrialList > 0)
	gohelper.setActive(self._goheroTrialNew, saveSeason ~= curSeason and curSeason > 0)
end

function TowerComposeMainView:refreshEntranceInfo()
	local curThemeId, curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local episodeConfig = TowerComposeConfig.instance:getEpisodeConfig(curThemeId, curLayerId)
	local themeConfig = TowerComposeConfig.instance:getThemeConfig(curThemeId)

	self._txtepisodeName.text = themeConfig.name

	local isNewThemeUpdate = TowerComposeModel.instance:checkLocalThemeUpdate()

	gohelper.setActive(self._gobossHasNew, isNewThemeUpdate)
end

function TowerComposeMainView:refreshTaskInfo()
	local towerTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.TowerCompose) or {}

	TowerComposeTaskModel.instance:setTaskInfoList(towerTasks)
end

function TowerComposeMainView:refreshUpdateTime()
	local timeStamp = TowerComposeTaskModel.instance:getTaskLimitTime(true)

	gohelper.setActive(self._gochangeTime, timeStamp and timeStamp > 0)

	if timeStamp and timeStamp > 0 then
		local timeStr = TimeUtil.SecondToActivityTimeFormat(timeStamp)

		self._txtTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity204entranceview_open"), timeStr)
	else
		self._txtTime.text = ""
	end

	self:refreshStoreTime()
end

function TowerComposeMainView:refreshStore()
	local isStoreOpen = TowerController.instance:isTowerStoreOpen()

	gohelper.setActive(self._gostore, isStoreOpen)

	local currencyIcon = TowerStoreModel.instance:getCurrencyIcon()

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecoin, currencyIcon)

	self._txtcoinNum.text = TowerStoreModel.instance:getCurrencyCount()

	self:refreshStoreTime()
end

function TowerComposeMainView:refreshStoreTime()
	local isUpdateStoreEmpty = TowerStoreModel.instance:isUpdateStoreEmpty()

	gohelper.setActive(self._gostoreTime, not isUpdateStoreEmpty)

	if isUpdateStoreEmpty then
		return
	end

	self._txtstoreTime.text = TowerStoreModel.instance:getUpdateStoreRemainTime()
end

function TowerComposeMainView:_onCloseViewFinish(viewName)
	if viewName == ViewName.TowerComposeThemeView then
		self:refreshEntranceInfo()
	end
end

function TowerComposeMainView:onClose()
	TaskDispatcher.cancelTask(self.checkShowEffect, self)
	TaskDispatcher.cancelTask(self.refreshUpdateTime, self)
	AudioMgr.instance:trigger(AudioEnum.TowerCompose.stop_ui_bus)
end

function TowerComposeMainView:onDestroyView()
	return
end

return TowerComposeMainView
