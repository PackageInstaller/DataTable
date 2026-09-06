-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/controller/PassportController.lua

module("logic.extensions.passport.controller.PassportController", package.seeall)

local PassportController = class("PassportController", BaseController)

function PassportController:ctor()
	return
end

function PassportController:onInit()
	PassportAgent.instance:addHandler(PassportAgent.PM_NotifyPassportPayBuyCertSucRes, self._NotifyPassportPayBuyCertSuc, self)
	self:onReset()
end

function PassportController:onReset()
	self._handler = nil
	self._handlerObj = nil
end

function PassportController:sendGetInfoReq(funcId)
	PassportAgent.instance:sendPM_PassportGetInfoReq(funcId)
end

function PassportController:sendAndGetPassActive()
	PassportModel.instance:resetPassActIds()
	PassportAgent.instance:sendPM_PassportGetAllUserValidPermanentActsReq()
end

function PassportController:_GetInfoRes(msg)
	PassportModel.instance:updateAfterGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PassportStateUpdate)
	self:_callback()
end

function PassportController:sendGainPrizeReq(actId, funcId, prizeIndex, isSuper, isAdd)
	local prizeType = 1

	if isSuper then
		prizeType = 2
	elseif isAdd then
		prizeType = 3
	end

	self:sendGainPrizeReqByType(actId, funcId, prizeIndex, prizeType)
end

function PassportController:sendGainPrizeReqByType(actId, funcId, prizeIndex, prizeType)
	PassportAgent.instance:sendPM_PassportGainPrizeReq(actId, funcId, prizeIndex, prizeType)
end

function PassportController:_GainPrizeRes(msg)
	PassportModel.instance:updateAfterGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PassportStateUpdate)
	self:_callback()
end

function PassportController:sendOneKeyGainPrizeReq(actId, funcId)
	PassportAgent.instance:sendPM_PassportOneKeyGainPrizeReq(actId, funcId)
end

function PassportController:_OneKeyGainPrizeRes(msg)
	PassportModel.instance:updateAfterOneKeyGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PassportStateUpdate)
	self:_callback()
end

function PassportController:sendPMGainPayAllPrizeReq(actId, funcId)
	PassportAgent.instance:sendPM_GainPayAllPrizeReq(actId, funcId)
end

function PassportController:sendBuyProgressReq(actId, funcId, num)
	PassportAgent.instance:sendPM_PassportBuyProgressReq(actId, funcId, num)
end

function PassportController:_BuyProgressRes(msg)
	PassportModel.instance:updateAfterBuyProgress(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PassportStateUpdate)
	self:_callback()
end

function PassportController:_NotifyPassportPayBuyCertSuc(msg)
	PassportModel.instance:updateAfterPayBuyCertSuc(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PassportStateUpdate)
	UIStateManager.instance:popByName(ViewName.PassportbuyView)
	UIStateManager.instance:popByName(ViewName.PassportwpbuyView)
	UIStateManager.instance:popByName(ViewName.PassportwpbuynewView)
	UIStateManager.instance:popByName(ViewName.BrotherGroupBuyView)
end

function PassportController:sendGainExtraPrize(actId, funcId)
	PassportAgent.instance:sendPM_PassportGainExtraPrizeReq(actId, funcId)
end

function PassportController:handleGainExtraPrize(msg)
	PassportModel.instance:updateAfterGainExtraPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PassportExtraPrizeUpdate)
end

function PassportController:sendBuyPassportReq(actId, funcId, goodsId, prizeType)
	PassportAgent.instance:sendPM_BuyPassportReq(actId, funcId, goodsId, prizeType)
end

function PassportController:handleBuyPassportRes(msg)
	PassportModel.instance:handleBuyPassportRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PassportStateUpdate)
end

function PassportController:_callback(...)
	return
end

function PassportController:_errorCall()
	return
end

function PassportController:_checkIsReqing()
	return
end

function PassportController:_buyPassportWithDifferentPayType(actId, isHigher, isAdd)
	local data = PassportConfig.instance:getPeriodActivityCfgById(actId)

	if data == nil then
		printError("缺失配置", actId)

		return
	end

	if not self:_checkBuyTimeStart(actId, isHigher, isAdd) then
		return
	end

	local payType = data.payType

	if payType == 1 then
		self:_payTypeOne(actId, isHigher, isAdd)
	elseif payType == 2 then
		self:_payTypeTwo(actId, isHigher, isAdd)
	else
		printError("超出支付货币类型")
	end
