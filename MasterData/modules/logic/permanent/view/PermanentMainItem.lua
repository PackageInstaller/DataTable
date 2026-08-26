-- chunkname: @modules/logic/permanent/view/PermanentMainItem.lua

module("modules.logic.permanent.view.PermanentMainItem", package.seeall)

local PermanentMainItem = class("PermanentMainItem", ListScrollCell)

function PermanentMainItem:init(go)
	self._go = go
	self._btnClick = gohelper.findChildButtonWithAudio(self._go, "Root/click")
	self._goNormal = gohelper.findChild(self._go, "Root/#go_Normal")
	self._simagekv = gohelper.findChildSingleImage(self._go, "Root/#go_Normal/#simage_kv")
	self._txtname = gohelper.findChildTextMesh(self._go, "Root/#go_Normal/#txt_name")
	self._txtnameen = gohelper.findChildTextMesh(self._go, "Root/#go_Normal/#txt_name_en")
	self._goallget = gohelper.findChild(self._go, "Root/#go_Normal/#go_allget")
	self._goreddot = gohelper.findChild(self._go, "Root/#go_Normal/#go_reddot")
	self._goLocked = gohelper.findChild(self._go, "Root/#go_Locked")
	self._simagekvL = gohelper.findChildSingleImage(self._go, "Root/#go_Locked/#simage_kv")
	self._txtnameL = gohelper.findChildTextMesh(self._go, "Root/#go_Locked/#txt_name")
	self._txtnameenL = gohelper.findChildTextMesh(self._go, "Root/#go_Locked/#txt_name_en")
	self._imagePropItem = gohelper.findChildImage(self._goLocked, "image_LockedTextBG/#image_PropItem")
	self._txtPropNum = gohelper.findChildTextMesh(self._goLocked, "image_LockedTextBG/#txt_PropNum")
	self._goEmpty = gohelper.findChild(self._go, "Root/#go_Empty")
	self._gonew = gohelper.findChild(self._go, "Root/#go_Locked/#go_new")

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagePropItem, "216_1")

	local itemStr = CommonConfig.instance:getConstStr(ConstEnum.PermanentUnlockCost)
	local nums = string.splitToNumber(itemStr, "#")
	local var_1_0 = {
		type = nums[1],
		id = nums[2]
	}

	var_1_0.quantity = nums[3] or 0
	self.cost = var_1_0
	self._root = gohelper.findChild(self._go, "Root")
	self.animator = self._root:GetComponent(gohelper.Type_Animator)
end

function PermanentMainItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.UnlockPermanent, self._onUnlcokPermanent, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.GetActivityInfoWithParamSuccess, self._refreshAllGetFlag, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self, LuaEventSystem.Low)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.refreshStoryReddot, self._onRefreshStoryReddot, self)
end

function PermanentMainItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.UnlockPermanent, self._onUnlcokPermanent, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.GetActivityInfoWithParamSuccess, self._refreshAllGetFlag, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.refreshStoryReddot, self._onRefreshStoryReddot, self)
end

function PermanentMainItem:refreshRedDot()
	if not self.notEventRedDot then
		return
	end

	self.notEventRedDot:refreshRedDot()
end

function PermanentMainItem:onUpdateMO(mo)
	self._mo = mo

	if mo.id == -999 then
		gohelper.setActive(self._goEmpty, true)
		gohelper.setActive(self._goNormal, false)
		gohelper.setActive(self._goLocked, false)

		if self._view.playOpen then
			self.animator:Play(UIAnimationName.Open)
		end

		return
	end

	local permanentActId = mo.config.id
	local kvIcon = PermanentConfig.instance:getKvIconName(mo.id)

	self._simagekv:LoadImage(ResUrl.getPermanentSingleBg(kvIcon))

	self._txtname.text = mo.config.name
	self._txtnameen.text = mo.config.nameEn

	self._simagekvL:LoadImage(ResUrl.getPermanentSingleBg(kvIcon))

	self._txtnameL.text = mo.config.name
	self._txtnameenL.text = mo.config.nameEn

	if mo.config.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goreddot, mo.config.redDotId)
	else
		self.notEventRedDot = permanentActId == VersionActivity2_1Enum.ActivityId.EnterView and RedDotController.instance:addNotEventRedDot(self._goreddot, self._v2a1_checkNotEventReddotShow, self) or RedDotController.instance:addNotEventRedDot(self._goreddot, self._checkNotEventReddotShow, self)
	end

	self:_refreshState()
	self:_refreshCost()
