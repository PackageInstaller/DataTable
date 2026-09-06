-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoohatchView.lua

module("logic.extensions.zoo.view.ZoohatchView", package.seeall)

local ZoohatchView = class("ZoohatchView", ViewComponent)
local absorbDeviceState_Tips = {
	[ZooMO.absorbDeviceState_Absorbing] = lang("petzoo_absorb_isabsorbing"),
	[ZooMO.absorbDeviceState_CD] = lang("petzoo_absorb_in_cd"),
	[ZooMO.absorbDeviceState_FriendAbsorbed] = lang("petzoo_absorb_absorbed"),
	[ZooMO.absorbDeviceState_NoPlace] = lang("petzoo_absorb_nohatching"),
	[ZooMO.absorbDeviceState_MinAbaorbTimeLimit] = lang("petzoo_absorb_mintime_limit"),
	[ZooMO.absorbDeviceState_NotFriend] = lang("petzoo_absorb_nofriend")
}

function ZoohatchView:buildUI()
	ZoohatchView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._hatchSlots = {}

	local stealingTips = lang("petzoo_hatch_has_stolen_time")
	local textNoEggs = lang("petzoo_hatch_slot_egg_empty")

	for i = 1, 3 do
		local slot = {}
		local slotNode = self:getGo("hatch/" .. i)

		slot.getBtn = Framework.ButtonAdapter.Get(slotNode)
		slot.eggIcon = goutil.findChild(slotNode, "eggIcon")
		slot.hatchTimer = goutil.findChild(slotNode, "hatchTimer")
		slot.hatchTimerTxt = goutil.findChildTextComponent(slotNode, "hatchTimer/time")
		slot.modifyBtn = Framework.ButtonAdapter.GetFrom(slotNode, "modifyBtn")
		slot.modifyText = goutil.findChildTextComponent(slotNode, "modifyBtn/text")
		slot.modifyIcon = goutil.findChild(slotNode, "modifyBtn/icon"):GetComponent(ComponentType.UIImageSpriteChange)
		slot.stealer = goutil.findChild(slotNode, "stealer")
		slot.stealing = goutil.findChild(slotNode, "stealer/stealing")
		slot.stealingTime = goutil.findChildTextComponent(slotNode, "stealer/stealing/time")
		slot.stealerName = goutil.findChildTextComponent(slotNode, "stealer/stealing/name")
		slot.stealerBtn = Framework.ButtonAdapter.Get(slot.stealer)
		slot.stealerItem = goutil.findChild(slot.stealer, "item")
		slot.lockBtn = Framework.ButtonAdapter.GetFrom(slotNode, "lock")
		slot.quickBtn = Framework.ButtonAdapter.GetFrom(slotNode, "quickBtn")

		local stolenTips = goutil.findChildTextComponent(slotNode, "stealer/stealing/tips")

		stolenTips.text = stealingTips
		slot.modifyText.text = textNoEggs
		self._hatchSlots[i] = slot
	end

	self._recoveryBtn = self:getBtn("recoveryBtn")
	self._deviceNode = self:getGo("device")
	self._deviceBtn = self:getBtn("device/deviceBtn")
	self._deviceStolenMax = self:getGo("device/stolenMax")
	self._deviceStolenMaxItem = self:getGo("device/stolenMax/item")
	self._btnGetMaxStolenPrize = self:getBtn("device/stolenMax/btnGetPrize")
end

function ZoohatchView:bindEvents()
	ZoohatchView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)

	for i, value in ipairs(self._hatchSlots) do
		value.quickBtn:AddClickListener(function()
			self:_onClickQuick(i)
		end)
		value.modifyBtn:AddClickListener(function()
			self:_onClickModify(i)
		end)
		value.getBtn:AddClickListener(function()
			self:_onClickGet(i)
		end)
		value.stealerBtn:AddClickListener(function()
			self:_onClickStealer(i)
		end)
		value.lockBtn:AddClickListener(function()
			self:_onClickLockBtn(i)
		end)
	end

	self._recoveryBtn:AddClickListener(self._onClickRecover, self)
	self._deviceBtn:AddClickListener(self._onClickDevice, self)
	self._btnGetMaxStolenPrize:AddClickListener(self._onClickGetDevicePrize, self)
