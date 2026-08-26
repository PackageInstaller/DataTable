-- chunkname: @modules/logic/fight/entity/FightEntityAssembledMonsterSub.lua

module("modules.logic.fight.entity.FightEntityAssembledMonsterSub", package.seeall)

local FightEntityAssembledMonsterSub = class("FightEntityAssembledMonsterSub", FightEntityMonster)

function FightEntityAssembledMonsterSub:getScale()
	return self.mainEntity:getScale()
end

function FightEntityAssembledMonsterSub:setScale(scale)
	self.mainEntity:setScale(scale)
end

function FightEntityAssembledMonsterSub:getHangPoint(hangPointName, noProcess)
	if not noProcess and not string.nilorempty(hangPointName) and ModuleEnum.SpineHangPointRoot ~= hangPointName then
		hangPointName = string.format("%s_part_%d", hangPointName, self:getPartIndex())
	end

	return FightEntityAssembledMonsterSub.super.getHangPoint(self, hangPointName)
end

function FightEntityAssembledMonsterSub:resetAnimState()
	self.mainEntity:resetAnimState()
end

function FightEntityAssembledMonsterSub:setAlpha(alpha, duration)
	self.mainEntity:setAlphaData(self.id, alpha, duration)
end

function FightEntityAssembledMonsterSub:getMainEntityId()
	if self.mainEntityId then
		return self.mainEntityId
	end

	local mainEntityId
	local list = FightDataHelper.entityMgr:getEnemyNormalList()

	for i, v in ipairs(list) do
		local config = lua_fight_assembled_monster.configDict[v.skin]

		if config and config.part == 1 then
			mainEntityId = v.id

			break
		end
	end

	if not mainEntityId then
		logError("构建组合怪部件,但是没有找到主怪")

		return
	end

	self.mainEntityId = mainEntityId

	return self.mainEntityId
end

function FightEntityAssembledMonsterSub:getMainEntity()
	self.mainEntity = self.mainEntity or FightHelper.getEntity(self.mainEntityId)

	return self.mainEntity
end

function FightEntityAssembledMonsterSub:initComponents()
	if not self:getMainEntityId() then
		return
	end

	self:getMainEntity()
	FightEntityAssembledMonsterSub.super.initComponents(self)

	local mainEntity = FightHelper.getEntity(self.mainEntityId)

	self.mainSpine = mainEntity.spine

	self.spine:disposeSelf()

	self.spine = FightAssembledMonsterSpineSub.New(self)

	self.spineRenderer:disposeSelf()

	self.spineRenderer = mainEntity.spineRenderer
end

function FightEntityAssembledMonsterSub:getPartIndex()
	local entityMO = self:getMO()

	if entityMO then
		return lua_fight_assembled_monster.configDict[entityMO.skin].part
	end
end

return FightEntityAssembledMonsterSub
