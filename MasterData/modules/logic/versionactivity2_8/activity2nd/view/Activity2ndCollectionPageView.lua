-- chunkname: @modules/logic/versionactivity2_8/activity2nd/view/Activity2ndCollectionPageView.lua

module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndCollectionPageView", package.seeall)

local Activity2ndCollectionPageView = class("Activity2ndCollectionPageView", BaseView)

Activity2ndCollectionPageView.InAnim = "swith_in"
Activity2ndCollectionPageView.OutAnim = "switch_out"

function Activity2ndCollectionPageView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageMiddle = gohelper.findChildSingleImage(self.viewGO, "TypeMechine/#simage_Middle")
	self._btntypemechine = gohelper.findChildButtonWithAudio(self.viewGO, "TypeMechine/#btn_typemechine")
	self._simageMiddleDec1 = gohelper.findChildSingleImage(self.viewGO, "TypeMechine/#simage_MiddleDec1")
	self._goPage1 = gohelper.findChild(self.viewGO, "Page1")
	self._goPage2 = gohelper.findChild(self.viewGO, "Page2")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Page1/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Page1/#txt_LimitTime")
	self._btnBack = gohelper.findChildButtonWithAudio(self.viewGO, "Page2/#btn_Back")
	self._btnOK = gohelper.findChildButtonWithAudio(self.viewGO, "Page2/#btn_OK")
	self._inputname = gohelper.findChildTextMeshInputField(self.viewGO, "Page2/InputField")
	self._txtInput = gohelper.findChildText(self.viewGO, "Page2/inputField/#txt_input")
	self._goInputTip = gohelper.findChild(self.viewGO, "Page2/Tips")
	self._txtInputTip = gohelper.findChildText(self.viewGO, "Page2/Tips/txt_Tips")
	self._goMail = gohelper.findChild(self.viewGO, "Page1/Entrance0")
	self._goMailRedPoint = gohelper.findChild(self.viewGO, "Page1/Entrance0/#go_RedPoint")
	self._btnMail = gohelper.findChildButtonWithAudio(self.viewGO, "Page1/Entrance0/#btn_Entrance")
	self._btnpage2 = gohelper.findChildButtonWithAudio(self.viewGO, "Page2/#btn_page2")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._txt = ""
	self._showTips = false
	self._isswitching = false
	self._showTipTime = 5
	self._isFirstEnter = false
	self._lastStrLen = 0
	self._onceGetReward = false
	self.longPress = SLFramework.UGUI.UILongPressListener.Get(self._btnBack.gameObject)

	self.longPress:SetLongPressTime({
		0.5,
		99999
	})

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity2ndCollectionPageView:addEvents()
	self._btnBack:AddClickListener(self._btnBackOnClick, self)
	self.longPress:AddLongPressListener(self._onBtnBackLongPress, self)
	self._btnOK:AddClickListener(self._btnOKOnClick, self)
	self._btntypemechine:AddClickListener(self._btnTypeMechineOnClick, self)
	self._btnMail:AddClickListener(self.onClickMailBtn, self)
	self._btnpage2:AddClickListener(self._btnTypeMechineOnClick, self)
	self._inputname:AddOnValueChanged(self._inputValueChanged, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.checkNeedRefreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.checkNeedRefreshUI, self)
	self.addEventCb(self, Activity2ndController.instance, Activity2ndEvent.InputErrorOrHasReward, self.refreshShowTips, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.onReceivePVBtn, self)
end

function Activity2ndCollectionPageView:removeEvents()
	self._btnBack:RemoveClickListener()
	self.longPress:RemoveLongPressListener()
	self._btnOK:RemoveClickListener()
	self._btntypemechine:RemoveClickListener()
	self._btnMail:RemoveClickListener()
	self._btnpage2:RemoveClickListener()
	self._inputname:RemoveOnValueChanged()
	self._btnpvrewarditem:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.checkNeedRefreshUI, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.checkNeedRefreshUI, self)
	self.removeEventCb(self, Activity2ndController.instance, Activity2ndEvent.InputErrorOrHasReward, self.refreshShowTips, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.onReceivePVBtn, self)
