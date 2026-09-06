-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcardspack/view/MonthCardPackView.lua

module("logic.extensions.monthcardspack.view.MonthCardPackView", package.seeall)

local MonthCardPackView = class("MonthCardPackView", ViewComponent)

function MonthCardPackView:buildUI()
	MonthCardPackView.super.buildUI(self)

	self._btnBuy = self:getBtn("btnBuy")
	self._btnTip = self:getBtn("btnTip")
	self._txtPrice = self:getTxt("btnBuy/txtPrice")
	self._txtRemain = self:getTxt("remain/txt")
	self._txtOldPrice = self:getTxt("txtOldPrice")
	self._btnGoldenDiamondDetail = self:getBtn("card_1/btnDetail")
	self._activityTime = self:getTxt("time/txt")

	self:_initMonthCard()
	self:_initResMonthCard()
end

function MonthCardPackView:_initMonthCard()
	self._monthCardViewContent = self:getGo("card_2/View/Viewport/Content").transform
	self._monthCardItemsNode = self:getGo("card_2/View/Viewport/Content/items").transform
	self._monthCardItem = self:getGo("card_2/itemcell")
	self._btnMonthCardDetails = self:getBtn("card_2/btnDetail")
	self._monthCardItems = ItemGroup.New(self._monthCardItemsNode, self._monthCardItem, nil, nil, true)
end

function MonthCardPackView:_initResMonthCard()
	self._resMonthCardViewContent = self:getGo("card_3/View/Viewport/Content").transform
	self._resMonthCardItemsNode = self:getGo("card_3/View/Viewport/Content/items").transform
	self._resMonthCardItem = self:getGo("card_3/itemcell")
	self._btnResMonthCardDetails = self:getBtn("card_3/btnDetail")
	self._resMonthCardItems = ItemGroup.New(self._resMonthCardItemsNode, self._resMonthCardItem, nil, nil, true)
end

function MonthCardPackView:bindEvents()
	MonthCardPackView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickTips, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._btnGoldenDiamondDetail:AddClickListener(self._onClickGoldenDiamondDetail, self)
	self._btnMonthCardDetails:AddClickListener(self._onClickMonthCardDetails, self)
	self._btnResMonthCardDetails:AddClickListener(self._onClickResMonthCardDetails, self)
end

function MonthCardPackView:unbindEvents()
	MonthCardPackView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnGoldenDiamondDetail:RemoveClickListener()
	self._btnMonthCardDetails:RemoveClickListener()
	self._btnResMonthCardDetails:RemoveClickListener()
end

function MonthCardPackView:onEnter()
	MonthCardPackView.super.onEnter(self)
	MonthCardPackController.instance:checkCurrActivity()
	MonthCardPackController.instance:setClickTabRedpoint()
	GlobalDispatcher:addListener(GlobalNotify.OnMonthCardPackInfo, self._onMonthCardPackInfo, self)
	GlobalDispatcher:addListener(PayController.NotifyPayResultRes, self._onNotifyPayResultRes, self)

	local currActivetyId = MonthCardPackModel.instance:getActivityId()

	if currActivetyId == 0 then
		FloatWordMgr.instance:show("活动已结束")
		self:close()

		return
	end

	MonthCardPackController.instance:requestMonthCardPackGetInfo(currActivetyId)
	Framework.TransformUtil.SetAnchoredPos(self._monthCardViewContent, 0, 0)
	Framework.TransformUtil.SetAnchoredPos(self._resMonthCardViewContent, 0, 0)

	local acCo = MonthCardPackConfig.instance:getActivityCo(currActivetyId)

	self._firstMonthCardId = acCo.cardIds[1]
	self._secondMonthCardId = acCo.cardIds[2]

	self:_refreshMonthCardView(self._firstMonthCardId, self._monthCardItems)
	self:_refreshMonthCardView(self._secondMonthCardId, self._resMonthCardItems)
	self:_refreshView()
	self:_playEffect()
end

function MonthCardPackView:onExit()
	MonthCardPackView.super.onExit(self)
	self:_stopEffect()
	self._monthCardItems:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
	self._resMonthCardItems:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
	GlobalDispatcher:removeListener(PayController.NotifyPayResultRes, self._onNotifyPayResultRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMonthCardPackInfo, self._onMonthCardPackInfo, self)
end

function MonthCardPackView:_refreshView()
	self:_refreshTimes()
	self:_refreshOldPrice()
	self:_updateActTime()
end

function MonthCardPackView:_playEffect()
	self._eff = UIEffectManager.instance:playEffectBrief(self, "20220429/yueka_leichong/fx_ui_yuekadabao_jiemian.prefab", self.mainGO, true)

	self._eff:setParent(self.mainGO.transform)
	self._eff:setLocalPos(0, 0, 0)
	self._eff:setScale(1)
end

