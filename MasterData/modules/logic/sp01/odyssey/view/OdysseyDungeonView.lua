-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonView.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonView", package.seeall)

local OdysseyDungeonView = class("OdysseyDungeonView", BaseView)

function OdysseyDungeonView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._btnInteractClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_interactClose")
	self._gomapName = gohelper.findChild(self.viewGO, "root/#go_mapName")
	self._txtmapName = gohelper.findChildText(self.viewGO, "root/#go_mapName/#txt_mapName")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_task")
	self._gotaskContent = gohelper.findChild(self.viewGO, "root/#scroll_task/Viewport/#go_taskContent")
	self._gotaskItem = gohelper.findChild(self.viewGO, "root/#scroll_task/Viewport/#go_taskContent/#go_taskItem")
	self._golevel = gohelper.findChild(self.viewGO, "root/right/#go_level")
	self._gotask = gohelper.findChild(self.viewGO, "root/right/#go_task")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_task/#btn_task")
	self._gotaskReddot = gohelper.findChild(self.viewGO, "root/right/#go_task/#go_taskReddot")
	self._gobottom = gohelper.findChild(self.viewGO, "root/#go_bottom")
	self._btnmyth = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/btnContent/#btn_myth")
	self._btnreligion = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/btnContent/#btn_religion")
	self._btnbackpack = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/btnContent/#btn_backpack")
	self._btnherogroup = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/btnContent/#btn_herogroup")
	self._btndatabase = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/btnContent/#btn_database")
	self._btnshowhide = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_bottom/#btn_showhide")
	self._gomercenary = gohelper.findChild(self.viewGO, "root/#go_mercenary")
	self._imageprogressBar = gohelper.findChildImage(self.viewGO, "root/#go_mercenary/#image_progressBar")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "root/#go_mercenary/#image_progressBar/#image_progress")
	self._gomercenaryContent = gohelper.findChild(self.viewGO, "root/#go_mercenary/#image_progressBar/#go_mercenaryContent")
	self._gomercenaryItem = gohelper.findChild(self.viewGO, "root/#go_mercenary/#image_progressBar/#go_mercenaryContent/#go_mercenaryItem")
	self._btnmercenaryJump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_mercenary/#btn_mercenaryJump")
	self._btnmercenaryTip = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_mercenary/#btn_mercenaryTip")
	self._gomercenaryTip = gohelper.findChild(self.viewGO, "root/#go_mercenary/#go_mercenaryTip")
	self._txtnextTime = gohelper.findChildText(self.viewGO, "root/#go_mercenary/#go_mercenaryTip/bg/#txt_nextTime")
	self._txttotalTime = gohelper.findChildText(self.viewGO, "root/#go_mercenary/#go_mercenaryTip/bg/#txt_totalTime")
	self._btncloseMercenaryTip = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_mercenary/#go_mercenaryTip/#btn_closeMercenaryTip")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._btnMapSelect = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_mapSelect/#btn_mapSelect")
	self._goarrow = gohelper.findChild(self.viewGO, "root/#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyDungeonView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnmyth:AddClickListener(self._btnmythOnClick, self)
	self._btnreligion:AddClickListener(self._btnreligionOnClick, self)
	self._btnbackpack:AddClickListener(self._btnbackpackOnClick, self)
	self._btnherogroup:AddClickListener(self._btnherogroupOnClick, self)
	self._btndatabase:AddClickListener(self._btndatabaseOnClick, self)
	self._btnshowhide:AddClickListener(self._btnshowhideOnClick, self)
	self._btnmercenaryTip:AddClickListener(self._btnmercenaryTipOnClick, self)
	self._btnmercenaryJump:AddClickListener(self._btnmercenaryJumpOnClick, self)
	self._btncloseMercenaryTip:AddClickListener(self._btncloseMercenaryTipOnClick, self)
	self._btnMainTask:AddClickListener(self._btnmainTaskOnClick, self)
	self._btnMapSelect:AddClickListener(self._btnmapSelectOnClick, self)
	self._btnInteractClose:AddClickListener(self._btnInteractCloseOnClick, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementPush, self.onUpdateElementPush, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnRewardGet, self.refreshBottomBtnShow, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnMapSelectItemEnter, self.refreshUI, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.DailyRefresh, self.refreshUI, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnRewardGet, self.popupRewardView, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self.refreshMapSelectUI, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnMapUpdate, self.refreshMapSelectUI, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.SetDungeonUIShowState, self.setInteractEleUIShowState, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonRightUI, self.showRightUI, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnRefreshReddot, self.refreshReddot, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnRefreshReddot, self.checkAndAutoExposeReligion, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateLibraryReddot, self.refreshReddot, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonBagGetEffect, self.showDungeonBagGetEffect, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonTalentGetEffect, self.showDungeonTalentGetEffect, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowInteractCloseBtn, self.showInteractCloseBtn, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.PlaySubTaskFinishEffect, self.playFinishSubTaskItemEffect, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.PlaySubTaskShowEffect, self.playSubTaskItemShowEffect, self)
end

function OdysseyDungeonView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnmyth:RemoveClickListener()
	self._btnreligion:RemoveClickListener()
	self._btnbackpack:RemoveClickListener()
	self._btnherogroup:RemoveClickListener()
	self._btndatabase:RemoveClickListener()
	self._btnshowhide:RemoveClickListener()
	self._btnmercenaryTip:RemoveClickListener()
	self._btnmercenaryJump:RemoveClickListener()
	self._btncloseMercenaryTip:RemoveClickListener()
	self._btnMainTask:RemoveClickListener()
	self._btnMapSelect:RemoveClickListener()
	self._btnInteractClose:RemoveClickListener()
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementPush, self.onUpdateElementPush, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnRewardGet, self.refreshBottomBtnShow, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnMapSelectItemEnter, self.refreshUI, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.DailyRefresh, self.refreshUI, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnRewardGet, self.popupRewardView, self)
	self.removeEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self.refreshMapSelectUI, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnMapUpdate, self.refreshMapSelectUI, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.SetDungeonUIShowState, self.setInteractEleUIShowState, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonRightUI, self.showRightUI, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnRefreshReddot, self.refreshReddot, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnRefreshReddot, self.checkAndAutoExposeReligion, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.UpdateLibraryReddot, self.refreshReddot, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonBagGetEffect, self.showDungeonBagGetEffect, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowDungeonTalentGetEffect, self.showDungeonTalentGetEffect, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowInteractCloseBtn, self.showInteractCloseBtn, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.PlaySubTaskFinishEffect, self.playFinishSubTaskItemEffect, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.PlaySubTaskShowEffect, self.playSubTaskItemShowEffect, self)
