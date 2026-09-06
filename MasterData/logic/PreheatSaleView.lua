-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preheatsale/view/PreheatSaleView.lua

module("logic.extensions.preheatsale.view.PreheatSaleView", package.seeall)

local PreheatSaleView = class("PreheatSaleView", ViewComponent)

function PreheatSaleView:ctor()
	PreheatSaleView.super.ctor(self)
end

function PreheatSaleView:unbindEvents()
	PreheatSaleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function PreheatSaleView:bindEvents()
	PreheatSaleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
end

function PreheatSaleView:onExit()
	PreheatSaleView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PreheatSaleError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.PreheatSaleInfoUpdate, self._updateByInfo, self)
	removetimer(self._updateByTime, self)

	for i = 1, 5 do
		MaterialMgr.resetAll(self._itemCells[i])
	end

	MaterialMgr.resetAll(self._addReward)
end

function PreheatSaleView:buildUI()
	PreheatSaleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._txtPayTip = self:getTxt("txtPayTip")
	self._txtDate = self:getTxt("txtDate")
	self._txtpay = self:getTxt("btnBuy/txt")
	self._itemCells = {}

	for i = 1, 5 do
		self._itemCells[i] = self:getGo("reward/item" .. i)
	end

	self._addReward = self:getGo("addReward")
end

function PreheatSaleView:onEnter()
	PreheatSaleView.super.onEnter(self)

	self._actId, self._actCfg = PreheatSaleModel.instance:getCurActId()

	if self._actId ~= 0 then
		self:_updateByCfg()
		PreheatSaleAgent.instance:sendPM_PreheatSaleGetInfoReq(self._actId)
	else
		FloatWordMgr.instance:show(lang("活动未开始"))
		self:close()
	end

	GlobalDispatcher:addListener(GlobalNotify.PreheatSaleError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.PreheatSaleInfoUpdate, self._updateByInfo, self)
end

function PreheatSaleView:_updateByCfg()
	self._commonCfg = PreheatSaleConfig.instance:getcommonCfg(self._actId)

	goutil.setActive(self._btnBuy.gameObject, false)

	self._txtpay.text = langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._commonCfg.payGoodsId))
	self._timeStart = GameUtil.string2time(self._actCfg.startTime)
	self._timeEnd = GameUtil.string2time(self._actCfg.endTime)
	self._txtDate.text = langPara("活动结束时间：%s", GameUtil.formatTimeStamp("%m月%d日%H时", self._timeEnd))
	self._getAddDate = GameUtil.string2time(self._commonCfg.gainExtraGiftTime)
	self._txtPayTip.text = langPara(GameUtil.formatTimeStamp("%m月%d日%H点前购买额外获得", self._getAddDate))

	if not self._commonCfg.gift then
		local prizeStr = ""
		local prizeStrs = string.split(prizeStr, "#")
		local dataList = {}

		for i, data in pairs(prizeStrs) do
			if not GameUtil.isEmptyString(data) then
				table.insert(dataList, data)
			end
		end

		for i = 1, 5 do
			MaterialMgr.resetAll(self._itemCells[i])

			if dataList[i] then
				MaterialMgr.setCellByCfg(dataList[i], self._itemCells[i])
			end

			goutil.setActive(self._itemCells[i], self._itemCells[i])
		end

		prizeStr = self._commonCfg.extraGift or ""
		prizeStrs = string.split(prizeStr, "#")
		dataList = {}

		for i, data in pairs(prizeStrs) do
			if not GameUtil.isEmptyString(data) then
				table.insert(dataList, data)
			end
		end

		MaterialMgr.resetAll(self._addReward)

		if dataList[1] then
			MaterialMgr.setCellByCfg(dataList[1], self._addReward)
		end

		removetimer(self._updateByTime, self)
		settimer(1, self._updateByTime, self)
	end
end

function PreheatSaleView:_updateByInfo()
	goutil.setActive(self._btnBuy.gameObject, true)

	if PreheatSaleModel.instance:getIsHasBuy(self._actId) then
		self._txtpay.text = lang("已购买")
	end
end

function PreheatSaleView:_onError(status)
	self:close()
end

function PreheatSaleView:_updateByTime()
	if self._timeEnd and self._timeEnd > ServerTime.now() then
		-- block empty
	else
		removetimer(self._updateByTime, self)
		FloatWordMgr.instance:show(lang("活动结束"))
		self:close()
	end
end

function PreheatSaleView:_onClickBuy()
	if PreheatSaleModel.instance:getIsHasBuy(self._actId) then
		self._txtpay.text = lang("已购买")

		FloatWordMgr.instance:show(lang("不可重复购买"))
	else
		PayController.instance:sendGenOrderNoReq(self._commonCfg.payGoodsId, GameEnum.PaySubGoodsType.PREHEAT_SALE, self._actId)
	end
end

return PreheatSaleView
