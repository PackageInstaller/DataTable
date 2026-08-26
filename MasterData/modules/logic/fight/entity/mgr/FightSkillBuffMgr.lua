-- chunkname: @modules/logic/fight/entity/mgr/FightSkillBuffMgr.lua

module("modules.logic.fight.entity.mgr.FightSkillBuffMgr", package.seeall)

local FightSkillBuffMgr = class("FightSkillBuffMgr")

function FightSkillBuffMgr:ctor()
	self:_init()
end

function FightSkillBuffMgr:_init()
	self._buffPlayDict = {}
	self._buffEffectPlayDict = {}
end

function FightSkillBuffMgr:clearCompleteBuff()
	self:_init()
end

function FightSkillBuffMgr:playSkillBuff(fightStepData, actEffectData)
	if not self:hasPlayBuff(actEffectData) then
		local fightWorkStepBuff = FightWork2Work.New(FightWorkStepBuff, fightStepData, actEffectData)

		fightWorkStepBuff:onStart()

		local effectType = actEffectData.effectType
		local buffMO = actEffectData.buff

		self._buffPlayDict[actEffectData.clientId] = true

		local stepUid = fightStepData.stepUid

		if stepUid and effectType == FightEnum.EffectType.BUFFADD then
			local buffCO = lua_skill_buff.configDict[buffMO.buffId]

			if buffCO and buffCO.effect ~= "0" and not string.nilorempty(buffCO.effect) then
				local key = string.format(stepUid .. "-" .. buffMO.entityId .. "-" .. buffCO.effect)

				self._buffEffectPlayDict[key] = true
			end
		end
	end
end

function FightSkillBuffMgr:hasPlayBuff(actEffectData)
	return self._buffPlayDict[actEffectData.clientId]
end

function FightSkillBuffMgr:hasPlayBuffEffect(entityId, buff, stepUid)
	local buffCO = lua_skill_buff.configDict[buff.buffId]

	if stepUid and buffCO and buffCO.effect ~= "0" and not string.nilorempty(buffCO.effect) then
		local key = string.format(stepUid .. "-" .. entityId .. "-" .. buffCO.effect)

		return self._buffEffectPlayDict[key]
	end

	return false
end

FightSkillBuffMgr.StackBuffFeatureList = {
	FightEnum.BuffType_DeadlyPoison
}

function FightSkillBuffMgr:buffIsStackerBuff(buff_config)
	if not buff_config then
		return false
	end

	local buffId = buff_config.id

	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(buffId) then
		local buff_type_config = lua_skill_bufftype.configDict[buff_config.typeId]
		local tab = FightStrUtil.instance:getSplitCache(buff_type_config.includeTypes, "#")

		return true, tab[1]
	end

	for _, feature in ipairs(FightSkillBuffMgr.StackBuffFeatureList) do
		if FightConfig.instance:hasBuffFeature(buffId, feature) then
			local buff_type_config = lua_skill_bufftype.configDict[buff_config.typeId]
			local tab = FightStrUtil.instance:getSplitCache(buff_type_config.includeTypes, "#")

			return true, tab[1]
		end
	end

	local buff_type_config = lua_skill_bufftype.configDict[buff_config.typeId]

	if buff_type_config then
		local tab = FightStrUtil.instance:getSplitCache(buff_type_config.includeTypes, "#")
		local type = tab[1]

		if type == FightEnum.BuffIncludeTypes.Stacked or type == FightEnum.BuffIncludeTypes.Stacked12 or type == FightEnum.BuffIncludeTypes.Stacked15 or type == FightEnum.BuffIncludeTypes.Stacked14 then
			return true, type
		end
	end
end

FightSkillBuffMgr.tempSignKeyDict = {}

function FightSkillBuffMgr:dealStackerBuff(buff_list)
	local type10_tab = FightSkillBuffMgr.tempSignKeyDict

	tabletool.clear(type10_tab)

	for i = #buff_list, 1, -1 do
		local buffMO = buff_list[i]
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO and self:buffIsStackerBuff(buffCO) then
			local sign_key = FightBuffHelper.getBuffMoSignKey(buffMO)

			if not type10_tab[sign_key] then
				type10_tab[sign_key] = true
			else
				table.remove(buff_list, i)
			end
		end
	end
end

function FightSkillBuffMgr:getStackedCount(entityId, buffMo)
	local buffCo = lua_skill_buff.configDict[buffMo.buffId]

	if not self:buffIsStackerBuff(buffCo) then
		return 1
	end

	local entityMO = FightDataHelper.entityMgr:getById(entityId)
	local buffDic = entityMO and entityMO:getBuffDic()

	if buffDic then
		local sign_key = FightBuffHelper.getBuffMoSignKey(buffMo)
		local count = 0

		for _, buffMO in pairs(buffDic) do
			if sign_key == FightBuffHelper.getBuffMoSignKey(buffMO) then
				count = count + 1

				if buffMO.layer and buffMO.layer ~= 0 then
					count = count + buffMO.layer - 1
				end
			end
		end

		return count
	end

	return 1
end

FightSkillBuffMgr.instance = FightSkillBuffMgr.New()

return FightSkillBuffMgr
