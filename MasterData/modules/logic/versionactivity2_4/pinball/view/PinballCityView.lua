-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballCityView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballCityView", package.seeall)

local PinballCityView = class("PinballCityView", BaseView)

function PinballCityView:onInitView()
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_start")
	self._btnrest = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_rest")
	self._gorestgery = gohelper.findChild(self.viewGO, "Right/#btn_rest/gery")
	self._btnend = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_end")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_task")
	self._gotaskred = gohelper.findChild(self.viewGO, "Right/#btn_task/#go_reddotreward")
	self._txtDay = gohelper.findChildTextMesh(self.viewGO, "Top/#txt_day")
	self._topCurrencyRoot = gohelper.findChild(self.viewGO, "Top/#go_currency")
	self._leftCurrencyRoot = gohelper.findChild(self.viewGO, "Left/#go_currency")
	self._leftCurrencyItem = gohelper.findChild(self.viewGO, "Left/#go_currency/go_item")
	self._btnmood = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_mood/#btn_mood")
	self._imagemoodicon = gohelper.findChildImage(self.viewGO, "Left/#go_mood/#btn_mood/#simage_icon")
	self._imagemood1 = gohelper.findChildImage(self.viewGO, "Left/#go_mood/#btn_mood/#simage_progress1")
	self._imagemood2 = gohelper.findChildImage(self.viewGO, "Left/#go_mood/#btn_mood/#simage_progress2")
	self._imagemood2_eff = gohelper.findChildImage(self.viewGO, "Left/#go_mood/#btn_mood/#simage_progress2/#simage_progress2_eff")
	self._btntip = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_mood/#btn_tips")
	self._gotipright = gohelper.findChild(self.viewGO, "Left/#go_mood/#go_tipright")
	self._gotiptop = gohelper.findChild(self.viewGO, "Left/#go_mood/#go_tiptop")
	self._txttiptopnum = gohelper.findChildTextMesh(self.viewGO, "Left/#go_mood/#go_tiptop/layout/#txt_num")
	self._txtrighttips = gohelper.findChildTextMesh(self.viewGO, "Left/#go_mood/#go_tipright/#scroll_dec/Viewport/Content/#txt_desc")
	self._btnclosetip = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_mood/#go_tipright/#btn_close")
	self._goTry = gohelper.findChild(self.viewGO, "Left/#go_Try")
	self._goTips = gohelper.findChild(self.viewGO, "Left/#go_Try/#go_Tips")
	self._simageReward = gohelper.findChildSingleImage(self.viewGO, "Left/#go_Try/#go_Tips/#simage_Reward")
	self._txtNum = gohelper.findChildText(self.viewGO, "Left/#go_Try/#go_Tips/#txt_Num")
	self._btnitem = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Try/#go_Tips/#btn_item")
	self._goResetBtn = gohelper.findChild(self.viewGO, "Left/image_ResetBtn")
	self._goTryBtn = gohelper.findChild(self.viewGO, "Left/#go_Try/image_TryBtn")
	self._anim = gohelper.findChildAnim(self.viewGO, "")
end

function PinballCityView:addEvents()
	self._btnstart:AddClickListener(self._onStartClick, self)
	self._btnrest:AddClickListener(self._onRestClick, self)
	self._btnend:AddClickListener(self._onEndClick, self)
	self._btntask:AddClickListener(self._onTaskClick, self)
	self._btnclosetip:AddClickListener(self.closeTips, self)
	self._btnmood:AddClickListener(self._openCloseTopTips, self)
	self._btntip:AddClickListener(self._openCloseRightTips, self)

	self._btnReset = SLFramework.UGUI.UIClickListener.Get(self._goResetBtn)

	self._btnReset:AddClickListener(self._clickReset, self)

	self._btnTry = SLFramework.UGUI.UIClickListener.Get(self._goTryBtn)

	self._btnTry:AddClickListener(self._clickTrial, self)
	PinballController.instance:registerCallback(PinballEvent.EndRound, self._refreshUI, self)
	PinballController.instance:registerCallback(PinballEvent.OperChange, self._refreshUI, self)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, self._refreshMood, self)
	PinballController.instance:registerCallback(PinballEvent.OperBuilding, self._refreshMood, self)
	PinballController.instance:registerCallback(PinballEvent.LearnTalent, self._refreshMood, self)
	PinballController.instance:registerCallback(PinballEvent.DataInited, self._refreshUI, self)
	self.viewContainer:registerCallback(PinballEvent.ClickScene, self.closeTips, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.closeTips, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.onViewClose, self)
