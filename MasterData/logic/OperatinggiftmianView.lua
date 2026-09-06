-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operatingGift/view/OperatinggiftmianView.lua

module("logic.extensions.operatingGift.view.OperatinggiftmianView", package.seeall)

local OperatinggiftmianView = class("OperatinggiftmianView", ViewComponent)
local json = require("cjson")

function OperatinggiftmianView:ctor()
	OperatinggiftmianView.super.ctor(self)
end

function OperatinggiftmianView:buildUI()
	OperatinggiftmianView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._gift = self:getGo("gift")
	self._giftCells = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("gift/giftCell" .. i)
		cell.items = {}

		for i = 1, 4 do
			cell.items[i] = goutil.findChild(cell.go, "item" .. i)
		end

		cell.goCost = goutil.findChild(cell.go, "btnCost")
		cell.btnCost = GameUtil.asBtn(cell.goCost)
		cell.redPoint = goutil.findChild(cell.goCost, "redPoint")
		cell.txtCost = goutil.findChildTextComponent(cell.go, "btnCost/txtCost")
		cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
		self._giftCells[i] = cell
	end
end

function OperatinggiftmianView:bindEvents()
	OperatinggiftmianView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickBtnTip)

	for i = 1, 5 do
		self._giftCells[i].btnCost:AddClickListener(function()
			self:_onClickBtnCost(i)
		end, self)
	end
end

function OperatinggiftmianView:unbindEvents()
	OperatinggiftmianView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i = 1, 5 do
		self._giftCells[i].btnCost:RemoveClickListener()
	end
end

function OperatinggiftmianView:destroyUI()
	OperatinggiftmianView.super.destroyUI(self)
end