end

function Activity2ndCollectionPageView:_btnPVRewardOnClick()
	local actId = Activity2ndEnum.ActivityId.V2a8_PVPopupReward

	if self:checkCanGet(actId) then
		Activity101Rpc.instance:sendGet101BonusRequest(actId, 1)
	end
end

function Activity2ndCollectionPageView:_onBtnBackLongPress()
	self._txt = ""

	self._inputname:SetText(self._txt)

	self._lastStrLen = string.len(self._txt)
end

function Activity2ndCollectionPageView:_btnBackOnClick()
	self._txt = string.sub(self._txt, 1, -2)

	self._inputname:SetText(self._txt)

	self._lastStrLen = string.len(self._txt)
end

function Activity2ndCollectionPageView:_btnOKOnClick()
	Activity2ndController.instance:trySendText(self._txt)
end

function Activity2ndCollectionPageView:_btnTypewriter(param)
	local str = param.str
	local anim = param.anim

	if string.len(self._txt) < 20 then
		self._txt = self._txt .. str
	else
		str = luaLang("Activity2ndCollectionPageView_EnterMaxStr")

		self:refreshShowTips(str)

		return
	end

	self._inputname:SetText(self._txt)
	anim:Update(0)
	anim:Play("click", 0, 0)

	self._lastStrLen = string.len(self._txt)

	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_click)
end

function Activity2ndCollectionPageView:_btnTypeMechineOnClick()
	if self._isswitching then
		return
	end

	Activity2ndModel.instance:changeShowTypeMechine()
	self:switchTyepMechine()
end

function Activity2ndCollectionPageView:switchTyepMechine()
	self._showTypeMechine = Activity2ndModel.instance:getShowTypeMechine()

	if self._showTypeMechine then
		if not Activity2ndCollectionPageView.InAnim then
			local animAnim = Activity2ndCollectionPageView.OutAnim

			self._animator:Play(animAnim, 0, 0)

			self._isswitching = true

			local activityStatus = ActivityHelper.getActivityStatus(Activity2ndEnum.ActivityId.V2a8_PVPopupReward)
			local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal
			local hasReceive = self:checkReceied(Activity2ndEnum.ActivityId.V2a8_PVPopupReward)

			gohelper.setActive(self._gopvreward, not self._showTypeMechine and isNormalStatus and not hasReceive)
			gohelper.setActive(self._goPage1, not self._showTypeMechine)
			gohelper.setActive(self._goPage2, self._showTypeMechine)

			if self._showTypeMechine then
				AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_start)
				AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.stop_ui_fuleyuan_typewriter_loop)
			else
				AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_loop)
			end

			self:_initShowTips()

			self._txt = ""

			self._inputname:SetText(self._txt)

			self._lastStrLen = string.len(self._txt)

			TaskDispatcher.runDelay(self._afteranim, self, 0.5)
		end
	end
end

function Activity2ndCollectionPageView:_afteranim()
	self._isswitching = false

	TaskDispatcher.cancelTask(self._afteranim, self)
	self:_checkFirstEnter()
end

function Activity2ndCollectionPageView:_inputValueChanged()
	local txt = self._inputname:GetText()

	if self._lastStrLen == 0 then
		local str = string.sub(txt, -1)
		local btnItem = self._btnDict[string.upper(str)]

		if btnItem and btnItem.anim then
			btnItem.anim:Update(0)
			btnItem.anim:Play("click", 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_click)
		end
	elseif string.len(txt) > self._lastStrLen then
		local str = string.sub(txt, -1)
		local btnItem = self._btnDict[string.upper(str)]

		if btnItem and btnItem.anim then
			btnItem.anim:Update(0)
			btnItem.anim:Play("click", 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_click)
		end
	end

	self._txt = string.upper(txt)

	self._inputname:SetText(self._txt)

	self._lastStrLen = string.len(txt)
end