end

function PinballCityView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnrest:RemoveClickListener()
	self._btnend:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnclosetip:RemoveClickListener()
	self._btnmood:RemoveClickListener()
	self._btntip:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnTry:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.EndRound, self._refreshUI, self)
	PinballController.instance:unregisterCallback(PinballEvent.OperChange, self._refreshUI, self)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, self._refreshMood, self)
	PinballController.instance:unregisterCallback(PinballEvent.OperBuilding, self._refreshMood, self)
	PinballController.instance:unregisterCallback(PinballEvent.LearnTalent, self._refreshMood, self)
	PinballController.instance:unregisterCallback(PinballEvent.DataInited, self._refreshUI, self)
	self.viewContainer:unregisterCallback(PinballEvent.ClickScene, self.closeTips, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.closeTips, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onViewClose, self)
end

function PinballCityView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio1)
	gohelper.setActive(self._leftCurrencyItem, false)
	RedDotController.instance:addRedDot(self._gotaskred, RedDotEnum.DotNode.V2a4PinballTaskRed)
	self:closeTips()
	self:createCurrencyItem()
	self:_refreshUI()
	PinballStatHelper.instance:resetCityDt()
	PinballController.instance:sendGuideMainLv()
end

function PinballCityView:onViewClose(viewName)
	if viewName == ViewName.PinballDayEndView or viewName == ViewName.PinballGameView then
		self._anim.enabled = true

		self._anim:Play("open", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio1)
		TaskDispatcher.runDelay(self._openAnimFinish, self, 1.84)
	end
end

function PinballCityView:_openAnimFinish()
	self._anim.enabled = false
end

function PinballCityView:closeTips()
	gohelper.setActive(self._gotipright, false)
	gohelper.setActive(self._btntip, true)
	gohelper.setActive(self._gotiptop, false)
end

function PinballCityView:_openCloseTopTips()
	gohelper.setActive(self._gotipright, false)
	gohelper.setActive(self._btntip, true)
	gohelper.setActive(self._gotiptop, not self._gotiptop.activeSelf)
end

function PinballCityView:_openCloseRightTips()
	gohelper.setActive(self._gotipright, not self._gotipright.activeSelf)
	gohelper.setActive(self._btntip, not self._gotipright.activeSelf)
	gohelper.setActive(self._gotiptop, false)
end

function PinballCityView:_clickReset()
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PinballReset, MsgBoxEnum.BoxType.Yes_No, self._realReset, nil, nil, self)
end

function PinballCityView:_realReset()
	self._anim.enabled = true

	self._anim:Play("open", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio1)
	TaskDispatcher.runDelay(self._openAnimFinish, self, 1.84)
	PinballStatHelper.instance:sendResetCity()
	Activity178Rpc.instance:sendAct178Reset(VersionActivity2_4Enum.ActivityId.Pinball)
end

function PinballCityView:_clickTrial()
	if ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.Pinball) == ActivityEnum.ActivityStatus.Normal then
		local actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_4Enum.ActivityId.Pinball)
		local episodeId = actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function PinballCityView:_clickLock()
	local actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_4Enum.ActivityId.Pinball)
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function PinballCityView:createCurrencyItem()
	local topCurrency = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}

	for _, currencyType in ipairs(topCurrency) do
		local go = self:getResInst(self.viewContainer._viewSetting.otherRes.currency, self._topCurrencyRoot)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PinballCurrencyItem)

		comp:setCurrencyType(currencyType)
	end

	local leftCurrency = {
		PinballEnum.ResType.Food,
		PinballEnum.ResType.Play
	}

	for _, currencyType in ipairs(leftCurrency) do
		local go = gohelper.cloneInPlace(self._leftCurrencyItem)

		gohelper.setActive(go, true)

		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PinballCurrencyItem2)

		comp:setCurrencyType(currencyType)
	end
end

function PinballCityView:_refreshUI()
	local isFinishDay = PinballModel.instance.oper ~= PinballEnum.OperType.None

	gohelper.setActive(self._btnstart, not isFinishDay)
	gohelper.setActive(self._btnrest, not isFinishDay)
	gohelper.setActive(self._btnend, isFinishDay)
	gohelper.setActive(self._gorestgery, PinballModel.instance.restCdDay > 0)

	self._txtDay.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_day"), PinballModel.instance.day)

	self:_refreshMood()
	self:_refreshResetShow()
