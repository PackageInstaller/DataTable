-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\Product.lua

local Product = Class("Product")
local ResRecharge = require("ClientData/ResRecharge")
local ResRechargeRebateMisc = require("ClientData/ResRechargeRebateMisc")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResLimit = require("ClientData/ResLimit")

Product.DEFAULT_INDEX_PRIORITY = 200

local REBAT_RATE = ResRechargeRebateMisc[1].exchage_rate or 10

function Product.create(gameData, platformData)
	local rechargeId = gameData.recharge_id
	local resData = ResRecharge[rechargeId]

	if gameData and platformData and resData then
		return Product(gameData, platformData)
	else
		return nil
	end
end

function Product.update(product, gameData, platformData)
	if product == nil then
		return
	end

	if gameData then
		product:updateGameData(gameData)
	end

	if platformData then
		product:updatePlatformData(platformData)
	end

	local rechargeId = gameData and gameData.recharge_id
	local resData = rechargeId and ResRecharge[rechargeId]

	if resData then
		product:updateResData(resData)
	end
end

function Product:ctor(gameData, platformData)
	Product.update(self, gameData, platformData)
end

function Product:updateGameData(gameData)
	self.rechargeId = gameData.recharge_id
	self.productId = gameData.product_id
	self.rechargeNum = gameData.recharge_num
	self.firstBonus = gameData.first_bonus
	self.normalBonus = gameData.normal_bonus
	self.periodType = gameData.period
	self.isFirstRecharge = gameData.fisrt_recharge_flag ~= 0
	self.buyTimesLeft = math.max(gameData.can_buy_count, 0)
end

function Product:updatePlatformData(platformData)
	self.platformProductName = platformData.productName
	self.price = platformData.price
	self.priceCent = platformData.price * 100
	self.currencyCode = platformData.currencyCode
	self.isFree = self.price <= 0
end

function Product:updateResData(resData)
	self.priceText = resData.cost_money / 100
	self.priceTextRebate = resData.cost_money / REBAT_RATE
	self.refundCoin = resData.refund_coin
	self.rechargeType = resData.recharge_type
	self.indexPriority = resData.index_priority or Product.DEFAULT_INDEX_PRIORITY
	self.productName = resData.product_name
	self.iconPath = resData.icon_path
	self.iconName = resData.icon_name
	self.subIconPath = resData.sub_icon_path
	self.subIconName = resData.sub_icon_name
	self.hotIconPath = resData.hot_icon_path
	self.hotIconName = resData.hot_icon_name
	self.itemId = resData.item_id
	self.randId = resData.rand_id
	self.selLib = resData.sel_lib
	self.rate10 = resData.rate or 10
	self.rateType = resData.rate_type
	self.buyTimesMax = resData.can_buy_count
	self.isRecommend = resData.recommend and resData.recommend ~= 0
	self.productDesc1 = resData.product_desc_1
	self.productDesc2 = resData.product_desc_2
	self.originalPrice = resData.original_money

	if resData.show_original_money and resData.show_original_money ~= 0 then
		self.showOriginalPrice = resData.show_original_money / 100
	end

	self.nestedId = resData.nested_id
	self.unlockStage = resData.unlock_stage
	self.unlockVip = resData.unlock_vip
	self.mulityLinkId = resData.mulity_link_id
	self.mulityLinkNoNew = resData.mulity_link_no_new
	self.mulityAddCount = resData.mulity_add_count
	self.unlockCondition = resData.condition_id
	self.monthCardId = resData.monthCardId
	self.relateGiftDraw = resData.relate_gift_draw
	self.openLimitId = resData.downlimit_id

	local res = ResLimit[self.openLimitId]

	if res then
		self.openLimitDes = res.limit_desc
	else
		self.openLimitDes = ""
	end

	self.lockLimitId = resData.uplimit_id
	self.lockLimitDes = resData.uplimit_desc

	if self.originalPrice == nil then
		self.originalPrice = math.floor(self.price * 10 / self.rate10)
	end
end

function Product:setGetLeftTimes(leftTimes)
	self.getLeftTimes = leftTimes
end

function Product:getGetLeftTimes()
	return self.getLeftTimes
end

function Product:hasFreeNew()
	return self.price == 0 or self:getGetLeftTimes() > 0 and self.mulityLinkNoNew ~= 1
end

function Product._getPriceText(priceText)
	local price = tonumber(priceText)

	if price and price ~= math.floor(price) then
		priceText = string.format("%.2f", price)
	end

	return priceText
end

function Product:isProductValid()
	if self.unlockCondition and ConditionLimitManager.inLimitState(self.unlockCondition) then
		return false
	end

	local limitState = self.unlockStage
	local limitVip = self.unlockVip
	local limitLock = limitState and not CurAvatar:mainStageStatePassed(limitState[1], limitState[2], limitState[3])
	local vipLock = limitVip and limitVip > (CurAvatar.vipLevel or 0)

	if limitState and limitVip then
		if limitLock and vipLock then
			return false
		end
	elseif limitLock or vipLock then
		return false
	end

	return true
end

function Product:productCanBuy()
	return self:isProductValid() and self.buyTimesLeft > 0
end

function Product:getProductRemainTime()
	if self:productCanBuy() then
		local condData = ResConditionLimit[self.unlockCondition]

		if condData and condData.regday then
			local endTick = CurAvatar.roleCreateTick + condData.regday * Const.TIME_ONE_DAY

			if endTick - ClientUtils.getServerTime() > 0 then
				return endTick - ClientUtils.getServerTime()
			end
		end
	end
end

function Product:checkOpenLimit()
	if self.openLimitId and self.openLimitId > 0 then
		return LimitManager.checkConditionOK(self.openLimitId)
	else
		return true
	end
end

function Product:checkLockLimit()
	if self.lockLimitId and self.lockLimitId > 0 then
		return LimitManager.checkConditionOK(self.lockLimitId)
	else
		return false
	end
end

return Product
