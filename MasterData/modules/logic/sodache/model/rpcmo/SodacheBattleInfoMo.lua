-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheBattleInfoMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheBattleInfoMo", package.seeall)

local SodacheBattleInfoMo = pureTable("SodacheBattleInfoMo")

function SodacheBattleInfoMo:init(data)
	self.status = data.status
	self.enemyUid = data.enemyUid
	self.fightId = data.fightId
	self.itemId = data.itemId
	self.careerIds = data.careerIds
end

function SodacheBattleInfoMo:getUnitMo()
	local insideMo = SodacheModel.instance:getInsideMo()

	return insideMo.unitBox.unitsMap[self.enemyUid]
end

function SodacheBattleInfoMo:getRecommend()
	local recommended = {}
	local battleConfig = lua_battle.configDict[self.fightId]

	if battleConfig and not string.nilorempty(battleConfig.monsterGroupIds) then
		local monsterGroupIds = string.splitToNumber(battleConfig.monsterGroupIds, "#") or {}

		recommended = FightHelper.getAttributeCounter(monsterGroupIds, false) or {}
	end

	return recommended
end

return SodacheBattleInfoMo
