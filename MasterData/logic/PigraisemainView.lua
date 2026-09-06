-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraisemainView.lua

module("logic.extensions.pigraise.view.PigraisemainView", package.seeall)

local PigraisemainView = class("PigraisemainView", ViewComponent)

function PigraisemainView:ctor()
	PigraisemainView.super.ctor(self)

	self._effQueue1 = {}
	self._effQueue2 = {}
	self._upQueue = {}
end

function PigraisemainView:buildUI()
	PigraisemainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnHelp = self:getBtn("btnHelp")
	self._goldBarCon = self:getGo("goldBarCon")
	self._lvGo = self:getGo("Left/Lv")
	self._txtLv = goutil.findChildTextComponent(self._lvGo, "txtLv")
	self._sldExp = self:getSlider("Left/Lv/exp")
	self._txtExp = goutil.findChildTextComponent(self._lvGo, "exp/txtexp")
	self._energy = self:getGo("Left/Energy")
	self._sldEnergy = self:getSlider("Left/Energy/value")
	self._imgEnergyFill = goutil.findChildImageComponent(self._energy.transform, "value/fill")
	self._mood = self:getGo("Left/Mood")
	self._sldMood = self:getSlider("Left/Mood/value")
	self._iconMood = goutil.findChildComponent(self._mood, "icon", "UIImageSpriteChange")
	self._imgMoodFill = goutil.findChildImageComponent(self._mood, "value/fill")
	self._imgHeart = goutil.findChild(self._sldExp.gameObject, "bg")
	self._event = self:getGo("Mid/event")
	self._btnHandle = self:getBtn("Mid/event/btnHandle")
	self._imgIcon = goutil.findChildComponent(self._event, "imgIcon", "UIImageSpriteChange")
	self._touch = self:getGo("Mid/touch")
	self._btnTouch = self:getBtn("Mid/touch/btnTouch")
	self._txtCountTouch = goutil.findChildTextComponent(self._touch, "btnTouch/Count/txt")
	self._txtTimeCD = goutil.findChildTextComponent(self._touch, "txtTimeCD")
	self._btnFeed = self:getBtn("Mid/feed/btnFeed")
	self._surplusage = self:getGo("Mid/feed/surplusage")
	self._txtSur = goutil.findChildTextComponent(self._surplusage, "txt")
	self._btnFollow = self:getBtn("Mid/btnFollow")
	self._btnFollowGo = self:getGo("Mid/btnFollow")
	self._btnCancelFollow = self:getBtn("Mid/btnCancelFollow")
	self._btnCancelFollowGo = self:getGo("Mid/btnCancelFollow")
	self._btnRename = self:getBtn("Mid/Name/renameBtn")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "Mid/Name/txtName")
	self._pig = self:getGo("Mid/pig")
	self._drag = Framework.UIDragTrigger.Get(self:getGo("Mid/drag"))
	self._btnPlayBubble = self:getBtn("Mid/drag")
	self._bubblePos = self:getGo("Mid/bubblePos")
	self._btnShowPrize = self:getBtn("Right/btnShowPrize")
	self._btnAdventure = self:getBtn("Right/btnAdventure")
	self._btnShowPoster = self:getBtn("Right/btnShowPoster")
	self._btnShowPosterGo = self:getGo("Right/btnShowPoster")
	self._pointEvent = self:getGo("Mid/event/btnHandle/imgPoint")
	self._pointPrize = self:getGo("Right/btnShowPrize/imgPoint")
	self._pointGetSSR = self:getGo("Right/btnShowPoster/imgPoint")
	self._pointAdventure = self:getGo("Right/btnAdventure/imgPoint")
	self._maskGo = self:getGo("mask")
	self._feedItemInfo = PigraiseConfig.instance:getFeedCostItem()
	self._useItem = string.split(self._feedItemInfo, ":")

	goutil.setActive(self._maskGo, false)
end