end

function OdysseyDungeonView:_btnmercenaryJumpOnClick()
	self.curMapId = OdysseyDungeonModel.instance:getCurMapId()

	local isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()

	if self.curMercenaryCount == 0 or isInMapSelectState then
		return
	end

	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnmercenaryJumpOnClick")

	local mapMercenaryEleMoList = OdysseyDungeonModel.instance:getMercenaryElementsByMap(self.curMapId)

	if #mapMercenaryEleMoList == 0 then
		if not isInMapSelectState then
			self:_btnmapSelectOnClick()
		end
	else
		local elementId = mapMercenaryEleMoList[1].config.id

		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, elementId)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, elementId, OdysseyEnum.ElementAnimName.Tips)
	end
end

function OdysseyDungeonView:_btnmercenaryTipOnClick()
	gohelper.setActive(self._gomercenaryTip, true)
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnmercenaryTipOnClick")
end

function OdysseyDungeonView:_btncloseMercenaryTipOnClick()
	gohelper.setActive(self._gomercenaryTip, false)
end

function OdysseyDungeonView:_btnmapSelectOnClick()
	self:setChangeMapUIState(false)
	OdysseyDungeonModel.instance:setIsMapSelect(true)
	gohelper.setActive(self._gomapName, false)

	local sceneView = self.viewContainer:getDungeonSceneView()

	sceneView:refreshMapSelectView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnmapSelectOnClick")
end

function OdysseyDungeonView:_btntaskOnClick()
	OdysseyController.instance:openTaskView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btntaskOnClick")
end

function OdysseyDungeonView:_btnmythOnClick()
	self:_btnInteractCloseOnClick()
	OdysseyDungeonController.instance:openMythView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnmythOnClick")