function Activity2ndCollectionPageView:_initShowTips()
	self._showTips = false

	TaskDispatcher.cancelTask(self._endShowTip, self)
	gohelper.setActive(self._goInputTip, false)
end

function Activity2ndCollectionPageView:_editableInitView()
	self._activityItemList = {}

	gohelper.setActive(self._goPage1, not self._showTypeMechine)
	gohelper.setActive(self._goPage2, self._showTypeMechine)
	self:_initTypewriter()
	self:_initActivityBtn()
	self:_initPVBtn()
end

function Activity2ndCollectionPageView:_initPVBtn()
	self._gopvreward = gohelper.findChild(self.viewGO, "#go_topright")
	self._gopvrewardreddot = gohelper.findChild(self.viewGO, "#go_topright/#go_RedPoint")
	self._txtpvreward = gohelper.findChildText(self.viewGO, "#go_topright/#txt_task")
	self._gopvrewarditem = gohelper.findChild(self.viewGO, "#go_topright/#go_rewarditem/go_icon")
	self._gopvrewardcanget = gohelper.findChild(self.viewGO, "#go_topright/#go_rewarditem/go_canget")
	self._gopvrewardreceive = gohelper.findChild(self.viewGO, "#go_topright/#go_rewarditem/go_receive")
	self._btnpvrewarditem = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#go_rewarditem/#btn_click")
	self._pvconfig = ActivityConfig.instance:getActivityCo(Activity2ndEnum.ActivityId.V2a8_PVPopupReward)
	self._pvrewardconfig = ActivityConfig.instance:getNorSignActivityCo(Activity2ndEnum.ActivityId.V2a8_PVPopupReward, 1)
	self._txtpvreward.text = self._pvconfig.actDesc .. " (0/1)"
	self.goitemcomp = IconMgr.instance:getCommonPropItemIcon(self._gopvrewarditem)

	local rewardCo = string.split(self._pvrewardconfig.bonus, "#")

	if rewardCo and #rewardCo > 0 then
		self.goitemcomp:setMOValue(rewardCo[1], rewardCo[2], rewardCo[3], nil, true)
		self.goitemcomp:isShowQuality(false)
		self.goitemcomp:isShowCount(false)
	end

	self._btnpvrewarditem:AddClickListener(self._btnPVRewardOnClick, self)
	gohelper.setActive(self._btnpvrewarditem.gameObject, false)
	gohelper.setActive(self._gopvreward, false)
end

function Activity2ndCollectionPageView:_initTypewriter()
	self._btnList = {}
	self._btnDict = {}

	for row = 1, 3 do
		local goRow = gohelper.findChild(self.viewGO, "Page2/Keyboard/Row" .. row)
		local transform = goRow.transform
		local itemCount = transform.childCount
		local orderstring = Activity196Enum.Typewriter[row]

		for i = 1, itemCount do
			local btnItem = self:getUserDataTb_()
			local child = transform:GetChild(i - 1)
			local btn = SLFramework.UGUI.ButtonWrap.Get(child.gameObject)
			local str = string.sub(orderstring, i, i)
			local anim = child.gameObject:GetComponent(typeof(UnityEngine.Animator))

			btn:AddClickListener(self._btnTypewriter, self, {
				str = str,
				anim = anim
			})

			btnItem.btn = btn
			btnItem.name = "Btn" .. str
			btnItem.anim = anim
			anim.enabled = true

			table.insert(self._btnList, btnItem)

			self._btnDict[string.upper(str)] = btnItem
		end
	end

	gohelper.setActive(self._goInputTip, false)
end

function Activity2ndCollectionPageView:_checkFirstEnter()
	if GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.FirstEnterTypewriter, 0) == 1 then
		local randomIndex = math.random(1, 4)
		local str = luaLang(Activity2ndEnum.RandomType[randomIndex])

		self:refreshShowTips(str)
	else
		self:refreshShowTips(luaLang(Activity2ndEnum.ShowTipsType.FirstEnter))
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.FirstEnterTypewriter, 1)
	end
end