function MonthCardPackView:_stopEffect()
	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function MonthCardPackView:_refreshTimes()
	local currActivetyId = MonthCardPackModel.instance:getActivityId()
	local acCo = MonthCardPackConfig.instance:getActivityCo(currActivetyId)

	if not acCo then
		return
	end

	local remainTime = MonthCardPackModel.instance:getRemainTimes()
	local wholeLimitNums = MonthCardPackModel.instance:getWholeLimitNums()

	self._txtRemain.text = string.format("剩余<color=#20b376>%s</color>/%s份", wholeLimitNums, acCo.limit)

	if remainTime == 0 then
		self._txtPrice.text = "已购买"
	else
		local price = PayConfig.instance:getPayMoneyYuan(acCo.payGoodsId)

		self._txtPrice.text = string.format("%s 元打包", price)
	end
end

function MonthCardPackView:_updateActTime()
	local currActivetyId = MonthCardPackModel.instance:getActivityId()

	if currActivetyId == 0 then
		return
	end

	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.MonthCardPack, currActivetyId)
	local sdate = GameUtil.time2date(stime)
	local edate = GameUtil.time2date(etime)

	self._activityTime.text = string.format("活动时间:%s月%s日-%s月%s日", sdate.month, sdate.day, edate.month, edate.day)
end

function MonthCardPackView:_refreshOldPrice()
	local cfgMonthCard = MonthCardConfig.instance:getCfgByIndex(self._firstMonthCardId)
	local cfgResMonthCard = MonthCardConfig.instance:getCfgByIndex(self._secondMonthCardId)
	local goldDiamondgoodsId = GoldenDiamondCardConfig.instance:getCommonValue("GOODS_ID")
	local originPrice = checknumber(PayConfig.instance:getPayMoneyYuan(goldDiamondgoodsId))

	originPrice = originPrice + checknumber(PayConfig.instance:getPayMoneyYuan(cfgMonthCard.payGoodsId))
	originPrice = originPrice + checknumber(PayConfig.instance:getPayMoneyYuan(cfgResMonthCard.payGoodsId))
	self._txtOldPrice.text = string.format("原价：%d元", originPrice)
end

function MonthCardPackView:_refreshMonthCardView(monthCardId, monthCardItems)
	local cfg = MonthCardConfig.instance:getCfgByIndex(monthCardId)
	local mosDay = string.split(cfg.dailyGain, "#")
	local list = string.split(cfg.onceGain, "#")
	local mos = {}

	for i, str in ipairs(list) do
		mos[i] = str
	end

	table.insert(mos, cfg.extraGain)

	for i, str in ipairs(mosDay) do
		table.insert(mos, str)
	end

	monthCardItems:updateWithMoArray(mos, self._updateMonthCardCell, self)
end

function MonthCardPackView:_updateMonthCardCell(item, data)
	MaterialMgr.setCellByCfg(data, item.mainGO)

	local items = string.split(data, ":")

	if checknumber(items[1]) == MatType.HeadFrame then
		Framework.TransformUtil.SetLocalScale(item.mainGO.transform, 0.7, 0.7, 0.7)
	else
		Framework.TransformUtil.SetLocalScale(item.mainGO.transform, 0.8, 0.8, 0.8)
	end
end

function MonthCardPackView:_onMonthCardPackInfo()
	self:_refreshView()
end

function MonthCardPackView:_onNotifyPayResultRes()
	self:_refreshView()

	local currActivetyId = MonthCardPackModel.instance:getActivityId()

	if currActivetyId == 0 then
		return
	end

	MonthCardPackController.instance:requestMonthCardPackGetInfo(currActivetyId)
end

function MonthCardPackView:_onClickTips()
	TipsFacade.instance:openRulesView("monthcardpack")
end

function MonthCardPackView:_onClickBuy()
	local currActivetyId = MonthCardPackModel.instance:getActivityId()
	local acCo = MonthCardPackConfig.instance:getActivityCo(currActivetyId)

	if not acCo then
		return
	end

	local remainTime = MonthCardPackModel.instance:getRemainTimes()
	local wholeLimitNums = MonthCardPackModel.instance:getWholeLimitNums()

	if remainTime == 0 then
		FloatWordMgr.instance:show("您已购买！")

		return
	end

	if wholeLimitNums == 0 then
		FloatWordMgr.instance:show("已售罄！")

		return
	end

	PayController.instance:pay(acCo.payGoodsId, GameEnum.PaySubGoodsType.MONTH_CARD_PACK, currActivetyId)
end

function MonthCardPackView:_onClickGoldenDiamondDetail()
	local currActivetyId = MonthCardPackModel.instance:getActivityId()
	local acCo = MonthCardPackConfig.instance:getActivityCo(currActivetyId)

	if not acCo then
		self:close()

		return
	end

	GotoMgr.gotoByString(acCo.jumpToGoldenDiamondCard)
end

function MonthCardPackView:_onClickMonthCardDetails()
	local currActivetyId = MonthCardPackModel.instance:getActivityId()
	local acCo = MonthCardPackConfig.instance:getActivityCo(currActivetyId)

	if not acCo then
		self:close()

		return
	end

	GotoMgr.gotoByString(acCo.jumpToMonthCard)
end

function MonthCardPackView:_onClickResMonthCardDetails()
	local currActivetyId = MonthCardPackModel.instance:getActivityId()
	local acCo = MonthCardPackConfig.instance:getActivityCo(currActivetyId)

	if not acCo then
		self:close()

		return
	end

	GotoMgr.gotoByString(acCo.jumpToResMonthCard)
end

return MonthCardPackView