function PigraisemainView:bindEvents()
	PigraisemainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnHelp:AddClickListener(self._onClickBtnHelp, self)
	self._btnHandle:AddClickListener(self._onClickBtnEvent, self)
	self._btnTouch:AddClickListener(self._onClickBtnTouch, self)
	self._btnFeed:AddClickListener(self._onClickBtnFeed, self)
	self._btnFollow:AddClickListener(function()
		self:_onSwitchFollowState(true, true)
	end)
	self._btnCancelFollow:AddClickListener(function()
		self:_onSwitchFollowState(false, true)
	end)
	self._btnShowPrize:AddClickListener(self._onClickBtnShowPrize, self)
	self._btnAdventure:AddClickListener(self._onClickBtnAdventure, self)
	self._btnShowPoster:AddClickListener(self._onClickBtnShowPoster, self)
	self._btnPlayBubble:AddClickListener(self._onClickBtnPlayBubble, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._btnRename:AddClickListener(self._onClickBtnRename, self)
end

function PigraisemainView:unbindEvents()
	PigraisemainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
	self._btnHandle:RemoveClickListener()
	self._btnTouch:RemoveClickListener()
	self._btnFeed:RemoveClickListener()
	self._btnFollow:RemoveClickListener()
	self._btnCancelFollow:RemoveClickListener()
	self._btnShowPrize:RemoveClickListener()
	self._btnAdventure:RemoveClickListener()
	self._btnShowPoster:RemoveClickListener()
	self._btnPlayBubble:RemoveClickListener()
	self._btnRename:RemoveClickListener()
	self._drag:RemoveDragListener()
end

function PigraisemainView:destroyUI()
	PigraisemainView.super.destroyUI(self)
	self:_destroyShoutao()
end

function PigraisemainView:onEnter()
	PigraisemainView.super.onEnter(self)

	if not PigraiseModel.instance:isHavePigDefineId() then
		self:close()
		UIStateManager.instance:push(ViewName.PigraiseadoptView, true)

		return
	end

	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.getStateReq, self)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor)
	PigraiseController.instance:getStateReq(function()
		PigraiseModelMgr.instance:pushViewWithModel(self._pig, self._viewPresentor.viewName, 0.8, 210)
	end)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._refreshMatCountUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PigRaiseStateUpdate, self._refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PigFeedSuccess, self._playEffect, self)
	self:_onSwitchFollowState(PigraiseModel.instance:getIsFollow(), false)
	removetimer(self._updateTime, self)
	settimer(1, self._updateTime, self)
	self:_preLoadShoutao()
	RedPointController.instance:regRedPoint(self._pointEvent, RedPointModel.ID_PIGRAISE_EVENT)
	RedPointController.instance:regRedPoint(self._pointPrize, RedPointModel.ID_PIGRAISE_PRIZE)
	RedPointController.instance:regRedPoint(self._pointGetSSR, RedPointModel.ID_PIGRAISE_NEWPET)
	RedPointController.instance:regRedPoint(self._pointAdventure, RedPointModel.ID_PIGRAISE_ADVENTURE)
end

function PigraisemainView:onEnterFinished()
	PigraisemainView.super.onEnterFinished(self)
end

function PigraisemainView:onExit()
	self:_finishPlayBubble()
	PigraisemainView.super.onExit(self)
	removetimer(self._onTick, self)
	self:_destroyShoutao()
	self:_clearEffs()
	PigraiseModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.getStateReq, self)

	if self._isFollow ~= PigraiseModel.instance:getIsFollow() then
		PigraiseModel.instance:setFollowState(self._isFollow)
		PigraiseController.instance:followReq(PigraiseModel.instance:getIsFollow())
	end

	GlobalDispatcher:removeListener(GlobalNotify.PigFeedSuccess, self._playEffect, self)
	removetimer(self._updateTime, self)
	removetimer(self._finishPlayBubble, self)
	removetimer(self._sendTouch, self)
	self:_finishPlayBubble()
	RedPointController.instance:unregRedPoint(self._pointEvent, RedPointModel.ID_PIGRAISE_EVENT)
	RedPointController.instance:unregRedPoint(self._pointPrize, RedPointModel.ID_PIGRAISE_PRIZE)
	RedPointController.instance:unregRedPoint(self._pointGetSSR, RedPointModel.ID_PIGRAISE_NEWPET)
	RedPointController.instance:unregRedPoint(self._pointAdventure, RedPointModel.ID_PIGRAISE_ADVENTURE)
	goutil.setActive(self._maskGo, false)