end

function ZoohatchView:unbindEvents()
	ZoohatchView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for i, value in ipairs(self._hatchSlots) do
		value.quickBtn:RemoveClickListener()
		value.modifyBtn:RemoveClickListener()
		value.getBtn:RemoveClickListener()
		value.stealerBtn:RemoveClickListener()
		value.lockBtn:RemoveClickListener()
	end

	self._recoveryBtn:RemoveClickListener()
	self._deviceBtn:RemoveClickListener()
	self._btnGetMaxStolenPrize:RemoveClickListener()
end

function ZoohatchView:onEnter()
	ZoohatchView.super.onEnter(self)
	self:_updateHatchView()
	GlobalDispatcher:addListener(GlobalNotify.ZooTakeAnimalOutFromHatch, self._onZooTakeAnimalOutFromHatch, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooCancelHatch, self._onZooCancelHatch, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooNotifyInstallAbsorbDevice, self._onZooNotifyInstallAbsorbDevice, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooHatchUseSpeedUpCard, self._updateHatch, self)
	GlobalDispatcher:addListener(GlobalNotify.OnPutEggIntoSlot, self._onPutEggIntoSlot, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooUninstallAbsorbDevice, self._onZooUninstallAbsorbDevice, self)
	GlobalDispatcher:addListener(GlobalNotify.OnNotifyZooUnistallAbsorbDevice, self._onNotifyZooUnistallAbsorbDevice, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooGainFriendAbsorbPrize, self._updateHatchView, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSetAbsorbDevice, self._onSetAbsorbDevice, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendRemove, self._removeFriend, self)
	settimer(1, self._tickSlots, self, true)
end

function ZoohatchView:_initParams()
	self._currZoo = ZooModel.instance:getCurrZoo()
	self._hatchInfo = self._currZoo:getHatchInfos()
	self._deviceMinHatchTime = ZooConfig.instance:getAbsorbNeedRestHatchTime()
	self._friendId = not self._currZoo:isMyZoo() and self._currZoo:getZooUserId() or nil
end

function ZoohatchView:_updateZooStatus()
	local isMyZoo = self._currZoo:isMyZoo()

	goutil.setActive(self._recoveryBtn.gameObject, isMyZoo)
	self:_updateAbsorbDevice()

	self._recoveryFlag = false
end

function ZoohatchView:_updateHatchView()
	self:_initParams()
	self:_updateZooStatus()
	self:_updateHatch()
end

function ZoohatchView:onExit()
	ZoohatchView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooTakeAnimalOutFromHatch, self._onZooTakeAnimalOutFromHatch, self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooCancelHatch, self._onZooCancelHatch, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooNotifyInstallAbsorbDevice, self._onZooNotifyInstallAbsorbDevice, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnNotifyZooUnistallAbsorbDevice, self._onNotifyZooUnistallAbsorbDevice, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooHatchUseSpeedUpCard, self._updateHatch, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPutEggIntoSlot, self._onPutEggIntoSlot, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooGainFriendAbsorbPrize, self._updateHatchView, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooUninstallAbsorbDevice, self._onZooUninstallAbsorbDevice, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSetAbsorbDevice, self._onSetAbsorbDevice, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendRemove, self._removeFriend, self)
	removetimer(self._tickSlots, self)

	for i, value in ipairs(self._hatchSlots) do
		uGuiUtil.clearImage(value.eggIcon)
		MaterialMgr.resetAll(value.stealerItem)

		value.stealerProxy = nil
		value.useIcon = nil
	end

	MaterialMgr.resetAll(self._deviceStolenMaxItem.gameObject)
end

