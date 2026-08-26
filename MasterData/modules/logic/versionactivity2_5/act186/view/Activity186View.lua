-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186View.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186View", package.seeall)

local Activity186View = class("Activity186View", BaseView)

function Activity186View:onInitView()
	self.btnShop = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnShop")
	self.goShopCanget = gohelper.findChild(self.viewGO, "root/btnShop/canGet")
	self.goShopTime = gohelper.findChild(self.viewGO, "root/btnShop/time")
	self.txtShopTime = gohelper.findChildTextMesh(self.viewGO, "root/btnShop/time/txt")
	self.btnNewYear = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnNewYear")
	self.goNewYearFinish = gohelper.findChild(self.viewGO, "root/btnNewYear/finish")
	self.goNewYearLock = gohelper.findChild(self.viewGO, "root/btnNewYear/lock")
	self.txtNewYearLock = gohelper.findChildTextMesh(self.viewGO, "root/btnNewYear/lock/txt")
	self.goNewYearTime = gohelper.findChild(self.viewGO, "root/btnNewYear/time")
	self.txtNewYearTime = gohelper.findChildTextMesh(self.viewGO, "root/btnNewYear/time/txt")
	self.btnYuanxiao = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnYuanxiao")
	self.goYuanxiaoFinish = gohelper.findChild(self.viewGO, "root/btnYuanxiao/finish")
	self.goYuanxiaoLock = gohelper.findChild(self.viewGO, "root/btnYuanxiao/lock")
	self.txtYuanxiaoLock = gohelper.findChildTextMesh(self.viewGO, "root/btnYuanxiao/lock/txt")
	self.goYuanxiaoTime = gohelper.findChild(self.viewGO, "root/btnYuanxiao/time")
	self.txtYuanxiaoTime = gohelper.findChildTextMesh(self.viewGO, "root/btnYuanxiao/time/txt")
	self.btnMainActivity = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnMainActivity")
	self.btnGame = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnGame")
	self.btnAvg = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnAvg")
	self.txtStage = gohelper.findChildTextMesh(self.viewGO, "root/btnMainActivity/stage/Text")
	self.txtStageName = gohelper.findChildTextMesh(self.viewGO, "root/btnMainActivity/txt")
	self.goNewYearReddot = gohelper.findChild(self.viewGO, "root/btnNewYear/reddot")
	self.goYuanxiaoReddot = gohelper.findChild(self.viewGO, "root/btnYuanxiao/reddot")
	self.goMainActivityReddot = gohelper.findChild(self.viewGO, "root/btnMainActivity/reddot")
	self.newYearReddot = RedDotController.instance:addNotEventRedDot(self.goNewYearReddot, self._onRefreshNewYearRed, self)
	self.yuanxiaoReddot = RedDotController.instance:addRedDot(self.goYuanxiaoReddot, RedDotEnum.DotNode.V2a5_Act187, 0)
	self.mainActivityReddot = RedDotController.instance:addRedDot(self.goMainActivityReddot, RedDotEnum.DotNode.V2a5_Act186Task, 0)
	self.mainActivityAnim = gohelper.findChildComponent(self.viewGO, "root/btnMainActivity", gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186View:addEvents()
	self.addClickCb(self, self.btnShop, self._btngotoOnClick, self)
	self.addClickCb(self, self.btnNewYear, self.onClickBtnNewYear, self)
	self.addClickCb(self, self.btnYuanxiao, self.onClickBtnYuanxiao, self)
	self.addClickCb(self, self.btnMainActivity, self.onClickBtnMainActivity, self)
	self.addClickCb(self, self.btnGame, self.onClickBtnGame, self)
	self.addClickCb(self, self.btnAvg, self.onClickBtnAvg, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.FinishGame, self.onFinishGame, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.UpdateInfo, self.onUpdateInfo, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.GetOnceBonus, self.onGetOnceBonus, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onRefreshRed, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.RefreshRed, self.onRefreshRed, self)
end

function Activity186View:removeEvents()
	return
end

function Activity186View:_editableInitView()
	return
end

function Activity186View:onRefreshRed()
	self.newYearReddot:refreshRedDot()
	self.yuanxiaoReddot:refreshDot()
	self.mainActivityReddot:refreshDot()
end

function Activity186View:onClickBtnAvg()
	if not self.actMo then
		return
	end

	if not self.actMo:isCanShowAvgBtn() then
		return
	end

	Activity186Controller.instance:setPlayerPrefs(Activity186Enum.LocalPrefsKey.AvgMark, 1)

	local storyId = Activity186Config.instance:getConstNum(self.actId, Activity186Enum.ConstId.AvgStoryId)

	StoryController.instance:playStory(storyId, nil, self.onStoryEnd, self)
end

function Activity186View:onClickBtnGame()
	Activity186Controller.instance:checkEnterGame(self.actId, true)
end

function Activity186View:onClickBtnYuanxiao()
	Activity187Controller.instance:openAct187View()
end

function Activity186View:onClickBtnMainActivity()
	Activity186Controller.instance:openTaskView(self.actId)
end

function Activity186View:onClickBtnNewYear()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(ActivityEnum.Activity.V2a5_Act186Sign)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	ViewMgr.instance:openView(ViewName.Activity186SignView, {
		actId = self.actId
	})
end

function Activity186View:_btngotoOnClick()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(ActivityEnum.Activity.V2a5_FurnaceTreasure)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	local jumpId = FurnaceTreasureConfig.instance:getJumpId(ActivityEnum.Activity.V2a5_FurnaceTreasure)

	if jumpId and jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end
end

function Activity186View:onGetOnceBonus()
	self:_showDeadline()
end

function Activity186View:onFinishGame()
	self:refreshView()
end

function Activity186View:onUpdateInfo()
	self:refreshView()
	self:refreshMainActivityAnim()
end

function Activity186View:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function Activity186View:onOpen()
	local value = Activity186Controller.instance:getPlayerPrefs(Activity186Enum.LocalPrefsKey.FirstEnterView, 0)

	self.isFirstEnterView = value == 0

	Activity186Controller.instance:setPlayerPrefs(Activity186Enum.LocalPrefsKey.FirstEnterView, 1)
	self:refreshParam()
	self:refreshView()

	if not self.isFirstEnterView then
		self:checkGame()
	end

	self:_showDeadline()
	self:refreshMainActivityAnim()
end

function Activity186View:refreshParam()
	self.actId = self.viewParam.actId
	self.actMo = Activity186Model.instance:getById(self.actId)
end

function Activity186View:refreshView()
	self:_refreshGameBtn()
end

function Activity186View:_refreshGameBtn()
	if not self.actMo then
		return
	end

	local canPlay = self.actMo:hasGameCanPlay()

	self:setGameVisable(canPlay)
end

function Activity186View:setGameVisable(isVisable)
	if self.gameVisable == isVisable then
		return
	end

	self.gameVisable = isVisable

	gohelper.setActive(self.btnGame, isVisable)
end

function Activity186View:refreshStageName(stage)
	self.txtStage.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towerpermanent_stage"), GameUtil.getNum2Chinese(stage))
	self.txtStageName.text = luaLang(string.format("activity186view_txt_stage%s", stage))
end

function Activity186View:checkGame()
	Activity186Controller.instance:checkEnterGame(self.actId)
end

function Activity186View:_showDeadline()
	TaskDispatcher.cancelTask(self._onRefreshTime, self)
	TaskDispatcher.runRepeat(self._onRefreshTime, self, 1)
	self:_onRefreshTime()
end

function Activity186View:_onRefreshTime()
	self:_refreshShopTime()
	self:_refreshAvgBtn()
	self:_refreshNewYearTime()
	self:_refreshYuanxiaoTime()
	self:_refreshGameBtn()
end

function Activity186View:_refreshAvgBtn()
	local canShowBtn = self.actMo:isCanShowAvgBtn()

	self:setAvgVisable(canShowBtn)

	if self.actMo:isCanPlayAvgStory() then
		self:onClickBtnAvg()
	end
end

function Activity186View:_refreshShopTime()
	local status = ActivityHelper.getActivityStatus(ActivityEnum.Activity.V2a5_FurnaceTreasure)
	local isShow = false

	if status == ActivityEnum.ActivityStatus.Normal then
		local dotInfo4 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.V1a6FurnaceTreasure)

		if dotInfo4 then
			for _, v in pairs(dotInfo4.infos) do
				if v.value > 0 then
					isShow = true

					break
				end
			end
		end
	end

	gohelper.setActive(self.goShopCanget, isShow)
	gohelper.setActive(self.goShopTime, not isShow)

	if not isShow then
		self.txtShopTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.V2a5_FurnaceTreasure, true)
	end