end

function OdysseyDungeonView:_btnreligionOnClick()
	self:_btnInteractCloseOnClick()
	OdysseyDungeonController.instance:openMembersView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnreligionOnClick")
end

function OdysseyDungeonView:_btnbackpackOnClick()
	self:_btnInteractCloseOnClick()
	OdysseyController.instance:openBagView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnbackpackOnClick")
end

function OdysseyDungeonView:_btnherogroupOnClick()
	self:_btnInteractCloseOnClick()
	OdysseyController.instance:openHeroGroupView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnherogroupOnClick")
end

function OdysseyDungeonView:_btndatabaseOnClick()
	self:_btnInteractCloseOnClick()
	OdysseyController.instance:openLibraryView(AssassinEnum.LibraryType.Hero)
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btndatabaseOnClick")
end

function OdysseyDungeonView:_btnshowhideOnClick()
	self:_btnInteractCloseOnClick()

	if self.isShowBtnContent then
		self._animBottom:Play("close", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_list_fold)
	else
		self._animBottom:Play("open", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_list_unfold)
	end

	self.isShowBtnContent = not self.isShowBtnContent

	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnshowhideOnClick#" .. tostring(self.isShowBtnContent))
end

function OdysseyDungeonView:_btnmainTaskOnClick()
	local curMainMapCo, curMainElementCo = OdysseyDungeonModel.instance:getCurMainElement()

	self.curMapId = OdysseyDungeonModel.instance:getCurMapId()

	if curMainElementCo then
		if curMainElementCo.mapId == self.curMapId then
			OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, curMainElementCo.id)
			OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, curMainElementCo.id, OdysseyEnum.ElementAnimName.Tips)
		else
			local isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()

			OdysseyDungeonModel.instance:setNeedFocusMainMapSelectItem(true)

			if not isInMapSelectState then
				self:_btnmapSelectOnClick()
			else
				local mapSelectView = self.viewContainer:getDungeonMapSelectView()

				if mapSelectView then
					mapSelectView:onFocusMainMapSelectItem(true)
				end
			end
		end

		OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnmainTaskOnClick#" .. curMainElementCo.id)
	else
		GameFacade.showToast(ToastEnum.OdysseyElementLock)
	end
end

function OdysseyDungeonView:onSubTaskItemClick(subTaskItem)
	self.curMapId = OdysseyDungeonModel.instance:getCurMapId()

	if subTaskItem and subTaskItem.elementMo and subTaskItem.elementMo.config and subTaskItem.elementMo.config.mapId == self.curMapId then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, subTaskItem.elementMo.config.id)
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, subTaskItem.elementMo.config.id, OdysseyEnum.ElementAnimName.Tips)
		OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("onSubTaskItemClick#" .. subTaskItem.elementMo.config.id)
	end
end

function OdysseyDungeonView:_btnInteractCloseOnClick()
	ViewMgr.instance:closeView(ViewName.OdysseyDungeonInteractView)
end