function OperatinggiftmianView:onEnter()
	OperatinggiftmianView.super.onEnter(self)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ENTER_TIANYANVIEW)
	CampaignThemeAgent.instance:sendPM_GetMyCurCampaignThemeInfoReq(self._handleGetInfo, self)
	GlobalDispatcher:addListener(CampaignThemeAgent.PM_NotifyCampaignThemeBuyGiftRes, self.handleNotifyBuyGiftRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
end

function OperatinggiftmianView:onEnterFinished()
	OperatinggiftmianView.super.onEnterFinished(self)
end

function OperatinggiftmianView:onExit()
	OperatinggiftmianView.super.onExit(self)

	for i = 1, 5 do
		for k = 1, 4 do
			MaterialMgr.resetAll(self._giftCells[i].items[k])
		end
	end

	GlobalDispatcher:removeListener(CampaignThemeAgent.PM_NotifyCampaignThemeBuyGiftRes, self.handleNotifyBuyGiftRes, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
end

function OperatinggiftmianView:onExitFinished()
	OperatinggiftmianView.super.onExitFinished(self)
end

function OperatinggiftmianView:_dailyReset()
	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.OperatingGift, self._curActId) then
		FloatWordMgr.instance:show("不在活动时间")
		self:close()

		return
	end

	CampaignThemeAgent.instance:sendPM_GetMyCurCampaignThemeInfoReq(self._handleGetInfo, self)
end

function OperatinggiftmianView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("tianyangift")
end

function OperatinggiftmianView:_onClickBtnCost(id)
	local giftType = self._curActCfgs[id].giftType

	if giftType == 1 then
		self:_onClickBtnType1(id)
	elseif giftType == 2 then
		self:_onClickBtnType2(id)
	elseif giftType == 3 then
		self:_onClickBtnType3(id)
	end
end

function OperatinggiftmianView:_onClickBtnType1(id)
	local gainState = self._giftState[id]
	local giftId = self._curActCfgs[id].giftId

	if gainState then
		FloatWordMgr.instance:show("已领取")
		self:_updateBtnState()

		return
	else
		CampaignThemeAgent.instance:sendPM_GainCampaignThemeGiftReq(self._curActId, giftId, function()
			self._giftState[id] = true

			self:_updateBtnState()
		end, self)
	end
end

function OperatinggiftmianView:_onClickBtnType2(id)
	local gainState = self._giftState[id]
	local cfg = self._curActCfgs[id]
	local giftId = cfg.giftId
	local payGoodId = cfg.payGoodsId

	if self._isAbleToFreeGain then
		if gainState then
			FloatWordMgr.instance:show("已领取")
			self:_updateBtnState()

			return
		else
			CampaignThemeAgent.instance:sendPM_GainCampaignThemeGiftReq(self._curActId, giftId, function()
				self._giftState[id] = true

				self:_updateBtnState()
			end, self)
		end
	elseif gainState then
		FloatWordMgr.instance:show("已购买")
		self:_updateBtnState()

		return
	else
		local para = {
			actId = self._curActId
		}

		json.encode(para)
		PayController.instance:pay(payGoodId, GameEnum.PaySubGoodsType.OPERATINGGGIFT, giftId, json.encode(para))
	end
end

function OperatinggiftmianView:_onClickBtnType3(id)
	local cfg = self._curActCfgs[id]
	local giftId = cfg.giftId
	local payGoodId = cfg.payGoodsId

	if self._isAbleToBuySevenDayGift then
		local para = {
			actId = self._curActId
		}

		json.encode(para)
		PayController.instance:pay(payGoodId, GameEnum.PaySubGoodsType.OPERATINGGGIFT, giftId, json.encode(para))
	elseif self._isOverTime then
		FloatWordMgr.instance:show("剩余天数不足6天，不可购买七日礼包了")
		self:_updateBtnState()
	else
		FloatWordMgr.instance:show("已购买")
		self:_updateBtnState()
	end
end

function OperatinggiftmianView:_handleGetInfo(msg)
	self._curActId = checkint(msg.actId)
	self._startTime, self._endTime = ActivityDefineController.instance:getStartTimeAndEndTime(16, self._curActId)
	self._buySpecialGiftTime = checkint(msg.specialGiftBuyTimeMillis)
	self._isAbleToFreeGain = false
	self._isAbleToBuySevenDayGift = false
	self._isOverTime = false
	self._isFirstDayBuy = false

	if self._buySpecialGiftTime == 0 then
		if self._endTime - ServerTime.now() <= 518400 then
			self._isOverTime = true
		else
			self._isAbleToBuySevenDayGift = true
		end
	else
		local lastTime = GameUtil.time2date(self._buySpecialGiftTime / 1000)
		local lastDay = lastTime.day

		if lastTime.hour >= 5 then
			lastDay = lastDay + 1
		end

		local lastNextDayTime = os.time({
			hour = 5,
			second = 0,
			minute = 0,
			day = lastDay,
			month = lastTime.month,
			year = lastTime.year
		})

		if ServerTime.now() - lastNextDayTime >= 518400 then
			if self._endTime - ServerTime.now() <= 518400 then
				self._isOverTime = true
			else
				self._isAbleToBuySevenDayGift = true
			end
		else
			self._isAbleToBuySevenDayGift = false

			if lastNextDayTime > ServerTime.now() then
				self._isFirstDayBuy = true
				self._isAbleToFreeGain = false
			else
				self._isFirstDayBuy = false
				self._isAbleToFreeGain = true
			end
		end
	end

	self._giftState = {}

	for _, state in ipairs(msg.giftGainBits) do
		table.insert(self._giftState, checkbool(state))
	end

	self._curActCfgs = OperatingGiftConfig.instance:getActCfgsById(self._curActId)

	if self._curActCfgs then
		self:_updateGiftItem()
	else
		printError("活动配置不存在")
	end
end

function OperatinggiftmianView:_updateGiftItem()
	for i = 1, 5 do
		local cell = self._giftCells[i]
		local giftType = self._curActCfgs[i].giftType
		local payGoodsId = self._curActCfgs[i].payGoodsId

		if not self._curActCfgs[i].giftContent then
			local giftContent = ""
			local giftStrs = MaterialMgr.changeItemStrArr(giftContent)

			for k = 1, 4 do
				MaterialMgr.resetAll(cell.items[k])

				if not GameUtil.isEmptyString(giftStrs[k]) then
					MaterialMgr.setCellByCfg(giftStrs[k], cell.items[k])
					goutil.setActive(cell.items[k], true)
				else
					goutil.setActive(cell.items[k], false)
				end
			end

			if giftType == 1 then
				cell.txtTitle.text = lang("免费<size=28>礼包</size>")
			elseif giftType == 2 then
				local priceNum = string.sub(payGoodsId, GameUtil.getStrLen("rmb_") + 1, -1)

				cell.txtTitle.text = langPara("%s元<size=28>礼包</size>", priceNum)
			elseif giftType == 3 then
				cell.txtTitle.text = lang("时装<size=28>礼包</size>")
			end
		end
	end

	self:_updateBtnState()
end

function OperatinggiftmianView:_updateBtnState()
	for i = 1, 5 do
		local cell = self._giftCells[i]
		local giftType = self._curActCfgs[i].giftType
		local gainState = self._giftState[i]
		local payGoodsId = self._curActCfgs[i].payGoodsId
		local priceNum = string.sub(payGoodsId, GameUtil.getStrLen("rmb_") + 1, -1)

		if giftType == 1 then
			cell.txtCost.text = gainState and lang("已领取") or lang("领取")

			GameUtil.SetGray(cell.goCost, gainState)
			goutil.setActive(cell.redPoint, not gainState)
		elseif giftType == 2 then
			if gainState then
				cell.txtCost.text = self._isAbleToFreeGain and lang("已领取") or lang("已购买")

				goutil.setActive(cell.redPoint, false)
			else
				cell.txtCost.text = self._isAbleToFreeGain and lang("领取") or langPara("￥ %s", priceNum)

				goutil.setActive(cell.redPoint, self._isAbleToFreeGain)
			end

			GameUtil.SetGray(cell.goCost, gainState)
		elseif giftType == 3 then
			goutil.setActive(cell.redPoint, false)

			cell.txtCost.text = self._isAbleToFreeGain and lang("已购买") or langPara("￥ %s", priceNum)

			GameUtil.SetGray(cell.goCost, not self._isAbleToBuySevenDayGift)
		end
	end
end

function OperatinggiftmianView:handleNotifyBuyGiftRes(status, msg)
	if status == 0 and self._curActId == checkint(msg.actId) then
		self._giftState[checkint(msg.giftId)] = true

		self:_updateBtnState()

		if self._curActCfgs[msg.giftId].giftType == 3 then
			CampaignThemeAgent.instance:sendPM_GetMyCurCampaignThemeInfoReq(self._handleGetInfo, self)
		end
	end
end

return OperatinggiftmianView
