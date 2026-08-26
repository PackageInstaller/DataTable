-- chunkname: @modules/logic/tower/view/permanenttower/TowerPermanentDeepView.lua

module("modules.logic.tower.view.permanenttower.TowerPermanentDeepView", package.seeall)

local TowerPermanentDeepView = class("TowerPermanentDeepView", BaseView)

function TowerPermanentDeepView:onInitView()
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_category")
	self._godeepLayer = gohelper.findChild(self.viewGO, "Left/#go_deepLayer")
	self._godeepLayerReddot = gohelper.findChild(self.viewGO, "Left/#go_deepLayer/#go_deepLayerReddot")
	self._gobossNormal = gohelper.findChild(self.viewGO, "#go_deep/#go_bossNormal")
	self._gobossEndless = gohelper.findChild(self.viewGO, "#go_deep/#go_bossEndless")
	self._txtbestDeepRecord = gohelper.findChildText(self.viewGO, "#go_deep/deepRecord/#txt_bestDeepRecord")
	self._gonormalFightBg = gohelper.findChild(self.viewGO, "#go_deep/deepFight/#go_normalFightBg")
	self._goendlessFightBg = gohelper.findChild(self.viewGO, "#go_deep/deepFight/#go_endlessFightBg")
	self._gocurDeepRecord = gohelper.findChild(self.viewGO, "#go_deep/deepFight/#go_curDeepRecord")
	self._txtcurDeepRecord = gohelper.findChildText(self.viewGO, "#go_deep/deepFight/#go_curDeepRecord/#txt_curDeepRecord")
	self._txtdeepFightName = gohelper.findChildText(self.viewGO, "#go_deep/deepFight/#txt_deepFightName")
	self._btndeepFight = gohelper.findChildButtonWithAudio(self.viewGO, "#go_deep/deepFight/#btn_deepFight")
	self._btnresetDeep = gohelper.findChildButtonWithAudio(self.viewGO, "#go_deep/deepFight/#btn_resetDeep")
	self._btndeepTask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_deep/#btn_deepTask")
	self._godeepTaskReddot = gohelper.findChild(self.viewGO, "#go_deep/#btn_deepTask/#go_deepTaskReddot")
	self._goEnterDeepGuide = gohelper.findChild(self.viewGO, "#go_EnterDeepGuide")
	self._goDeepSuccReward = gohelper.findChild(self.viewGO, "#go_DeepSuccReward")
	self._btnDeepSuccReward = gohelper.findChildButtonWithAudio(self.viewGO, "#go_DeepSuccReward/#btn_deepSuccReward")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerPermanentDeepView:addEvents()
	self._btnresetDeep:AddClickListener(self._btnresetDeepOnClick, self)
	self._btndeepTask:AddClickListener(self._btndeepTaskOnClick, self)
	self._btndeepFight:AddClickListener(self._btndeepFightOnClick, self)
	self._btnDeepSuccReward:AddClickListener(self._btnDeepSuccRewardOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnTowerDeepReset, self.refreshUI, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnSelectDeepLayer, self.checkDeepSuccRewardGet, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.refreshTaskStateAnim, self)
end

function TowerPermanentDeepView:removeEvents()
	self._btnresetDeep:RemoveClickListener()
	self._btndeepTask:RemoveClickListener()
	self._btndeepFight:RemoveClickListener()
	self._btnDeepSuccReward:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnTowerDeepReset, self.refreshUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnSelectDeepLayer, self.checkDeepSuccRewardGet, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.refreshTaskStateAnim, self)
end

function TowerPermanentDeepView:_btnresetDeepOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.TowerDeepReset, MsgBoxEnum.BoxType.Yes_No, self.sendTowerDeepResetRequest, nil, nil, self)
end

function TowerPermanentDeepView:sendTowerDeepResetRequest()
	TowerDeepRpc.instance:sendTowerDeepResetRequest()
end

function TowerPermanentDeepView:_btndeepTaskOnClick()
	TowerController.instance:openTowerDeepTaskView()
end

function TowerPermanentDeepView:_btndeepFightOnClick()
	local param = {}

	param.towerType = TowerEnum.TowerType.Normal
	param.towerId = TowerEnum.PermanentTowerId
	param.layerId = 0
	param.episodeId = self.curEpisodeId

	TowerController.instance:enterFight(param)
end

function TowerPermanentDeepView:_btnDeepSuccRewardOnClick()
	local isCanGet = TowerDeepTaskModel.instance:isTaskCanGet(self.succDeepTaskMo)

	if isCanGet then
		TaskRpc.instance:sendFinishTaskRequest(self.succDeepTaskMo.id)
	end