function OdysseyDungeonView:_editableInitView()
	self._goRight = gohelper.findChild(self.viewGO, "root/right")
	self._goMainTaskItem = gohelper.findChild(self._gotaskItem, "go_main")
	self._goSubTaskItemContent = gohelper.findChild(self._gotaskItem, "go_sub")
	self._txtTaskName = gohelper.findChildText(self._gotaskItem, "go_main/taskName/txt_taskName")
	self._btnMainTask = gohelper.findChildButtonWithAudio(self._gotaskItem, "go_main")
	self._txtTaskDesc = gohelper.findChildText(self._gotaskItem, "go_main/taskDesc/txt_taskDesc")
	self._goSubTaskItem = gohelper.findChild(self._gotaskItem, "go_sub/go_subTaskItem")
	self._goshowhideIcon = gohelper.findChild(self.viewGO, "root/#go_bottom/#btn_showhide/icon")
	self._gobtnContent = gohelper.findChild(self.viewGO, "root/#go_bottom/btnContent")
	self._gomythReddot = gohelper.findChild(self._btnmyth.gameObject, "go_reddot")
	self._goreligionReddot = gohelper.findChild(self._btnreligion.gameObject, "go_reddot")
	self._gobackpackReddot = gohelper.findChild(self._btnbackpack.gameObject, "go_reddot")
	self._goherogroupReddot = gohelper.findChild(self._btnherogroup.gameObject, "go_reddot")
	self._godatabaseReddot = gohelper.findChild(self._btndatabase.gameObject, "go_reddot")
	self._goMapSelectReddot = gohelper.findChild(self._btnMapSelect.gameObject, "go_reddot")
	self._animBottom = self._gobottom:GetComponent(gohelper.Type_Animator)
	self._gobackpackEffect = gohelper.findChild(self._btnbackpack.gameObject, "#effect_get")
	self._goherogroupEffect = gohelper.findChild(self._btnherogroup.gameObject, "#effect_get")

	gohelper.setActive(self._goSubTaskItem, false)
	gohelper.setActive(self._gomercenaryItem, false)
	gohelper.setActive(self._gomercenaryTip, false)
	gohelper.setActive(self._goRight, true)
	gohelper.setActive(self._btnInteractClose.gameObject, false)

	self.isShowBtnContent = true
	self.mercenaryItemMap = self:getUserDataTb_()
	self.hasExposeReligionMap = self:getUserDataTb_()
	self.subTaskItemMap = self:getUserDataTb_()
	self.subTaskShowEffectMap = self:getUserDataTb_()

	OdysseyTaskModel.instance:setTaskInfoList()
	AssassinController.instance:dispatchEvent(AssassinEvent.EnableLibraryToast, false)
end

function OdysseyDungeonView:onUpdateParam()
	return
end

function OdysseyDungeonView:onOpen()
	OdysseyStatHelper.instance:initDungeonStartTime()
	RedDotController.instance:addRedDot(self._gotaskReddot, RedDotEnum.DotNode.OdysseyTask)
	self._animBottom:Play("idle", 0, 0)
	self:initConstData()
	self:refreshUI()
	self:refreshReddot()
	self:refreshBottomBtnShow()
	self:checkAndAutoExposeReligion()
end

OdysseyDungeonView.MercenaryBarWidth = 442
OdysseyDungeonView.MercenaryBarFirstWidth = 63
OdysseyDungeonView.MercenaryBarItemSpace = 83

function OdysseyDungeonView:initConstData()
	local maxCountconstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MercenaryLimitedNum)

	self.mercenaryMaxCount = tonumber(maxCountconstCo.value)

	local recoverConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MercenaryRecoverSpeed)

	self.recoverTimeStamp = tonumber(recoverConstCo.value) * TimeUtil.OneHourSecond
	self.mercenaryUnlockCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MercenaryUnlock)
	self.levelGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[3], self._golevel)
	self.levelComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.levelGO, OdysseyDungeonLevelComp)
end

function OdysseyDungeonView:refreshUI()
	self:refreshMapUI()
	self:refreshMercenaryUI()
	self:refreshTaskUI()
	self:createAndRefreshSubTaskItem()
	self:refreshMapSelectUI()
end

function OdysseyDungeonView:refreshMapUI()
	self.curMapId = OdysseyDungeonModel.instance:getCurMapId()
	self.mapConfig = OdysseyConfig.instance:getDungeonMapConfig(self.curMapId)
	self._txtmapName.text = self.mapConfig.mapName

	self.levelComp:refreshUI()
end

function OdysseyDungeonView:refreshMercenaryUI()
	self.isMercenaryUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(self.mercenaryUnlockCo.value)

	if not self.isMercenaryUnlock then
		gohelper.setActive(self._gomercenary, false)

		return
	end

	gohelper.setActive(self._gomercenary, true)

	self.curMercenaryEleMoList = OdysseyDungeonModel.instance:getCurMercenaryElements()
	self.curMercenaryCount = #self.curMercenaryEleMoList

	for index = 1, self.mercenaryMaxCount do
		local mercenaryItem = self.mercenaryItemMap[index]

		if not mercenaryItem then
			mercenaryItem = {
				go = gohelper.clone(self._gomercenaryItem, self._gomercenaryContent, "mercenaryItem" .. index)
			}
			mercenaryItem.goEmpty = gohelper.findChild(mercenaryItem.go, "go_empty")
			mercenaryItem.goHas = gohelper.findChild(mercenaryItem.go, "go_has")
			self.mercenaryItemMap[index] = mercenaryItem
		end

		gohelper.setActive(mercenaryItem.go, true)
		gohelper.setActive(mercenaryItem.goEmpty, index > self.curMercenaryCount)
		gohelper.setActive(mercenaryItem.goHas, index <= self.curMercenaryCount)
	end

	self:refreshMercenaryBar()

	if self.curMercenaryCount < self.mercenaryMaxCount then
		TaskDispatcher.cancelTask(self.refreshMercenaryBar, self)
		TaskDispatcher.runRepeat(self.refreshMercenaryBar, self, 1)
	end
