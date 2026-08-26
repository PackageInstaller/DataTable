-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityEnterPatFaceView.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityEnterPatFaceView", package.seeall)

local AtomicOperationActivityEnterPatFaceView = class("AtomicOperationActivityEnterPatFaceView", BaseView)

function AtomicOperationActivityEnterPatFaceView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "root/#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "root/#txt_LimitTime")
	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#btn_claim")
	self._gohasget = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#go_hasget")
	self._btnclose = gohelper.findChildButton(self.viewGO, "root/#btn_close")
	self._gohasget = gohelper.findChild(self.viewGO, "root/btn/#go_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityEnterPatFaceView:addEvents()
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btntrans:AddClickListener(self._btntransOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onNorSignActivityRefresh, self)
	self.addEventCb(self, AtomicOperationActivityController.instance, AtomicOperationActivityEvent.OnPreparationInfoUpdate, self.refreshUI, self)
end

function AtomicOperationActivityEnterPatFaceView:removeEvents()
	self._btnclaim:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btntrans:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onNorSignActivityRefresh, self)
	self.removeEventCb(self, AtomicOperationActivityController.instance, AtomicOperationActivityEvent.OnPreparationInfoUpdate, self.refreshUI, self)
end

function AtomicOperationActivityEnterPatFaceView:onNorSignActivityRefresh()
	self:refreshSignInReward()
end

function AtomicOperationActivityEnterPatFaceView:_btntransOnClick()
	local isDynamic = self.isDynamicRole

	self:refreshRole(not self.isDynamicRole)
	SDKDataTrackMgr.instance:trackClickEnterActivityButton(self.viewName, string.format("L2D_change_%s", (isDynamic or nil) and (StatEnum.CharacterResNameEnum.Art or StatEnum.CharacterResNameEnum.L2D)))
end

function AtomicOperationActivityEnterPatFaceView:_btndetailOnClick()
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = AtomicOperationActivityConfig.instance:getConstNum(AtomicOperationActivityEnum.ConstId.HeroId)
	})
	SDKDataTrackMgr.instance:trackClickEnterActivityButton(self.viewName, "character_view")
end

function AtomicOperationActivityEnterPatFaceView:_btnclaimOnClick()
	local rewardInfoList = ActivityType101Model.instance:getType101Info(self.signActId)

	if not rewardInfoList or next(rewardInfoList) == nil then
		logError("原子之心联动运营活动 签到奖励为空")

		return
	end

	local list = {}

	for _, v in pairs(rewardInfoList) do
		local id = v.id

		if v.state == AtomicOperationActivityEnum.RewardState.CanGet then
			table.insert(list, id)
		end
	end

	if next(list) then
		Activity101Rpc.instance:sendGet101BonusListRequest(self.signActId, list)
	end
end

function AtomicOperationActivityEnterPatFaceView:_editableInitView()
	self.isDynamicRole = true
	self._rewardItemList = self:getUserDataTb_()
	self._goRoleStatic = gohelper.findChild(self.viewGO, "root/#goRole/#go_roletype01")
	self._goRoleDynamic = gohelper.findChild(self.viewGO, "root/#goRole/#go_roletype02")
	self._gospine = gohelper.findChild(self.viewGO, "root/#goRole/#go_roletype02/#go_spine")
	self._gospineRoot = gohelper.findChild(self.viewGO, "root/#goRole/#go_roletype02/#go_spine/#go_spineRoot")
	self._btntrans = gohelper.findChildButton(self.viewGO, "root/#goRole/#btn_trans")
	self._txttrans = gohelper.findChildTextMesh(self.viewGO, "root/#goRole/#btn_trans/#txt_trans")
	self._uiSpine = GuiModelAgent.Create(self._gospineRoot, true)

	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.FullScreen, self.viewName)

	self._skinId = AtomicOperationActivityConfig.instance:getConstNum(AtomicOperationActivityEnum.ConstId.SkinId)

	local skinCo = SkinConfig.instance:getSkinCo(self._skinId)

	self._uiSpine:setResPath(skinCo, self._onSpineLoaded, self)

	local offsets = SkinConfig.instance:getSkinOffset(skinCo.characterViewOffset)

	self._goBg = gohelper.findChild(self.viewGO, "root/#goRole/#go_roletype02/bg")

	CharacterVoiceEnum.setSpineOffset(self._uiSpine, 0, -650)
	transformhelper.setLocalScale(self._gospine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))

	self._btndetail = gohelper.findChildButton(self.viewGO, "root/#goRole/#go_characteritem1/btn_detail")
	self._roleAnimator = gohelper.findChildComponent(self.viewGO, "root/#goRole", gohelper.Type_Animator)
