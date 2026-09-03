-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/model/StagePracticeEnemyHero.lua

require("dm.gameplay.develop.model.hero.Hero")

StagePracticeEnemyHero = class("StagePracticeEnemyHero", Hero, _M)

StagePracticeEnemyHero:has("_id", {
	is = "r"
})
StagePracticeEnemyHero:has("_config", {
	is = "r"
})

function StagePracticeEnemyHero:initialize(heroid, player)
	super.initialize(self, heroid, player)
end

function StagePracticeEnemyHero:setEnemyId(enemyheroid)
	self._id = enemyheroid
	self._config = ConfigReader:getRecordById("EnemyHero", tostring(enemyheroid))
end

function StagePracticeEnemyHero:getId()
	return self._config.RoleModel
end

function StagePracticeEnemyHero:getModel()
	return self._config.RoleModel
end

function StagePracticeEnemyHero:sync(data)
	return
end