end

function OdysseyDungeonView:refreshMercenaryBar()
	local remainTimeStamp = OdysseyModel.instance:getRemainMercenaryRefreshTime()
	local nextRefreshTime = OdysseyModel.instance:getMercenaryNextRefreshTime()

	if nextRefreshTime > 0 and remainTimeStamp <= 0 and self.curMercenaryCount < self.mercenaryMaxCount then
		OdysseyRpc.instance:sendOdysseyFightMercenaryRefreshRequest()
	end

	local barProcessRate = (self.recoverTimeStamp - remainTimeStamp) / self.recoverTimeStamp
	local barWidth = 0

	if self.curMercenaryCount == 0 then
		barWidth = OdysseyDungeonView.MercenaryBarFirstWidth * barProcessRate
	elseif self.curMercenaryCount > 0 and self.curMercenaryCount < self.mercenaryMaxCount then
		barWidth = OdysseyDungeonView.MercenaryBarFirstWidth + (self.curMercenaryCount - 1) * OdysseyDungeonView.MercenaryBarItemSpace + OdysseyDungeonView.MercenaryBarItemSpace * barProcessRate
	elseif self.curMercenaryCount >= self.mercenaryMaxCount then
		barWidth = OdysseyDungeonView.MercenaryBarWidth
	end

	recthelper.setWidth(self._imageprogress.transform, barWidth)

	if self.mercenaryMaxCount <= self.curMercenaryCount then
		TaskDispatcher.cancelTask(self.refreshMercenaryBar, self)

		self._txtnextTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_dungeon_mercenary_nexttime"), "--:--:--")
		self._txttotalTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_dungeon_mercenary_totaltime"), "--:--:--")
	else
		local totalRecoverTimeStamp = Mathf.Max(self.mercenaryMaxCount - self.curMercenaryCount - 1, 0) * self.recoverTimeStamp + remainTimeStamp

		self._txtnextTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_dungeon_mercenary_nexttime"), TimeUtil.second2TimeString(remainTimeStamp, true))
		self._txttotalTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_dungeon_mercenary_totaltime"), TimeUtil.second2TimeString(totalRecoverTimeStamp, true))
	end
end

function OdysseyDungeonView:refreshTaskUI()
	local curMainMapCo, curMainElementCo = OdysseyDungeonModel.instance:getCurMainElement()

	if curMainElementCo then
		local mainTaskConfig = OdysseyConfig.instance:getMainTaskConfig(curMainElementCo.id)

		if mainTaskConfig then
			self._txtTaskName.text = mainTaskConfig.taskTitle
			self._txtTaskDesc.text = curMainElementCo.taskDesc

			gohelper.setActive(self._goMainTaskItem, true)
		else
			gohelper.setActive(self._goMainTaskItem, false)
		end
	else
		gohelper.setActive(self._goMainTaskItem, false)
	end
end