function Activity2ndCollectionPageView:_initActivityBtn()
	for i = 1, #Activity2ndEnum.ActivityOrder do
		local item = self._activityItemList[i]
		local actId = Activity2ndEnum.ActivityOrder[i]
		local config = ActivityConfig.instance:getActivityCo(actId)

		if not item then
			item = self:getUserDataTb_()
			item.actId = actId
			item.index = i
			item.redDotId = config and config.redDotId

			local go = gohelper.findChild(self.viewGO, "Page1/Entrance" .. i .. "/root")

			item.go = go
			item.btn = gohelper.findChildButtonWithAudio(go, "#btn_Entrance")
			item.txtname = gohelper.findChildText(go, "#btn_Entrance/txt_Entrance")

			item.btn:AddClickListener(self._activityBtnOnClick, self, item)

			item.gotip = gohelper.findChild(go, "Tips")
			item.txttip = gohelper.findChildText(go, "Tips/#txt_Tips")
			item.golimittime = gohelper.findChild(go, "LimitTime")
			item.txtlimittime = gohelper.findChildText(go, "LimitTime/#txt_Time")
			item.canvasGroup = gohelper.onceAddComponent(item.btn.gameObject, gohelper.Type_CanvasGroup)
			item.goRedPoint = gohelper.findChild(go, "#go_RedPoint")

			table.insert(self._activityItemList, item)
		end
	end
end

function Activity2ndCollectionPageView:onUpdateParam()
	return
end

function Activity2ndCollectionPageView:onOpen()
	self._centerActId = self.viewParam.actId
	self._showTypeMechine = Activity2ndModel.instance:getShowTypeMechine()

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_unfold)
	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_loop)
end

function Activity2ndCollectionPageView:checkNeedRefreshUI(viewName)
	self:refreshUI()
	self:checkCloseActivityView()
	self:checkNeedPlayAudio(viewName)
end

function Activity2ndCollectionPageView:checkNeedPlayAudio(viewName)
	for _, name in ipairs(Activity2ndEnum.ActivityViewName) do
		if viewName == name then
			AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_loop)

			break
		end
	end
end

function Activity2ndCollectionPageView:checkCloseActivityView()
	local allClose = true

	for _, actId in pairs(Activity2ndEnum.ActivityId) do
		local status = ActivityHelper.getActivityStatus(actId)

		if status ~= ActivityEnum.ActivityStatus.NotOnLine and status ~= ActivityEnum.ActivityStatus.Expired then
			allClose = false

			break
		end
	end

	if allClose then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function Activity2ndCollectionPageView:refreshUI()
	self:refreshCenterActUI()
	self:refreshActivityUI()

	if not self._onceGetReward then
		self:refreshPVBtn()
	end
end

function Activity2ndCollectionPageView:refreshPVBtn()
	local actId = Activity2ndEnum.ActivityId.V2a8_PVPopupReward
	local activityStatus = ActivityHelper.getActivityStatus(actId)
	local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

	if not isNormalStatus then
		return
	end

	self:_cangetPVReward()

	local hasReceive = self:checkReceied(actId)

	gohelper.setActive(self._gopvreward, not isNormalStatus or not hasReceive)

	local config = ActivityConfig.instance:getActivityCo(actId)
	local redId = config and config.redDotId

	if isNormalStatus and redId then
		RedDotController.instance:addRedDot(self._gopvrewardreddot, redId, actId)
	end
end

function Activity2ndCollectionPageView:_cangetPVReward()
	gohelper.setActive(self._gopvrewardcanget, true)
	gohelper.setActive(self._gopvrewardreceive, false)
	gohelper.setActive(self._btnpvrewarditem.gameObject, true)

	self._txtpvreward.text = self._pvconfig.actDesc .. " (1/1)"
end

function Activity2ndCollectionPageView:refreshCenterActUI()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(Activity196Enum.ActId)
end

function Activity2ndCollectionPageView:refreshActivityUI()
	self.playedActTagAudio = false
	self.playedActUnlockAudio = false

	for _, activityItem in ipairs(self._activityItemList) do
		self:refreshActivityItem(activityItem)
	end

	self:setActiveMailItem()
