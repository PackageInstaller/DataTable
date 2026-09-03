-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityEggActivity.lua

require("dm.gameplay.activity.model.ActivityEgg")

ActivityEggActivity = class("ActivityEggActivity", BaseActivity, _M)

ActivityEggActivity:has("_egg", {
	is = "r"
})
ActivityEggActivity:has("_num", {
	is = "r"
})

function ActivityEggActivity:initialize()
	super.initialize(self)

	self._num = 1
	self._eggList = {}
end

function ActivityEggActivity:dispose()
	super.dispose(self)
end

function ActivityEggActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.eggId then
		self._egg = self._egg or ActivityEgg:new()

		self._egg:synchronize(data.eggId)
	end

	if data.round then
		self._num = data.round
	end

	if data.eggList and self._egg then
		self._egg:syncReward(data.eggList)
	end
end

function ActivityEggActivity:reset()
	super.reset(self)
end

function ActivityEggActivity:hasRedPoint()
	return false
end

function ActivityEggActivity:getBgPath()
	return string.format("asset/scene/%s.jpg", self:getActivityConfig().Bmg)
end

function ActivityEggActivity:getStarEggId()
	local config = self:getActivityConfig()

	if config.ActivityBlockEggId and config.ActivityBlockEggId ~= "" then
		return config.ActivityBlockEggId
	end

	return nil
end

function ActivityEggActivity:getResourcesBanner()
	return self:getActivityConfig().ResourcesBanner or {}
end

function ActivityEggActivity:getPreviewRewards()
	local starId = ""

	if not self._previewRewards then
		self._previewRewards = {}

		local nextId = self:getStarEggId()

		while starId ~= nextId do
			starId = nextId
			nextId = ConfigReader:getDataByNameIdAndKey("ActivityBlockEgg", nextId, "NextPoint")

			local keyRewardShow = ConfigReader:getDataByNameIdAndKey("ActivityBlockEgg", nextId, "KeyRewardShow") or {}
			local normalRewardShow = ConfigReader:getDataByNameIdAndKey("ActivityBlockEgg", starId, "NormalRewardShow") or {}
			local length = #self._previewRewards + 1

			self._previewRewards[length] = {}

			if #keyRewardShow > 0 then
				self._previewRewards[length].bigRewards = {}
				self._previewRewards[length].normalRewards = {}

				for i = 1, #keyRewardShow do
					local id = keyRewardShow[i]
					local reward = ConfigReader:getDataByNameIdAndKey("Reward", id, "Content")[1]

					table.insert(self._previewRewards[length].bigRewards, reward)
				end

				for i = 1, #normalRewardShow do
					local id = normalRewardShow[i]
					local reward = ConfigReader:getDataByNameIdAndKey("Reward", id, "Content")[1]

					table.insert(self._previewRewards[length].normalRewards, reward)
				end
			else
				for i = 1, #normalRewardShow do
					local id = normalRewardShow[i]
					local reward = ConfigReader:getDataByNameIdAndKey("Reward", id, "Content")[1]

					table.insert(self._previewRewards[length], reward)
				end
			end
		end
	end

	return self._previewRewards
end