function OdysseyDungeonView:createAndRefreshSubTaskItem()
	local isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()

	if isInMapSelectState then
		return
	end

	local allSubTaskMoList = {}

	self.curMapId = OdysseyDungeonModel.instance:getCurMapId()

	local conquerEleMoList = OdysseyDungeonModel.instance:getMapNotFinishFightElementMoList(self.curMapId, OdysseyEnum.FightType.Conquer)

	if #conquerEleMoList > 0 then
		tabletool.addValues(allSubTaskMoList, conquerEleMoList)
	end

	local mythEleMoList = OdysseyDungeonModel.instance:getMapNotFinishFightElementMoList(self.curMapId, OdysseyEnum.FightType.Myth)

	if #mythEleMoList > 0 then
		tabletool.addValues(allSubTaskMoList, mythEleMoList)
	end

	local religionEleMoList = OdysseyDungeonModel.instance:getMapNotFinishFightElementMoList(self.curMapId, OdysseyEnum.FightType.Religion)

	if #religionEleMoList > 0 then
		tabletool.addValues(allSubTaskMoList, religionEleMoList)
	end

	local lastEleFightParam = OdysseyDungeonModel.instance:getLastElementFightParam()

	if lastEleFightParam and lastEleFightParam.lastElementId > 0 then
		local lastFightElementMo = OdysseyDungeonModel.instance:getElementMo(lastEleFightParam.lastElementId)
		local lastFightElementConfig = OdysseyConfig.instance:getElementFightConfig(lastEleFightParam.lastElementId)
		local isFinish = OdysseyDungeonModel.instance:isElementFinish(lastEleFightParam.lastElementId)

		if isFinish and lastFightElementMo and lastFightElementConfig and (lastFightElementConfig.type == OdysseyEnum.FightType.Conquer or lastFightElementConfig.type == OdysseyEnum.FightType.Myth or lastFightElementConfig.type == OdysseyEnum.FightType.Religion) then
			table.insert(allSubTaskMoList, lastFightElementMo)
		end
	end

	for index, elementMo in ipairs(allSubTaskMoList) do
		local subTaskItem = self.subTaskItemMap[index]

		if not subTaskItem then
			subTaskItem = {
				go = gohelper.clone(self._goSubTaskItem, self._goSubTaskItemContent, "rewardItem_" .. index)
			}
			subTaskItem.anim = subTaskItem.go:GetComponent(typeof(UnityEngine.Animator))
			subTaskItem.imageIcon = gohelper.findChildImage(subTaskItem.go, "bg/#image_icon")
			subTaskItem.txtTaskDesc = gohelper.findChildText(subTaskItem.go, "txt_taskDesc")
			subTaskItem.btnClick = gohelper.findChildButton(subTaskItem.go, "btn_click")

			subTaskItem.btnClick:AddClickListener(self.onSubTaskItemClick, self, subTaskItem)

			subTaskItem.finishEffect = gohelper.findChildImage(subTaskItem.go, "bg/bg_glow")
			subTaskItem.finishMaterial = subTaskItem.finishEffect.material
			subTaskItem.finishEffect.material = UnityEngine.Object.Instantiate(subTaskItem.finishMaterial)
			subTaskItem.materialPropsCtrl = subTaskItem.go:GetComponent(typeof(ZProj.MaterialPropsCtrl))

			subTaskItem.materialPropsCtrl.mas:Clear()
			subTaskItem.materialPropsCtrl.mas:Add(subTaskItem.finishEffect.material)

			self.subTaskItemMap[index] = subTaskItem
		end

		gohelper.setActive(subTaskItem.go, true)

		if not subTaskItem.elementMo or subTaskItem.elementMo.id ~= elementMo.id then
			gohelper.setActive(subTaskItem.go, false)

			self.subTaskShowEffectMap[elementMo.id] = subTaskItem
		else
			subTaskItem.anim:Play("idle", 0, 0)
		end

		subTaskItem.anim:Update(0)

		subTaskItem.elementMo = elementMo
		subTaskItem.fightElementConfig = OdysseyConfig.instance:getElementFightConfig(elementMo.id)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(subTaskItem.imageIcon, elementMo.config.icon)

		subTaskItem.txtTaskDesc.text = subTaskItem.fightElementConfig.title
	end

	for index = #allSubTaskMoList + 1, #self.subTaskItemMap do
		local subTaskItem = self.subTaskItemMap[index]

		if subTaskItem then
			gohelper.setActive(subTaskItem.go, false)
			subTaskItem.btnClick:RemoveClickListener()

			subTaskItem = nil
			self.subTaskItemMap[index] = nil
		end
	end
end

function OdysseyDungeonView:playSubTaskItemShowEffect()
	for elementId, subTaskItem in pairs(self.subTaskShowEffectMap) do
		if subTaskItem then
			gohelper.setActive(subTaskItem.go, true)
			subTaskItem.anim:Play("open", 0, 0)
			subTaskItem.anim:Update(0)
		end
	end

	if next(self.subTaskShowEffectMap) then
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_main_quest)
	end
