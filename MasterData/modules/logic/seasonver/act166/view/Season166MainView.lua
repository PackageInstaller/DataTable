-- chunkname: @modules/logic/seasonver/act166/view/Season166MainView.lua

module("modules.logic.seasonver.act166.view.Season166MainView", package.seeall)

local Season166MainView = class("Season166MainView", BaseView)

function Season166MainView:onInitView()
	self._goStarCollect = gohelper.findChild(self.viewGO, "starCollect")
	self._txttotalStarCount = gohelper.findChildText(self.viewGO, "starCollect/#txt_totalStarCount")
	self._gomainContent = gohelper.findChild(self.viewGO, "#go_mainContent")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "#go_mainContent/title/#txt_remainTime")
	self._goprogress = gohelper.findChild(self.viewGO, "trainEntrance/progress")
	self._goprogressItem = gohelper.findChild(self.viewGO, "trainEntrance/progress/#go_progress")
	self._goepisodeContent = gohelper.findChild(self.viewGO, "trainEntrance/#go_episodeContent")
	self._goepisodeItem = gohelper.findChild(self.viewGO, "trainEntrance/#go_episodeContent/#go_episodeItem")
	self._btntrainClick = gohelper.findChildButtonWithAudio(self.viewGO, "trainEntrance/#btn_trainClick")
	self._gohardUnlock = gohelper.findChild(self.viewGO, "trainEntrance/#go_hardUnlock")
	self._txthardUnlockTime = gohelper.findChildText(self.viewGO, "trainEntrance/#go_hardUnlock/#txt_hardUnlockTime")
	self._gospotEntrance = gohelper.findChild(self.viewGO, "spotEntrance")
	self._gospot1 = gohelper.findChild(self.viewGO, "spotEntrance/#go_spot1")
	self._gospot2 = gohelper.findChild(self.viewGO, "spotEntrance/#go_spot2")
	self._gospot3 = gohelper.findChild(self.viewGO, "spotEntrance/#go_spot3")
	self._gospotItem = gohelper.findChild(self.viewGO, "spotEntrance/#go_spotItem")
	self._btninformation = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mainContent/#btn_information")
	self._imagecoin = gohelper.findChildImage(self.viewGO, "#go_mainContent/#btn_information/#image_coin")
	self._txtcoinNum = gohelper.findChildText(self.viewGO, "#go_mainContent/#btn_information/#txt_coinNum")
	self._goinfoReddot = gohelper.findChild(self.viewGO, "#go_mainContent/#btn_information/#go_infoReddot")
	self._goinfoNewReddot = gohelper.findChild(self.viewGO, "#go_mainContent/#btn_information/#go_infoNewReddot")
	self._btntalenttree = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mainContent/#btn_talenttree")
	self._gotalentReddot = gohelper.findChild(self.viewGO, "#go_mainContent/#btn_talenttree/#go_talentReddot")
	self._btnteach = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mainContent/#btn_teach")
	self._goteachNormal = gohelper.findChild(self.viewGO, "#go_mainContent/#btn_teach/#go_teachNormal")
	self._goteachFinish = gohelper.findChild(self.viewGO, "#go_mainContent/#btn_teach/#go_teachFinish")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166MainView:addEvents()
	self._btninformation:AddClickListener(self._btninformationOnClick, self)
	self._btntalenttree:AddClickListener(self._btntalenttreeOnClick, self)
	self._btnteach:AddClickListener(self._btnteachOnClick, self)
	self._btntrainClick:AddClickListener(self._btntrainOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshUI, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshInformationCoin, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, Season166Controller.instance, Season166Event.TrainViewChangeTrain, self.refreshProgressCurEffect, self)
end

function Season166MainView:removeEvents()
	self._btninformation:RemoveClickListener()
	self._btntalenttree:RemoveClickListener()
	self._btnteach:RemoveClickListener()
	self._btntrainClick:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshUI, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshInformationCoin, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.removeEventCb(self, Season166Controller.instance, Season166Event.TrainViewChangeTrain, self.refreshProgressCurEffect, self)
