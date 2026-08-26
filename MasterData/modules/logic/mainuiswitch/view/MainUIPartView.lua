-- chunkname: @modules/logic/mainuiswitch/view/MainUIPartView.lua

module("modules.logic.mainuiswitch.view.MainUIPartView", package.seeall)

local MainUIPartView = class("MainUIPartView", BaseView)

function MainUIPartView:onInitView()
	self._goactbottomDec = gohelper.findChild(self.viewGO, "bottom/#go_contentbg/act_bottomDec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainUIPartView:addEvents()
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, self.refreshMainUI, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnMainPopupFlowFinish, self._onMainPopupFlowFinish, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnDailyPopupFlowFinish, self._onMainPopupFlowFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._OnCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.TiggerMainUIFirstAnim, self._playFirstAnim, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.TiggerMainUICaiDanAnim, self._tiggerMainUICaiDanAnim, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
end

function MainUIPartView:removeEvents()
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, self.refreshMainUI, self)
	self.removeEventCb(self, MainController.instance, MainEvent.OnMainPopupFlowFinish, self._onMainPopupFlowFinish, self)
	self.removeEventCb(self, MainController.instance, MainEvent.OnDailyPopupFlowFinish, self._onMainPopupFlowFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._OnCloseViewFinish, self, LuaEventSystem.Low)
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.TiggerMainUIFirstAnim, self._playFirstAnim, self)
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.TiggerMainUICaiDanAnim, self._tiggerMainUICaiDanAnim, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
end

function MainUIPartView:_OnCloseViewFinish(viewName)
	return
end

function MainUIPartView:_onMainPopupFlowFinish()
	if self._uiId then
		self:_enterMainView()
		self:_playFirstAnim()
	end
end

function MainUIPartView:_enterMainView()
	if self._uiId == MainUISwitchEnum.Skin.Normal then
		if not self._aniroommask then
			local goani = gohelper.findChild(self.viewGO, "right/#btn_summon/1/mask/image")

			self._aniroommask = goani:GetComponent(typeof(UnityEngine.Animation))
		end

		self._aniroommask:Play()
	else
		if not self._aniroommask1 then
			local goani = gohelper.findChild(self.viewGO, "right/#btn_summon/2/icon/mask1/image")

			self._aniroommask1 = goani:GetComponent(typeof(UnityEngine.Animator))
		end

		self._aniroommask1:Play("in", 0, 0)
	end
end

function MainUIPartView:dailyRefresh()
	if not MainController.instance:isInPopupFlow() then
		self:_playFirstAnim()
	end
end

function MainUIPartView:_playFirstAnim(isPause, isForce)
	local isPlayFirst = TimeUtil.getDayFirstLoginRed(MainUISwitchEnum.FirstEnterMainView)
	local animName = (isForce or isPlayFirst) and "first" or "idle"

	if not isPause and isPlayFirst then
		TimeUtil.setDayFirstLoginRed(MainUISwitchEnum.FirstEnterMainView)
	end

	local animList = self._animParts[self._uiId]

	if animList then
		for part, anim in pairs(animList) do
			if part ~= MainUISwitchEnum.MainUIPart.CaiDan then
				self:playPartAnim(anim, animName, isPause)
			end
		end
	end
end

function MainUIPartView:_tiggerMainUICaiDanAnim(animName, isPause, viewName)
	if self.viewName ~= viewName then
		return
	end

	local animList = self._animParts[self._uiId]
	local anim = animList and animList[MainUISwitchEnum.MainUIPart.CaiDan]

	self:playPartAnim(anim, animName, isPause)
end

function MainUIPartView:onOpen()
	if self.viewParam then
		self:refreshMainUI(self.viewParam)
		self:_playFirstAnim(true)
	end
end

function MainUIPartView:_editableInitView()
	local anim = gohelper.findChild(self.viewGO, "right/#btn_role/2/act_rolehead/ani")

	self._imagerolehead = gohelper.findChildImage(anim, "act_rolehead")
	self._animrolehead = anim:GetComponent(typeof(UnityEngine.Animator))
end

