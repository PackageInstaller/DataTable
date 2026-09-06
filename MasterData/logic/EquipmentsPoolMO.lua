-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/model/EquipmentsPoolMO.lua

module("logic.extensions.drawequipments.model.EquipmentsPoolMO", package.seeall)

local EquipmentsPoolMO = class("EquipmentsPoolMO")
local giftConfigs

function EquipmentsPoolMO:ctor(poolCo)
	self._poolCo = poolCo
	self._times = 0
	self._lastSSR = 0
	self._isDataReady = false

	self:_calculateOpenTime()
end

function EquipmentsPoolMO:getPoolId()
	return self._poolCo.poolId
end

function EquipmentsPoolMO:isDataReady()
	return self._isDataReady
end

function EquipmentsPoolMO:onPoolData(times, lastSSR)
	self._times = times
	self._lastSSR = lastSSR
	self._isDataReady = true
end

function EquipmentsPoolMO:onDrawPool(times, lastSSR)
	self._times = self._times + times

	if lastSSR >= 0 then
		self._lastSSR = lastSSR
	end
end

function EquipmentsPoolMO:getDrawTimes()
	return self._times
end

function EquipmentsPoolMO:getPoolName()
	return self._poolCo.name
end

function EquipmentsPoolMO:getPoolBgk()
	return "ui/bigbg/draweuips/" .. self._poolCo.petBg .. ".png"
end

function EquipmentsPoolMO:getShowEquipments()
	return self._poolCo.showEquips
end

function EquipmentsPoolMO:getPoolDesc()
	return self._poolCo.desc
end

function EquipmentsPoolMO:getGiftConfig()
	if string.nilorempty(self._poolCo.giftsKey) then
		return
	end

	if giftConfigs and giftConfigs[self._poolCo.giftsKey] then
		return giftConfigs[self._poolCo.giftsKey]
	end

	local giftCfg = DrawEquipmentsConfig.instance:getParamsString(self._poolCo.giftsKey)

	if string.nilorempty(giftCfg) then
		return
	end

	local configs = {}
	local gifts = string.split(giftCfg, ",")

	for i = 1, #gifts do
		local items = string.split(gifts[i], ":")
		local goodsId = checknumber(items[1])
		local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)

		if cfg then
			local giftMO = DrawEquipGiftMO.New()

			giftMO.goodsId = goodsId
			giftMO.giftType = checknumber(items[2])
			giftMO.giftName = items[3]
			giftMO.payType = cfg.payType
			giftMO.goodsCfgId = cfg.id

			if giftMO.giftType == 1 then
				giftMO.giftIcon = cfg.content or cfg.icon
			end

			table.insert(configs, giftMO)
		end
	end

	giftConfigs = giftConfigs or {}
	giftConfigs[self._poolCo.giftsKey] = configs

	return configs
end

function EquipmentsPoolMO:getActiveGiftMo()
	local configs = self:getGiftConfig()

	if not configs then
		return
	end

	for i = 1, #configs do
		local mo = configs[i]
		local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(mo.goodsId)

		if cfg and GameUtil.checkIsInTimePeriod(cfg.onlineTime, cfg.offlineTime) then
			if mo.giftType == 1 and ShopModel.instance:getGoodsCount(mo.goodsCfgId) > 0 then
				local isDiscount = PayShopController.instance:checkTimeStr(cfg.discountTime)

				if isDiscount and cfg.payType ~= GameEnum.PayShopPayType.RMB then
					local oldList = string.split(cfg.originalGoodsId, ":")
					local newList = string.split(cfg.discountGoodsId, ":")

					mo.label = string.format("text_discount_num", math.floor(checknumber(newList[3]) / checknumber(oldList[3]) * 10))
				else
					mo.label = lang("text_hot_sell")
				end

				return mo
			elseif mo.giftType == 2 and (cfg.limitTimes == 0 or PayShopModel.instance:getMibaoBuyTimesById(cfg.id) < cfg.limitTimes) then
				local disCount = checknumber(cfg.disCount)

				mo.label = disCount <= 0 and lang("text_hot_sell") or string.format("text_discount_num", math.floor(disCount / 100))

				return mo
			end
		end
	end
end

function EquipmentsPoolMO:getCycleCount()
	return self._poolCo.cycleCount
end

function EquipmentsPoolMO:getProgressPrize()
	return DrawEquipmentsConfig.instance:getPoolProgressPrize(self:getPoolId())
end