end

function Season166MainView:_btninformationOnClick()
	ViewMgr.instance:openView(ViewName.Season166InformationMainView, {
		actId = self.actId
	})
end

function Season166MainView:_btntalenttreeOnClick()
	ViewMgr.instance:openView(ViewName.Season166TalentView)
end

function Season166MainView:_btnteachOnClick()
	Season166Controller.instance:enterSeasonTeachView({
		actId = self.actId
	})
end

function Season166MainView:_btntrainOnClick()
	self.isTrainState = true

	self:refreshEntranceState()
	Season166Controller.instance:dispatchEvent(Season166Event.MainShowTrainList)
	self.viewContainer:getMainSceneView():playTrainAnim(true)
end

function Season166MainView:_editableInitView()
	self.baseSpotItemTab = self:getUserDataTb_()
	self.trainItemTab = self:getUserDataTb_()
	self.trainProgressTab = self:getUserDataTb_()

	for i = 1, 6 do
		self["_goEpisodePos" .. i] = gohelper.findChild(self._goepisodeContent, "#go_episodePos" .. i)
	end

	gohelper.setActive(self._gospotItem, false)
	gohelper.setActive(self._goepisodeItem, false)
	gohelper.setActive(self._goprogressItem, false)

	self.isTrainState = false
end

function Season166MainView:onUpdateParam()
	return
end

function Season166MainView:onOpen()
	self.actId = self.viewParam.actId
	self.infoCoinId = Season166Config.instance:getSeasonConstNum(self.actId, Season166Enum.InfoCostId)

	self:refreshUI()
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
	self.viewContainer:getMainSceneView():playInViewAnim(self.viewParam.jumpId)

	if self.viewParam.jumpId then
		self:processSeason166JumpParam(self.viewParam)
	end
end

function Season166MainView:initBaseSpotItem()
	local allBaseSpotCoList = Season166Config.instance:getSeasonBaseSpotCos(self.actId) or {}

	for baseId, baseSpotCo in ipairs(allBaseSpotCoList) do
		local baseSpotItem = self.baseSpotItemTab[baseId]

		if not baseSpotItem then
			baseSpotItem = {
				pos = self["_gospot" .. baseId]
			}
			baseSpotItem.go = gohelper.clone(self._gospotItem, baseSpotItem.pos, "baseSpotItem" .. baseId)
			baseSpotItem.item = MonoHelper.addNoUpdateLuaComOnceToGo(baseSpotItem.go, Season166MainBaseSpotItem, {
				actId = self.actId,
				baseId = baseId,
				config = baseSpotCo
			})
			self.baseSpotItemTab[baseId] = baseSpotItem
		end

		baseSpotItem.item:refreshUI()
		gohelper.setActive(baseSpotItem.go, true)
	end
end

function Season166MainView:initTrainEntrance()
	local allTrainCoList = Season166Config.instance:getSeasonTrainCos(self.actId)

	for trainId, trainCo in ipairs(allTrainCoList) do
		local trainItem = self.trainItemTab[trainId]

		if not trainItem then
			trainItem = {
				pos = self["_goEpisodePos" .. trainId]
			}
			trainItem.go = gohelper.clone(self._goepisodeItem, trainItem.pos, "trainItem" .. trainId)
			trainItem.item = MonoHelper.addNoUpdateLuaComOnceToGo(trainItem.go, Season166MainTrainItem, {
				actId = self.actId,
				trainId = trainId,
				config = trainCo
			})
			self.trainItemTab[trainId] = trainItem
		end

		trainItem.item:refreshUI()
		gohelper.setActive(trainItem.go, true)
	end

	self.viewContainer:getMainSceneView():setTrainItemTab(self.trainItemTab)
	self.viewContainer:getMainSceneView():refreshTrainEntranceNew()
