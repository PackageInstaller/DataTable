-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityEgg.lua

ActivityEgg = class("ActivityEgg", objectlua.Object, _M)

ActivityEgg:has("_id", {
	is = "r"
})
ActivityEgg:has("_eggList", {
	is = "r"
})
ActivityEgg:has("_eggBigRewards", {
	is = "r"
})

function ActivityEgg:initialize()
	super.initialize(self)
end

function ActivityEgg:synchronize(eggId)
	self._id = eggId
	self._config = ConfigReader:getRecordById("ActivityBlockEgg", self._id)
	self._eggList = {}

	for i = 1, #self:getEggPicture() do
		local data = {
			rewardId = "",
			image = self:getEggPicture()[i] .. ".png"
		}

		table.insert(self._eggList, data)
	end

	self._eggBigRewards = {}

	if self:getKeyRewardShow() and #self:getKeyRewardShow() > 0 then
		for i = 1, #self:getKeyRewardShow() do
			local rewardId = self:getKeyRewardShow()[i]

			self._eggBigRewards[rewardId] = {
				got = false,
				sort = i
			}
		end
	end
end

function ActivityEgg:syncReward(data)
	for i, v in pairs(data) do
		local index = tonumber(i) + 1

		if not self._eggList then
			self._eggList[index] = {
				rewardId = "",
				image = self:getEggPicture()[index] .. ".png"
			}
		end

		self._eggList[index].rewardId = v

		if self._eggBigRewards[v] then
			self._eggBigRewards[v].got = true
		end
	end
end

function ActivityEgg:getEggPicture()
	return self._config.EggPicture
end

function ActivityEgg:getCost()
	return self._config.Cost
end

function ActivityEgg:getKeyRewardShow()
	return self._config.KeyRewardShow
end

function ActivityEgg:getNormalRewardShow()
	return self._config.NormalRewardShow
end
