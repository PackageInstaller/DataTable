-- chunkname: @modules/logic/versionactivity1_4/act133/view/Activity133View.lua

module("modules.logic.versionactivity1_4.act133.view.Activity133View", package.seeall)

local Activity133View = class("Activity133View", BaseView)

function Activity133View:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/Content/#go_item")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_obtain/#go_reddot")
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gocheckingmask = gohelper.findChild(self.viewGO, "checkingmask")
	self._simagecheckingmask = gohelper.findChildSingleImage(self.viewGO, "checkingmask/mask/#simage_checkingmask")
	self._txttitle = gohelper.findChildText(self.viewGO, "checkingmask/detailbg/#txt_title")
	self._txtdetail = gohelper.findChildText(self.viewGO, "checkingmask/detailbg/scroll_view/Viewport/Content/#txt_detail")
	self._simagecompleted = gohelper.findChildSingleImage(self.viewGO, "#simage_completed")
	self._com_animator = self._simagecompleted.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._imagetitle = gohelper.findChildImage(self.viewGO, "#image_title")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "#image_title/remaintime/bg/#txt_remaintime")
	self._txtschedule = gohelper.findChildText(self.viewGO, "schedule/bg/txt_scheduletitle/#txt_schedule")
	self._imagefill = gohelper.findChildImage(self.viewGO, "schedule/fill/#go_fill")
	self._btnobtain = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_obtain")
	self._unlockAniTime = 0.6
	self.tweenDuration = 0.6
	self._completedAnitime = 1
	self._itemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity133View:addEvents()
	self._btnobtain:AddClickListener(self._btnobtainOnClick, self)

	self.maskClick = SLFramework.UGUI.UIClickListener.Get(self._simagecheckingmask.gameObject)

	self.maskClick:AddClickListener(self._onClickMask, self)
	self.addEventCb(self, Activity133Controller.instance, Activity133Event.OnSelectCheckNote, self._checkNote, self)
	self.addEventCb(self, Activity133Controller.instance, Activity133Event.OnUpdateInfo, self.onUpdateParam, self)
	self.addEventCb(self, Activity133Controller.instance, Activity133Event.OnGetBonus, self._onGetBouns, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function Activity133View:removeEvents()
	self._btnobtain:RemoveClickListener()
	self.maskClick:RemoveClickListener()
	self.removeEventCb(self, Activity133Controller.instance, Activity133Event.OnSelectCheckNote, self._checkNote, self)
	self.removeEventCb(self, Activity133Controller.instance, Activity133Event.OnUpdateInfo, self.onUpdateParam, self)
	self.removeEventCb(self, Activity133Controller.instance, Activity133Event.OnGetBonus, self._onGetBouns, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function Activity133View:_btnobtainOnClick()
	Activity133Controller.instance:openActivity133TaskView({
		self.actId
	})
end

function Activity133View:_editableInitView()
	self._simagefullbg:LoadImage(ResUrl.getActivity133Icon("v1a4_shiprepair_fullbg_0"))
	self._simagecheckingmask:LoadImage(ResUrl.getActivity133Icon("v1a4_shiprepair_fullbg_mask"))

	self._focusmaskopen = false
	self._csView = self.viewContainer._scrollview
	self._fixitemList = {}
	self.needfixnum = Activity133Config.instance:getNeedFixNum()

	for i = 1, self.needfixnum do
		local fixitem = self:getUserDataTb_()

		fixitem.go = gohelper.findChild(self.viewGO, "#simage_fullbg/" .. i)

		gohelper.setActive(fixitem.go, false)

		fixitem.hadfix = false
		fixitem.id = i

		if fixitem.go then
			table.insert(self._fixitemList, fixitem)
		end
	end

	local finnalbonus = Activity133Config.instance:getFinalBonus()

	self.finalBonus = GameUtil.splitString2(finnalbonus, true)

	for i, value in ipairs(self.finalBonus) do
		local item = self._itemList[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self._goitem)

			gohelper.setActive(item.go, true)

			item.icon = IconMgr.instance:getCommonPropItemIcon(item.go)
			item.goget = gohelper.findChild(item.go, "get")

			gohelper.setAsLastSibling(item.goget)
			gohelper.setActive(item.goget, false)
			table.insert(self._itemList, item)
		end

		item.icon:setMOValue(value[1], value[2], value[3], nil, true)
		item.icon:SetCountLocalY(45)
		item.icon:SetCountBgHeight(30)
		item.icon:setCountFontSize(36)
	end
end

function Activity133View:onUpdateParam()
	Activity133ListModel.instance:init(self._scrollview.gameObject)
	self:_refreshView()
end

function Activity133View:_fixShip(id)
	if id then
		local molist = Activity133ListModel.instance:getList()
		local iconid

		for key, mo in pairs(molist) do
			if mo.id == id then
				iconid = mo.icon
			end
		end

		local item = self._fixitemList[iconid]

		if item then
			gohelper.setActive(item.go, true)

			local animator = item.go:GetComponent(typeof(UnityEngine.Animator))

			animator.speed = 1

			animator:Play(UIAnimationName.Open, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
			animator:Update(0)
		end
	end

	self:_refreshFixList()
end

function Activity133View:_refreshView(state)
	if state then
		self:_refreshFixList()
		self:_checkFixNum()
	end

	self:_refreshRemainTime()
	self:_checkCompletedItem()
	self:_refreshRedDot()
end

function Activity133View:_refreshFixList()
	local molist = Activity133ListModel.instance:getList()

	for i, mo in pairs(molist) do
		local iconid = mo.icon

		if mo:isReceived() then
			gohelper.setActive(self._fixitemList[iconid].go, true)
		else
			gohelper.setActive(self._fixitemList[iconid].go, false)
		end
	end
end

function Activity133View:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView and self.fixid then
		self:_fixShip(self.fixid)
	end
end

function Activity133View:_refreshRedDot()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.Activity1_4Act133Task)
end

function Activity133View:_onGetBouns(msg)
	self.fixid = msg.id

	self:_checkFixedCompleted()
end

function Activity133View:_checkFixedCompleted()
	local fixednum = Activity133Model.instance:getFixedNum()

	self._txtschedule.text = fixednum .. "/" .. self.needfixnum

	local value = Mathf.Clamp01(fixednum / self.needfixnum)

	self._imagefill.fillAmount = value

	if value == 1 then
		self._iscomplete = true

		function self.callback()
			TaskDispatcher.cancelTask(self.callback, self)
			gohelper.setActive(self._simagecompleted.gameObject, true)

			self._com_animator.speed = 1

			self._com_animator:Play(UIAnimationName.Open, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_preference_open)
			self._com_animator:Update(0)
			TaskDispatcher.runDelay(self._onCompletedAniFinish, self, self._completedAnitime)
		end

		TaskDispatcher.runDelay(self.callback, self, 1.8)
	else
		gohelper.setActive(self._simagecompleted.gameObject, false)
		self:_checkFixNum()
	end
end

function Activity133View:_onCompletedAniFinish()
	TaskDispatcher.cancelTask(self._onCompletedAniFinish, self)
	self:_checkCompletedItem()

	local co = {}

	for _, reward in ipairs(self.finalBonus) do
		local o = MaterialDataMO.New()

		o:initValue(reward[1], reward[2], reward[3], nil, true)
		table.insert(co, o)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, co)
end

function Activity133View:_checkCompletedItem()
	for _, item in pairs(self._itemList) do
		gohelper.setActive(item.goget, self._iscomplete)

		if self._iscomplete then
			item.icon:setAlpha(0.45, 0.8)
		else
			item.icon:setAlpha(1, 1)
		end
	end
end

function Activity133View:_checkFixNum()
	local fixednum = Activity133Model.instance:getFixedNum()

	self._txtschedule.text = fixednum .. "/" .. self.needfixnum

	local value = Mathf.Clamp01(fixednum / self.needfixnum)

	self._imagefill.fillAmount = value

	if value == 1 then
		self._iscomplete = true

		gohelper.setActive(self._simagecompleted.gameObject, true)
	else
		gohelper.setActive(self._simagecompleted.gameObject, false)
	end
end

function Activity133View:_refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
	local remainTime = day .. luaLang("time_day") .. hour .. luaLang("time_hour2")

	self._txtremaintime.text = string.format(luaLang("remain"), remainTime)
end

function Activity133View:_checkNote(mo)
	if mo then
		local id = mo.id
		local posX, posY = mo:getPos()

		Activity133Model.instance:setSelectID(id)

		if not self._focusmaskopen then
			self._focusmaskopen = true

			gohelper.setActive(self._gocheckingmask, true)
		end

		local mo = Activity133ListModel.instance:getById(id)

		UIBlockMgr.instance:startBlock("Activity133View")
		self:_moveBg(posX, posY, 2.5, 1)

		self._txttitle.text = mo.title
		self._txtdetail.text = mo.desc

		gohelper.setActive(self._simagecompleted.gameObject, not self._focusmaskopen and self._iscomplete)
	else
		if self._focusmaskopen then
			self._focusmaskopen = false

			gohelper.setActive(self._gocheckingmask, false)
			UIBlockMgr.instance:startBlock("Activity133View")
			self:_moveBg(nil, nil, 1, 0)

			local id = Activity133Model.instance:getSelectID()

			self._csView:selectCell(id, false)
		end

		gohelper.setActive(self._simagecompleted.gameObject, not self._focusmaskopen and self._iscomplete)
	end
end

function Activity133View:_moveBg(x, y, scale, alpha)
	self:playMoveTween(x, y)
	self:playScaleTween(scale)
	self:playDoFade(alpha, 0.2)
end

function Activity133View:playDoFade(endAlpha, time)
	if self._fadeTweenId then
		ZProj.TweenHelper.KillById(self._fadeTweenId)

		self._fadeTweenId = nil
	end

	local canvasGroup = self._gocheckingmask:GetComponent(typeof(UnityEngine.CanvasGroup))
	local startAlpha = canvasGroup.alpha

	self._fadeTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self._gocheckingmask, startAlpha, endAlpha, time)
