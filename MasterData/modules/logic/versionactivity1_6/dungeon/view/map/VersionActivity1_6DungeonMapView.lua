-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/map/VersionActivity1_6DungeonMapView.lua

module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapView", package.seeall)

local VersionActivity1_6DungeonMapView = class("VersionActivity1_6DungeonMapView", BaseView)
local DungeonEnum = VersionActivity1_6DungeonEnum
local skillBtnPrefsKey = VersionActivity1_6Enum.ActivityId.Dungeon .. "UnlockSkillBtnAnim"
local bossBtnPrefsKey = VersionActivity1_6Enum.ActivityId.Dungeon .. "UnlockBossBtnAnim"

function VersionActivity1_6DungeonMapView:onInitView()
	self._topLeftGo = gohelper.findChild(self.viewGO, "#go_topleft")
	self._topRightGo = gohelper.findChild(self.viewGO, "#go_topright")
	self.simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._goSwitchModeContainer = gohelper.findChild(self.viewGO, "#go_switchmodecontainer")
	self._btnactivitystore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitystore")
	self._btnactivitytask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitytask")
	self._btnactivityskill = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_wish")
	self._imageActivityskillProgress = gohelper.findChildImage(self.viewGO, "#go_topright/#btn_wish/circle_bar")
	self._goBtnBoss = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_bossmode")
	self._txtstorenum = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	self._txtStoreRemainTime = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	self._imagestoreicon = gohelper.findChildImage(self.viewGO, "#go_topright/#btn_activitystore/icon")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._rectmask2D = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6DungeonMapView:addEvents()
	self._btnactivitystore:AddClickListener(self.btnActivityStoreOnClick, self)
	self._btnactivitytask:AddClickListener(self.btnActivityTaskOnClick, self)
	self._btnactivityskill:AddClickListener(self.btnActivitySkillOnClick, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
end

function VersionActivity1_6DungeonMapView:removeEvents()
	self._btnactivitystore:RemoveClickListener()
	self._btnactivitytask:RemoveClickListener()
	self._btnactivityskill:RemoveClickListener()
	self._btncloseview:RemoveClickListener()
end

function VersionActivity1_6DungeonMapView:btnActivityStoreOnClick()
	ReactivityController.instance:openReactivityStoreView(VersionActivity2_5Enum.ActivityId.Reactivity)
end

function VersionActivity1_6DungeonMapView:btnActivityTaskOnClick()
	ReactivityController.instance:openReactivityTaskView(VersionActivity2_5Enum.ActivityId.Reactivity)
end

function VersionActivity1_6DungeonMapView:btnActivitySkillOnClick()
	local isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	if not isUnlock then
		local toastId, toastParamList = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.Act_60101)

		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	VersionActivity1_6DungeonController.instance:openSkillView()
end

function VersionActivity1_6DungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivity1_6DungeonMapLevelView)
end

function VersionActivity1_6DungeonMapView:_editableInitView()
	self.playedSkillBtnAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(skillBtnPrefsKey), 0) == 1
	self.playedBossBtnAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(bossBtnPrefsKey), 0) == 1
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	self:addViewRedDot()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.SetSkillBtnActive, self.SetSkillBtnActive, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.SetBossBtnActive, self.SetBossBtnActive, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnFuncUnlockRefresh, self.onFunUnlockRefreshUI, self)
	TaskDispatcher.runRepeat(self._everyMinuteCall, self, TimeUtil.OneMinuteSecond)
	gohelper.setActive(self._btnactivitystore.gameObject, false)
	gohelper.setActive(self._btnactivitytask.gameObject, false)
end

function VersionActivity1_6DungeonMapView:onUpdateParam()
	self:refreshUI()
end

function VersionActivity1_6DungeonMapView:_onEscBtnClick()
	self:closeThis()
end

function VersionActivity1_6DungeonMapView:onOpen()
	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
	self:modifyBgm()
	self:refreshUI()
end

function VersionActivity1_6DungeonMapView:refreshUI()
	self:refreshBtnVisible()
	self:refreshActivityCurrency()
	self:refreshMask()
	self:refreshSkillProgress()
	self:refreshStoreRemainTime()
end

function VersionActivity1_6DungeonMapView:onFunUnlockRefreshUI()
	self:refreshBtnVisible()
	self:refreshSkillProgress()
end

function VersionActivity1_6DungeonMapView:refreshBtnVisible()
	local isSkillUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	gohelper.setActive(self._btnactivityskill.gameObject, isSkillUnlock)

	if isSkillUnlock then
		self:playSkillBtnAnim()
	end

	local isBossUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102)

	gohelper.setActive(self._goBtnBoss, isBossUnlock)

	if isBossUnlock then
		self:playBossBtnAnim()
	end
end

function VersionActivity1_6DungeonMapView:refreshActivityCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstorenum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity1_6DungeonMapView:refreshSkillProgress()
	local totalSkillPointNumStr = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)
	local totalSkillPointNum = tonumber(totalSkillPointNumStr)
	local gotSkillPointNum = VersionActivity1_6DungeonSkillModel.instance:getTotalGotSkillPointNum()

	self._imageActivityskillProgress.fillAmount = gotSkillPointNum / (1 * totalSkillPointNum)
end

function VersionActivity1_6DungeonMapView:refreshStoreRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_5Enum.ActivityId.ReactivityStore]
	local endTime = actInfoMo:getRealEndTimeStamp()
	local offsetSecond = endTime - ServerTime.now()

	if offsetSecond > TimeUtil.OneDaySecond then
		local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)

		self._txtStoreRemainTime.text = day .. "d"

		return
	end

	if offsetSecond > TimeUtil.OneHourSecond then
		local hour = Mathf.Floor(offsetSecond / TimeUtil.OneHourSecond)

		self._txtStoreRemainTime.text = hour .. "h"

		return
	end

	self._txtStoreRemainTime.text = "1h"
