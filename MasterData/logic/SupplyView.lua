-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/view/SupplyView.lua

module("logic.extensions.strength.view.SupplyView", package.seeall)

local SupplyView = class("SupplyView", ViewComponent)

function SupplyView:ctor()
	SupplyView.super.ctor(self)
end

function SupplyView:buildUI()
	SupplyView.super.buildUI(self)

	self._petId = 10335
	self.consumeCount = SupplyConfig.instance:getCommonValue("DAILY_FREE_COMPENSTAE_CONSUME")
	self.freeMaxLQ = SupplyConfig.instance:getCommonValue("DAILY_FREE_STRENGTH")

	local message = SupplyConfig.instance:getCommonValue("CLICK_SUPPLY")

	self._pet = self:getGo("pet")
	self._petBtn = self:getBtn("pet/tipBtn")
	self._dialogue = self:getGo("dialogue")
	self._dialogue_text = self:getGo("dialogue/Text"):GetComponent("Text")
	self._tip_text = self:getGo("tip/Text"):GetComponent("Text")

	GameUtil.SetActive(self._petBtn, false)

	self._dialogue_text.text = message
	self._tip_text.text = self._tip_text.text .. self.freeMaxLQ

	GameUtil.SetActive(self._dialogue, false)

	self._supplyList = {}

	for i = 1, 3 do
		local supplyItem = self:getGo("container/food" .. i)

		self:initSupplyItem(supplyItem)
	end

	self._birthdayGo = self:getGo("birthday")
	self.txtExtCount = self:getTxt("birthday/tip/Text")
	self.txtExtTime = self:getTxt("birthday/txtTime")
end

function SupplyView:initSupplyItem(supply)
	local supplyItem = {}

	supplyItem.foodState = goutil.findChild(supply, "foodState"):GetComponent("UIImageColorChange")
	supplyItem.btnUse = goutil.findChild(supply, "use/btnUse")
	supplyItem.useTxt = goutil.findChild(supply, "use/useTxt")
	supplyItem.btnLateUse = goutil.findChild(supply, "btnLateUse")
	supplyItem.btnLateCost = goutil.findChild(supplyItem.btnLateUse, "num"):GetComponent("Text")
	supplyItem.btnLateCost.text = self.consumeCount
	supplyItem.tipTime = goutil.findChild(supply, "tipTime"):GetComponent("Text")
	supplyItem.btnReady = goutil.findChild(supply, "btnReady")
	supplyItem.multi = goutil.findChild(supply, "multi")
	supplyItem.txtMulti = goutil.findChildTextComponent(supply, "multi/txtMulti")

	table.insert(self._supplyList, supplyItem)
	self:addBtnAdt(supplyItem, #self._supplyList - 1)
end

function SupplyView:addBtnAdt(supplyItem, idx)
	local btnUseAdt = Framework.ButtonAdapter.Get(supplyItem.btnUse)

	btnUseAdt:AddClickListener(function()
		self:_clickBtnUse(idx)
	end, self)

	local btnLateUseAdt = Framework.ButtonAdapter.Get(supplyItem.btnLateUse)

	btnLateUseAdt:AddClickListener(function()
		self:_clickBtnLateUse(idx)
	end, self)
end

function SupplyView:rmBtnRmt(supplyItem)
	local btnUseAdt = Framework.ButtonAdapter.Get(supplyItem.btnUse)

	btnUseAdt:RemoveClickListener()

	local btnLateUseAdt = Framework.ButtonAdapter.Get(supplyItem.btnLateUse)

	btnLateUseAdt:RemoveClickListener()
end

function SupplyView:bindEvents()
	SupplyView.super.bindEvents(self)
	self._petBtn:AddClickListener(self._petClickTip, self)
end

function SupplyView:unbindEvents()
	SupplyView.super.unbindEvents(self)

	local len = #self._supplyList

	for i = 1, len do
		self:rmBtnRmt(self._supplyList[i])
	end

	self._petBtn:RemoveClickListener()
end

function SupplyView:destroyUI()
	SupplyView.super.destroyUI(self)
end

function SupplyView:onEnter()
	SupplyView.super.onEnter(self)

	self.openTip = false
	self._isInView = true
	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, self._petId, self._pet)

	GameUtil.setLocalScale(self._pet, 1.5, 1.5, 1)
	SupplyController.instance:updataSupplyRedPoint(GameUtil.handler(self.updateStatus, self))
	GlobalDispatcher:addListener(GlobalNotify.ItemGetViewDoClosed, self._rewardTip, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTiliCount, self.updateStatus, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)

	self.txtExtCount.text = SupplyConfig.instance:getCommonValue("FREE_STRENGTH_REPLACE")

	local pId = SupplyConfig.instance:getCommonValue("FREE_STRENGTH_TIME_PLAN_ID")

	pId = checknumber(pId)

	local timeCfg = SupplyConfig.instance:getTimePlanCfg(pId)

	self._timeCfg = timeCfg

	GameUtil.SetActive(self._birthdayGo, false)

	if timeCfg and GameUtil.checkIsInTimePeriod(timeCfg.startTime, timeCfg.endTime) then
		GameUtil.SetActive(self._birthdayGo, true)

		local pre = GameUtil.string2date(timeCfg.startTime)
		local next = GameUtil.string2date(timeCfg.endTime)

		self.txtExtTime.text = langPara("%s月%s日%s点-%s月%s日%s点", pre.month, pre.day, pre.hour, next.month, next.day, next.hour)
	end

	self:_setMultiDesc()
	self:_updateSeveralSec()
	settimer(3, self._updateSeveralSec, self)
