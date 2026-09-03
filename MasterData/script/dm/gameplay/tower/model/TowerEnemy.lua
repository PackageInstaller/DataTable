-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/model/TowerEnemy.lua

TowerEnemy = class("TowerEnemy", objectlua.Object)

TowerEnemy:has("_id", {
	is = "r"
})
TowerEnemy:has("_config", {
	is = "r"
})
TowerEnemy:has("_name", {
	is = "r"
})
TowerEnemy:has("_enemyMasterId", {
	is = "r"
})
TowerEnemy:has("_enemyMasterRoleModel", {
	is = "r"
})
TowerEnemy:has("_enemyCardId", {
	is = "r"
})
TowerEnemy:has("_enemyTeamPets", {
	is = "r"
})

function TowerEnemy:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("TowerEnemy", id)
	self._enemyTeamPets = {}

	if self._config then
		self._name = self._config.Name
		self._enemyMasterId = self._config.EnemyMaster

		self:initEnemyMaster()

		self._enemyCardId = self._config.EnemyCard

		self:initEnemyCards()
	end
end

function TowerEnemy:initEnemyMaster()
	local config = ConfigReader:getRecordById("EnemyMaster", self._enemyMasterId)

	self._enemyMasterRoleModel = config.RoleModel
end

function TowerEnemy:initEnemyCards()
	local enemyFirstHeros = ConfigReader:getDataByNameIdAndKey("EnemyCard", self._enemyCardId, "FirstFormation")
	local enemyFixHeros = ConfigReader:getDataByNameIdAndKey("EnemyCard", self._enemyCardId, "CardCollection")
	local count = 1

	for i = 1, #enemyFixHeros do
		self._enemyTeamPets[i] = enemyFixHeros[i]
		count = count + 1
	end

	for k, v in pairs(enemyFirstHeros) do
		self._enemyTeamPets[count] = v[2]
		count = count + 1
	end
end

function TowerEnemy:synchronize(data)
	return
end

function TowerEnemy:getPlayerCost(data)
	return self._config.PlayerCost
end

function TowerEnemy:getPlayerCardAmount(data)
	return self._config.PlayerCardAmount
end
