-- chunkname: @modules/logic/currency/controller/CurrencyController.lua

module("modules.logic.currency.controller.CurrencyController", package.seeall)

local CurrencyController = class("CurrencyController", BaseController)

function CurrencyController:onInit()
	CurrencyJumpHandler.clearHandlers()
end

function CurrencyController:onInitFinish()
	return
end

function CurrencyController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._OnDailyRefresh, self)
	LoginController.instance:registerCallback(LoginEvent.OnBeginLogout, self._onBeginLogout, self)
end

function CurrencyController:reInit()
	CurrencyJumpHandler.clearHandlers()
end

function CurrencyController:_OnDailyRefresh()
	CurrencyRpc.instance:sendGetBuyPowerInfoRequest()

	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)
	local currencyList = {}

	if id then
		table.insert(currencyList, id)
	end

	local act123Id = Season123Model.instance:getCurSeasonId()

	if act123Id then
		local ticketId = Season123Config.instance:getEquipItemCoin(act123Id, Activity123Enum.Const.UttuTicketsCoin)

		if ticketId then
			table.insert(currencyList, ticketId)
		end
	end

	if #currencyList > 0 then
		CurrencyRpc.instance:sendGetCurrencyListRequest(currencyList)
	end
end

function CurrencyController:openPowerView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.PowerView, param, isImmediate)
end

function CurrencyController:_onBeginLogout()
	TaskDispatcher.cancelTask(self._checkPowerRecover, self)
	TaskDispatcher.cancelTask(self._autoUseExpirePowerItem, self)
end

function CurrencyController:powerRecover()
	local level = PlayerModel.instance:getPlayinfo().level
	local levelConfig = PlayerConfig.instance:getPlayerLevelCO(level)

	if not levelConfig then
		return
	end

	local recoverLimit = levelConfig.maxAutoRecoverPower
	local currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)

	if not currencyMO then
		return
	end

	local power = currencyMO.quantity

	if recoverLimit <= power then
		return
	end

	self._recoverEndTime = currencyMO.lastRecoverTime / 1000 + currencyCo.recoverTime

	TaskDispatcher.runRepeat(self._checkPowerRecover, self, 1)
end

function CurrencyController:_checkPowerRecover()
	if self._recoverEndTime <= ServerTime.now() then
		TaskDispatcher.cancelTask(self._checkPowerRecover, self)
		CurrencyRpc.instance:sendGetCurrencyListRequest({
			CurrencyEnum.CurrencyType.Power
		})
	end
end

function CurrencyController:checkFreeDiamondEnough(needDiamond, srcType, noAnim, callback, callbackObj, jumpCallBack, jumpCallbackObj)
	local freeDiamondMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	if freeDiamondMo then
		if needDiamond <= freeDiamondMo.quantity then
			return true
		else
			local deltaDiamond = needDiamond - freeDiamondMo.quantity
			local params = {
				isExchangeStep = true,
				msg = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.FreeDiamondExchange),
				extra = {
					deltaDiamond
				},
				needDiamond = deltaDiamond,
				srcType = srcType,
				callback = callback,
				callbackObj = callbackObj,
				jumpCallBack = jumpCallBack,
				jumpCallbackObj = jumpCallbackObj
			}
			local viewSetting = ViewMgr.instance:getSetting(ViewName.CurrencyExchangeView)

			if noAnim then
				viewSetting.anim = nil
			else
				viewSetting.anim = ViewAnim.Default
			end

			ViewMgr.instance:openView(ViewName.CurrencyExchangeView, params)

			return false
		end
	else
		logError("can't find freeDiamond MO")

		return false
	end
end

function CurrencyController:checkExchangeFreeDiamond(needDiamond, srcType, callback, callbackObj, jumpCallBack, jumpCallbackObj, msg, extra, costData, noCallBack, noCallBackObj)
	local payDiamondMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Diamond)

	if payDiamondMo then
		if needDiamond <= payDiamondMo.quantity then
			CurrencyRpc.instance:sendExchangeDiamondRequest(needDiamond, srcType, callback, callbackObj)

			return false
		else
			local isBanDiamond = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BanDiamond)

			if isBanDiamond then
				GameFacade.showToast(ToastEnum.ExchangeFreeDiamond)

				return false
			else
				local deltaDiamond = needDiamond - payDiamondMo.quantity
				local var_11_0 = {
					isExchangeStep = false
				}

				var_11_0.msg = msg ~= nil and msg or MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough)
				var_11_0.needDiamond = deltaDiamond
				var_11_0.jumpCallBack = jumpCallBack
				var_11_0.jumpCallbackObj = jumpCallbackObj
				var_11_0.extra = extra
				var_11_0.costData = costData
				var_11_0.noCallback = noCallBack
				var_11_0.noCallbackObj = noCallBackObj

				local params = var_11_0

				ViewMgr.instance:openView(ViewName.CurrencyExchangeView, params)

				return true
			end
		end
	else
		logError("can't find payDiamond MO")

		return false
	end
end