end

function VersionActivity1_6DungeonMapView:refreshMask()
	gohelper.setActive(self.simagemask.gameObject, self.activityDungeonMo:isHardMode())
end

VersionActivity1_6DungeonMapView.BlockKey = "VersionActivity1_6DungeonMapView_OpenAnim"

function VersionActivity1_6DungeonMapView:showBtnUI()
	gohelper.setActive(self._topLeftGo, true)
	gohelper.setActive(self._topRightGo, true)
	gohelper.setActive(self._goSwitchModeContainer, true)
	self.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_6DungeonMapView.BlockKey)
	TaskDispatcher.runDelay(self.onOpenAnimaDone, self, 0.667)
end

function VersionActivity1_6DungeonMapView:onOpenAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivity1_6DungeonMapView.BlockKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity1_6DungeonMapView:hideBtnUI()
	self.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_6DungeonMapView.BlockKey)
	TaskDispatcher.runDelay(self.onCloseAnimaDone, self, 0.667)
end

function VersionActivity1_6DungeonMapView:_onOpenView(viewName)
	if viewName == ViewName.VersionActivity1_6DungeonMapLevelView then
		self._rectmask2D.padding = Vector4(0, 0, 600, 0)

		gohelper.setActive(self._btncloseview, true)
		self:hideBtnUI()
	end
end

function VersionActivity1_6DungeonMapView:_onCloseView(viewName)
	if viewName == ViewName.VersionActivity1_6DungeonMapLevelView then
		self._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(self._btncloseview, false)
		self:showBtnUI()
		self:playSkillBtnAnim()
		self:playBossBtnAnim()
	end
end

function VersionActivity1_6DungeonMapView:onModeChange()
	self:refreshMask()
end

function VersionActivity1_6DungeonMapView:onClose()
	TaskDispatcher.cancelTask(self._everyMinuteCall, self)
end

function VersionActivity1_6DungeonMapView:onDestroyView()
	return
end

function VersionActivity1_6DungeonMapView:_everyMinuteCall()
	self:refreshUI()
end

function VersionActivity1_6DungeonMapView:SetSkillBtnActive(param)
	local active = param == "1"
	local isSkillUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	active = active and isSkillUnlock

	gohelper.setActive(self._btnactivityskill.gameObject, active)

	if active then
		self:_playSkillBtnAnimImpl()
	end
end

function VersionActivity1_6DungeonMapView:SetBossBtnActive(param)
	local active = param == "1"
	local isBossUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102)

	active = active and isBossUnlock

	gohelper.setActive(self._goBtnBoss, active)

	if active then
		self:_playBossBtnAnimImpl()
	end
end

function VersionActivity1_6DungeonMapView:playSkillBtnAnim()
	if self.playedSkillBtnAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	self:_playSkillBtnAnimImpl()

	local key = PlayerModel.instance:getPlayerPrefsKey(skillBtnPrefsKey)

	PlayerPrefsHelper.setNumber(key, 1)

	self.playedSkillBtnAnim = true
end

function VersionActivity1_6DungeonMapView:_playSkillBtnAnimImpl()
	local skillBtnAnimator = self._btnactivityskill:GetComponent(typeof(UnityEngine.Animator))

	skillBtnAnimator:Play(UIAnimationName.Unlock)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonSkillViewUnlock)
end

function VersionActivity1_6DungeonMapView:playBossBtnAnim()
	if self.playedBossBtnAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	self:_playBossBtnAnimImpl()

	local key = PlayerModel.instance:getPlayerPrefsKey(bossBtnPrefsKey)

	PlayerPrefsHelper.setNumber(key, 1)

	self.playedBossBtnAnim = true
end

function VersionActivity1_6DungeonMapView:_playBossBtnAnimImpl()
	local animator = self._goBtnBoss:GetComponent(typeof(UnityEngine.Animator))

	animator:Play(UIAnimationName.Unlock)
end

function VersionActivity1_6DungeonMapView:onCloseAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivity1_6DungeonMapView.BlockKey)
	gohelper.setActive(self._goSwitchModeContainer, false)
	gohelper.setActive(self._topLeftGo, false)
	gohelper.setActive(self._topRightGo, false)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity1_6DungeonMapView:modifyBgm()
	local modifyBgmEpisodeId = DungeonEnum.ModifyBgmEpisodeId
	local pass = DungeonModel.instance:hasPassLevelAndStory(modifyBgmEpisodeId)

	if pass then
		AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_6Dungeon, AudioEnum.Bgm.Act1_6DungeonBgm2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	end
end

function VersionActivity1_6DungeonMapView:addViewRedDot()
	local goTaskRedDot = gohelper.findChild(self.viewGO, "#go_topright/#btn_activitytask/#go_reddot")

	RedDotController.instance:addRedDot(goTaskRedDot, RedDotEnum.DotNode.V1a6DungeonTask)

	local goSkillRedDot = gohelper.findChild(self.viewGO, "#go_topright/#btn_wish/#go_reddot")

	RedDotController.instance:addRedDot(goSkillRedDot, RedDotEnum.DotNode.V1a6DungeonSkillPoint)

	local goBossRedDot = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_bossmode/#go_reddot")
	local goBossRedDot2 = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_bossmode/#go_reddot2")

	RedDotController.instance:addRedDot(goBossRedDot, RedDotEnum.DotNode.V1a6DungeonBossEnter)
	RedDotController.instance:addRedDot(goBossRedDot2, RedDotEnum.DotNode.V1a6DungeonNewBoss)
end

return VersionActivity1_6DungeonMapView