end

function OdysseyDungeonView:playFinishSubTaskItemEffect()
	for index, subTaskItem in ipairs(self.subTaskItemMap) do
		if subTaskItem then
			local isFinish = OdysseyDungeonModel.instance:isElementFinish(subTaskItem.elementMo.id)

			if isFinish then
				subTaskItem.anim:Play("finish", 0, 0)
				subTaskItem.anim:Update(0)
			end
		end
	end

	TaskDispatcher.cancelTask(self.cleanFinishSubTaskItem, self)
	TaskDispatcher.runDelay(self.cleanFinishSubTaskItem, self, 1)
end

function OdysseyDungeonView:cleanFinishSubTaskItem()
	for index = #self.subTaskItemMap, 1, -1 do
		local subTaskItem = self.subTaskItemMap[index]

		if subTaskItem then
			local isFinish = OdysseyDungeonModel.instance:isElementFinish(subTaskItem.elementMo.id)

			if isFinish then
				gohelper.setActive(subTaskItem.go, false)
				subTaskItem.btnClick:RemoveClickListener()

				subTaskItem = nil
				self.subTaskItemMap[index] = nil
			end
		end
	end

	self.subTaskShowEffectMap = self:getUserDataTb_()
end

function OdysseyDungeonView:refreshMapSelectUI()
	local mapInfoList = OdysseyDungeonModel.instance:getMapInfoList()

	gohelper.setActive(self._btnMapSelect.gameObject, #mapInfoList > 1)

	if HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.OdysseyDungeon) then
		recthelper.setAnchorX(self._btnMapSelect.gameObject.transform, 0)
	else
		recthelper.setAnchorX(self._btnMapSelect.gameObject.transform, -150)
	end
end

function OdysseyDungeonView:setChangeMapUIState(showState)
	gohelper.setActive(self._gobottom, showState)
	gohelper.setActive(self._goarrow, showState)
	gohelper.setActive(self._btnMapSelect.gameObject, showState)
	gohelper.setActive(self._goSubTaskItemContent, showState)
end

function OdysseyDungeonView:showRightUI(showState)
	gohelper.setActive(self._goRight, showState)
	self.levelComp:setShowState(showState)
end

function OdysseyDungeonView:setInteractEleUIShowState(uiSideType, showState)
	self.isMercenaryUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(self.mercenaryUnlockCo.value)

	if uiSideType == OdysseyEnum.DungeonUISideType.Bottom then
		gohelper.setActive(self._gobottom, showState)
		gohelper.setActive(self._gomercenary, showState and self.isMercenaryUnlock)
	elseif uiSideType == OdysseyEnum.DungeonUISideType.Right then
		gohelper.setActive(self._goRight, showState)
		gohelper.setActive(self._gomercenary, showState and self.isMercenaryUnlock)
	end
end

function OdysseyDungeonView:popupRewardView()
	OdysseyDungeonController.instance:popupRewardView()
end

function OdysseyDungeonView:showDungeonBagGetEffect()
	gohelper.setActive(self._gobackpackEffect, false)
	gohelper.setActive(self._gobackpackEffect, true)
end

function OdysseyDungeonView:showDungeonTalentGetEffect()
	gohelper.setActive(self._goherogroupEffect, false)
	gohelper.setActive(self._goherogroupEffect, true)
end

function OdysseyDungeonView:refreshReddot()
	local canShowReligionReddot = OdysseyMembersModel.instance:checkCanShowNewDot()

	gohelper.setActive(self._goreligionReddot, canShowReligionReddot)

	local isHasNotUseTalentPoint = OdysseyTalentModel.instance:checkHasNotUsedTalentPoint()

	gohelper.setActive(self._goherogroupReddot, isHasNotUseTalentPoint)

	local isHasNewUnlockMyth = OdysseyDungeonModel.instance:checkHasNewUnlock(OdysseyEnum.LocalSaveKey.MythNew, OdysseyDungeonModel.instance:getCurUnlockMythIdList())

	gohelper.setActive(self._gomythReddot, isHasNewUnlockMyth)

	local checkIsItemNewFlag = OdysseyItemModel.instance:checkIsItemNewFlag()

	gohelper.setActive(self._gobackpackReddot, checkIsItemNewFlag)

	local canShowDatabaseReddot = AssassinLibraryModel.instance:isAnyLibraryNewUnlock()

	gohelper.setActive(self._godatabaseReddot, canShowDatabaseReddot)

	local isHasNewUnlockMap = OdysseyDungeonModel.instance:checkHasNewUnlock(OdysseyEnum.LocalSaveKey.MapNew, OdysseyDungeonModel.instance:getCurUnlockMapIdList())

	gohelper.setActive(self._goMapSelectReddot, isHasNewUnlockMap)
