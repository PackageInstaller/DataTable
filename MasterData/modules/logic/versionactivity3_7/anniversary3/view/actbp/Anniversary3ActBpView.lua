-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/actbp/Anniversary3ActBpView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.actbp.Anniversary3ActBpView", package.seeall)

local Anniversary3ActBpView = class("Anniversary3ActBpView", BaseView)

function Anniversary3ActBpView:onInitView()
	self._goroleicon = gohelper.findChild(self.viewGO, "#go_roleicon")
	self._gocategory = gohelper.findChild(self.viewGO, "#go_category")
	self._gobonus = gohelper.findChild(self.viewGO, "#go_category/#go_bonus")
	self._gobonusnormal = gohelper.findChild(self.viewGO, "#go_category/#go_bonus/#go_bonusnormal")
	self._gobonusselect = gohelper.findChild(self.viewGO, "#go_category/#go_bonus/#go_bonusselect")
	self._gobonusreddot = gohelper.findChild(self.viewGO, "#go_category/#go_bonus/#go_bonusreddot")
	self._btnbonus = gohelper.findChildButtonWithAudio(self.viewGO, "#go_category/#go_bonus/#btn_bonus")
	self._gotask = gohelper.findChild(self.viewGO, "#go_category/#go_task")
	self._gotasknormal = gohelper.findChild(self.viewGO, "#go_category/#go_task/#go_tasknormal")
	self._gotaskselect = gohelper.findChild(self.viewGO, "#go_category/#go_task/#go_taskselect")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "#go_category/#go_task/#go_taskreddot")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_category/#go_task/#btn_task")
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._goremaintime = gohelper.findChild(self.viewGO, "#go_ui/#go_remaintime")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "#go_ui/#go_remaintime/#txt_remaintime")
	self._txtlv = gohelper.findChildText(self.viewGO, "#go_ui/level/#txt_lv")
	self._txtscore = gohelper.findChildText(self.viewGO, "#go_ui/score/#txt_score")
	self._imagescore = gohelper.findChildImage(self.viewGO, "#go_ui/#image_score")
	self._gomax = gohelper.findChild(self.viewGO, "#go_ui/#go_max")
	self._sliderscore = gohelper.findChildSlider(self.viewGO, "#go_ui/#slider_score")
	self._btnunlock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#btn_unlock")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#btn_get")
	self._golevelupbeffect = gohelper.findChild(self.viewGO, "#go_ui/#btn_get/#go_levelupbeffect")
	self._gobonusview = gohelper.findChild(self.viewGO, "#go_bonusview")
	self._gotaskview = gohelper.findChild(self.viewGO, "#go_taskview")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Anniversary3ActBpView:addEvents()
	self._btnbonus:AddClickListener(self._btnbonusOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnunlock:AddClickListener(self._btnunlockOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
end

function Anniversary3ActBpView:removeEvents()
	self._btnbonus:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnunlock:RemoveClickListener()
	self._btnget:RemoveClickListener()
end

function Anniversary3ActBpView:_btnbonusOnClick()
	self._curCateType = Anniversary3ActBpEnum.CateType.Bonus

	self._bonusAnim:Play("open", 0, 0)
	self:_refresh()
end

function Anniversary3ActBpView:_btntaskOnClick()
	self._curCateType = Anniversary3ActBpEnum.CateType.Task

	self._taskAnim:Play("open", 0, 0)
	self:_refresh()
	Anniversary3ActBpController.instance:dispatchEvent(Anniversary3ActBpEvent.OnSelectTaskTab)
end

function Anniversary3ActBpView:_btnunlockOnClick()
	Anniversary3ActBpController.instance:openAnniversary3ActBpPropView(self._bpId, self._actId)
end

function Anniversary3ActBpView:_btngetOnClick()
	if self._curCateType == Anniversary3ActBpEnum.CateType.Bonus then
		Activity233Rpc.instance:sendGetAct233BpBonusRequest(self._actId, 0, false)
	else
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActBp)
	end
end

function Anniversary3ActBpView:_addSelfEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onTaskUpdate, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onTaskUpdate, self)
	self.addEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnGetInfo, self._onGetInfo, self)
	self.addEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnUpdateScore, self._onUpdateScore, self)
	self.addEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnGetBonus, self._onGetBonus, self)
	self.addEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnBuySuccess, self._onBuySuccess, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Anniversary3ActBpView:_removeSelfEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onTaskUpdate, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onTaskUpdate, self)
	self.removeEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnGetInfo, self._onGetInfo, self)
	self.removeEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnUpdateScore, self._onUpdateScore, self)
	self.removeEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnGetBonus, self._onGetBonus, self)
	self.removeEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnBuySuccess, self._onBuySuccess, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Anniversary3ActBpView:_onTaskUpdate()
	self:_refresh()
end

function Anniversary3ActBpView:_onGetInfo()
	self:_refresh()
end

function Anniversary3ActBpView:_onUpdateScore()
	self:_refresh()
end

function Anniversary3ActBpView:_onGetBonus()
	self:_refresh()
end

function Anniversary3ActBpView:_onBuySuccess()
	self:_refresh()
end

