-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/actbp/Anniversary3ActBpBonusView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.actbp.Anniversary3ActBpBonusView", package.seeall)

local Anniversary3ActBpBonusView = class("Anniversary3ActBpBonusView", BaseView)

function Anniversary3ActBpBonusView:onInitView()
	self._gobonusview = gohelper.findChild(self.viewGO, "#go_bonusview")
	self._btnpay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bonusview/root/left/pay/#btn_pay")
	self._scrollbonus = gohelper.findChildScrollRect(self.viewGO, "#go_bonusview/root/#scroll_bonus")
	self._gobonuscontent = gohelper.findChild(self.viewGO, "#go_bonusview/root/#scroll_bonus/viewport/#go_bonuscontent")
	self._gobonusitem = gohelper.findChild(self.viewGO, "#go_bonusview/root/#scroll_bonus/viewport/#go_bonuscontent/#go_bonusitem")
	self._gokeybonus = gohelper.findChild(self.viewGO, "#go_bonusview/root/#go_keybonus")
	self._txtbonuslefttime = gohelper.findChildText(self.viewGO, "#go_bonusview/root/#txt_bonuslefttime")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_bonusview/root/#go_unlock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Anniversary3ActBpBonusView:addEvents()
	self._btnpay:AddClickListener(self._btnpayOnClick, self)
end

function Anniversary3ActBpBonusView:removeEvents()
	self._btnpay:RemoveClickListener()
end

function Anniversary3ActBpBonusView:_btnpayOnClick()
	return
end

function Anniversary3ActBpBonusView:_editableInitView()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3ActBp
	self._bpId = Anniversary3ActBpModel.instance:getCurBpId(self._actId)

	self:_init()
	self:_addSelfEvents()
end

function Anniversary3ActBpBonusView:_init()
	self._bonusItems = self:getUserDataTb_()
end

function Anniversary3ActBpBonusView:_addSelfEvents()
	self._scrollbonus:AddOnValueChanged(self._onScrollRectValueChanged, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onTaskUpdate, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onTaskUpdate, self)
	self.addEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnGetInfo, self._onGetInfo, self)
	self.addEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnGetBonus, self._onGetBonus, self)
	self.addEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnBuySuccess, self._onBuySuccess, self)
end

function Anniversary3ActBpBonusView:_removeSelfEvents()
	self._scrollbonus:RemoveOnValueChanged()
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onTaskUpdate, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onTaskUpdate, self)
	self.removeEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnGetInfo, self._onGetInfo, self)
	self.removeEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnGetBonus, self._onGetBonus, self)
	self.removeEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnBuySuccess, self._onBuySuccess, self)
end

function Anniversary3ActBpBonusView:_onScrollRectValueChanged()
	self:_refreshKeyItem()
end

function Anniversary3ActBpBonusView:_onTaskUpdate()
	self:_refresh()
end

function Anniversary3ActBpBonusView:_onGetInfo()
	self:_refresh()
end

function Anniversary3ActBpBonusView:_onGetBonus()
	self:_refresh()
end

function Anniversary3ActBpBonusView:_onBuySuccess()
	self:_refresh()
end

function Anniversary3ActBpBonusView:onOpen()
	self._hasPay = Anniversary3ActBpModel.instance:isPremiumPayed(self._bpId, self._actId)

	self:_refresh()
end

function Anniversary3ActBpBonusView:_refresh()
	self:_refreshItems()
	self:_refreshKeyItem()
	self:_refreshUI()
end

function Anniversary3ActBpBonusView:_refreshItems()
	local bonusCos = Activity233Config.instance:getBonusCos(self._bpId)

	for i = 1, #bonusCos do
		if not self._bonusItems[i] then
			self._bonusItems[i] = Anniversary3ActBpBonusItem.New()

			local go = gohelper.cloneInPlace(self._gobonusitem)

			self._bonusItems[i]:init(go)
		end

		self._bonusItems[i]:refresh(bonusCos[i])
	end
end

function Anniversary3ActBpBonusView:_refreshUI()
	local lv = Anniversary3ActBpModel.instance:getActBpLevel(self._bpId, self._actId)

	if not self._lastLv or self._lastLv ~= lv then
		self:_focusLv(lv)

		self._lastLv = lv
	end

	local hasPay = Anniversary3ActBpModel.instance:isPremiumPayed(self._bpId, self._actId)

	if not self._hasPay and hasPay then
		gohelper.setActive(self._gounlock, true)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("unlockwait")
		TaskDispatcher.runDelay(self._showUnlockFinished, self, 3)
	end
end

function Anniversary3ActBpBonusView:_showUnlockFinished()
	gohelper.setActive(self._gounlock, false)
	UIBlockMgr.instance:endBlock("unlockwait")
end

local maxAnchorPosX = -3940

function Anniversary3ActBpBonusView:_focusLv(lv)
	local maxLv = #Activity233Config.instance:getBonusCos(self._bpId)
	local curPosX = maxLv < 6 and 0 or (lv - 5) * maxAnchorPosX / (maxLv - 5)

	recthelper.setAnchorX(self._gobonuscontent.transform, curPosX)
end

local startPosX = 0
local endPosX = -3940
local startLv = 6
local endLv = 30

function Anniversary3ActBpBonusView:_refreshKeyItem()
	if not self._keyBonusLvs then
		self._keyBonusLvs = {}

		local bonusCos = Activity233Config.instance:getBonusCos(self._bpId)

		for _, co in ipairs(bonusCos) do
			if co.keyBonus >= 1 then
				table.insert(self._keyBonusLvs, co.level)
			end
		end
	end

	local keyLv = self._keyBonusLvs[#self._keyBonusLvs]
	local curPosX, _, _ = transformhelper.getLocalPos(self._gobonuscontent.transform)
	local curLvIndex = startLv + math.floor((curPosX - startPosX) * (endLv - startLv) / (endPosX - startPosX))
	local bonusCos = Activity233Config.instance:getBonusCos(self._bpId)

	for i = curLvIndex, endLv do
		if bonusCos[i].keyBonus >= 1 then
			keyLv = i

			break
		end
	end

	if keyLv == self._keyLv then
		return
	end

	self._keyLv = keyLv

	local co = Activity233Config.instance:getBonusCo(self._keyLv, self._bpId)

	if not self._keyBonusItem then
		self._keyBonusItem = Anniversary3ActBpBonusKeyItem.New()

		self._keyBonusItem:init(self._gokeybonus)
	end

	self._keyBonusItem:refresh(co)
end

function Anniversary3ActBpBonusView:onClose()
	UIBlockMgr.instance:endBlock("unlockwait")
	TaskDispatcher.cancelTask(self._showUnlockFinished, self)
end

function Anniversary3ActBpBonusView:onDestroyView()
	if self._keyBonusItem then
		self._keyBonusItem:destroy()

		self._keyBonusItem = nil
	end

	if self._bonusItems then
		for _, bonusItem in pairs(self._bonusItems) do
			bonusItem:destroy()
		end

		self._bonusItems = nil
	end

	self:_removeSelfEvents()
end

return Anniversary3ActBpBonusView
