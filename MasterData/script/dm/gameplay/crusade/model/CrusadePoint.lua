-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/model/CrusadePoint.lua

CrusadePoint = class("CrusadePoint", objectlua.Object)

CrusadePoint:has("_id", {
	is = "r"
})
CrusadePoint:has("_buffId", {
	is = "r"
})
CrusadePoint:has("_index", {
	is = "rw"
})

function CrusadePoint:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:getRecordById("CrusadePoint", self._id)
	self._buffId = ""
	self._index = 0
end

function CrusadePoint:synchronizeBuff(buffId)
	self._buffId = buffId
end

function CrusadePoint:getBuffDesc()
	local desc = ConfigReader:getDataByNameIdAndKey("CrusadeBuff", self._buffId, "Desc")

	return Strings:get(desc)
end

function CrusadePoint:getRoleModel()
	return self._config.PointHead
end

function CrusadePoint:getSpRuleBubble()
	return self._config.SpRuleBubble
end

function CrusadePoint:getPointType()
	return self._config.PointType
end

function CrusadePoint:getBubble()
	return self._config.Bubble
end

function CrusadePoint:getBlockBattleConfig()
	return self._config.BlockBattleConfig
end

function CrusadePoint:getEnemyMaster()
	return self._config.EnemyMaster
end

function CrusadePoint:getEnemyCard()
	return self._config.EnemyCard
end

function CrusadePoint:getBackground()
	return self._config.Background
end

function CrusadePoint:getBGM()
	return self._config.BGM
end

function CrusadePoint:getVictoryConditions()
	return self._config.VictoryConditions
end

function CrusadePoint:getReward()
	return self._config.Reward
end

function CrusadePoint:getRewards()
	return (RewardSystem:getRewardsById(self:getReward()))
end