function EquipmentsPoolMO:getConsume()
	if string.nilorempty(self._poolCo.consume) then
		return 0, 0, 0
	end

	if not self._consumeMatType or not self._consumeMatId or not self._consumeMatNum then
		local matConsumes = string.split(self._poolCo.consume, ":")
		local matType = checknumber(matConsumes[1])

		self._consumeMatType = matType
		self._consumeMatId = checknumber(matConsumes[2])
		self._consumeMatNum = checknumber(matConsumes[3])
	end

	return self._consumeMatType, self._consumeMatId, self._consumeMatNum
end

function EquipmentsPoolMO:getPoolIconIndex()
	return self._poolCo.iconIndex
end

function EquipmentsPoolMO:getPoolCycleIndex()
	return self._poolCo.proIndex - 1
end

function EquipmentsPoolMO:getPoolTabName()
	return self._poolCo.tabName
end

function EquipmentsPoolMO:getPoolTabNamePos()
	if string.nilorempty(self._poolCo.namePos) then
		return 0, 0
	end

	local list = string.split(self._poolCo.namePos, ",")

	if list == nil or #list == 0 then
		return 0, 0
	end

	return checknumber(list[1]), checknumber(list[2])
end

function EquipmentsPoolMO:getCycleSurplusNum()
	local cycleCount = self:getCycleCount()

	if cycleCount == 0 then
		return -1
	end

	local supCount = self._times - self._lastSSR

	if cycleCount < supCount then
		supCount = supCount - math.floor(supCount / cycleCount) * cycleCount
	end

	supCount = cycleCount - supCount

	if supCount <= 0 then
		supCount = cycleCount
	end

	return supCount
end

function EquipmentsPoolMO:isPoolOpenedByNow(now)
	return self._startTimeStamp == 0 or now >= self._startTimeStamp
end

function EquipmentsPoolMO:isPoolOpened()
	return self:isPoolOpenedByNow(ServerTime.now())
end

function EquipmentsPoolMO:isPoolClosedByNow(now)
	return self._endTimeStamp ~= 0 and now >= self._endTimeStamp
end

function EquipmentsPoolMO:isPoolClosed()
	return self:isPoolClosedByNow(ServerTime.now())
end

function EquipmentsPoolMO:isPoolInPeriod()
	return self:isPoolOpened() and not self:isPoolClosed()
end

function EquipmentsPoolMO:isPoolInPeriodByNow(now)
	return self:isPoolOpenedByNow(now) and not self:isPoolClosedByNow(now)
end

function EquipmentsPoolMO:getStartTimeStamp()
	return self._startTimeStamp
end

function EquipmentsPoolMO:getEndTimeStamp()
	return self._endTimeStamp
end

function EquipmentsPoolMO:isOpenByFunction()
	if self._poolCo.funcOpenId == 0 then
		return true
	end

	return FuncOpenModel.instance:getFuncIsOpen(self._poolCo.funcOpenId)
end

function EquipmentsPoolMO:_calculateOpenTime()
	local startTimeStamp = 0
	local endTimeStamp = 0

	if self._poolCo.isOpenServer then
		local openTimes = RoleModel.instance:getAreaOpenTimeSec()
		local startTime, endTime = GameUtil.getTimestampOnStartAndEnd(openTimes, self._poolCo.startDay, self._poolCo.durationDay)

		startTimeStamp = startTime
		endTimeStamp = endTime
	else
		if not string.nilorempty(self._poolCo.openDateTime) then
			startTimeStamp = GameUtil.string2time(self._poolCo.openDateTime)
		end

		if not string.nilorempty(self._poolCo.endDateTime) then
			endTimeStamp = GameUtil.string2time(self._poolCo.endDateTime)
		end
	end

	self._startTimeStamp = startTimeStamp
	self._endTimeStamp = endTimeStamp
end

function EquipmentsPoolMO:isPoolPreheat()
	if not self._poolCo.isPreheat then
		return false
	end

	return self._startTimeStamp > ServerTime.now()
end

function EquipmentsPoolMO:poolTimerDesc()
	if self:isPoolPreheat() then
		local timer = GameUtil.time2date(self._startTimeStamp)

		return (string.format(lang("drawequip_item_time_desc1"), timer.year, timer.month, timer.day))
	else
		return lang("drawequip_item_time_desc2")
	end
end

function EquipmentsPoolMO:getPoolAttrName()
	local str = lang("text_none")

	for name, index in pairs(GameEnum.Races) do
		if not string.nilorempty(name) and checknumber(index) == self._poolCo.iconIndex then
			str = name

			break
		end
	end

	return str .. lang("attr")
end

return EquipmentsPoolMO