end

function PigraisemainView:onExitFinished()
	PigraisemainView.super.onExitFinished(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._refreshMatCountUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PigRaiseStateUpdate, self._refreshUI, self)
end

function PigraisemainView:getStateReq()
	PigraiseController.instance:getStateReq()
end

function PigraisemainView:_refreshUI()
	self._txtName.text = PigraiseModel.instance:getPigName()
	self._txtLv.text = string.format("亲密度%s级", PigraiseModel.instance:getCurLevel())

	if PigraiseModel.instance:getCurShowIntimacyInfo() then
		local curIntimacy, curIntimacyMax = PigraiseModel.instance:getCurShowIntimacyInfo()

		self._sldExp:SetValue(curIntimacy / curIntimacyMax)

		self._txtExp.text = string.format("%s/%s", curIntimacy, curIntimacyMax)
	else
		self._sldExp:SetValue(1)

		self._txtExp.text = "已满级"
	end

	self:_refreshEnergyUI()
	self:_refreshMoodUI()
	self:_refreshFeedbackUI()
	self:_refreshTouchUI()
	self:_refreshMatCountUI()

	self._inTouching = false

	local info = PigraiseModel.instance:getCurPetInfo()

	if info then
		if not info.cfg.bubblePos1 then
			local pos = {}

			GameUtil.setLocalPos(self._bubblePos, checknumber(pos[1]), checknumber(pos[2]))
		end
	end
end

function PigraisemainView:_refreshEnergyUI()
	local value = checknumber(PigraiseModel.instance:getPigCurEnergy()) / checknumber(PigraiseConfig.instance:getMaxEnergyVal())

	self._sldEnergy:SetValue(value)

	if value <= 0.2 and value >= 0 then
		Game.ImageUtil.SetColorRGBA(self._imgEnergyFill, 0.9921568627450981, 0.19607843137254902, 0.24705882352941178, 1)
	elseif value <= 0.6 and value > 0.2 then
		Game.ImageUtil.SetColorRGBA(self._imgEnergyFill, 1, 0.9294117647058824, 0, 1)
	elseif value <= 1 and value > 0.6 then
		Game.ImageUtil.SetColorRGBA(self._imgEnergyFill, 0.12156862745098039, 0.9921568627450981, 0.0784313725490196, 1)
	end
end

function PigraisemainView:_refreshMoodUI()
	local value = checknumber(PigraiseModel.instance:getPigCurMood()) / checknumber(PigraiseConfig.instance:getMaxMoodVal())

	self._sldMood:SetValue(value)

	if value <= 0.2 and value >= 0 then
		Game.ImageUtil.SetColorRGBA(self._imgMoodFill, 0.9921568627450981, 0.19607843137254902, 0.24705882352941178, 1)
	elseif value <= 0.6 and value > 0.2 then
		Game.ImageUtil.SetColorRGBA(self._imgMoodFill, 1, 0.9294117647058824, 0, 1)
	elseif value <= 1 and value > 0.6 then
		Game.ImageUtil.SetColorRGBA(self._imgMoodFill, 0.12156862745098039, 0.9921568627450981, 0.0784313725490196, 1)
	end
end

function PigraisemainView:_refreshFeedbackUI()
	self._feedbackEventInfo = PigraiseModel.instance:getCurFeedbackEventInfo()

	if self._feedbackEventInfo then
		goutil.setActive(self._event, true)
		self._imgIcon:SetState(checkint(self._feedbackEventInfo.icon) - 1)
	else
		goutil.setActive(self._event, false)
	end
end

function PigraisemainView:_refreshTouchUI()
	self._txtCountTouch.text = PigraiseModel.instance:getDailyTouchTimes()
	self._txtTimeCD.text = ""
end

function PigraisemainView:_refreshMatCountUI()
	self._txtSur.text = MaterialMgr.getMatCount(self._feedItemInfo)
	self._isFeeding = false
end