end

function PassportController:_checkBuyTimeStart(actId, isHigher, isAdd)
	local data = PassportConfig.instance:getPeriodActivityCfgById(actId)

	if data == nil then
		printError("缺失配置", actId)

		return false
	end

	local startTimeStr = ""

	startTimeStr = isHigher and data.thirdBuyStartTime or isAdd and data.additionalBuyStartTime or data.ordinaryBuyStartTime

	if not string.nilorempty(startTimeStr) then
		local startTime = GameUtil.string2time(startTimeStr)

		if startTime > ServerTime.now() then
			local date = GameUtil.string2date(startTimeStr)
			local tip = string.format("将在%s-%s-%s %s:00后开启购买", date.year, date.month, date.day, date.hour)

			FloatWordMgr.instance:show(tip)

			return false
		end
	end

	return true
end

function PassportController:_payTypeOne(actId, isHigher, isAdd)
	local data = PassportConfig.instance:getPeriodActivityCfgById(actId)

	if isHigher and (string.nilorempty(data.vipHigherGoodsId) or string.nilorempty(data.higherGoodsId)) then
		printError("有高级购买意图,但高级购买缺失配置,请务必填上")

		return
	end

	if isAdd and string.nilorempty(data.additonalGoodsId) then
		printError("新增的通行证档位购买配置为空，检测" .. data.actId)

		return
	end

	if isHigher then
		if not data.vipHigherGoodsId then
			local vipGoodsId = data.vipGoodsId

			if isHigher then
				if not data.higherGoodsId then
					local goodsId = data.goodsId
					local isDiscountTime = not isHigher and not isAdd and not string.nilorempty(data.discountTime) and GameUtil.checkTimeStr(data.discountTime)
					local isVipDiscount = VipModel.instance:getIsAbleToPassportDiscount()
					local payGoodsId = goodsId

					if isVipDiscount then
						payGoodsId = vipGoodsId
					end

					if isDiscountTime then
						payGoodsId = data.discountGoodsId
					end

					local temPrizeType = isAdd and 3 or 2
					local subGoodsType = GameEnum.PaySubGoodsType.PASS_PORT
					local subGoodsId = actId
					local para = {
						funcId = data.funcId,
						prizeType = temPrizeType
					}
					local extParams = GameUtil.jsonToString(para)

					PayController.instance:pay((isAdd or nil) and data.additonalGoodsId, subGoodsType, subGoodsId, extParams)
				end
			end
		end
	end
end

function PassportController:_payTypeTwo(actId, isHigher, isAdd)
	local data = PassportConfig.instance:getPeriodActivityCfgById(actId)

	if isHigher then
		if not data.vipHigherGoodsId then
			local vipGoodsId = data.vipGoodsId

			if isHigher then
				if not data.higherGoodsId then
					local goodsId = data.goodsId
					local isDiscountTime = not isHigher and not isAdd and not string.nilorempty(data.discountTime) and GameUtil.checkTimeStr(data.discountTime)
					local isVipDiscount = VipModel.instance:getIsAbleToPassportDiscount()
					local payGoodsId = goodsId

					if isVipDiscount then
						payGoodsId = vipGoodsId
					end

					if isDiscountTime then
						payGoodsId = data.discountGoodsId
					end

					if isAdd then
						payGoodsId = data.additonalGoodsId
					end

					local temPrizeType = isAdd and 3 or 2
					local matType, matId, matNum = MaterialMgr.getMatParams(payGoodsId)
					local txtCost = string.format("<quad name=%s:%s|icon size=40 width=1 offsetY=-8/>", matType, matId)

					local function successCallBack()
						PassportController.instance:sendBuyPassportReq(actId, data.funcId, payGoodsId, temPrizeType)
					end

					local alignment = UnityEngine.TextAnchor.MiddleCenter

					TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, (not string.nilorempty(data.payTipsText) or nil) and string.format(data.payTipsText, txtCost, matNum), successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
				end
			end
		end
	end
end

function PassportController:buyPassportByPayType(actId, temPrizeType, isHigher)
	local data = PassportConfig.instance:getPeriodActivityCfgById(actId)
	local payType = data.payType

	if payType == 1 then
		self:_payTypeOneForPassport(data, temPrizeType, isHigher)
	elseif payType == 2 then
		self:_payTypeTwoForPassport(data, temPrizeType, isHigher)
	else
		printError("超出支付货币类型")
	end