end

function Season166MainView:initTrainProgress()
	local trainCoList = Season166Config.instance:getSeasonTrainCos(self.actId)

	for i = 1, #trainCoList do
		local progressItem = self.trainProgressTab[i]

		if not progressItem then
			progressItem = {
				go = gohelper.clone(self._goprogressItem, self._goprogress, "progressItem" .. i)
			}
			progressItem.light = gohelper.findChild(progressItem.go, "light")
			progressItem.dark = gohelper.findChild(progressItem.go, "dark")
			progressItem.imageLight = gohelper.findChildImage(progressItem.go, "light")
			progressItem.imageDark = gohelper.findChildImage(progressItem.go, "dark")
			progressItem.goCurEffect = gohelper.findChild(progressItem.go, "go_curEffect")
			progressItem.config = trainCoList[i]
			self.trainProgressTab[i] = progressItem

			gohelper.setActive(progressItem.goCurEffect, false)
		end

		gohelper.setActive(progressItem.go, true)
	end
end

function Season166MainView:refreshUI()
	self:initBaseSpotItem()
	self:initTrainEntrance()
	self:initTrainProgress()
	self:refreshEntranceState()
	self:refreshRemainTime()
	self:refreshTrainProgress()
	self:refreshInformation()
	self:refreshInfoReddot()
	self:refreshTalentReddot()

	self._txttotalStarCount.text = Season166BaseSpotModel.instance:getCurTotalStarCount(self.actId)

	local isAllTeachFinish = Season166TeachModel.instance:checkIsAllTeachFinish(self.actId)

	gohelper.setActive(self._goteachFinish, isAllTeachFinish)
end

function Season166MainView:refreshEntranceState()
	self.viewContainer:getMainSceneView():playTrainEpisodeAnim(self.isTrainState)
	gohelper.setActive(self._btntrainClick.gameObject, not self.isTrainState)

	local isOpenTime, remainTime = Season166TrainModel.instance:isHardEpisodeUnlockTime(self.actId)

	gohelper.setActive(self._gohardUnlock, self.isTrainState and not isOpenTime and remainTime > 0)

	self._txthardUnlockTime.text = not isOpenTime and GameUtil.getSubPlaceholderLuaLang(luaLang("season166_unlockHardEpisodeTime"), {
		remainTime
	}) or ""

	self.viewContainer:setHelpBtnShowState(self.isTrainState)
	self:setCloseOverrideFunc()
	self.viewContainer:getMainSceneView():setTrainLevelBg()
end

function Season166MainView:setCloseOverrideFunc()
	if self.isTrainState then
		self.isTrainState = false

		self.viewContainer:setOverrideCloseClick(self.setTrainClose, self)
	else
		self.viewContainer:setOverrideCloseClick(self.closeThis, self)
	end
end

function Season166MainView:setTrainClose()
	self:refreshEntranceState()
	self.viewContainer:getMainSceneView():cleanJumpData()
	self.viewContainer:getMainSceneView():playTrainAnim(false)
end

function Season166MainView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)

	if not actInfoMo then
		self._txtremainTime.text = ""

		return
	end

	local endTime, offsetSecond = Season166Controller.instance:getSeasonEnterCloseTimeStamp(self.actId)

	if offsetSecond > 0 then
		self._txtremainTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	else
		self._txtremainTime.text = luaLang("ended")

		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
	end
end

function Season166MainView:refreshTrainProgress()
	local passCount = Season166TrainModel.instance:getCurTrainPassCount(self.actId)

	for index, progressItem in ipairs(self.trainProgressTab) do
		local isFinish = Season166TrainModel.instance:checkIsFinish(self.actId, index)

		gohelper.setActive(progressItem.light, isFinish)
		gohelper.setActive(progressItem.dark, not isFinish)

		local lightIconName = progressItem.config.type == Season166Enum.TrainSpType and "season_main_chapterdifficulticon2" or "season_main_chaptericon2"
		local darkIconName = progressItem.config.type == Season166Enum.TrainSpType and "season_main_chapterdifficulticon1" or "season_main_chaptericon1"

		UISpriteSetMgr.instance:setSeason166Sprite(progressItem.imageLight, lightIconName, true)
		UISpriteSetMgr.instance:setSeason166Sprite(progressItem.imageDark, darkIconName, true)
	end