function PigraisemainView:_updateTime()
	if PigraiseModel.instance:isupdatePigCurEnergy() then
		PigraiseModel.instance:updatePigCurEnergy()
		self:_refreshEnergyUI()
	end

	if PigraiseModel.instance:isupdatePigCurMood() then
		PigraiseModel.instance:updatePigCurMood()
		self:_refreshMoodUI()
	end

	if PigraiseModel.instance:isupdatePigCDTime() then
		local time = PigraiseModel.instance:getPigCDTime()
		local hour, min, sec = GameUtil.getTimeHHMMSS(time)

		self._txtTimeCD.text = string.format("%02d:%02d", min, sec)
		self._isNeedRreshTouchUI = true
	elseif self._isNeedRreshTouchUI then
		self._isNeedRreshTouchUI = false

		self:_refreshTouchUI()
	else
		return
	end
end

function PigraisemainView:_onClickBtnClose()
	self:close()
end

function PigraisemainView:_onClickBtnHelp()
	self:_finishPlayBubble()
	ViewMgr.instance:open(ViewName.RulesView, "pigraiserule")
end

function PigraisemainView:_onFoodEffectLoaded(eff)
	local targetGo = PigraiseModelMgr.instance:getAvatarPet():getGameObject().transform.parent.gameObject

	goutil.addChildToParent(eff.effGo, targetGo)
	Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, -2.5)
	Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 0.01, 0.01, 0.01)

	self._foodeff = eff
end

function PigraisemainView:_onClickBtnEvent()
	self:_finishPlayBubble()

	if self._feedbackEventInfo then
		UIStateManager.instance:push(ViewName.PigraiseeventView, self._feedbackEventInfo)
	end

	goutil.setActive(self._event, false)
end

function PigraisemainView:_onClickBtnTouch()
	local touchtime = PigraiseModel.instance:getDailyTouchTimes()

	if touchtime <= 0 then
		FloatWordMgr.instance:show(string.format("今天抚摸次数已用完，明天再来抚摸%s吧", PigraiseModel.instance:getPigName()))

		return
	end

	if PigraiseModel.instance:isupdatePigCDTime() then
		FloatWordMgr.instance:show(string.format("距离上次抚摸还太早，再等等哦"))

		return
	end

	if not self._inTouching then
		self:_startTouch()
	end
end

function PigraisemainView:_startTouch()
	if not self._shoutaoGo then
		return
	end

	local avatarPet = PigraiseModelMgr.instance:getAvatarPet()
	local petGo = avatarPet and avatarPet:getGameObject()
	local petParent = petGo and petGo.transform.parent

	if not petParent then
		return
	end

	goutil.setActive(self._maskGo, true)

	self._inTouching = true

	self._shoutaoGo.transform:SetParent(PigraiseModelMgr.instance:getAvatarPet():getGameObject().transform.parent)
	Framework.TransformUtil.SetLocalRotation(self._shoutaoGo.transform, 300, 0, 0)
	Framework.TransformUtil.SetLocalPos(self._shoutaoGo.transform, 0, 2.5, -5)
	Framework.TransformUtil.SetLocalScale(self._shoutaoGo.transform, 5, 5, 5)
	goutil.setActive(self._shoutaoGo, true)
	removetimer(self._sendTouch, self)
	settimer(3, self._sendTouch, self, false)
	PigraiseModelMgr.instance:getAvatarPet().animatorCtrl:setTrigger(UnityEngine.Animator.StringToHash("touch"))
end

function PigraisemainView:_sendTouch()
	goutil.setActive(self._maskGo, false)

	if self._shoutaoGo then
		self._shoutaoGo.transform:SetParent(nil)
		goutil.setActive(self._shoutaoGo, false)
	end

	if VipModel.instance:getIsAbleToOneKeyToTouchPig() then
		PigraiseController.instance:oneKeytouchReq()
	else
		PigraiseController.instance:touchReq()
	end
end

