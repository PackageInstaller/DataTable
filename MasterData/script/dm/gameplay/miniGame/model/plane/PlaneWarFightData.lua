-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneWarFightData.lua

PlaneWarFightData = class("PlaneWarFightData", objectlua.Object, _M)

PlaneWarFightData:has("_rewardList", {
	is = "r"
})
PlaneWarFightData:has("_score", {
	is = "r"
})
PlaneWarFightData:has("_energy", {
	is = "rw"
})
PlaneWarFightData:has("_enemyList", {
	is = "r"
})
PlaneWarFightData:has("_rewardIds", {
	is = "r"
})

function PlaneWarFightData:initialize()
	super.initialize(self)

	self._rewardList = {}
	self._score = 0
	self._energy = 0
	self._enemyList = {}
	self._rewardIds = {}
end

function PlaneWarFightData:addReward(rewardId, reward)
	self._rewardIds[rewardId] = self._rewardIds[rewardId] or 0
	self._rewardIds[rewardId] = self._rewardIds[rewardId] + 1

	local info = RewardSystem:parseInfo(reward)

	if not self._rewardList[info.id] then
		self._rewardList[info.id] = {
			id = info.id,
			amount = info.amount
		}
	else
		self._rewardList[info.id].amount = self._rewardList[info.id].amount + info.amount
	end
end

function PlaneWarFightData:collectServerData()
	local rewardList = self:getRewardList()
	local list = {}

	if rewardList[CurrencyIdKind.kDiamond] then
		local reward = rewardList[CurrencyIdKind.kDiamond]

		list[#list + 1] = {
			type = 2,
			code = CurrencyIdKind.kDiamond,
			amount = reward.amount
		}
	end

	for id, amount in pairs(rewardList) do
		if id ~= CurrencyIdKind.kDiamond and id ~= CurrencyIdKind.kGold then
			list[#list + 1] = {
				type = 2,
				code = id,
				amount = amount.amount
			}
		end
	end

	if rewardList[CurrencyIdKind.kGold] then
		local reward = rewardList[CurrencyIdKind.kGold]

		list[#list + 1] = {
			type = 2,
			code = CurrencyIdKind.kGold,
			amount = reward.amount
		}
	end

	return list
end

function PlaneWarFightData:addScore(score)
	self._score = self._score + score
end

function PlaneWarFightData:addEnergy(energy)
	self._energy = self._energy + energy
end

function PlaneWarFightData:addEnemy(enemyId)
	self._enemyList[enemyId] = self._enemyList[enemyId] or 0
	self._enemyList[enemyId] = self._enemyList[enemyId] + 1
end
