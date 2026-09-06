-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/DayrechargeView.lua

module("logic.extensions.doubleeleven.view.DayrechargeView", package.seeall)

local DayrechargeView = class("DayrechargeView", ViewComponent)

function DayrechargeView:ctor()
	DayrechargeView.super.ctor(self)
end

function DayrechargeView:unbindEvents()
	DayrechargeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGoto)
end

function DayrechargeView:bindEvents()
	DayrechargeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function DayrechargeView:buildUI()
	DayrechargeView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecell = self:getGo("cell")
	self._itemGo = self:getGo("item")
	self._bigReward = self:getGo("bigReward")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._btnGoto = self:getBtn("btnGoto")
	self._tableview = ScrollerList.create(self._tableviewGo, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DayrechargeView:onExit()
	DayrechargeView.super.onExit(self)
	self._tableview:dispose()

	for _, clone in ipairs(self._cloneGoList) do
		MaterialMgr.resetAll(clone)
		goutil.destroy(clone, true)
	end

	for _, btn in ipairs(self._btnRecieveList) do
		GameUtil.rmClickHandler(btn)
	end

	self._cloneGoList = nil
	self._btnRecieveList = nil
end

function DayrechargeView:onEnter()
	DayrechargeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DE_UpdataContinuousRechargeInfo, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.DE_UpdataContinuousRechargePrize, self._refreshUI, self)

	self._activityId = DoubleElevenConfig.instance:getDaysRechargeCommonValue("DAY_ACTID", true)

	DoubleElevenModel.instance:setActivityId(self._activityId)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DaysRecharge, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))
	self._cloneGoList = {}
	self._btnRecieveList = {}
	self._curSelectId = 0
	self._rechargeCfg = DoubleElevenConfig.instance:getDayRechargeCfg()
	self._lastestCfg = DoubleElevenConfig.instance:getLastestRechargeCfg()

	DoubleElevenController.instance:csGetDaysRechargeGetInfoReq(self._activityId)
	self:_refreshUI()
	self:bigRewardUI()
end

function DayrechargeView:_refreshUI()
	self._tableview:reloadData(self._rechargeCfg)
	self._tableview:regReloadFinish(function()
		self._tableview:MoveCellToBegin(self._curSelectId)
	end)
end

function DayrechargeView:bigRewardUI()
	local itemParent = goutil.findChild(self._bigReward, "itemList")
	local txtTitle = goutil.findChildTextComponent(self._bigReward, "txtTitle")
	local btnRecieve = goutil.findChildButtonComponent(self._bigReward, "btnRecieve")
	local receive = goutil.findChild(self._bigReward, "receive")
	local state = DoubleElevenModel.instance:getRechargeItemState(self._lastestCfg.money, self._lastestCfg.itemId)

	receive:SetActive(state > 1)
	btnRecieve.gameObject:SetActive(state == 1)

	txtTitle.text = string.format("充值<size=38>%s</size>天", self._lastestCfg.rechargeDays)

	local prizeArr = string.split(self._lastestCfg.prize, "#")

	for i, v in ipairs(prizeArr) do
		local clone = goutil.findChild(itemParent, "reward_" .. i)

		if not clone then
			clone = goutil.cloneAndSetParent(self._itemGo, itemParent.transform, "reward_" .. i)

			table.insert(self._cloneGoList, clone)
		end

		MaterialMgr.setCellByCfg(v, clone)
	end

	GameUtil.addClickHandler(btnRecieve, GameUtil.handler(self._sendGainPrizeReq, self, self._lastestCfg.itemId))
	table.insert(self._btnRecieveList, btnRecieve)
end

function DayrechargeView:_updateCell(view, cell, data)
	local cellGo = self:_clearCell(cell)
	local prizeArr = string.split(data.prize, "#")

	for i, v in ipairs(prizeArr) do
		local clone = goutil.findChild(cellGo.itemGroupParent, "reward_" .. i)

		if not clone then
			clone = goutil.cloneAndSetParent(self._itemGo, cellGo.itemGroupParent.transform, "reward_" .. i)

			table.insert(self._cloneGoList, clone)
		end

		MaterialMgr.setCellByCfg(v, clone)
	end

	local state = DoubleElevenModel.instance:getRechargeItemState(data.money, data.itemId)

	cellGo.receive:SetActive(state > 1)
	cellGo.btnRecieve.gameObject:SetActive(state == 1)
	cellGo.canGet.gameObject:SetActive(state == 1)

	cellGo.txtTitle.text = string.format("充值%s天", data.rechargeDays)

	if state == 1 then
		self._curSelectId = cell.index
	end

	if state > 1 then
		self._curSelectId = cell.index + 1
	end

	GameUtil.addClickHandler(cellGo.btnRecieve, GameUtil.handler(self._sendGainPrizeReq, self, data.itemId))
	table.insert(self._btnRecieveList, btnRecieve)
end

function DayrechargeView:_clearCell(cell)
	local cellGo = {}

	cellGo.txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	cellGo.effectParent = goutil.findChild(cell, "effect")
	cellGo.receive = goutil.findChild(cell, "receive")
	cellGo.itemGroupParent = goutil.findChild(cell, "itemList")
	cellGo.canGet = goutil.findChild(cell, "canGet")
	cellGo.btnRecieve = goutil.findChildButtonComponent(cell, "btnRecieve")

	return cellGo
end

function DayrechargeView:_sendGainPrizeReq(itemId)
	DoubleElevenController.instance:csGetDaysRechargeGainPrizeReq(self._activityId, itemId)
end

function DayrechargeView:_onClickTip()
	TipsFacade.instance:openRulesView("dayrebate_rule")
end

function DayrechargeView:_onClickGoto()
	GotoMgr.gotoByString("mibao#GodDiamond")
end

return DayrechargeView