end

function PassportController:_payTypeOneForPassport(data, temPrizeType, isHigher)
	isHigher = checkbool(isHigher)

	if temPrizeType == PassportModel.ORDINARY_PAYMENT_PRIZE_TYPE and (string.nilorempty(data.vipHigherGoodsId) or string.nilorempty(data.higherGoodsId)) then
		printError("有高级购买意图,但高级购买缺失配置,请务必填上")

		return
	end

	if temPrizeType == PassportModel.ADDITIONAL_PAYMENT_PRIZE_TYPE and string.nilorempty(data.additonalGoodsId) then
		printError("新增的通行证档位购买配置为空，检测" .. data.actId)

		return
	end

	if isHigher then
		if not data.vipHigherGoodsId then
			local vipGoodsId = data.vipGoodsId

			if isHigher then
				if not data.higherGoodsId then
					local goodsId = data.goodsId
					local isDiscountTime = temPrizeType ~= PassportModel.ORDINARY_PAYMENT_PRIZE_TYPE and temPrizeType ~= PassportModel.ADDITIONAL_PAYMENT_PRIZE_TYPE and temPrizeType ~= PassportModel.THIRD_PAYMENT_PRIZE_TYPE and not string.nilorempty(data.discountTime) and GameUtil.checkTimeStr(data.discountTime)
					local isVipDiscount = VipModel.instance:getIsAbleToPassportDiscount()
					local payGoodsId = goodsId

					if isVipDiscount then
						payGoodsId = vipGoodsId
					end

					if isDiscountTime then
						payGoodsId = data.discountGoodsId
					end

					if temPrizeType == PassportModel.ADDITIONAL_PAYMENT_PRIZE_TYPE then
						payGoodsId = data.additonalGoodsId
					end

					local subGoodsType = GameEnum.PaySubGoodsType.PASS_PORT
					local subGoodsId = data.actId
					local para = {
						funcId = data.funcId,
						prizeType = temPrizeType
					}
					local extParams = GameUtil.jsonToString(para)

					PayController.instance:pay((temPrizeType == PassportModel.THIRD_PAYMENT_PRIZE_TYPE or nil) and data.thirdGoodsId, subGoodsType, subGoodsId, extParams)
				end
			end
		end
	end
end

function PassportController:_payTypeTwoForPassport(data, temPrizeType, isHigher)
	isHigher = checkbool(isHigher)

	local isAdd = temPrizeType == PassportModel.ADDITIONAL_PAYMENT_PRIZE_TYPE

	if isHigher then
		if not data.vipHigherGoodsId then
			local vipGoodsId = data.vipGoodsId

			if isHigher then
				if not data.higherGoodsId then
					local goodsId = data.goodsId
					local isDiscountTime = not isHigher and not isAdd and temPrizeType ~= PassportModel.THIRD_PAYMENT_PRIZE_TYPE and not string.nilorempty(data.discountTime) and GameUtil.checkTimeStr(data.discountTime)
					local isVipDiscount = VipModel.instance:getIsAbleToPassportDiscount()
					local payGoodsId = goodsId

					if isVipDiscount then
						payGoodsId = vipGoodsId
					end

					if isDiscountTime then
						payGoodsId = data.discountGoodsId
					end

					if isAdd then
						payGoodsId = data.additonalGoodsId
					end

					if temPrizeType == PassportModel.THIRD_PAYMENT_PRIZE_TYPE then
						payGoodsId = data.thirdGoodsId
					end

					local matType, matId, matNum = MaterialMgr.getMatParams(payGoodsId)
					local txtCost = string.format("<quad name=%s:%s|icon size=40 width=1 offsetY=-8/>", matType, matId)
					local content = ""

					if not string.nilorempty(data.payTipsText) then
						content = string.format(data.payTipsText, txtCost, matNum)
					end

					if temPrizeType == PassportModel.THIRD_PAYMENT_PRIZE_TYPE then
						payGoodsId = data.thirdGoodsId
					end

					local function successCallBack()
						PassportController.instance:sendBuyPassportReq(data.actId, data.funcId, payGoodsId, temPrizeType)
					end

					local alignment = UnityEngine.TextAnchor.MiddleCenter

					TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
				end
			end
		end
	end
end

PassportController.instance = PassportController.New()

return PassportController