function ZoohatchView:_onClickQuick(tag)
	if self._hatchInfo[tag].hatchEndTime > ServerTime.now() then
		ViewMgr.instance:open(ViewName.ZooSpeedCardUsedView, tag)
	else
		FloatWordMgr.instance:show(lang("petzoo_speedcard_hatchfinished"))
	end
end

function ZoohatchView:_onClickGet(tag)
	if not self._friendId and self._hatchInfo[tag].animalRace > 0 and ServerTime.now() >= self._hatchInfo[tag].hatchEndTime then
		local myZoo = ZooModel.instance:getMyZoo()
		local dataList = ZoowarehouseController.instance:search(myZoo:getAnimalList())

		if dataList and #dataList >= ZooConfig.instance:getMaxAnimalNum() then
			TipsFacade.instance:openCommonTips(lang("petzoo_has_max_pet_count"))
		else
			local animalMo = AnimalModel.New()
			local cfg = ZooConfig.instance:getAnimalById(self._hatchInfo[tag].animalRace)

			animalMo:initData({
				raceId = self._hatchInfo[tag].animalRace,
				geneInfo = self._hatchInfo[tag].geneInfo,
				name = cfg.name
			})
			UIStateManager.instance:push(ViewName.ZoogetanimalbeforeView, animalMo, tag)
		end
	end
end

function ZoohatchView:_onClickModify(tag)
	if checknumber(self._hatchInfo[tag].animalRace) == 0 then
		ZooController.instance:openSelectView(ZooController.EGGTYPE, function(eggIds)
			if eggIds and eggIds[1] then
				ZooController.instance:sendPM_PutEggIntoSlotReq(tag, eggIds[1])
			else
				FloatWordMgr.instance:show(lang("petzoo_selecteggs_select_none"))
			end
		end)
	else
		self:_onClickRecover()
		UIStateManager.instance:push(ViewName.ZoohatchcancelView, tag)
	end
end

function ZoohatchView:_onClickStealer(tag)
	if self._friendId then
		if self._hatchInfo[tag].absorbBuddyId == RoleModel.instance:getUserId() then
			if self._hatchInfo[tag].absorbMaxEndTime <= ServerTime.now() then
				ZooController.instance:sendPM_ZooGainAbsorbDevicePrizeReq(self._friendId)
			else
				FloatWordMgr.instance:show(lang("petzoo_absorb_prize_timelimit"))
			end
		end
	else
		ZooAgent.instance:sendPM_ZooUninstallAbsorbDeviceReq()
	end
end

function ZoohatchView:_onClickLockBtn(tag)
	FloatWordMgr.instance:show(lang("petzoo_hatch_slot_viplimit"))
end

function ZoohatchView:_onClickRecover()
	self._recoveryFlag = not self._recoveryFlag

	self:_updateHatch()
end

function ZoohatchView:_onClickGetDevicePrize()
	ZooController.instance:sendPM_ZooGainAbsorbDevicePrizeReq(0)
end

function ZoohatchView:_onClickDevice()
	local myZoo = ZooModel.instance:getMyZoo()
	local status = myZoo:getAbsorbDeviceStatus(self._friendId)

	if status ~= ZooMO.absorbDeviceState_Ok then
		local tips = absorbDeviceState_Tips[status]

		if tips then
			FloatWordMgr.instance:show(tips)
		end

		return
	end

	TipsFacade.instance:openPopupWindowWithTog(lang("tip"), lang("petzoo_absorb_put_tips"), function()
		ZooController.instance:sendPM_ZooSetAbsorbDeviceReq(self._friendId)
	end)
end

function ZoohatchView:_isSlotUnlock(i)
	return i < 3 or VipModel.instance:getIsAbleVipHatch()
end