end

function Season166MainView:refreshProgressCurEffect(trainId)
	for index, progressItem in ipairs(self.trainProgressTab) do
		gohelper.setActive(progressItem.goCurEffect, index == trainId)

		if index == trainId then
			transformhelper.setLocalScale(progressItem.light.transform, 1.3, 1.3, 1.3)
			transformhelper.setLocalScale(progressItem.dark.transform, 1.3, 1.3, 1.3)
		else
			transformhelper.setLocalScale(progressItem.light.transform, 1, 1, 1)
			transformhelper.setLocalScale(progressItem.dark.transform, 1, 1, 1)
		end
	end
end

function Season166MainView:refreshInformation()
	local currencyCo = CurrencyConfig.instance:getCurrencyCo(self.infoCoinId)
	local currencyRes = string.format("%s_1", currencyCo and currencyCo.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecoin, currencyRes, true)
	self:refreshInformationCoin()
end

function Season166MainView:refreshInformationCoin()
	local currencyMO = CurrencyModel.instance:getCurrency(self.infoCoinId)

	self._txtcoinNum.text = GameUtil.numberDisplay(currencyMO.quantity)
end

function Season166MainView:processSeason166JumpParam(viewParam)
	if viewParam.jumpId == Season166Enum.JumpId.BaseSpotEpisode then
		self.isTrainState = false

		local baseId = viewParam.jumpParam.baseId

		self.baseSpotItemTab[baseId].item:onClickBaseSpotItem()
		self:refreshEntranceState()
	elseif viewParam.jumpId == Season166Enum.JumpId.TrainEpisode then
		self.isTrainState = true

		local trainId = viewParam.jumpParam.trainId

		self.trainItemTab[trainId].item:onClickTrainItem()
		self:refreshEntranceState()
	elseif viewParam.jumpId == Season166Enum.JumpId.MainView then
		self.isTrainState = false

		self:refreshEntranceState()
	elseif viewParam.jumpId == Season166Enum.JumpId.TrainView then
		self:_btntrainOnClick()
	elseif viewParam.jumpId == Season166Enum.JumpId.TeachView then
		Season166Controller.instance:enterSeasonTeachView({
			actId = self.actId
		})
	end
end

function Season166MainView:_onCloseViewFinish(viewName)
	if viewName == ViewName.Season166InformationMainView then
		self:refreshInfoReddot()
	end

	if viewName == ViewName.Season166TalentView then
		self:refreshTalentReddot()
	end
end

function Season166MainView:refreshInfoReddot()
	RedDotController.instance:addRedDot(self._goinfoReddot, RedDotEnum.DotNode.Season166InformationEnter, nil, self.checkInfoReddotShow, self)
end

function Season166MainView:checkInfoReddotShow(redDotIcon)
	redDotIcon:defaultRefreshDot()

	local canShowNew = Season166Model.instance:checkHasNewUnlockInfo()

	if canShowNew then
		gohelper.setActive(self._goinfoNewReddot, true)
		gohelper.setActive(self._goinfoReddot, false)
	else
		gohelper.setActive(self._goinfoNewReddot, false)
		gohelper.setActive(self._goinfoReddot, true)
		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function Season166MainView:refreshTalentReddot()
	gohelper.setActive(self._gotalentReddot, Season166Model.instance:checkAllHasNewTalent(self.actId))
end

function Season166MainView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function Season166MainView:onDestroyView()
	return
end

return Season166MainView