end

function AtomicOperationActivityEnterPatFaceView:onUpdateParam()
	return
end

function AtomicOperationActivityEnterPatFaceView:onOpen()
	self:checkParam()
	self:refreshUI()
	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneSecond)
	self:_setModelVisible()
	AudioMgr.instance:trigger(AudioEnum3_10.OperationActivity.play_ui_mingdi_gsn_open)
end

function AtomicOperationActivityEnterPatFaceView:checkParam()
	self.signActId = self.viewParam and self.viewParam.actId or ActivityEnum.Activity.SP02_AtomicOperationActivitySignIn
end

function AtomicOperationActivityEnterPatFaceView:refreshUI()
	self:refreshSignInReward()
end

function AtomicOperationActivityEnterPatFaceView:refreshRole(isDynamic)
	TaskDispatcher.cancelTask(self._setModelVisible, self)
	self._roleAnimator:Play("switch", 0, 0)
	UIBlockHelper.instance:startBlock(AtomicOperationActivityEnum.LockScreenKey.SwitchRole, AtomicOperationActivityEnum.LockScreenTime.SwitchRole, self.viewName)

	self.isDynamicRole = isDynamic

	TaskDispatcher.runDelay(self._setModelVisible, self, AtomicOperationActivityEnum.LockScreenTime.SwitchRole)
end

function AtomicOperationActivityEnterPatFaceView:_onSpineLoaded()
	if self._uiSpine then
		self._uiSpine:setAllLayer(UnityLayer.SceneEffect)
		self._uiSpine:initSkinDragEffect(self._skinId)
	end

	gohelper.setAsFirstSibling(self._goBg)
end

function AtomicOperationActivityEnterPatFaceView:_setModelVisible()
	local value = self.isDynamicRole

	self._txttrans.text = value and luaLang("storeskinpreviewview_btnswitch") or "L2D"

	TaskDispatcher.cancelTask(self._setModelVisible, self)
	UIBlockHelper.instance:endBlock(AtomicOperationActivityEnum.LockScreenKey.SwitchRole)

	if not self:isSpineInView() then
		return
	end

	if value then
		gohelper.setActive(self._goRoleDynamic, true)
		gohelper.setActive(self._goRoleStatic, false)

		if self._uiSpine then
			self._uiSpine:setModelVisible(true)
			self._uiSpine:showModelEffect()
		end
	else
		gohelper.setActive(self._goRoleDynamic, false)
		gohelper.setActive(self._goRoleStatic, true)

		if self._uiSpine then
			self._uiSpine:setModelVisible(false)
			self._uiSpine:hideModelEffect()
		end
	end
end

function AtomicOperationActivityEnterPatFaceView:isSpineInView()
	return self._goRoleDynamic
end

function AtomicOperationActivityEnterPatFaceView:refreshSignInReward()
	local rewardInfoList = ActivityType101Model.instance:getType101Info(self.signActId)

	if not rewardInfoList or next(rewardInfoList) == nil then
		logError("原子之心联动运营活动 签到奖励为空")

		return
	end

	local canRewardCount = 0

	for index, info in ipairs(rewardInfoList) do
		local item

		if not self._rewardItemList[index] then
			local itemGo = gohelper.findChild(self.viewGO, string.format("root/simage_rewardbg/reward") .. tostring(index))

			item = self:initRewardItem(itemGo, info)

			table.insert(self._rewardItemList, item)
		else
			item = self._rewardItemList[index]
		end

		if info.state == AtomicOperationActivityEnum.RewardState.CanGet then
			canRewardCount = canRewardCount + 1
		end

		local preInfo = rewardInfoList[index - 1]

		self:refreshSingleRewardItem(item, info, preInfo)
	end

	local canGet = canRewardCount > 0

	gohelper.setActive(self._btnclaim, canGet)
	gohelper.setActive(self._gohasget, not canGet)