end

function OdysseyDungeonView:refreshBottomBtnShow()
	local religionConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.ReligionUnlock)
	local canReligionUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(religionConstCo.value)

	gohelper.setActive(self._btnreligion.gameObject, canReligionUnlock)

	local itemMoList = OdysseyItemModel.instance:getItemMoList()
	local canBackPackUnlock = #itemMoList > 0

	gohelper.setActive(self._btnbackpack.gameObject, canBackPackUnlock)

	local canMythUnlock = OdysseyDungeonModel.instance:checkHasFightTypeElement(OdysseyEnum.FightType.Myth)

	gohelper.setActive(self._btnmyth.gameObject, canMythUnlock)
	gohelper.setActive(self._btnshowhide.gameObject, canReligionUnlock and canBackPackUnlock and canMythUnlock or false)
end

function OdysseyDungeonView:onUpdateElementPush()
	self:refreshMercenaryUI()
	self:refreshBottomBtnShow()
	self:refreshTaskUI()
	self:createAndRefreshSubTaskItem()
	self:playSubTaskItemShowEffect()
end

function OdysseyDungeonView:showInteractCloseBtn(showState)
	gohelper.setActive(self._btnInteractClose.gameObject, showState)
end

function OdysseyDungeonView:checkAndAutoExposeReligion()
	local religionConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.ReligionUnlock)
	local canReligionUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(religionConstCo.value)

	if not canReligionUnlock then
		return
	end

	local canAutoExposeList = OdysseyDungeonModel.instance:getCanAutoExposeReligionCoList()

	for index, religionCo in ipairs(canAutoExposeList) do
		local canExpose = OdysseyMembersModel.instance:checkReligionMemberCanExpose(religionCo.id)

		if canExpose and not self.hasExposeReligionMap[religionCo.id] then
			OdysseyRpc.instance:sendOdysseyFightReligionDiscloseRequest(religionCo.id)

			self.hasExposeReligionMap[religionCo.id] = true
		end
	end
end

function OdysseyDungeonView:_onCloseViewFinish(viewName)
	if viewName == ViewName.OdysseyDungeonRewardView then
		gohelper.setActive(self._gobackpackEffect, false)
		gohelper.setActive(self._goherogroupEffect, false)
	end
end

function OdysseyDungeonView:onClose()
	TaskDispatcher.cancelTask(self.refreshMercenaryBar, self)
	TaskDispatcher.cancelTask(self.cleanFinishSubTaskItem, self)

	local curHeroInMapId = OdysseyDungeonModel.instance:getHeroInMapId()

	OdysseyDungeonModel.instance:setCurMapId(curHeroInMapId)
	OdysseyDungeonModel.instance:setIsMapSelect(false)
	OdysseyDungeonModel.instance:setJumpNeedOpenElement(0)
	OdysseyDungeonModel.instance:setStoryOptionParam(nil)
	OdysseyDungeonModel.instance:setNeedFocusMainMapSelectItem(false)
	ViewMgr.instance:closeView(ViewName.OdysseyDungeonMapSelectInfoView)
	self:_btnInteractCloseOnClick()
	AssassinController.instance:dispatchEvent(AssassinEvent.EnableLibraryToast, true)

	for index, subTaskItem in ipairs(self.subTaskItemMap) do
		subTaskItem.btnClick:RemoveClickListener()
	end

	OdysseyStatHelper.instance:sendOdysseyViewStayTime("OdysseyDungeonView")
end

function OdysseyDungeonView:onDestroyView()
	return
end

return OdysseyDungeonView