end

function Activity2ndCollectionPageView:setActiveMailItem()
	local activityStatus = ActivityHelper.getActivityStatus(Activity2ndEnum.ActivityId.MailActivty)
	local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self._goMail, isNormalStatus)

	local config = ActivityConfig.instance:getActivityCo(Activity2ndEnum.ActivityId.MailActivty)
	local redId = config and config.redDotId

	if isNormalStatus and redId then
		RedDotController.instance:addRedDot(self._goMailRedPoint, redId, Activity2ndEnum.ActivityId.MailActivty)
	end
end

function Activity2ndCollectionPageView:refreshActivityItem(activityItem)
	local activityStatus = ActivityHelper.getActivityStatus(activityItem.actId)
	local isNormalStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

	if activityItem.golimittime then
		gohelper.setActive(activityItem.golimittime, isNormalStatus)
	end

	activityItem.canvasGroup.alpha = isNormalStatus and 1 or 0.5

	local actInfoMo = ActivityModel.instance:getActivityInfo()[activityItem.actId]

	if not actInfoMo then
		return
	end

	if activityStatus == ActivityEnum.ActivityStatus.NotOpen then
		gohelper.setActive(activityItem.gotip, true)

		if activityItem.txttip then
			activityItem.txttip.text = string.format(luaLang("ShortenAct_TaskItem_remain_open"), actInfoMo:getRemainTimeStr2ByOpenTime())
		end
	elseif activityStatus == ActivityEnum.ActivityStatus.Expired or activityStatus == ActivityEnum.ActivityStatus.NotOnLine then
		gohelper.setActive(activityItem.gotip, true)

		if activityItem.txttip then
			activityItem.txttip.text = luaLang("ended")
		end
	elseif activityStatus == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(activityItem.gotip, false)

		if activityItem.txtlimittime then
			activityItem.txtlimittime.text = activityStatus == ActivityEnum.ActivityStatus.Normal and actInfoMo:getRemainTimeStr2ByEndTime() or ""
		end

		if activityItem.txtname then
			activityItem.txtname.text = actInfoMo.config.name
		end
	end

	if isNormalStatus and activityItem.redDotId and activityItem.redDotId ~= 0 then
		if activityItem.actId == Activity2ndEnum.ActivityId.AnnualReview then
			self._annualRed = RedDotController.instance:addRedDot(activityItem.goRedPoint, activityItem.redDotId, nil, self._checkFirstClickRed, self)
		elseif activityItem.actId == Activity2ndEnum.ActivityId.ActiveActivity then
			RedDotController.instance:addRedDot(activityItem.goRedPoint, activityItem.redDotId, nil, nil, nil)
		else
			RedDotController.instance:addRedDot(activityItem.goRedPoint, activityItem.redDotId, activityItem.actId, nil, nil)
		end
	end
end

function Activity2ndCollectionPageView:_activityBtnOnClick(activityItem)
	local checkFunc = self["checkActivityCanClickFunc" .. activityItem.index]

	checkFunc = checkFunc or self.defaultCheckActivityCanClick

	if not checkFunc(self, activityItem) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	local clickCallback = self["onClickActivity" .. activityItem.index]

	if clickCallback then
		clickCallback(self, activityItem.actId)

		if activityItem.actId ~= Activity2ndEnum.ActivityId.AnnualReview then
			AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.stop_ui_fuleyuan_typewriter_loop)
		end
	end

	ActivityEnterMgr.instance:enterActivity(activityItem.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		activityItem.actId
	})
end

function Activity2ndCollectionPageView:defaultCheckActivityCanClick(activityItem)
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(activityItem.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return true
end

function Activity2ndCollectionPageView:refreshShowTips(str)
	if self._showTips then
		return
	end

	self._showTips = true
	self._txtInputTip.text = str

	gohelper.setActive(self._goInputTip, true)
	TaskDispatcher.runDelay(self._endShowTip, self, self._showTipTime)
end

function Activity2ndCollectionPageView:_endShowTip()
	TaskDispatcher.cancelTask(self._endShowTip, self)

	self._showTips = false

	gohelper.setActive(self._goInputTip, false)
end

function Activity2ndCollectionPageView:onClickMailBtn()
	local param = {
		actId = Activity2ndEnum.ActivityId.MailActivty
	}

	Activity2ndController.instance:statButtonClick(Activity2ndEnum.ActivityId.MailActivty)
	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.stop_ui_fuleyuan_typewriter_loop)
	ViewMgr.instance:openView(ViewName.Activity2ndMailView, param)
