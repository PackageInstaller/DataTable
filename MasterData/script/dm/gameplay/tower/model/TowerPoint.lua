-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/model/TowerPoint.lua

TowerPoint = class("TowerPoint", objectlua.Object)

TowerPoint:has("_id", {
	is = "r"
})
TowerPoint:has("_pointId", {
	is = "rw"
})
TowerPoint:has("_enemyId", {
	is = "rw"
})
TowerPoint:has("_win", {
	is = "rw"
})
TowerPoint:has("_rewardList", {
	is = "rw"
})
TowerPoint:has("_towerEnemy", {
	is = "rw"
})
TowerPoint:has("_index", {
	is = "rw"
})
TowerPoint:has("_combat", {
	is = "rw"
})

function TowerPoint:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("TowerPoint", id)
end

function TowerPoint:synchronize(data)
	if data.pointId then
		self._pointId = data.pointId
	end

	if data.enemyId then
		self._enemyId = data.enemyId
		self._towerEnemy = TowerEnemy:new(data.enemyId)
	end

	if data.win ~= nil then
		self._win = data.win
	end

	if data.rewardList then
		self._rewardList = self:splitEquip(data.rewardList)
	end

	if data.index then
		self._index = data.index
	end

	if data.combat then
		self._combat = data.combat
	end
end

function TowerPoint:splitEquip(rewards)
	local list = {}

	for _, reward in pairs(rewards) do
		if reward.type == RewardType.kEquip then
			local code = reward.code
			local type = reward.type
			local amount = reward.amount

			for j = 1, amount do
				list[#list + 1] = {
					amount = 1,
					code = code,
					type = type
				}
			end
		else
			list[#list + 1] = reward
		end
	end

	return list
end
