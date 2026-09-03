-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/model/RecruitPool.lua

RecruitPool = class("RecruitPool", objectlua.Object, _M)

RecruitPool:has("_id", {
	is = "r"
})
RecruitPool:has("_freeTimes", {
	is = "rw"
})
RecruitPool:has("_owner", {
	is = "rw"
})
RecruitPool:has("_bateInfo", {
	is = "rw"
})
RecruitPool:has("_bateRound", {
	is = "rw"
})
RecruitPool:has("_bateCount", {
	is = "rw"
})
RecruitPool:has("_dailyCount", {
	is = "rw"
})

function RecruitPool:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:getRecordById("DrawCard", id)
	self._freeTimes = 0
	self._bateInfo = {}
	self._bateRound = 1
	self._bateCount = 0
	self._dailyCount = 0
end

function RecruitPool:dispose()
	super.dispose(self)
end

function RecruitPool:sync(data)
	if data.value then
		self._freeTimes = data.value
	end
end

function RecruitPool:syncRebateInfo(info)
	self._bateInfo = info
end

function RecruitPool:syncRebateRound(counts)
	self._bateRound = counts
end

function RecruitPool:syncRebateCount(counts)
	self._bateCount = counts
end

function RecruitPool:syncDailyCount(counts)
	self._dailyCount = counts
end

function RecruitPool:getType()
	return self._config.DrawCardType
end

function RecruitPool:getName(fontName)
	if fontName then
		return Strings:get(self._config.DrawCardName, {
			fontName = fontName
		})
	end

	return Strings:get(self._config.DrawCardName)
end

function RecruitPool:getNameEn()
	return Strings:get(self._config.DrawCardENName)
end

function RecruitPool:getRank()
	return self._config.Rank
end

function RecruitPool:getRealCostIdAndCount()
	local couponCount = self:CouponCost()
	local costId = self:getCouponId()
	local count1
	local count2 = couponCount[2]

	count1 = self._freeTimes > 0 and 0 or couponCount[1]

	if count2 then
		return {
			{
				costId = costId,
				costCount = count1
			},
			{
				costId = costId,
				costCount = count2
			}
		}
	else
		return {
			{
				costId = costId,
				costCount = count1
			}
		}
	end
end

function RecruitPool:getCouponId()
	return self._config.Coupon
end

function RecruitPool:CouponCost()
	return self._config.CouponCost
end

function RecruitPool:getRareDesc()
	return self._config.DrawCardDesc or {}
end

function RecruitPool:getRareTitle()
	return self._config.DrawCardDescTitle
end

function RecruitPool:getShortDesc()
	return self._config.ShortDesc
end

function RecruitPool:getShortDescEn()
	return self._config.ShortENDesc
end

function RecruitPool:getDescList()
	return self._config.ReviewText
end

function RecruitPool:getSpecialDescList()
	return self._config.ReviewTextSpecial
end

function RecruitPool:getRecruitTimes()
	return self._config.Number
end

function RecruitPool:getPreview()
	return self._config.Preview
end

function RecruitPool:getShowRewards()
	return self._config.ShowReward
end

function RecruitPool:getSpecialRewardTimes()
	return self._config.Times[2]
end

function RecruitPool:getNormalReward()
	local rewardId = self._config.NormalReward

	return rewardId and RewardSystem:getRewardsById(rewardId) or nil
end

function RecruitPool:getCondition()
	return self._config.Condition
end

function RecruitPool:getDrawLimit()
	return self._config.DrawLimit
end

function RecruitPool:hasDrawLimit()
	return self:getDrawLimit() ~= -1
end

function RecruitPool:getOffCount()
	return self._config.OffCount
end

function RecruitPool:getPoolInfo()
	return self._config.DrawCardUPDesc or {}
end

function RecruitPool:getPoolDesc()
	return self._config.UPDesc or {}
end

function RecruitPool:getRoleDetail()
	return self._config.RoleDetail
end

function RecruitPool:getLink()
	return self._config.Link
end

function RecruitPool:getUPDesc()
	return self._config.UPDesc
end

function RecruitPool:getTimeRewardData()
	local resultList = {}
	local resultArray = {}
	local TimeRewardId = self._config.TimeRewardId

	if TimeRewardId then
		for i = 1, #TimeRewardId do
			local oneId = TimeRewardId[i]
			local config = ConfigReader:getRecordById("TimeReward", tostring(oneId))

			if config then
				resultArray[#resultArray + 1] = config
				resultList[config.Id] = config
			end
		end
	end

	table.sort(resultArray, function(a, b)
		return a.DrawCardTimes < b.DrawCardTimes
	end)

	self._firstTimeRewardId = resultArray[1].Id

	return resultList, resultArray
end

function RecruitPool:getFirstTimeRewardId()
	return self._firstTimeRewardId
end

function RecruitPool:getRebate()
	if not self._rebate then
		self._rebate = {}

		local rebate = self._config.Rebate

		if rebate then
			for key, value in pairs(rebate) do
				self._rebate[#self._rebate + 1] = {
					redPoint = false,
					status = 0,
					count = key,
					reward = value
				}
			end

			table.sort(self._rebate, function(a, b)
				return a.count < b.count
			end)
		end
	end

	for index, info in ipairs(self._rebate) do
		local st = self._bateInfo[info.count]

		self._rebate[index].redPoint = st == DrawCardRewardStatus.FinishNotGet
		self._rebate[index].status = st
	end

	return self._rebate
end

function RecruitPool:getRebateRoundLimit()
	local limit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "DrawCard_Rebate_Limit", "content")

	return limit or 999
end

function RecruitPool:getRebateCanShow()
	local rebate = self:getRebate()

	if #self._rebate == 0 or self:getBateRound() > self:getRebateRoundLimit() then
		return false
	end

	return true
end

function RecruitPool:hasRedPoint()
	if self:getBateRound() > self:getRebateRoundLimit() then
		return false
	end

	local data = self:getRebate()

	for index, info in ipairs(data) do
		if info.redPoint then
			return true
		end
	end

	return false
end

function RecruitPool:getResourcesBanner()
	return self._config.ResourcesBanner
end