end

function Activity2ndCollectionPageView:onClickActivity1(actId)
	Activity2ndController.instance:statButtonClick(actId)
	SDKDataTrackMgr.instance:trackClickActivityJumpButton()

	local url = Activity125Config.instance:getH5BaseUrl(actId)

	WebViewController.instance:simpleOpenWebBrowser(url)

	if GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Activity2ndAnnualReview, 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Activity2ndAnnualReview, 1)
		self:_checkFirstClickRed(self._annualRed)
	end
end

function Activity2ndCollectionPageView:onClickActivity2(actId)
	local function openfunc()
		local param = {
			actId = actId
		}

		ViewMgr.instance:openView(ViewName.Activity2ndShowSkinView, param)
	end

	Activity101Rpc.instance:sendGet101InfosRequest(actId, openfunc, self)
	Activity2ndController.instance:statButtonClick(actId)
end

function Activity2ndCollectionPageView:onClickActivity3(actId)
	local function openfunc()
		local param = {
			actId = actId
		}

		ViewMgr.instance:openView(ViewName.Activity2ndTakePhotosView, param)
	end

	Activity2ndController.instance:statButtonClick(actId)
	Activity125Rpc.instance:sendGetAct125InfosRequest(actId, openfunc, self)
end

function Activity2ndCollectionPageView:onClickActivity4(actId)
	local param = {
		actId = actId
	}

	Activity2ndController.instance:statButtonClick(actId)
	ViewMgr.instance:openView(ViewName.V2a8_SelfSelectCharacterView, param)
end

function Activity2ndCollectionPageView:onClickActivity5(actId)
	local function openfunc()
		local param = {
			actId = actId
		}

		ViewMgr.instance:openView(ViewName.Activity197View, param)
	end

	Activity2ndController.instance:statButtonClick(actId)
	Activity197Rpc.instance:sendGet197InfoRequest(actId, openfunc, self)
end

function Activity2ndCollectionPageView:checkReceied(actId)
	return (ActivityType101Model.instance:isType101RewardGet(actId, 1))
end

function Activity2ndCollectionPageView:checkCanGet(actId)
	return (ActivityType101Model.instance:isType101RewardCouldGet(actId, 1))
end

function Activity2ndCollectionPageView:onReceivePVBtn()
	local actId = Activity2ndEnum.ActivityId.V2a8_PVPopupReward

	if self:checkReceied(actId) then
		gohelper.setActive(self._gopvrewardcanget, false)
		gohelper.setActive(self._gopvrewardreceive, true)
		gohelper.setActive(self._btnpvrewarditem.gameObject, false)

		self._onceGetReward = true
	end
end

function Activity2ndCollectionPageView:_checkFirstClickRed(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = Activity2ndModel.instance:checkAnnualReviewShowRed()

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function Activity2ndCollectionPageView:onDestroyView()
	return
end

function Activity2ndCollectionPageView:onClose()
	TaskDispatcher.cancelTask(self._endShowTip, self)
	TaskDispatcher.cancelTask(self._afteranim, self)

	if self._btnList and #self._btnList > 0 then
		for index, value in ipairs(self._btnList) do
			value.btn:RemoveClickListener()
		end
	end

	if self._activityItemList and #self._activityItemList > 0 then
		for index, value in ipairs(self._activityItemList) do
			value.btn:RemoveClickListener()
		end
	end

	Activity2ndModel.instance:cleanShowTypeMechine()
	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.stop_ui_fuleyuan_typewriter_loop)
end

return Activity2ndCollectionPageView