end

function TowerPermanentDeepView:_editableInitView()
	self.rectScrollCategory = self._scrollcategory:GetComponent(gohelper.Type_RectTransform)
	self.normalDeepEpisodeId = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.NormalDeepEpisodeId)
	self.endlessDeepEpisodeId = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.EndlessDeepEpisodeId)
	self.deepFightAnim = gohelper.findChildComponent(self.viewGO, "#go_deep/deepFight", gohelper.Type_Animation)
	self.enterDeepGuideAnim = self._goEnterDeepGuide:GetComponent(gohelper.Type_Animator)
	self.deepSuccRewardAnim = self._goDeepSuccReward:GetComponent(gohelper.Type_Animator)
	self.deepTaskAnim = gohelper.findChildComponent(self.viewGO, "#go_deep/#btn_deepTask/ani", gohelper.Type_Animator)
	self.deepRecordLineAnim = gohelper.findChildComponent(self.viewGO, "#go_deep/deepRecord/ani_line", gohelper.Type_Animation)
	self.deepRecordSwitchAnim = gohelper.findChildComponent(self.viewGO, "#go_deep/deepRecord/#ani_switch", gohelper.Type_Animation)

	gohelper.setActive(self._goEnterDeepGuide, false)
	gohelper.setActive(self._goDeepSuccReward, false)
end

function TowerPermanentDeepView:onUpdateParam()
	return
end

function TowerPermanentDeepView:onOpen()
	RedDotController.instance:addRedDot(self._godeepLayerReddot, RedDotEnum.DotNode.TowerDeepTask)
	RedDotController.instance:addRedDot(self._godeepTaskReddot, RedDotEnum.DotNode.TowerDeepTask)

	self.jumpParam = self.viewParam or {}

	self:refreshCategory()
	self:refreshUI()
	self:checkDeepSuccRewardGet()
	self:refreshTaskStateAnim()

	if not self.hasSuccReward then
		TaskDispatcher.runDelay(self.showDeepRecordChange, self, 1.5)
	end

	self.curTaskRewardHasGet = TowerDeepTaskModel.instance:isSuccRewardHasGet()
end

function TowerPermanentDeepView:refreshCategory()
	self.isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()

	recthelper.setHeight(self.rectScrollCategory, (self.isDeepLayerUnlock or nil) and (TowerEnum.PermanentUI.DeepScrollH or TowerEnum.PermanentUI.ScrollH))

	if self.jumpParam and self.jumpParam.episodeId and TowerPermanentModel.instance:isNewPassLayer() then
		gohelper.setActive(self._godeepLayer, false)
	else
		gohelper.setActive(self._godeepLayer, self.isDeepLayerUnlock)
	end
end

function TowerPermanentDeepView:refreshUI()
	self.maxDeepHigh = TowerPermanentDeepModel.instance:getLastMaxDeepHigh()
	self._txtbestDeepRecord.text = string.format("%dM", self.maxDeepHigh)
	self.isOpenEndless = TowerPermanentDeepModel.instance.isOpenEndless

	gohelper.setActive(self._gonormalFightBg, not self.isOpenEndless)
	gohelper.setActive(self._goendlessFightBg, self.isOpenEndless)
	gohelper.setActive(self._gobossNormal, not self.isOpenEndless)
	gohelper.setActive(self._gobossEndless, self.isOpenEndless)

	self.curDeepHigh = TowerPermanentDeepModel.instance:getCurDeepHigh()
	self._txtcurDeepRecord.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("TowerDeep_curDeepHigh"), self.curDeepHigh)
	self.curDeepGroupMo = TowerPermanentDeepModel.instance:getCurDeepGroupMo()

	if self.curDeepGroupMo then
		local isHasFight = self.curDeepGroupMo:checkHasTeamData()

		self._txtdeepFightName.text = self.isOpenEndless and (isHasFight and luaLang("TowerDeep_endlessFight") or luaLang("TowerDeep_endlessNotFight")) or isHasFight and luaLang("TowerDeep_normalFight") or luaLang("TowerDeep_normalNotFight")

		gohelper.setActive(self._btnresetDeep.gameObject, isHasFight)
		gohelper.setActive(self._gocurDeepRecord, isHasFight)

		if self.isOpenEndless then
			self.curEpisodeId = self.endlessDeepEpisodeId or self.normalDeepEpisodeId
		end
	end
end