function PigraisemainView:_onClickBtnFeed()
	if checkint(MaterialMgr.getMatCount(self._feedItemInfo)) < checkint(self._useItem[3]) and checkint(self._useItem[3]) > 0 then
		MaterialMgr.openGetSource(checkint(self._useItem[1]), checkint(self._useItem[2]))

		local warning = string.format("%s的饲料不够了，要努力赚钱买粮", PigraiseModel.instance:getPigName())

		FloatWordMgr.instance:show(warning)

		return
	end

	if PigraiseModel.instance:getPigCurEnergy() >= PigraiseConfig.instance:getMaxEnergyVal() then
		local warning = string.format("别再喂啦！%s吃不下去了啦！", PigraiseModel.instance:getPigName())

		FloatWordMgr.instance:show(warning)

		return
	end

	if not self._isFeeding then
		self._isFeeding = true

		PigraiseModelMgr.instance:getAvatarPet().animatorCtrl:setTrigger(UnityEngine.Animator.StringToHash("eat"))

		local resPath = "fx_ui_zhuzhuyangcheng/fx_ui_zhuzhuyangcheng_04.prefab"
		local targetGo = PigraiseModelMgr.instance:getAvatarPet():getGameObject()

		self._foodeff = UIEffectManager.instance:playEffect(self, resPath, nil, 0, 0, false, false, nil, function(target, eff)
			goutil.addChildToParent(eff.effGo, targetGo)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, -0.041, 0, 0.39)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 0.002, 0.002, 0.002)
			eff:setLayer(Framework.LayerUtil.NameToLayer(SceneLayer.UI3D))
			eff:setVisible(true, true)
		end)

		PigraiseController.instance:feedReq()
	end
end

function PigraisemainView:_sendFeedReq()
	PigraiseController.instance:feedReq()
	goutil.setActive(self._maskGo, false)
end

function PigraisemainView:_playEffect(addValue, isUp)
	addValue = checknumber(addValue)

	if addValue > 0 then
		if not ViewMgr.instance:isOpen(ViewName.FavorChange) then
			UIStateManager.instance:open(ViewName.FavorChange, addValue)
		else
			GlobalDispatcher:dispatch(GlobalNotify.PigFavorChange, addValue)
		end

		self._queue = self._queue or {}

		if #self._queue == 0 then
			settimer(0, self._onTick, self, true)
		end

		table.insert(self._queue, UnityEngine.Time.time + 0.2)
		table.insert(self._upQueue, isUp == true)
	end
end

function PigraisemainView:_onLoaded(eff)
	eff:setParent(eff.widget.transform)
	eff:setScale(1)
	GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(eff.widget) + 1)
	eff:setVisible(true, true)
end

function PigraisemainView:_onTick()
	if #self._queue == 0 then
		removetimer(self._onTick, self)
	elseif UnityEngine.Time.time >= self._queue[1] then
		local path = "fx_ui_zhuzhuyangcheng/fx_ui_zhuzhuyangcheng_03.prefab"
		local curEff = UIEffectManager.instance:playEffect(self, path, self.mainGO, 0, 0, false, false, self._onFinished1, self._onLoaded, self)

		curEff:setEffTime(0.5)
		table.insert(self._effQueue1, curEff)
		table.remove(self._queue, 1)
	end
end

function PigraisemainView:_onFinished1(eff)
	UIEffectManager.instance:stopEffect(eff)
	table.remove(self._effQueue1, 1)

	local path = "fx_ui_zhuzhuyangcheng/fx_ui_zhuzhuyangcheng_02.prefab"
	local curEff = UIEffectManager.instance:playEffect(self, path, self._imgHeart, 0, 0, false, false, self._onFinished2, self._onLoaded, self)

	table.insert(self._effQueue2, curEff)
end

function PigraisemainView:_onFinished2(eff)
	UIEffectManager.instance:stopEffect(eff)
	table.remove(self._effQueue2, 1)

	local isPlayUp = self._upQueue[1]

	table.remove(self._upQueue, 1)

	if isPlayUp then
		local path = "fx_ui_zhuzhuyangcheng/fx_ui_zhuzhuyangcheng_01.prefab"

		self._upEff = UIEffectManager.instance:playEffect(self, path, self.mainGO, 0, 0, false, false, self._onFinished3, self._onLoaded, self)
	end