function Anniversary3ActBpView:_editableInitView()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3ActBp
	self._bpId = Anniversary3ActBpModel.instance:getCurBpId(self._actId)
	self._curCateType = Anniversary3ActBpEnum.CateType.Bonus
	self._taskAnim = self._gotaskview:GetComponent(typeof(UnityEngine.Animator))
	self._bonusAnim = self._gobonusview:GetComponent(typeof(UnityEngine.Animator))

	self:_addSelfEvents()
end

function Anniversary3ActBpView:onOpen()
	self:_initReddot()
	self:_refresh(true)
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
end

function Anniversary3ActBpView:onUpdateParam()
	Anniversary3ActBpController.instance:again‌RequestActivity()
end

function Anniversary3ActBpView:_onCloseViewFinish()
	if self:_checkIsTopView() then
		Anniversary3ActBpController.instance:again‌RequestActivity()
	end
end

function Anniversary3ActBpView:_checkIsTopView()
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	if openViewList and #openViewList > 0 then
		local viewName = openViewList[#openViewList]

		return viewName == self.viewName
	end
end

function Anniversary3ActBpView:_refreshTime()
	local remaintimestr = ActivityModel.getRemainTimeStr(self._actId)

	self._txtremaintime.text = string.format(luaLang("summonmainequipprobup_deadline"), remaintimestr)
end

function Anniversary3ActBpView:_initReddot()
	RedDotController.instance:addRedDot(self._gobonusreddot, RedDotEnum.DotNode.V3a7Anniversary3ActBpBonus)
	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.V3a7Anniversary3ActBpTask)
end

function Anniversary3ActBpView:_refresh(init)
	self:_refreshBtns(init)
	self:_refreshUI(init)
	self:_refreshContent(init)
end

function Anniversary3ActBpView:_refreshBtns()
	local hasPay = Anniversary3ActBpModel.instance:isPremiumPayed(self._bpId, self._actId)

	gohelper.setActive(self._btnunlock.gameObject, not hasPay)

	local hasTaskRewards = Anniversary3ActBpModel.instance:hasTaskRewardCouldGet(self._bpId, self._actId)
	local hasBonusReward = Anniversary3ActBpModel.instance:hasBonusRewardCouldGet(self._bpId, self._actId)

	if self._curCateType == Anniversary3ActBpEnum.CateType.Bonus then
		gohelper.setActive(self._btnget.gameObject, hasBonusReward)
	elseif self._curCateType == Anniversary3ActBpEnum.CateType.Task then
		gohelper.setActive(self._btnget.gameObject, hasTaskRewards)
	end
end

local addScoreTime = 1

function Anniversary3ActBpView:_refreshUI(init)
	local levelScore = Activity233Config.instance:getLevelScore(self._bpId)
	local score = Anniversary3ActBpModel.instance:getActBpScore(self._bpId, self._actId)
	local level = Anniversary3ActBpModel.instance:getActBpLevel(self._bpId, self._actId)
	local maxLv = #Activity233Config.instance:getBonusCos(self._bpId)

	gohelper.setActive(self._gomax, level == maxLv)

	local scoreInThisLevel = score % levelScore

	self._txtlv.text = level
	self._txtscore.text = scoreInThisLevel .. "/" .. levelScore

	local toValue = scoreInThisLevel / levelScore
	local fromValue = self._sliderscore:GetValue()

	if toValue < fromValue then
		fromValue = fromValue - 1
	end

	self:_killTween()

	if init then
		self:_updateScoreValue(toValue)
	elseif math.abs(fromValue - toValue) > 0.01 then
		self._addScoreTween = ZProj.TweenHelper.DOTweenFloat(fromValue, toValue, addScoreTime, self._updateScoreValue, nil, self, nil, EaseType.OutQuart)
	end
end

function Anniversary3ActBpView:_updateScoreValue(value)
	value = value < 0 and value + 1 or value

	self._sliderscore:SetValue(value)

	self._imagescore.fillAmount = value
end

function Anniversary3ActBpView:_refreshContent()
	gohelper.setActive(self._gobonusnormal, self._curCateType ~= Anniversary3ActBpEnum.CateType.Bonus)
	gohelper.setActive(self._gobonusselect, self._curCateType == Anniversary3ActBpEnum.CateType.Bonus)
	gohelper.setActive(self._gotasknormal, self._curCateType ~= Anniversary3ActBpEnum.CateType.Task)
	gohelper.setActive(self._gotaskselect, self._curCateType == Anniversary3ActBpEnum.CateType.Task)
	gohelper.setActive(self._gobonusview, self._curCateType == Anniversary3ActBpEnum.CateType.Bonus)
	gohelper.setActive(self._gotaskview, self._curCateType == Anniversary3ActBpEnum.CateType.Task)
end

function Anniversary3ActBpView:onClose()
	return
end

function Anniversary3ActBpView:_killTween()
	if self._addScoreTween then
		ZProj.TweenHelper.KillById(self._addScoreTween)

		self._addScoreTween = nil
	end
end

function Anniversary3ActBpView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	self:_killTween()
	self:_removeSelfEvents()
end

return Anniversary3ActBpView