end

function SupplyView:onExit()
	self._isInView = false

	SupplyView.super.onExit(self)
	removetimer(self.updateBtnStatus, self)
	removetimer(self._updateSeveralSec, self)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	GameUtil.SetActive(self._petBtn, false)
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self._rewardTip, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTiliCount, self.updateStatus, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
end

function SupplyView:onEnterFinished()
	SupplyView.super.onEnterFinished(self)
end

function SupplyView:onExitFinished()
	SupplyView.super.onExitFinished(self)
end

function SupplyView:_reloadData()
	SupplyModel.instance.isInitedSupplyInfo = false

	SupplyController.instance:updataSupplyRedPoint(GameUtil.handler(self.updateStatus, self))
end

function SupplyView:updateBtnStatus()
	local btnStateList = SupplyController.instance:getBtnStateList()
	local isNeedTime = false

	for k, v in pairs(self._supplyList or {}) do
		local supplyItem = v
		local index = k - 1

		GameUtil.SetActive(supplyItem.btnUse, false)
		GameUtil.SetActive(supplyItem.btnLateUse, false)
		GameUtil.SetActive(supplyItem.useTxt, false)
		GameUtil.SetActive(supplyItem.btnReady, false)

		local cfg = SupplyConfig.instance:getDailyCfgById(index)

		supplyItem.tipTime.text = self:splitTimeStr(cfg.startTime) .. "-" .. self:splitTimeStr(cfg.endTime)

		local state = btnStateList[index]

		if state == "未到时间" then
			GameUtil.SetActive(supplyItem.btnReady, true)

			isNeedTime = true
		elseif state == "已领取" then
			GameUtil.SetActive(supplyItem.useTxt, true)
			supplyItem.foodState:SetState(1)
		elseif state == "可领取" then
			GameUtil.SetActive(supplyItem.btnUse, true)
		elseif state == "可补领" then
			GameUtil.SetActive(supplyItem.btnLateUse, true)
		end
	end

	removetimer(self.updateBtnStatus, self)

	if isNeedTime then
		settimer(30, self.updateBtnStatus, self)
	end
end

function SupplyView:updateStatus()
	if not self._isInView then
		return
	end

	SupplyController.instance:getSupplyList()
	self:updateBtnStatus()
end

function SupplyView:_autoOpenClose()
	removetimer(self._autoClose, self)
	settimer(2, self._autoClose, self)
end

function SupplyView:_autoClose()
	removetimer(self._autoClose, self)
	GameUtil.SetActive(self._dialogue, false)
end

function SupplyView:_rewardTip()
	GameUtil.SetActive(self._dialogue, true)
	self:_autoOpenClose()
end

function SupplyView:_petClickTip()
	self.openTip = not self.openTip

	GameUtil.SetActive(self._dialogue, self.openTip)
	self:_autoOpenClose()
end

function SupplyView:splitTimeStr(time)
	local strs = string.split(time, ":")
	local startH = strs[1]

	if not strs[2] then
		return startH .. ":" .. strs[2]
	end
end

function SupplyView:_clickBtnUse(idx)
	SupplyController.instance:getSupply(idx, function()
		self:updateStatus()
		GameUtil.SetActive(self._petBtn, true)
	end)
end

function SupplyView:_clickBtnLateUse(idx)
	local cost = checknumber(self.consumeCount)
	local supply = checknumber(self.freeMaxLQ)

	content = langPara("确定消耗%s钻石补领%s体力吗?", cost, supply)

	TipsFacade.instance:openPopupCostDiamondView(cost, content, function()
		SupplyController.instance:getLaterSupply(idx, GameUtil.handler(self.updateStatus, self))
	end)
end

function SupplyView:_updateSeveralSec()
	self:_updateMultiLabel()
end

function SupplyView:_updateMultiLabel()
	if self._timeCfg then
		local isShow = GameUtil.checkIsInTimePeriod(self._timeCfg.startTime, self._timeCfg.endTime)

		for i, v in ipairs(self._supplyList) do
			goutil.setActive(v.multi, self._timeCfg)
		end
	end
end

function SupplyView:_setMultiDesc()
	local multiDesc = SupplyConfig.instance:getCommonValue("STRENGTH_TIMES_DESC")

	for i, v in ipairs(self._supplyList) do
		v.txtMulti.text = multiDesc
	end
end

return SupplyView