end

function PigraisemainView:_onFinished3(eff)
	UIEffectManager.instance:stopEffect(eff)

	self._upEff = nil
end

function PigraisemainView:_clearEffs()
	if self._upEff then
		UIEffectManager.instance:stopEffect(self._upEff)

		self._upEff = nil
	end

	for _, v in ipairs(self._effQueue1) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effQueue1 = {}

	for _, v in ipairs(self._effQueue2) do
		UIEffectManager.instance:stopEffect(v)
	end

	UIEffectManager.instance:stopEffect(self._foodeff)

	self._foodeff = nil
	self._effQueue2 = {}
	self._queue = {}
	self._upQueue = {}
end

function PigraisemainView:_onSwitchFollowState(isFollow, isShowTips)
	self._isFollow = isFollow

	goutil.setActive(self._btnFollowGo, not isFollow)
	goutil.setActive(self._btnCancelFollowGo, isFollow)

	if not isShowTips then
		return
	end

	if isFollow then
		FloatWordMgr.instance:show("主人今天你要带我出去玩吗？最喜欢你了！")
	else
		FloatWordMgr.instance:show("今天也玩得够累了，谢谢主人哦！")
	end
end

function PigraisemainView:_onDrag(eventData)
	PigraiseModelMgr.instance:onModelTrun(eventData.delta.x)
end

function PigraisemainView:_onClickBtnShowPrize()
	self:_finishPlayBubble()
	UIStateManager.instance:push(ViewName.PigraiseprizeView)
end

function PigraisemainView:_onClickBtnAdventure()
	self:_finishPlayBubble()
	UIStateManager.instance:push(ViewName.PigraiseadventureView)
end

function PigraisemainView:_onClickBtnShowPoster()
	self:_finishPlayBubble()
	UIStateManager.instance:push(ViewName.PigskinselectView)
end

function PigraisemainView:_onClickBtnPlayBubble()
	if not self._isPlayBubble then
		local newstr = PigraiseModel.instance:getCurPigDialogue()

		if newstr then
			self._isPlayBubble = true
			newstr = string.gsub(newstr, "#username#", RoleModel.instance:getUserName())

			BubbleController.instance:OpenView(newstr, self._bubblePos.transform.position, true)
			settimer(2.5, self._finishPlayBubble, self, false)
		end
	end
end

function PigraisemainView:_finishPlayBubble()
	BubbleController.instance:CloseView()

	self._isPlayBubble = false
end

function PigraisemainView:_preLoadShoutao()
	self._resPath = GameUrl.getSpineUrl("30003_pet_shoutao")

	getres(self._resPath, self._onShoutaoLoaded, self, ResType.AssetBundle, true)
end

function PigraisemainView:_onShoutaoLoaded(res)
	local resPath = self._resPath

	self:_destroyShoutao()

	if not resPath or res.ResPath ~= resPath then
		return
	end

	if res and res.IsSuccess then
		self._resPath = res.ResPath
		self._shoutaoRes = res

		self._shoutaoRes:Retain()

		self._shoutaoGo = goutil.clone(res:GetMainAsset())

		goutil.setActive(self._shoutaoGo, false)
		Framework.GameObjectUtil.SetLayerRecursively(self._shoutaoGo, Framework.LayerUtil.NameToLayer(SceneLayer.UI3D))
	end
end

function PigraisemainView:_destroyShoutao()
	if self._shoutaoGo then
		goutil.destroy(self._shoutaoGo, true)

		self._shoutaoGo = nil
	end

	if self._shoutaoRes then
		self._shoutaoRes:Release()

		self._shoutaoRes = nil
	end

	self._resPath = nil
end

function PigraisemainView:_onClickBtnRename()
	self:_finishPlayBubble()

	local v = FriendConfig.instance:getCommonValue("NO_RENAME_PERIOD")
	local times = string.split(v, "#")

	if #times == 2 and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
		FloatWordMgr.instance:show("本功能正在进行技术维护，具体开放时间请留意公告！")

		return
	end

	UIStateManager.instance:push(ViewName.PigskinrenameView)
end

return PigraisemainView