end

function Activity186View:_refreshNewYearTime()
	local starTime = ActivityModel.instance:getActStartTime(ActivityEnum.Activity.V2a5_Act186Sign)
	local leftTime = starTime * 0.001 - ServerTime.now()

	if leftTime > 0 then
		local day = math.ceil(leftTime / TimeUtil.OneDaySecond)

		self.txtNewYearLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), day)

		gohelper.setActive(self.goNewYearLock, true)
		gohelper.setActive(self.goNewYearFinish, false)
		gohelper.setActive(self.goNewYearTime, false)
	else
		gohelper.setActive(self.goNewYearLock, false)

		local endTime = ActivityModel.instance:getActEndTime(ActivityEnum.Activity.V2a5_Act186Sign)

		leftTime = endTime * 0.001 - ServerTime.now()

		local isEnd = leftTime <= 0

		gohelper.setActive(self.goNewYearFinish, isEnd)
		gohelper.setActive(self.goNewYearTime, not isEnd)

		if not isEnd then
			self.txtNewYearTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.V2a5_Act186Sign, true)
		end
	end
end

function Activity186View:_refreshYuanxiaoTime()
	local actId = Activity187Model.instance:getAct187Id()
	local starTime = ActivityModel.instance:getActStartTime(actId)
	local leftTime = starTime * 0.001 - ServerTime.now()

	if leftTime > 0 then
		local day = math.ceil(leftTime / TimeUtil.OneDaySecond)

		self.txtYuanxiaoLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), day)

		gohelper.setActive(self.goYuanxiaoLock, true)
		gohelper.setActive(self.goYuanxiaoFinish, false)
		gohelper.setActive(self.goYuanxiaoTime, false)
	else
		gohelper.setActive(self.goYuanxiaoLock, false)

		local endTime = ActivityModel.instance:getActEndTime(actId)

		leftTime = endTime * 0.001 - ServerTime.now()

		local isEnd = leftTime <= 0

		gohelper.setActive(self.goYuanxiaoFinish, isEnd)
		gohelper.setActive(self.goYuanxiaoTime, not isEnd)

		if not isEnd then
			self.txtYuanxiaoTime.text = ActivityHelper.getActivityRemainTimeStr(actId, true)
		end
	end
