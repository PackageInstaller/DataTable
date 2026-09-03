-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/model/ArenaRival.lua

ArenaRival = class("ArenaRival", objectlua.Object, _M)

ArenaRival:has("_extra", {
	is = "r"
})
ArenaRival:has("_status", {
	is = "r"
})
ArenaRival:has("_id", {
	is = "r"
})
ArenaRival:has("_level", {
	is = "rw"
})
ArenaRival:has("_nickName", {
	is = "rw"
})
ArenaRival:has("_headImg", {
	is = "rw"
})
ArenaRival:has("_combat", {
	is = "rw"
})
ArenaRival:has("_showHero", {
	is = "r"
})
ArenaRival:has("_master", {
	is = "r"
})
ArenaRival:has("_heroes", {
	is = "r"
})
ArenaRival:has("_leadStageId", {
	is = "r"
})
ArenaRival:has("_leadStageLevel", {
	is = "r"
})

function ArenaRival:initialize()
	super.initialize(self)

	self._status = 0
	self._id = ""
	self._level = 0
	self._nickName = ""
	self._headImg = ""
	self._combat = 0
	self._showHero = "ZTXCun"
	self._master = {}
	self._heroes = {}
	self._extra = 0
	self._leadStageId = ""
	self._leadStageLevel = 0

	self:initExtra()
end

function ArenaRival:synchronize(data)
	if data.extra then
		self._extra = self._extra + data.extra
	end

	if data.status then
		self._status = data.status
	end

	if data.id then
		self._id = data.id
	end

	if data.level then
		self._level = data.level
	end

	if data.headImg then
		self._headImg = data.headImg
	end

	if data.nickname then
		self._nickName = data.nickname
	end

	if data.combat then
		self._combat = data.combat
	end

	if data.showId then
		self._showHero = data.showId
	end

	if data.master then
		self:initMaster(data.master)
	end

	if data.heroes then
		self:initHeroes(data.heroes)
	end

	if data.leadStageId then
		self._leadStageId = data.leadStageId
	end

	if data.leadStageLevel then
		self._leadStageLevel = data.leadStageLevel
	end
end

function ArenaRival:initMaster(master)
	for i, v in pairs(master) do
		self._master[i] = v
	end
end

function ArenaRival:initHeroes(heroes)
	for i, v in pairs(heroes) do
		self._heroes[i] = v
	end
end

function ArenaRival:initExtra()
	local rewardId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_RewardBase", "content")
	local rewards = ConfigReader:getRecordById("Reward", rewardId)

	if rewards and rewards.Content then
		for i = 1, #rewards.Content do
			local reward = rewards.Content[i]

			if reward.type == RewardType.kSpecialValue then
				self._extra = reward.amount
			end
		end
	end
end