end

function PinballCityView:_refreshMood()
	local addVal = 0
	local arr = {}
	local index = 0

	if PinballModel.instance:getTotalFoodCost() > PinballModel.instance:getResNum(PinballEnum.ResType.Food) then
		local val = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.NoFoodAddComplaint)

		if val ~= 0 then
			index = index + 1

			table.insert(arr, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_food_not_enough"), index, val))

			addVal = addVal + val
		end
	else
		local val = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.FoodEnoughSubComplaint)

		if val ~= 0 then
			index = index + 1

			table.insert(arr, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_food_enough"), index, val))

			addVal = addVal - val
		end
	end

	if PinballModel.instance:getTotalPlayDemand() > PinballModel.instance:getResNum(PinballEnum.ResType.Play) then
		local val = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.NoPlayAddComplaint)

		if val ~= 0 then
			index = index + 1

			table.insert(arr, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_play_not_enough"), index, val))

			addVal = addVal + val
		end
	else
		local val = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.PlayEnoughSubComplaint)

		if val ~= 0 then
			index = index + 1

			table.insert(arr, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_play_enough"), index, val))

			addVal = addVal - val
		end
	end

	if PinballModel.instance.oper == PinballEnum.OperType.Rest and PinballModel.instance.restCdDay <= 0 then
		local val = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.RestSubComplaint)

		if val ~= 0 then
			index = index + 1

			table.insert(arr, GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_rest"), index, val))

			addVal = addVal - val
		end
	end

	self._txtrighttips.text = table.concat(arr, "\n")

	local max = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit)
	local threshold = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThreshold)
	local cur = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint)
	local next = addVal + cur

	next = Mathf.Clamp(next, 0, max)

	local curStage = 1

	if max <= cur then
		curStage = 3
	elseif threshold <= cur then
		curStage = 2
	end

	UISpriteSetMgr.instance:setAct178Sprite(self._imagemoodicon, "v2a4_tutushizi_heart_" .. curStage)
	UISpriteSetMgr.instance:setAct178Sprite(self._imagemood2, "v2a4_tutushizi_heartprogress_" .. curStage)

	if next < cur then
		UISpriteSetMgr.instance:setAct178Sprite(self._imagemood1, "v2a4_tutushizi_heartprogress_" .. curStage)
	else
		UISpriteSetMgr.instance:setAct178Sprite(self._imagemood1, "v2a4_tutushizi_heartprogress_4")
	end

	local value1 = cur / max
	local value2 = next / max

	if value2 < value1 then
		value2 = value1
		value1 = value2
	end

	self._imagemood1.fillAmount = value2
	self._imagemood2.fillAmount = value1
	self._imagemood2_eff.fillAmount = value1
	self._txttiptopnum.text = cur == next and string.format("%s/%s", cur, max) or next < cur and string.format("%s<#6EC47F>（-%s）</color>/%s", cur, cur - next, max) or string.format("%s<#D85B5B>（+%s）</color>/%s", cur, next - cur, max)
end

function PinballCityView:_onStartClick()
	ViewMgr.instance:openView(ViewName.PinballMapSelectView)
end

function PinballCityView:_onRestClick()
	if PinballModel.instance.restCdDay > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.PinballRestConfirm2, MsgBoxEnum.BoxType.Yes_No, self.onYesClick, nil, nil, self)

		return
	end

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.PinballRestConfirm, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.NotShow, self.onYesClick, nil, nil, self)
end

function PinballCityView:onYesClick()
	Activity178Rpc.instance:sendAct178Rest(VersionActivity2_4Enum.ActivityId.Pinball)
end

function PinballCityView:_onEndClick()
	Activity178Rpc.instance:sendAct178EndRound(VersionActivity2_4Enum.ActivityId.Pinball)
end

function PinballCityView:_onTaskClick()
	ViewMgr.instance:openView(ViewName.PinballTaskView)
end

function PinballCityView:onClose()
	PinballStatHelper.instance:sendExitCity()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.cancelTask(self._openAnimFinish, self)
end

function PinballCityView:_refreshResetShow()
	gohelper.setActive(self._btnReset, not self._isLock and PinballModel.instance.day >= PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ResetDay))
end

return PinballCityView