function TowerPermanentDeepView:refreshTaskStateAnim()
	local allCanGetList = TowerDeepTaskModel.instance:getAllCanGetList()

	self.deepTaskAnim:Play(#allCanGetList > 0 and "loop" or "idle", 0, 0)
	self.deepTaskAnim:Update(0)
end

function TowerPermanentDeepView:showDeepRecordChange()
	local lastMaxDeepHigh = TowerPermanentDeepModel.instance:getLastMaxDeepHigh()

	self.curMaxDeepHigh = TowerPermanentDeepModel.instance:getCurMaxDeepHigh()

	if lastMaxDeepHigh == self.curMaxDeepHigh then
		return
	end

	self.deepRecordLineAnim:Play()
	self.deepRecordSwitchAnim:Play()

	self.deepRecordTweenId = ZProj.TweenHelper.DOTweenFloat(lastMaxDeepHigh, self.curMaxDeepHigh, 0.5, self.onDeepRecordFrameCallback, self.onDeepRecordTweenDone, self, nil, EaseType.Linear)

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_role_cover_open_2)
end

function TowerPermanentDeepView:onDeepRecordFrameCallback(value)
	self._txtbestDeepRecord.text = string.format("%dM", value)
end

function TowerPermanentDeepView:onDeepRecordTweenDone()
	self._txtbestDeepRecord.text = string.format("%dM", self.curMaxDeepHigh)

	if self.deepRecordTweenId then
		ZProj.TweenHelper.KillById(self.deepRecordTweenId)

		self.deepRecordTweenId = nil
	end

	TowerPermanentDeepModel.instance:setLastMaxDeepHigh()
end

function TowerPermanentDeepView:selectDeepLayer()
	self:_btndeepLayerOnClick()
end

function TowerPermanentDeepView:checkDeepSuccRewardGet()
	self.succDeepTaskMo = TowerDeepTaskModel.instance:getSuccRewardTaskMo()
	self.isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()
	self.isEnterDeepGuideFinish = TowerPermanentDeepModel.instance:checkEnterDeepLayerGuideFinish()
	self.isInDeepLayer = TowerPermanentDeepModel.instance:getIsInDeepLayerState()
	self.canShowDeep = self.isDeepLayerUnlock and self.isEnterDeepGuideFinish and self.isInDeepLayer
	self.hasSuccReward = self.succDeepTaskMo and TowerDeepTaskModel.instance:isTaskCanGet(self.succDeepTaskMo)

	if self.hasSuccReward and self.canShowDeep then
		gohelper.setActive(self._goEnterDeepGuide, true)
		gohelper.setActive(self._goDeepSuccReward, true)
		TaskDispatcher.runDelay(self.sendOnDeepSuccRewardGuide, self, 0.2)
	end
end

function TowerPermanentDeepView:sendOnDeepSuccRewardGuide()
	TowerController.instance:dispatchEvent(TowerEvent.OnEnterDeepSuccRewardGuide)
end

function TowerPermanentDeepView:_onCloseViewFinish(viewName)
	local rewardHasGet = TowerDeepTaskModel.instance:isSuccRewardHasGet()

	if rewardHasGet == self.curTaskRewardHasGet then
		return
	end

	if viewName == ViewName.CommonPropView then
		self.enterDeepGuideAnim:Play("close", 0, 0)
		self.enterDeepGuideAnim:Update(0)
		self.deepSuccRewardAnim:Play("close", 0, 0)
		self.deepSuccRewardAnim:Update(0)
		TaskDispatcher.runDelay(self.hideDeepSuccReward, self, 0.5)

		self.curTaskRewardHasGet = true
	end
end

function TowerPermanentDeepView:hideDeepSuccReward()
	gohelper.setActive(self._goEnterDeepGuide, false)
	gohelper.setActive(self._goDeepSuccReward, false)
	self:showDeepRecordChange()
	self.deepFightAnim:Play()
	TowerController.instance:dispatchEvent(TowerEvent.OnSuccRewardGetFinish)
end

function TowerPermanentDeepView:onClose()
	TowerPermanentDeepModel.instance:initData()
	TaskDispatcher.cancelTask(self.sendOnDeepSuccRewardGuide, self)
	TaskDispatcher.cancelTask(self.hideDeepSuccReward, self)
	TaskDispatcher.cancelTask(self.showDeepRecordChange, self)

	if self.deepRecordTweenId then
		ZProj.TweenHelper.KillById(self.deepRecordTweenId)

		self.deepRecordTweenId = nil
	end

	TowerPermanentDeepModel.instance:setLastMaxDeepHigh()
end

function TowerPermanentDeepView:onDestroyView()
	return
end

return TowerPermanentDeepView