end

function AtomicOperationActivityEnterPatFaceView:initRewardItem(itemGo, info)
	local item = self:getUserDataTb_()

	item.simage_icon = gohelper.findChildSingleImage(itemGo, "#simage_icon")
	item.goCanGet = gohelper.findChild(itemGo, "go_canget")
	item.goReceive = gohelper.findChild(itemGo, "go_receive")
	item.goTomorrow = gohelper.findChild(itemGo, "go_tomorrow")
	item.btnClick = gohelper.findChildButton(itemGo, "#btn_click")

	item.btnClick:AddClickListener(self.onRewardItemOnClick, {
		target = self,
		id = info.id
	})

	return item
end

function AtomicOperationActivityEnterPatFaceView:refreshSingleRewardItem(item, info, preInfo)
	local isUnlock = info.state == AtomicOperationActivityEnum.RewardState.CanGet
	local isGet = info.state == AtomicOperationActivityEnum.RewardState.HasGet

	gohelper.setActive(item.goCanGet, isUnlock and not isGet)
	gohelper.setActive(item.goReceive, isGet)

	local config = ActivityType101Config.instance:getDayCO(self.signActId, info.id)

	gohelper.setActive(item.goTomorrow, not isUnlock and not isGet and preInfo ~= nil and preInfo.state ~= AtomicOperationActivityEnum.RewardState.Locked)

	local bonusParamStr = string.split(config.bonus, "|")[1]
	local bonusParam = string.split(bonusParamStr, "#")
	local itemConfig, icon = ItemModel.instance:getItemConfigAndIcon(bonusParam[1], bonusParam[2], true)

	item.simage_icon:LoadImage(icon)
end

function AtomicOperationActivityEnterPatFaceView.onRewardItemOnClick(param)
	local target = param.target

	target:onItemRewardClick(param.id)
end

function AtomicOperationActivityEnterPatFaceView:onItemRewardClick(id)
	local infos = ActivityType101Model.instance:getType101Info(self.signActId)

	if not infos then
		return
	end

	local info = infos[id]

	if not info or info.state ~= AtomicOperationActivityEnum.RewardState.CanGet then
		local config = ActivityType101Config.instance:getDayCO(self.signActId, info.id)
		local bonusParamStr = string.split(config.bonus, "|")[1]
		local bonusParam = string.split(bonusParamStr, "#")

		MaterialTipController.instance:showMaterialInfo(bonusParam[1], bonusParam[2])

		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(self.signActId, id)
end

function AtomicOperationActivityEnterPatFaceView:refreshTime()
	local actId = self.signActId
	local txtTime = self._txtLimitTime
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if not actInfoMo then
		txtTime.text = luaLang("ended")

		return
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal and toastId then
		txtTime.text = status == ActivityEnum.ActivityStatus.Expired and luaLang("ended") or luaLang("notOpen")
	else
		local nowTime = ServerTime.now()
		local offsetTime = actInfoMo.endTime / TimeUtil.OneSecondMilliSecond - nowTime

		txtTime.text = TimeUtil.SecondToActivityTimeFormat(offsetTime)
	end
end

function AtomicOperationActivityEnterPatFaceView:onClose()
	return
end

function AtomicOperationActivityEnterPatFaceView:onDestroyView()
	if self._rewardItemList and next(self._rewardItemList) then
		for _, item in ipairs(self._rewardItemList) do
			item.btnClick:RemoveClickListener()
			item.simage_icon:UnLoadImage()
		end
	end

	tabletool.clear(self._rewardItemList)

	self._rewardItemList = nil

	TaskDispatcher.cancelTask(self.refreshTime, self)
	TaskDispatcher.cancelTask(self._setModelVisible, self)

	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

return AtomicOperationActivityEnterPatFaceView