function MainUIPartView:_initMainUIPart()
	local gomail = gohelper.findChild(self.viewGO, "left/#btn_mail")
	local gostorage = gohelper.findChild(self.viewGO, "left/#btn_storage")
	local goquest = gohelper.findChild(self.viewGO, "left/#btn_quest/btn")
	local gobank = gohelper.findChild(self.viewGO, "left/#btn_bank")
	local gobankeffect = gohelper.findChild(self.viewGO, "left/#btn_bank/#go_bankeffect")
	local goroom = gohelper.findChild(self.viewGO, "right/#btn_room")
	local gorole = gohelper.findChild(self.viewGO, "right/#btn_role")
	local gosummon = gohelper.findChild(self.viewGO, "right/#btn_summon")
	local gopower = gohelper.findChild(self.viewGO, "right/#btn_power")
	local gofight = gohelper.findChild(self.viewGO, "right/go_fight")
	local goactivityfight = gohelper.findChild(self.viewGO, "right/go_fight/#go_activityfight/#btn_fight")
	local gonormaljumpfight = gohelper.findChild(self.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight")
	local gonormalfight = gohelper.findChild(self.viewGO, "right/go_fight/#go_normalfight/#btn_fight")
	local goskinBg = gohelper.findChild(self.viewGO, "right/#go_skinBg")
	local goCaiDan = gohelper.findChild(self.viewGO, "right/#skin_caidan")

	self._goskinBgmask = gohelper.findChild(self.viewGO, "right/#go_skinBg/simage_mask")
	self._mainUIParts = self:getUserDataTb_()
	self._animParts = self:getUserDataTb_()
	self._skinAnimViews = self:getUserDataTb_()

	for _, skinId in pairs(MainUISwitchEnum.Skin) do
		local skinTb = self._mainUIParts[skinId]

		if not skinTb then
			skinTb = self:getUserDataTb_()
			self._mainUIParts[skinId] = skinTb
		end

		skinTb[MainUISwitchEnum.MainUIPart.Mail] = gohelper.findChild(gomail, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Quest] = gohelper.findChild(gostorage, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Storage] = gohelper.findChild(goquest, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Bank] = gohelper.findChild(gobank, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Room] = gohelper.findChild(goroom, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Role] = gohelper.findChild(gorole, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Summon] = gohelper.findChild(gosummon, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Power] = gohelper.findChild(gopower, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Fight] = gohelper.findChild(gofight, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.ActivityFight] = gohelper.findChild(goactivityfight, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.NormalFight] = gohelper.findChild(gonormalfight, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.NormalJumpFight] = gohelper.findChild(gonormaljumpfight, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.BankEffect] = gohelper.findChild(gobankeffect, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.SkinBG] = gohelper.findChild(goskinBg, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.CaiDan] = gohelper.findChild(goCaiDan, skinId)

		for _, part in pairs(MainUISwitchEnum.MainUIPart) do
			self:_initPartAnim(skinId, part)
		end
	end
end

function MainUIPartView:_initPartAnim(skinId, part)
	local animSkinTb = self._animParts[skinId]

	if not animSkinTb then
		animSkinTb = self:getUserDataTb_()
		self._animParts[skinId] = animSkinTb
	end

	local go = self._mainUIParts[skinId][part]

	if go then
		local anim = go:GetComponent(typeof(UnityEngine.Animator))

		if anim then
			animSkinTb[part] = anim
		end
	end

	local skinAnim = MainUISwitchEnum.SkinAnim[skinId]

	if skinAnim then
		if skinAnim.view and not self._skinAnimViews[skinId] then
			self._skinAnimViews[skinId] = skinAnim.view.New(skinId, self.viewGO)
		end

		self._skinAnimViews[skinId].viewParam = self.viewParam
	end
end

function MainUIPartView:refreshMainUI(id)
	id = id or MainUISwitchModel.instance:getCurUseUI()

	if self._uiId == id then
		return
	end

	self._uiId = id
	self._bankeffect = 1

	if not self._mainUIParts then
		self:_initMainUIPart()
	end

	local isShowSkinbgMask = true

	for _, co in ipairs(lua_scene_ui.configList) do
		local skinId = co.id
		local skinTb = self._mainUIParts[skinId]

		for _, part in pairs(MainUISwitchEnum.MainUIPart) do
			local obj = skinTb[part]

			if id == skinId then
				obj = obj or self._mainUIParts[MainUISwitchEnum.Skin.Normal][part]

				if obj then
					local isShow = self:_checkShowPartObj(skinId, part)

					gohelper.setActive(obj, isShow)

					if part == MainUISwitchEnum.MainUIPart.SkinBG and isShow then
						isShowSkinbgMask = false
					end
				end
			elseif self._mainUIParts[id] then
				local skinObj = self._mainUIParts[id][part]

				skinObj = skinObj or self._mainUIParts[MainUISwitchEnum.Skin.Normal][part]

				if obj and skinObj ~= obj then
					gohelper.setActive(obj, false)
				end
			end
		end
	end

	gohelper.setActive(self._goskinBgmask, isShowSkinbgMask)
	gohelper.setActive(self._goactbottomDec, id == MainUISwitchEnum.Skin.Sp01)
	TaskDispatcher.cancelTask(self._cutRoleHead, self)

	if id == MainUISwitchEnum.Skin.Sp01 then
		self:_delayCutHead()
		TaskDispatcher.runRepeat(self._cutRoleHead, self, MainUISwitchEnum.HeadCutTime)
	end

	self:_enterMainView()

	if self._skinAnimViews[id] then
		self._skinAnimViews[id]:onShow()
	end
end

function MainUIPartView:_checkShowPartObj(skinId, part)
	return true
end

function MainUIPartView:playPartAnim(anim, aniName, isPause)
	if not anim then
		return
	end

	anim:Play(aniName, 0, 0)

	if isPause then
		anim:Update(0)
	end

	anim.enabled = not isPause
end

function MainUIPartView:_cutRoleHead()
	self._animrolehead:Play(MainUISwitchEnum.AnimName.Switch, 0, 0)
	TaskDispatcher.cancelTask(self._delayCutHead, self)
	TaskDispatcher.runDelay(self._delayCutHead, self, MainUISwitchEnum.HeadCutLoadime)
end

function MainUIPartView:_delayCutHead()
	local random = math.random(1, 3)

	UISpriteSetMgr.instance:setMainSprite(self._imagerolehead, "main_act_rolehead_" .. random, true)
end

function MainUIPartView:onClose()
	TaskDispatcher.cancelTask(self._cutRoleHead, self)
	TaskDispatcher.cancelTask(self._delayCutHead, self)
	TaskDispatcher.cancelTask(self._enterMainView, self)
end

function MainUIPartView:onDestroyView()
	for _, view in pairs(self._skinAnimViews) do
		view:onDestroyView()
	end
end

return MainUIPartView