end

function Activity186View:setAvgVisable(isVisable)
	if self.avgVisable == isVisable then
		return
	end

	self.avgVisable = isVisable

	gohelper.setActive(self.btnAvg, isVisable)
	Activity186Controller.instance:dispatchEvent(Activity186Event.RefreshRed)
end

function Activity186View:onStoryEnd()
	Activity186Rpc.instance:sendGetAct186OnceBonusRequest(self.actId)
	ViewMgr.instance:openView(ViewName.Activity186GiftView, {
		actId = self.actId
	})
end

function Activity186View:_onRefreshNewYearRed()
	return Activity186Model.instance:isShowSignRed()
end

function Activity186View:refreshMainActivityAnim()
	if not self.actMo then
		return
	end

	local value = Activity186Controller.instance:getPlayerPrefs(Activity186Enum.LocalPrefsKey.MainActivityStageAnim, 0)
	local curStage = self.actMo.currentStage

	if value ~= curStage then
		Activity186Controller.instance:setPlayerPrefs(Activity186Enum.LocalPrefsKey.MainActivityStageAnim, curStage)
		self:refreshStageName(value ~= 0 and value or 1)
		self.mainActivityAnim:Play("refresh")
		TaskDispatcher.runDelay(self._refreshRealStage, self, 0.17)
	else
		self:_refreshRealStage()
		self.mainActivityAnim:Play("idle")
	end
end

function Activity186View:_refreshRealStage()
	if not self.actMo then
		return
	end

	self:refreshStageName(self.actMo.currentStage)
end

function Activity186View:onClose()
	TaskDispatcher.cancelTask(self._onRefreshTime, self)
end

function Activity186View:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshTime, self)
	ViewMgr.instance:closeView(ViewName.Activity186TaskView)
	ViewMgr.instance:closeView(ViewName.Activity186SignView)
	ViewMgr.instance:closeView(ViewName.Activity186EffectView)
end

return Activity186View
