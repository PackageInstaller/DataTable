-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paytempt/controller/PaytemptController.lua

module("logic.extensions.paytempt.controller.PaytemptController", package.seeall)

local PaytemptController = class("PaytemptController", BaseController)

PaytemptController.PAYTEMPT_GOODS_UPDATE = "paytempt_goods_update"

function PaytemptController:ctor()
	PaytemptController.super.ctor(self)
end

function PaytemptController:onInit()
	self:onReset()
	PayAgent.instance:addHandler(PayAgent.NotifyPayResultRes, self.handleNotifyPayResultRes, self)
	PayTemptAgent.instance:addHandler(PayTemptAgent.PM_NotifyNewGiftRes, self.onGiftInfoChange, self)
	GlobalDispatcher:addListener(PayShopModel.GetAllPayShopBuyTimesRes, self.onShopUpdate, self)
end

function PaytemptController:onReset()
	removetimer(self.sendGetInfo, self)
	removetimer(self.onTimer, self)

	self.isShopHasUpdate = false
end

function PaytemptController:onShopUpdate()
	self.isShopHasUpdate = true
end

function PaytemptController:sendGetInfo()
	PayTemptAgent.instance:sendPM_GetMyAllPayTemptInfoReq(function(msg)
		PaytemptModel.instance:setData(msg.infos)
		removetimer(self.onTimer, self)
		settimer(30, self.onTimer, self)
		self:onTimer()
		forcePrint("=====RoleDataRequestor:_loadPayTempInfo===back")
		self:notify(PaytemptController.PAYTEMPT_GOODS_UPDATE)
	end)
end

function PaytemptController:onGiftInfoChange(msg, status)
	PaytemptModel.instance:setData(msg.newGiftInfos)
	print(">>>>>>>>>>>>>>>>> PaytemptController:onGiftInfoChange(msg,status)")
	self:notify(PaytemptController.PAYTEMPT_GOODS_UPDATE)
end

function PaytemptController:onTimer()
	if self.isShopHasUpdate then
		local list = PaytemptConfig.instance:getClientCfgs()

		for k, cfg in pairs(list) do
			local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(cfg.shopId)

			if isCanBuy then
				local timeStr = cfg.openTime
				local timeArr = string.split(timeStr, "#")

				if GameUtil.checkIsInTimePeriod(timeArr[1], timeArr[2]) then
					local obj = {}

					obj.type = PaytemptModel.TYPE_CLIENT
					obj.id = cfg.id
					obj.shopId = cfg.shopId
					obj.timeStart = timeArr[1]
					obj.timeEnd = timeArr[2]

					local timeEnd = GameUtil.string2time(timeArr[2])

					obj.endTimeMillis = timeEnd * 1000

					PaytemptModel.instance:addData(obj)
				end
			end
		end
	end
end

function PaytemptController:handleNotifyPayResultRes(msg, status)
	if status == 0 then
		local subGoodsType = msg.subGoodsType

		if subGoodsType == GameEnum.PaySubGoodsType.PAY_TEMPT then
			PaytemptModel.instance:delDataById(msg.subGoodsId)
			TipsFacade.instance:openCommonTips("购买成功")
			self:notify(PaytemptController.PAYTEMPT_GOODS_UPDATE)
		end

		if subGoodsType == GameEnum.PaySubGoodsType.PAY_SHOP then
			local isHasDel = PaytemptModel.instance:delDataById(msg.subGoodsId, PaytemptModel.TYPE_CLIENT)

			if isHasDel then
				TipsFacade.instance:openCommonTips("购买成功")
				self:notify(PaytemptController.PAYTEMPT_GOODS_UPDATE)
			end
		end
	end
end

PaytemptController.instance = PaytemptController.New()

return PaytemptController