end

function PermanentMainItem:_checkNotEventReddotShow()
	local result = false
	local childActIdList = ActivityConfig.instance:getPermanentChildActList(self._mo.id)

	for _, actId in ipairs(childActIdList) do
		local actCo = ActivityConfig.instance:getActivityCo(actId)
		local isDotShow = RedDotModel.instance:isDotShow(actCo.redDotId, actId)

		if isDotShow then
			result = true

			break
		end
	end

	return result
end

function PermanentMainItem:onDestroy()
	self._simagekv:UnLoadImage()
	self._simagekvL:UnLoadImage()
	TaskDispatcher.cancelTask(self._onUnlcokPermanent, self)
end

function PermanentMainItem:_refreshState()
	if self._view.playOpen then
		self.animator:Play(UIAnimationName.Open)
	end

	local hasRead = PermanentModel.instance:isActivityLocalRead(self._mo.id)

	gohelper.setActive(self._gonew, not hasRead)

	if not hasRead then
		PermanentModel.instance:setActivityLocalRead(self._mo.id)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[self._mo.config.redDotId] = true
		})
	end

	self:_refreshAllGetFlag()
	gohelper.setActive(self._goEmpty, false)
	gohelper.setActive(self._goNormal, self._mo.permanentUnlock)
	gohelper.setActive(self._goLocked, not self._mo.permanentUnlock)
end

function PermanentMainItem:_refreshCost()
	local currencyMO = CurrencyModel.instance:getCurrency(self.cost.id)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtPropNum.text = quantity >= self.cost.quantity and string.format(string.format("%s/%s", quantity, self.cost.quantity)) or string.format(string.format("<color=#d97373>%s</color>/%s", quantity, self.cost.quantity))
		end
	end
end

function PermanentMainItem:_btnOnClick()
	if self._mo.id == -999 then
		return
	end

	if self._mo.permanentUnlock then
		if OptionPackageController.instance:checkNeedDownload(OptionPackageEnum.Package.VersionActivity) then
			return
		end

		PermanentController.instance:enterActivity(self._mo.id)
	else
		local itemCo = ItemModel.instance:getItemConfig(self.cost.type, self.cost.id)
		local itemName = itemCo and itemCo.name

		GameFacade.showMessageBox(MessageBoxIdDefine.PermanentUnlockConfirm, MsgBoxEnum.BoxType.Yes_No, self._unlockCallback, nil, nil, self, nil, nil, self.cost.quantity, itemName, self._mo.config.name)
	end
end

function PermanentMainItem:_unlockCallback()
	local items = {}

	table.insert(items, self.cost)

	local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(items)

	if enough then
		PermanentController.instance:unlockPermanent(self._mo.id)
	else
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)
	end
end

function PermanentMainItem:_onCurrencyChange()
	self:_refreshCost()
end

function PermanentMainItem:_onUnlcokPermanent(id)
	if self._mo.id == id then
		gohelper.setActive(self._goNormal, true)
		self.animator:Play("unlock", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_permanent_unlock)
		UIBlockMgrExtend.instance.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("permanentUnlockAnim")
		TaskDispatcher.runDelay(self.setPermanentUnlock, self, 1.5)
	end
end

function PermanentMainItem:_refreshAllGetFlag()
	local isReceiveAllBonus = ActivityModel.instance:isReceiveAllBonus(self._mo.id)

	gohelper.setActive(self._goallget, isReceiveAllBonus)
end

function PermanentMainItem:setPermanentUnlock()
	gohelper.setActive(self._goLocked, false)
	UIBlockMgr.instance:endBlock("permanentUnlockAnim")
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
end

function PermanentMainItem:getAnimator()
	return self.animator
end

function PermanentMainItem:_v2a1_checkNotEventReddotShow()
	local isDotShow = self:_checkNotEventReddotShow()

	isDotShow = isDotShow or PermanentModel.instance:IsDotShowPermanent2_1()

	return isDotShow
end

function PermanentMainItem:_onRefreshStoryReddot()
	local mo = self._mo

	if not mo then
		return
	end

	if not self.notEventRedDot then
		return
	end

	if mo.id == -999 then
		return
	end

	if not mo.config then
		return
	end

	local permanentActId = mo.config.id

	if permanentActId ~= VersionActivity2_1Enum.ActivityId.EnterView then
		return
	end

	self.notEventRedDot:refreshRedDot()
end

return PermanentMainItem