function ZoohatchView:_updateAbsorbDevice()
	local myZoo = ZooModel.instance:getMyZoo()
	local status = myZoo:getAbsorbDeviceStatus(self._friendId)

	if status ~= ZooMO.absorbDeviceState_AbaorbMax then
		if self._friendId then
			local isActive = status ~= ZooMO.absorbDeviceState_Cant

			goutil.setActive(self._deviceNode.gameObject, isActive)
			MaterialMgr.resetAll(self._deviceStolenMaxItem.gameObject)

			if isActive then
				uGuiUtil.setGoGrayState(self._deviceBtn.gameObject, status ~= ZooMO.absorbDeviceState_Ok)
				self._deviceStolenMax:SetActive(status == ZooMO.absorbDeviceState_AbaorbMax)
				self._deviceBtn.gameObject:SetActive(status ~= ZooMO.absorbDeviceState_AbaorbMax)

				if status == ZooMO.absorbDeviceState_AbaorbMax then
					MaterialMgr.setCellByCfg(ZooConfig.instance:getAbsorbDevicePrize(), self._deviceStolenMaxItem.gameObject)
				end
			end
		end
	end
end

function ZoohatchView:_updateHatch()
	for i, slot in ipairs(self._hatchSlots) do
		self:_updateHatachSlot(i, slot)
	end
end

function ZoohatchView:_updateHatachSlot(i, slot)
	local hatchInfo = self._hatchInfo[i]

	if hatchInfo.animalRace == 0 then
		self:_updateEmptySlot(i, slot)
	else
		self:_updateEggSlot(i, slot, hatchInfo)
	end
end

function ZoohatchView:_updateEmptySlot(i, slot)
	goutil.setActive(slot.eggIcon, false)
	goutil.setActive(slot.hatchTimer, false)
	goutil.setActive(slot.quickBtn.gameObject, false)
	goutil.setActive(slot.stealer, false)

	local isVipOpened = self:_isSlotUnlock(i)
	local isSlotOpened = not self._friendId and isVipOpened

	goutil.setActive(slot.modifyBtn.gameObject, isSlotOpened)
	slot.modifyIcon:SetState(0)
	goutil.setActive(slot.modifyText.gameObject, true)

	if self._friendId then
		goutil.setActive(slot.lockBtn.gameObject, false)
	else
		goutil.setActive(slot.lockBtn.gameObject, not isVipOpened)
	end
end

function ZoohatchView:_updateEggSlot(i, slot, hatchInfo)
	local hatchDeviceFlag = checknumber(hatchInfo.absorbBuddyId) > 0

	goutil.setActive(slot.eggIcon, true)
	goutil.setActive(slot.lockBtn.gameObject, false)
	goutil.setActive(slot.stealer, hatchDeviceFlag)
	goutil.setActive(slot.hatchTimer, not hatchDeviceFlag)
	self:_updateHatchTimer(slot, hatchInfo)

	if hatchDeviceFlag then
		self:_updateAbsorbStealer(slot, hatchInfo)
	end

	self:_updateRecoverState(i, slot)
end

function ZoohatchView:_updateRecoverState(i, slot)
	if self._recoveryFlag then
		local recoveryFlag = self:_isSlotUnlock(i)

		goutil.setActive(slot.modifyBtn.gameObject, self._recoveryFlag)

		if self._recoveryFlag then
			slot.modifyIcon:SetState(1)
			goutil.setActive(slot.modifyText.gameObject, false)
		end
	end
end

function ZoohatchView:_updateAbsorbStealer(slot, hatchInfo)
	local now = ServerTime.now()
	local absorbTime = now - hatchInfo.absorbStartTime

	if absorbTime < hatchInfo.maxCanAbsorbTime then
		goutil.setActive(slot.stealerItem, false)
		goutil.setActive(slot.stealing, true)

		slot.stealingTime.text = GameUtil.FormatTimeSymbol(absorbTime)
	elseif self._friendId and hatchInfo.absorbBuddyId == RoleModel.instance:getUserId() then
		goutil.setActive(slot.stealerItem, true)
		goutil.setActive(slot.stealing, false)

		if slot.stealerProxy == nil then
			slot.stealerProxy = MaterialMgr.setCellByCfg(ZooConfig.instance:getAbsorbDevicePrize(), slot.stealerItem)

			Framework.TransformUtil.SetLocalPos(slot.stealerProxy.view.transform, 0, 13, 0)
			Framework.TransformUtil.SetLocalScale(slot.stealerProxy.view.transform, 0.6, 0.6, 1)
			slot.stealerProxy:setCallBack(function()
				return
			end)
		end
	else
		goutil.setActive(slot.stealing, true)
		goutil.setActive(slot.stealerItem, false)

		slot.stealingTime.text = lang("petzoo_hatch_stolen_max")
	end

	slot.stealerName.text = string.format(lang("petzoo_hatch_stolen_owner"), hatchInfo.absorbBuddyName)