end

function Activity133View:playScaleTween(to)
	if self._scaleTweenId then
		ZProj.TweenHelper.KillById(self._scaleTweenId)

		self._scaleTweenId = nil
	end

	self._scaleTweenId = ZProj.TweenHelper.DOScale(self._simagefullbg.transform, to, to, to, self.tweenDuration, self.onTweenFinish, self)
end

function Activity133View:onTweenFinish()
	UIBlockMgr.instance:endBlock("Activity133View")
end

function Activity133View:playMoveTween(x, y)
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	self._moveTweenId = x and y and ZProj.TweenHelper.DOAnchorPos(self._simagefullbg.transform, x, y, self.tweenDuration) or ZProj.TweenHelper.DOAnchorPos(self._simagefullbg.transform, 0, 0, self.tweenDuration)
end

function Activity133View:_onClickMask()
	if self._focusmaskopen then
		self._focusmaskopen = false

		gohelper.setActive(self._gocheckingmask, false)

		local id = Activity133Model.instance:getSelectID()

		self:_moveBg(nil, nil, 1, 0)
		self._csView:selectCell(id, false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
		gohelper.setActive(self._simagecompleted.gameObject, not self._focusmaskopen and self._iscomplete)
	end
end

function Activity133View:onOpen()
	self.actId = self.viewParam.actId

	ActivityEnterMgr.instance:enterActivity(self.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		self.actId
	})
	Activity133ListModel.instance:init(self._scrollview.gameObject)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
	self:_refreshView(true)
end

function Activity133View:onClose()
	return
end

function Activity133View:onDestroyView()
	self._simagefullbg:UnLoadImage()
	self._simagecheckingmask:UnLoadImage()
end

return Activity133View