function CurrencyController:checkDiamondEnough(needDiamond, jumpCallBack, jumpCallbackObj)
	local payDiamondMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Diamond)

	if payDiamondMo then
		if needDiamond <= payDiamondMo.quantity then
			return true
		else
			local isBanDiamond = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BanDiamond)

			if isBanDiamond then
				GameFacade.showToast(ToastEnum.ExchangeFreeDiamond)
			else
				local deltaDiamond = needDiamond - payDiamondMo.quantity
				local params = {
					isExchangeStep = false,
					msg = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough),
					needDiamond = deltaDiamond,
					jumpCallBack = jumpCallBack,
					jumpCallbackObj = jumpCallbackObj
				}

				ViewMgr.instance:openView(ViewName.CurrencyExchangeView, params)
			end

			return false
		end
	else
		logError("can't find payDiamond MO")

		return false
	end
end

function CurrencyController:getPowerItemDeadLineTime()
	local minDeadline
	local powitemlist = ItemPowerModel.instance:getPowerItemList() or {}

	for _, powerItem in pairs(powitemlist) do
		local config = ItemConfig.instance:getPowerItemCo(powerItem.id)

		if config.expireType ~= 0 and ItemPowerModel.instance:getPowerItemCount(powerItem.uid) > 0 then
			local time = ItemPowerModel.instance:getPowerItemDeadline(powerItem.uid)

			if not minDeadline or time < minDeadline then
				minDeadline = time
			end
		end
	end

	return minDeadline
end

function CurrencyController:checkToUseExpirePowerItem()
	TaskDispatcher.runRepeat(self._autoUseExpirePowerItem, self, 1)
end

function CurrencyController:_autoUseExpirePowerItem()
	local itemDeadline = self:getPowerItemDeadLineTime()

	if not itemDeadline then
		TaskDispatcher.cancelTask(self._autoUseExpirePowerItem, self)

		return
	end

	if itemDeadline and itemDeadline > 0 then
		local limitSec = itemDeadline - ServerTime.now()

		if limitSec <= 0 then
			ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
			TaskDispatcher.cancelTask(self._autoUseExpirePowerItem, self)
		end
	end
end

function CurrencyController:checkFreeDiamondEnoughDaily(needDiamond, srcType, noAnim, callback, callbackObj, jumpCallBack, jumpCallbackObj, missDiamondCount, costData, noCallBack, noCallBackObj)
	local freeDiamondMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	if freeDiamondMo then
		if needDiamond <= freeDiamondMo.quantity then
			return true
		else
			local deltaDiamond = needDiamond - freeDiamondMo.quantity
			local msg = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.FreeDiamondExchange)
			local params = {
				isShowDailySure = true,
				isExchangeStep = true,
				msg = (srcType == CurrencyEnum.PayDiamondExchangeSource.Summon or nil) and MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.FreeDiamondNotEnough_Summon),
				extra = {
					missDiamondCount,
					deltaDiamond
				},
				needDiamond = deltaDiamond,
				srcType = srcType,
				callback = callback,
				callbackObj = callbackObj,
				jumpCallBack = jumpCallBack,
				jumpCallbackObj = jumpCallbackObj,
				costData = costData,
				noCallback = noCallBack,
				noCallbackObj = noCallBackObj
			}
			local viewSetting = ViewMgr.instance:getSetting(ViewName.CurrencyExchangeView)

			if noAnim then
				viewSetting.anim = nil
			else
				viewSetting.anim = ViewAnim.Default
			end

			self:openCurrencyExchangeView(params)

			return false
		end
	else
		logError("can't find freeDiamond MO")

		return false
	end
end

function CurrencyController:openCurrencyExchangeView(params)
	if not self:canShowCurrencyExchangeView(params) then
		self:checkCurrencyExchange(params)

		return
	end

	ViewMgr.instance:openView(ViewName.CurrencyExchangeView, params)
end

function CurrencyController:canShowCurrencyExchangeView(params)
	local key = self:getOptionLocalKey(params.srcType)

	return (TimeUtil.getDayFirstLoginRed(key))
end

function CurrencyController:getOptionLocalKey(srcType)
	return string.format("SummonConfirmView#%s%s", tostring(PlayerModel.instance:getPlayinfo().userId), tostring(srcType))
end

function CurrencyController:checkCurrencyExchange(params)
	local needShowNext = false

	if params.isExchangeStep then
		needShowNext = CurrencyController.instance:checkExchangeFreeDiamond(params.needDiamond, params.srcType, params.callback, params.callbackObj, params.jumpCallBack, params.jumpCallbackObj, (params.srcType == CurrencyEnum.PayDiamondExchangeSource.Summon or nil) and (MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough_Summon) or MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough)), {
			params.extra[1]
		}, params.costData, params.noCallback, params.noCallbackObj)
	else
		if params.jumpCallBack then
			params.jumpCallBack(params.jumpCallbackObj)
		end

		StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
	end

	if params.yesCallback then
		params.yesCallback()
	end

	return needShowNext
end

CurrencyController.instance = CurrencyController.New()

return CurrencyController
