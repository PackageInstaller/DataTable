-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataGift.lua

local ResOpActivityDetail = require("ClientData/ResOpActivityDetail")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local RechargeManager = require("System/Recharge/RechargeManager")
local ActivityDataGift = Class("ActivityDataGift", ActivityDataBase)

function ActivityDataGift:ctor()
	self.serverData = {}
	self.clientData = {}
	self.detailData = {}
end

function ActivityDataGift:updateClientData(actId)
	self.actId = actId
	self.detailData = ResOpActivityDetail[actId] or {}
	self.clientData = {}

	for index, dDate in ipairs(self.detailData) do
		if dDate.param then
			local rechargeId = dDate.param[1]

			self.clientData[rechargeId] = dDate
		end
	end
end

function ActivityDataGift:updateRoleData(roleData)
	self.serverData = {}

	local svrData = roleData.gift.item

	if svrData then
		for idx, data in ipairs(svrData) do
			self.serverData[data.recharge_id] = {}
			self.serverData[data.recharge_id].count = data.counter.count
			self.serverData[data.recharge_id].nextResetTime = data.counter.next_reset_time
		end
	end
end

function ActivityDataGift:checkNew()
	local hasFree = false

	for recharge_id, data in pairs(self.serverData) do
		local product = RechargeManager.getProductByRechargeId(recharge_id)

		if product then
			local count = self:getHasBuyNum(recharge_id)
			local canBuyCount = product.buyTimesMax - count

			if product.price == 0 and canBuyCount ~= 0 then
				hasFree = true

				break
			end

			if product:hasFreeNew() and canBuyCount ~= 0 then
				hasFree = true

				break
			end
		end
	end

	return hasFree
end

function ActivityDataGift:isOver()
	local isOver = true

	for recharge_id, data in pairs(self.clientData) do
		local product = RechargeManager.getProductByRechargeId(recharge_id)

		if product then
			local maxTime = product.buyTimesMax
			local count = self:getHasBuyNum(recharge_id)

			if count < maxTime then
				isOver = false

				break
			end
		end
	end

	return isOver
end

function ActivityDataGift:getHasBuyNum(rechargeId)
	local counter = self.serverData[rechargeId]

	if counter and ClientUtils.getServerTime() < counter.nextResetTime then
		return counter.count
	end

	return 0
end

function ActivityDataGift:onServerStateChange(opActState)
	if self.actObject:inOpenState() then
		for recharge_id, data in pairs(self.clientData) do
			local product = RechargeManager.getProductByRechargeId(recharge_id)

			if product then
				local maxTime = product.buyTimesMax
				local count = self:getHasBuyNum(recharge_id)

				product.buyTimesLeft = maxTime - count
			end
		end
	end
end

local function SortProduct(a, b)
	if a[1].indexPriority == b[1].indexPriority then
		return a[1].rechargeId < b[1].rechargeId
	else
		return a[1].indexPriority < b[1].indexPriority
	end
end

function ActivityDataGift:getAllProduct(includeLock)
	local allProducts = {}

	for index, cData in ipairs(self.detailData) do
		if cData.param2 ~= 0 then
			local rechargeId = cData.param[1]
			local product = RechargeManager.getProductByRechargeId(rechargeId)

			if product and product:isProductValid() then
				local inLock = false

				if cData.limit_id and ConditionLimitManager.inLimitState(cData.limit_id) then
					inLock = true
				elseif cData.act_limit_id and not CurAvatar:checkActivityConditionLimit(cData.act_limit_id) then
					inLock = true
				end

				if not inLock or includeLock then
					table.insert(allProducts, {
						product,
						cData,
						inLock
					})
				end
			end
		end
	end

	table.sort(allProducts, SortProduct)

	return allProducts
end

function ActivityDataGift:isProductLocked(rechargeId)
	local cData = self.clientData[rechargeId] or {}
	local inLock = false

	if cData.limit_id and ConditionLimitManager.inLimitState(cData.limit_id) then
		return true, ConditionLimitManager.getLimitUnlockDesc(cData.limit_id)
	end

	if cData.act_limit_id then
		local unlock, unlockDesc = CurAvatar:checkActivityConditionLimit(cData.act_limit_id)

		if not unlock then
			return true, unlockDesc or ""
		end
	end

	return false
end

function ActivityDataGift:checkChangedNew(record)
	for index, cData in ipairs(self.detailData) do
		local inLock = false

		if cData.limit_id and ConditionLimitManager.inLimitState(cData.limit_id) then
			inLock = true
		elseif cData.act_limit_id and not CurAvatar:checkActivityConditionLimit(cData.act_limit_id) then
			inLock = true
		end

		if not inLock then
			local rechargeId = cData.param[1]

			if not record[rechargeId] then
				return true
			end
		end
	end
end

function ActivityDataGift:onSetChangedNew()
	local record = {}

	for index, cData in ipairs(self.detailData) do
		local inLock = false

		if cData.limit_id and ConditionLimitManager.inLimitState(cData.limit_id) then
			inLock = true
		elseif cData.act_limit_id and not CurAvatar:checkActivityConditionLimit(cData.act_limit_id) then
			inLock = true
		end

		if not inLock then
			local rechargeId = cData.param[1]

			record[rechargeId] = true
		end
	end

	self.actObject:saveChangedNewRecord(record)
end

function ActivityDataGift:hasValidProduct()
	for index, cData in ipairs(self.detailData) do
		local inLock = false

		if cData.limit_id and ConditionLimitManager.inLimitState(cData.limit_id) then
			inLock = true
		elseif cData.act_limit_id and not CurAvatar:checkActivityConditionLimit(cData.act_limit_id) then
			inLock = true
		end

		if not inLock then
			return true
		end
	end

	return false
end

return ActivityDataGift
