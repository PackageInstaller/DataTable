-- chunkname: @modules/logic/fight/config/FightASFDConfig.lua

module("modules.logic.fight.config.FightASFDConfig", package.seeall)

local FightASFDConfig = class("FightASFDConfig", BaseConfig)

function FightASFDConfig:ctor()
	return
end

function FightASFDConfig:reqConfigNames()
	return {
		"fight_asfd",
		"fight_asfd_emitter_position",
		"fight_asfd_const",
		"fight_asfd_fly_path",
		"fight_lsj_asfd"
	}
end

function FightASFDConfig:onConfigLoaded(configName, configTable)
	if configName == "fight_asfd" then
		self:buildFightASFDConfig(configTable)
	elseif configName == "fight_asfd_const" then
		self:buildFightASFDConstConfig(configTable)
	elseif configName == "fight_asfd_fly_path" then
		self:buildFightASFDFlyPathConfig(configTable)
	end
end

function FightASFDConfig:buildFightASFDConfig(configTable)
	local configDict = configTable.configDict

	self.defaultEmitterCo = configDict[1]
	self.defaultMissileCo = configDict[2]
	self.defaultExplosionCo = configDict[3]
	self.defaultBornCo = configDict[7]
	self.unitListDict = {
		[FightEnum.ASFDUnit.Emitter] = {},
		[FightEnum.ASFDUnit.Missile] = {},
		[FightEnum.ASFDUnit.Explosion] = {},
		[FightEnum.ASFDUnit.Born] = {}
	}

	for _, co in ipairs(configTable.configList) do
		local list = self.unitListDict[co.unit]

		if list then
			table.insert(list, co)
		end
	end

	table.sort(self.unitListDict[FightEnum.ASFDUnit.Emitter], self.sortASFDCo)
	table.sort(self.unitListDict[FightEnum.ASFDUnit.Missile], self.sortASFDCo)
	table.sort(self.unitListDict[FightEnum.ASFDUnit.Explosion], self.sortASFDCo)
	table.sort(self.unitListDict[FightEnum.ASFDUnit.Born], self.sortASFDCo)
end

function FightASFDConfig.sortASFDCo(asfdCo1, asfdCo2)
	local priority1 = asfdCo1.priority
	local priority2 = asfdCo2.priority

	if priority1 ~= priority2 then
		return priority2 < priority1
	end

	return asfdCo1.id > asfdCo2.id
end

function FightASFDConfig:buildFightASFDConstConfig(configTable)
	local configDict = configTable.configDict

	self.flyDuration = tonumber(configDict[1].value)
	self.missileInterval = tonumber(configDict[2].value)
	self.explosionDuration = tonumber(configDict[3].value)
	self.randomRadius = tonumber(configDict[4].value)
	self.skillId = tonumber(configDict[5].value)
	self.hitHangPoint = configDict[11].value
	self.maDiErDaCritScale = tonumber(configDict[12].value)
	self.fissionScale = tonumber(configDict[13].value)
	self.emitterWaitTime = tonumber(configDict[14].value)
	self.flyReduceInterval = tonumber(configDict[15].value)
	self.missileReduceInterval = tonumber(configDict[16].value)
	self.minFlyDuration = tonumber(configDict[17].value)
	self.minMissileInterval = tonumber(configDict[18].value)
	self.normalSkillIcon = configDict[20].value
	self.bigSkillIcon = configDict[21].value
	self.headIcon = configDict[22].value
	self.sampleXRate = tonumber(configDict[23].value)
	self.lineType = tonumber(configDict[24].value)
	self.alfMaxShowEffectCount = tonumber(configDict[26].value)
	self.xiTiSpecialSkillId = tonumber(configDict[27].value)
	self.lsjLastASFDDelay = tonumber(configDict[28].value)

	local skillList = configDict[29].value

	self.asfdSkillIdList = string.splitToNumber(skillList, "#")
	self.emitterCenterOffset = Vector2(0, 0)
	self.myASFDConfig = self:buildASFDEmitterConfig("法术飞弹-我方")
	self.enemyASFDConfig = self:buildASFDEmitterConfig("法术飞弹-敌方")
	self.startAnimAbUrl = FightHelper.getCameraAniPath("v2a4_asfd/v2a4_asfd_start")
	self.endAnimAbUrl = FightHelper.getCameraAniPath("v2a4_asfd/v2a4_asfd_end")
	self.startAnim = ResUrl.getCameraAnim("v2a4_asfd/v2a4_asfd_start")
	self.endAnim = ResUrl.getCameraAnim("v2a4_asfd/v2a4_asfd_end")
end

function FightASFDConfig:buildASFDEmitterConfig(name)
	return {
		uniqueSkill_point = 5,
		name = name
	}
end

function FightASFDConfig:buildFightASFDFlyPathConfig(configTable)
	local configDict = configTable.configDict

	self.defaultFlyPath = configDict[1]
end

function FightASFDConfig:getFlyPathCo(id)
	local pathCo = lua_fight_asfd_fly_path.configDict[id]

	if not pathCo then
		return self.defaultFlyPath
	end

	return pathCo
end

function FightASFDConfig:getASFDEmitterConfig(side)
	return (side == FightEnum.EntitySide.EnemySide or nil) and (self.enemyASFDConfig or self.myASFDConfig)
end

function FightASFDConfig:getUnitList(unit)
	return self.unitListDict[unit]
end

function FightASFDConfig:getMissileInterval(index)
	local interval = self.missileInterval - (index - 1) * self.missileReduceInterval

	return math.max(self.minMissileInterval, interval)
end

function FightASFDConfig:getFlyDuration(flyDuration, index)
	local duration = flyDuration - (index - 1) * self.flyReduceInterval

	return math.max(self.minFlyDuration, duration)
end

function FightASFDConfig:getSkillCo()
	if not self.skillLCo then
		self.skillCo = lua_skill.configDict[self.skillId]
	end

	return self.skillCo
end

function FightASFDConfig:isASFDSkill(skillId)
	if not skillId then
		return
	end

	for _, _skillId in ipairs(self.asfdSkillIdList) do
		if skillId == _skillId then
			return true
		end
	end
end

function FightASFDConfig:getASFDCoRes(asfdCo)
	if not asfdCo then
		return
	end

	local res = asfdCo.res

	if not string.find(res, "|") then
		return res
	end

	self.tempResDict = self.tempResDict or {}

	local resList = self.tempResDict[res]

	if not resList or #resList < 1 then
		resList = tabletool.copy(FightStrUtil.instance:getSplitCache(res, "|"))
		self.tempResDict[res] = resList
	end

	local len = #resList

	if len == 1 then
		return table.remove(resList)
	end

	local randomPos = math.random(len)

	return table.remove(resList, randomPos)
end

function FightASFDConfig:getLSJCo(index)
	local co = index and lua_fight_lsj_asfd.configDict[index]

	if not co then
		logError("鹭鸶剪 奥术飞弹配置不存在 ： " .. tostring(index))

		return lua_fight_lsj_asfd.configDict[1]
	end

	return co
end

FightASFDConfig.instance = FightASFDConfig.New()

return FightASFDConfig