end

function ZoohatchView:_updateHatchTimer(slot, hatchInfo)
	local surplusTime = hatchInfo:getHatchSurplusTime()

	goutil.setActive(slot.quickBtn.gameObject, surplusTime > 0 and not self._friendId)

	if surplusTime <= 0 then
		slot.hatchTimerTxt.text = lang("petzoo_hatch_finished")

		local cfg = ZooConfig.instance:getAnimalById(hatchInfo.animalRace)

		uGuiUtil.setSpriteToImage(slot.eggIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.adultShow))
	else
		slot.hatchTimerTxt.text = GameUtil.FormatTimeSymbol(surplusTime)

		local cfg = ZooConfig.instance:getAnimalById(hatchInfo.animalRace)
		local stateTime = hatchInfo.hatchCD * (1 - cfg.hatchProgress[1] / cfg.hatchProgress[2])

		if stateTime < surplusTime then
			if slot.useIcon ~= cfg.eggShow then
				uGuiUtil.setSpriteToImage(slot.eggIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.eggShow))

				slot.useIcon = cfg.eggShow
			end
		elseif slot.useIcon ~= cfg.groupShow then
			uGuiUtil.setSpriteToImage(slot.eggIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.groupShow))

			slot.useIcon = cfg.groupShow
		end
	end
end

function ZoohatchView:_tickSlots()
	local hatchingEggflag, deviceFlag = false, false

	for i, value in ipairs(self._hatchSlots) do
		local hatchInfo = self._hatchInfo[i]

		self:_tickSlot(value, hatchInfo)
	end
end

function ZoohatchView:_tickSlot(slot, hatchInfo)
	if checknumber(hatchInfo.animalRace) == 0 then
		return
	end

	local hatchDeviceFlag = checknumber(hatchInfo.absorbBuddyId) > 0

	self:_updateHatchTimer(slot, hatchInfo)

	if hatchDeviceFlag then
		self:_updateAbsorbStealer(slot, hatchInfo)
	end
end

function ZoohatchView:_onZooTakeAnimalOutFromHatch(tag)
	self._recoveryFlag = false

	self:_updateHatachSlot(tag, self._hatchSlots[tag])
end

function ZoohatchView:_onSetAbsorbDevice(friendId)
	self:_updateHatchView()
end

function ZoohatchView:_onZooCancelHatch(tag)
	self._recoveryFlag = false

	self:_updateHatachSlot(tag, self._hatchSlots[tag])
end

function ZoohatchView:_onPutEggIntoSlot(slotId)
	self._recoveryFlag = false

	self:_updateHatachSlot(slotId, self._hatchSlots[slotId])
end

function ZoohatchView:_onZooUninstallAbsorbDevice()
	self:_updateHatchView()
	FloatWordMgr.instance:show(lang("petzoo_absorb_unistall"))
end

function ZoohatchView:_onZooNotifyInstallAbsorbDevice()
	self:_updateHatchView()
end

function ZoohatchView:_onNotifyZooUnistallAbsorbDevice(friendId)
	if friendId == self._friendId then
		self:_updateHatchView()
	end
end

function ZoohatchView:_removeFriend(id)
	if tonumber(self._friend) == tonumber(id) then
		goutil.setActive(self._deviceNode, false)
		FloatWordMgr.instance:show("你和对方解除了好友关系")
	end
end

return ZoohatchView
