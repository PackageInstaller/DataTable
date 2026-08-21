-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RogueUnitMgr.lua

module("logic.extensions.roguelike.flow.component.mgr.RogueUnitMgr", package.seeall)

local M = class("RogueUnitMgr", IRogueFlowComp)

function M:onInit()
	self._entityId2Unit = {}
end

function M:onStart()
	self._model = self.flow.model or false
end

function M:onClear()
	for _, unit in pairs(self._entityId2Unit) do
		RogueUnitGenerator.destroyUnit(unit)
	end

	self._model = false

	RogueUnitGenerator.clear()
end

function M:createRoleUnit(entityInfo)
	local unit = RogueUnitGenerator.createRoleUnit(entityInfo)

	unit.meshModel:setDirection(UnitSpineDir.Right)

	local roleId = entityInfo.entityCode
	local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleId)

	if not roleCo then
		print("没有角色配置", roleId)
	end

	local qua6 = roleCo.qua6
	local powerInfo = {
		value = 10,
		level = qua6[1]
	}
	local agileInfo = {
		value = 10,
		level = qua6[2]
	}
	local luckyInfo = {
		value = 10,
		level = qua6[3]
	}
	local insightInfo = {
		value = 10,
		level = qua6[4]
	}
	local knowledgeInfo = {
		value = 10,
		level = qua6[5]
	}
	local communicateInfo = {
		value = 10,
		level = qua6[6]
	}

	unit.roleProp:initProperty(powerInfo, agileInfo, luckyInfo, insightInfo, knowledgeInfo, communicateInfo)

	local heroData = HeroDepotModel.instance:getHeroInfoByID(roleId)
	local level = 0

	if heroData then
		level = heroData:getLevel()
	end

	local hp = RoguelikeConfig.instance:getConstByName("InitialHp").numValue
	local san = RoguelikeConfig.instance:getConstByName("InitialTeamSan").numValue
	local six
	local hpMax = hp
	local sanMax = san

	if not RogueMgr.instance:getIsClientMode() then
		hp = RoguelikeModel.instance:getRoleHp(roleId)
		san = RoguelikeModel.instance:getRoleSan(roleId)
		six = RoguelikeModel.instance:getRoleSix(roleId)
		hpMax = RoguelikeModel.instance:getRoleHpMax(roleId)
		sanMax = RoguelikeModel.instance:getRoleSanMax(roleId)
	end

	unit.roleProp:setRoleInfo(entityInfo.entityCode, entityInfo.idx)

	if six ~= nil then
		unit.roleProp:updateProperty(six)
	end

	unit.roleProp:setSan(san)
	unit.roleProp:setHp(hp, true)
	unit.roleProp:setHpMax(hpMax)
	unit.roleProp:setSanMax(sanMax)
	print("创建角色", entityInfo.entityCode, "血量:", hp, "SAN：", san)
	self:addUnit(roleId, unit)

	return unit
end

function M:createMonsterUnit(entityInfo)
	local unit = RogueUnitGenerator.createMonsterUnit(entityInfo)
	local co = RoguelikeConfig.instance:getRoguelikeMonsterById(entityInfo.entityCode)

	unit.buff:addBuff(co.passiveEffect)

	local diffBuffs = RoguelikeModel.instance:getCurDiffBuffIds()

	if diffBuffs then
		for k, v in pairs(diffBuffs) do
			unit.buff:addBuff(v)
		end
	end

	unit.meshModel:setDirection(UnitSpineDir.Right)
	self:addUnit(entityInfo.entityCode, unit)

	return unit
end

function M:createEventUnit(eventInfo)
	local unit = RogueUnitGenerator.createEventUnit(eventInfo)

	self:addUnit(-1, unit)

	return unit
end

function M:createNormalBuffUnit(entityInfo, buffIds)
	local unit = RogueUnitGenerator.createPropUnit(entityInfo)

	if buffIds then
		for k, v in pairs(buffIds or {}) do
			local buffCO = RoguelikeConfig.instance:getEffectById(v)

			if buffCO.clientProgram == "" or string.find(buffCO.clientProgram, "Monster") then
				-- block empty
			else
				unit.buff:addBuff(v)
			end
		end
	end

	return unit
end

function M:createPropUnit(entityInfo)
	local unit = RogueUnitGenerator.createPropUnit(entityInfo)

	if entityInfo.propId then
		local co = RoguelikeConfig.instance:getPropById(entityInfo.propId)

		if co then
			if co.conditionId ~= 0 then
				unit.buff:addCondition(co.conditionId)
			end

			for k, v in pairs(co.effectIds or {}) do
				unit.buff:addBuff(v)
			end
		end
	end

	if entityInfo.equipId and entityInfo.level then
		local equipCo = RoguelikeConfig.instance:getEquipById(entityInfo.equipId, entityInfo.level)

		if equipCo then
			local effects = equipCo.passiveEffects and #equipCo.passiveEffects > 0 and equipCo.passiveEffects[1] or {}

			for k, v in pairs(effects) do
				for k1, v1 in pairs(v) do
					unit.buff:addBuff(v1)
				end
			end
		else
			print("找不到装备" .. entityInfo.equipId)
		end
	end

	return unit
end

function M:createMapItemUnit(mapInfo)
	local unit = RogueMapGenerator.createMapUnit(mapInfo)

	return unit
end

function M:createUnit(entityId)
	return
end

function M:getAllUnits()
	return
end

function M:getUnit(entityId)
	return self._entityId2Unit[entityId]
end

function M:addUnit(id, unit)
	self._entityId2Unit[id] = unit
end

function M:removeUnit(unit)
	return
end

return M
