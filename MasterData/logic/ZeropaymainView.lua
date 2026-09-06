-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/view/ZeropaymainView.lua

module("logic.extensions.zeropay.view.ZeropaymainView", package.seeall)

local ZeropaymainView = class("ZeropaymainView", ViewComponent)

function ZeropaymainView:ctor()
	ZeropaymainView.super.ctor(self)
end

function ZeropaymainView:buildUI()
	ZeropaymainView.super.buildUI(self)

	self._buyBtn = self:getBtn("buyBtn")
	self._closeBtn = self:getBtn("closeBtn")
	self._getConGo = self:getGo("getCon")
	self._getcellGo = self:getGo("getCon/cell")
	self._getGroup = ItemGroup.New(self._getConGo, self._getcellGo, nil, nil, true)
	self._btnText = goutil.findChildTextComponent(self.mainGO, "buyBtn/text")
end

function ZeropaymainView:bindEvents()
	ZeropaymainView.super.bindEvents(self)
	self._buyBtn:AddClickListener(self._onClickbuyBtn, self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
end

function ZeropaymainView:unbindEvents()
	ZeropaymainView.super.unbindEvents(self)
	self._buyBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
end

function ZeropaymainView:destroyUI()
	ZeropaymainView.super.destroyUI(self)
end

function ZeropaymainView:onEnter()
	ZeropaymainView.super.onEnter(self)

	self._actId = self:getFirstParam()

	GlobalDispatcher:addListener(ZeropayController.PM_GetGiftInfoRes, self._PM_GetGiftInfoRes, self)
	GlobalDispatcher:addListener(ZeropayController.PM_NotifyBuyGiftRes, self._PM_NotifyBuyGiftRes, self)
	ZeropayController.instance:sendPM_GetGiftInfoReq()
	self:_updateView()
end

function ZeropaymainView:onEnterFinished()
	ZeropaymainView.super.onEnterFinished(self)
end

function ZeropaymainView:onExit()
	ZeropaymainView.super.onExit(self)
	GlobalDispatcher:removeListener(ZeropayController.PM_GetGiftInfoRes, self._PM_GetGiftInfoRes, self)
	GlobalDispatcher:removeListener(ZeropayController.PM_NotifyBuyGiftRes, self._PM_NotifyBuyGiftRes, self)
	self._getGroup:dispose(function(item)
		local con = goutil.findChild(item.mainGO, "con")

		MaterialMgr.resetAll(con)
	end)
end

function ZeropaymainView:onExitFinished()
	ZeropaymainView.super.onExitFinished(self)
end

function ZeropaymainView:_onClickbuyBtn()
	if self._isOutLimit then
		FloatWordMgr.instance:show("已购买2次，无法再次购买")

		return
	end

	if self._hasBuyGift then
		FloatWordMgr.instance:show("您已购买此活动礼包，需领完7天钻石返利后次日才可再次购买")

		return
	end

	local cfg = ZeropayConfig.instance:getCfg(self._actId, self._giftId)
	local paramStr = "{\"actId\":" .. self._actId .. "}"

	PayController.instance:pay(cfg.payGoodsId, GameEnum.PaySubGoodsType.ZERO_PAY, self._giftId, paramStr)
end

function ZeropaymainView:_onClickcloseBtn()
	self:close()
end

function ZeropaymainView:_updateView()
	self._giftId = 1
	self._hasBuyGift = ZeropayModel.instance:isBuyGift(self._actId, self._giftId)
	self._isOutLimit = ZeropayModel.instance:getBuyTimes() >= 2

	self:_updateReward()
	self:_setBtnState()
end

function ZeropaymainView:_updateReward()
	local cfg = ZeropayConfig.instance:getCfg(self._actId, self._giftId)
	local pcfg = PayConfig.instance:getPayGoodsCfg(cfg.payGoodsId)

	self._btnText.text = self._hasBuyGift and "已购买" or "¥ " .. pcfg.payMoney * PayModel.RMB_UNIT

	if ZeropayModel.instance:getBuyTimes() >= 1 then
		if not cfg.followUpGiftContent then
			local currMatStr = cfg.giftContent
			local immgetList = MaterialMgr.changeItemStrArr(currMatStr)
			local daygetList = MaterialMgr.changeItemStrArr(cfg.mailContent)
			local list = {}

			for i, v in ipairs(immgetList) do
				table.insert(list, {
					isDayGet = false,
					cfgStr = v
				})
			end

			for i, v in ipairs(daygetList) do
				table.insert(list, {
					isDayGet = true,
					cfgStr = v,
					getDay = cfg.mailDay
				})
			end

			self._getGroup:updateWithMoArray(list, function(item, data)
				local con = goutil.findChild(item.mainGO, "con")
				local tagText = goutil.findChildTextComponent(item.mainGO, "text")
				local tagBgGo = goutil.findChild(item.mainGO, "tagBg")
				local showBg = false

				if data.isDayGet then
					tagText.text = string.format("领%s天", data.getDay)
					showBg = true
				else
					local arr = string.split(data.cfgStr, ":")
					local matType = checknumber(arr[1])
					local matId = checknumber(arr[2])

					if matType == MatType.Pet then
						tagText.text = "精灵"
						showBg = true
					elseif matType == MatType.Item and matId ~= 1008 then
						tagText.text = "道具"
						showBg = true
					elseif matType == MatType.Item and matId == 1008 then
						tagText.text = "坐骑"
						showBg = true
					else
						tagText.text = ""
						showBg = false
					end
				end

				goutil.setActive(tagBgGo, showBg)
				MaterialMgr.setCellByCfg(data.cfgStr, con)
			end)
		end
	end
end

function ZeropaymainView:_setBtnState()
	GameUtil.SetGray(self._buyBtn.gameObject, self._hasBuyGift or self._isOutLimit)
end

function ZeropaymainView:_PM_GetGiftInfoRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function ZeropaymainView:_PM_NotifyBuyGiftRes(status)
	if status == 0 then
		self:_updateView()
	end
end

return ZeropaymainView
