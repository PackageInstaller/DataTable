require "class"
---@class SkillManager
local SkillManager = class("SkillManager")
-- local SkillConditionHandler = require "SkillConditionHandler"
local SkillAffixHandler = require "SkillAffixHandler"
-- local SkillTargetHandler = require "SkillTargetHandler"
local BuffHandler = require "BuffHandler"
local SkillPerformancefHandler = require "SkillPerformancefHandler"
local BattleCore = require "BattleCore"


function SkillManager:ctor()
	self.affixHandler = SkillAffixHandler:instance() --效果处理器
	-- self.targetHandler = SkillTargetHandler:instance() --目标处理器
	self.buffHandler = BuffHandler:instance() --目标处理器
	self.perfHandler = SkillPerformancefHandler.instance() --表现处理器
end

---实例化
---@return SkillManager SkillManager
function SkillManager.instance()
	if (SkillManager._instance == nil) then
		SkillManager._instance = SkillManager:new()
	end
	return SkillManager._instance
end

---检测技能
---@param id integer 技能id
---@param source BattleRole 技能源
---@param target BattleBlock[] 技能目标
---@param delay number 表现延迟
function SkillManager:checkSkill(id, source, target, delay)
	BattleCore.ds("SkillManager:checkSkill",id)
	if (not id) then
		BattleCore.ds("SkillManager:checkSkill no skill id!!!!!!!!!!")
		return 0
	end
	
	local skillId = id
    local canUse = source:checkSkillCanBeUse(skillId)
    if canUse == false then
        BattleCore.ds("技能无法使用", skillId)
        return 0
    end
	local skillConfig = Config.GetSkillInfo(skillId)
	-- skillConfig.skillSource = source

	if (skillConfig) then
		local skillCanUse = skillConfig.skillType == GE.SkillType.Normal
		if skillCanUse == false then
			skillCanUse = source:checkHasCanNotUseActiveSkill() == false
		end
		if skillCanUse then
			return self:doSkill(source, target, skillConfig, delay)
		else
			BattleCore.ds("目前无法使用主动技能", skillId)
		end
	end
	
	return 0
end

---检测技能效果
---@param skillConfig SkillTable 技能配置
---@param source BattleRole 技能源
---@param target integer[]? 技能目标
---@param delay number? 表现延迟
function SkillManager:DoSkillEffect(skillConfig, source, target, delay)
	if (not skillConfig) then
		BattleCore.ds("SkillManager:checkSkill no skill id!!!!!!!!!!")
		return
	end
	local skillId = skillConfig.id
	if not GV.IsServer then
		BattleCore.ds("SkillManager:checkSkill", skillId)
	end
	local battleMgr = BattleCore:getBattleMgr()
	local timing = battleMgr:getTiming()
	---@type pendingAffixData[]
	local pendingAffixes = {}
	if (skillConfig) then
		local needFind = skillConfig.skillOperateType and skillConfig.skillOperateType == GE.SkillOperateType.SelfRange
		if source._isMyTurn then
			local effectList = nil
			if (timing == GE.BattleTiming.BeforeAction) then
				effectList = skillConfig.effectBeforeBattle
			elseif (timing == GE.BattleTiming.OnActionFinish) then
				effectList = skillConfig.effectAfterBattle
			elseif (timing == GE.BattleTiming.AfterAction) then
				effectList = skillConfig.effectActionOver
			end
			if effectList then
				if needFind then
					local targetHandler = BattleCore:getSkillTargetHandler()
					target = targetHandler:checkTargetBlockWithSource(source, skillConfig)
					needFind = false
				end
				for _, triggerId in ipairs(effectList) do
					local list = self:getPendingAffixes(triggerId, source, target, delay, skillId)
					pendingAffixes = tablex.combine(pendingAffixes, list)
				end
			end
		end
		local effectPassiveList = skillConfig.effectPassive
		if effectPassiveList then
			if needFind then
				local targetHandler = BattleCore:getSkillTargetHandler()
				target = targetHandler:checkTargetBlockWithSource(source, skillConfig)
				needFind = false
			end
			for _, triggerId in ipairs(effectPassiveList) do
				local list = self:getPendingAffixes(triggerId, source, target, delay, skillId)
				pendingAffixes = tablex.combine(pendingAffixes, list)
			end
		end
		source:doAffixes(pendingAffixes)
	end
end

---@class damageData
---@field source BattleRole
---@field damage number
---@field damageType SkillDamage
---@field atkCalculateType integer
-- ---@field attribute integer
---@field restraintCorrect number 攻击方的舰种克制系数（包含额外补正系数）
---@field healthRatio number 攻击方治疗量修正
---@field baseDamageRate number 基本伤害倍率
---@field skillAddRatio number
---@field isCrit boolean 是否暴击
---@field bulletNum number
---@field hitRate number
---@field exCritRatio number
---@field exDamageRatio number
---@field exDamageRatioB number
---@field terrainCfg MapTerrainTypeTable? 地形防御加成

---执行技能
---@param source BattleRole 技能源
---@param blockIdList BattleBlock[] 格子列表
---@param skillConfig SkillTable 技能表数据
---@param delay number? 表现延迟
function SkillManager:doSkill(source, blockIdList, skillConfig, delay)
	delay = (delay or 0)
    local skillId = skillConfig.id
    -- LuaLogger.ds("SkillManager:doSkill", tablex.dump(skillConfig), tablex.dump(blockIdList))
	local targetsList = blockIdList
	local CDNum = skillConfig.preCd
	if CDNum > 0 then
        source:setSkillCD(skillId, CDNum)
	end
	if skillConfig.usageNum > 0 then
		source:setSkillAmmoUsedNum(skillId, 1)
	end
	local index = 1
	local skinConfig = nil
	if source.isMonster then
		skinConfig = Config.GetCharacterSkinInfo(source.roleConfig.baseSkinID)
	else
		skinConfig = Config.GetCharacterSkinInfo(source.serverData.equipSkin)
	end
	---简易验证仅取玩家角色数据
	local needAddSimpleVerify = source.isMonster == false
	local battleMgr = BattleCore:getBattleMgr()
	local sourceCid = source.roleConfig.id
	local sourceHp = source:getAttrib(GE.AttribType.Hp)
	local sourceBlockId = source:getShowBlock().id
	
	--所有受击数据
	---@class allHitDetail
	---@field target BattleRole
	---@field singleHitData HitData
	---@field damageData damageData
	
	---@type allHitDetail[]
	local allHitDetail = {}
	for _, block in ipairs(targetsList) do
		BattleCore.ds("SkillManager:doSkill block!!!!!", block.cid)
		if index > skillConfig.effectNum then
			break
		end
		local hasRole = block.roleId ~= nil
		if hasRole and skillConfig.effectSoldierType ~= 4 then
			index = index + 1
		elseif skillConfig.effectSoldierType == 4 then
			index = index + 1
		end
		local target = block:tryGetRole()
		if target then
			local damageData = self:getDamageData(source, target, skillConfig, skinConfig)
			local singleHitData, dmgLog = target:getHitData(damageData)
			if LuaLogger.Enabled and not GV.IsServer then
				BattleCore.ds("SkillManager:doSkill singleHitData", tablex.dump(singleHitData))
			end
			---@type allHitDetail
			local temp = {
				target = target,
				singleHitData = singleHitData,
				damageData = damageData,
			}
			table.insert(allHitDetail, temp)
			local _damageValue = singleHitData.dmgValue

			if needAddSimpleVerify and target.isMonster == true then
				local _sourceBuffList = {}
				local buffList = source.buffController:getRawBuffList()
				for _, buff in ipairs(buffList) do
					if buff:getIsPassCondition() then
						table.insert(_sourceBuffList, buff.id)
					end
				end
				local targetHp = target:getAttrib(GE.AttribType.Hp)
				local targetBuffList = target.buffController:getRawBuffList()
				local _targetBuffList = {}
				for _, buff in ipairs(targetBuffList) do
					if buff:getIsPassCondition() then
						table.insert(_targetBuffList, buff.id)
					end
				end
				local _skillDamageData = tablex.clone(damageData)
				_skillDamageData.source = nil
				---@type ReportRoleDoSkillData
				local d = {
					cid = sourceCid,
					sourceBlockId = sourceBlockId,
					sourceBuffIdList = _sourceBuffList,
					targetBuffIdList = _targetBuffList,
					skillId = skillId,
					curSourceHp = sourceHp,
					curTargetHp = targetHp,
					targetCId = target.roleConfig.id,
					targetLevel = target.level,
					targetBlockId = block.cid,
					isCrit = damageData.isCrit,
					damageValue = _damageValue,
					terrainId = block.terrain,
					skillDamageData = _skillDamageData,
					skillHitData = dmgLog,
				}
				if battleMgr:isVerifyMode() then
					local isPass = false
					isPass = battleMgr:checkSimpleVerifyData(d)
					if isPass == false then
						local orderMgr = battleMgr:getOrderManager()
						orderMgr:OrderCheckFail()
					end
				else
					battleMgr:setSimpleVerifyData(d)
				end
			end
		end
	end
	local perfTime, shootTime, hasPerf, needFinalHit = self:doPerformance(source, skinConfig, skillConfig, delay, allHitDetail)
	--纯表现不用受击
	if skillConfig.atkCalculateType ~= GE.SkillCalculateType.NonDamage then
		for _, v in pairs(allHitDetail) do
			v.target:hit(v.damageData, delay + perfTime, v.singleHitData, hasPerf, needFinalHit)
			BattleCore.ds("SkillManager:doSkill perfTime", perfTime, shootTime, needFinalHit)
		end
	end
end

---@param skillData SkillTable
---@param skinData CharacterSkinTable
--获取子弹数量
function SkillManager:GetBulletNum(skillData, skinData)
	local skillActId = skillData.skillActId
	local targetType
	local targetSkillHitEff
	if skillData.effPriority == 1 then
		targetType = skillData.bulletType
		targetSkillHitEff = skillData.skillHitEff
	else
		targetType = skinData["bulletType"..skillActId]
		targetSkillHitEff = skinData["skillHitEff"..skillActId]
	end
	--子弹数量 默认为1  AreaAttack JustEffect
	local num = 1
	local bulletNumType
	for k, v in pairs(GE.SkillPerformanceToBulletNumType) do
		if tablex.contains(v, targetType) then
			bulletNumType = k
			break
		end
	end
	if bulletNumType == GE.BulletNumType.one then
		num = 1
	elseif bulletNumType == GE.BulletNumType.bulletList then
		num = tablex.size(targetSkillHitEff.bulletList)
	elseif bulletNumType == GE.BulletNumType.plane then
		num = 0
		for _, plane in pairs(targetSkillHitEff.bulletList) do
			for _, Bomb in pairs(plane.boomList) do
				num = num + 1
			end
		end
	end
	return num
end

---获取伤害数据
---@param source BattleRole 技能发起方
---@param target BattleRole 技能目标
---@param skillConfig SkillTable 技能表数据
---@param skinConfig? CharacterSkinTable 角色皮肤表数据
---@param hasCritData boolean? 是否需要计算暴击
---@param terrainConfig MapTerrainTypeTable? 地形数据
---@return damageData
function SkillManager:getDamageData(source, target, skillConfig, skinConfig, hasCritData, terrainConfig)
	local damageType = skillConfig.attackDamageType
	---@type number
	local damage = 0
	---@type number
	local damageAttrib = 0
	if (damageType == GE.SkillDamageType.Bombard) then
		damageAttrib = source:getAttrib(GE.AttribType.Bombard)
	elseif (damageType == GE.SkillDamageType.Torpedo) then
		damageAttrib = source:getAttrib(GE.AttribType.Torpedo)
		-- elseif (damageType == GE.SkillDamageType.AirBombard) then
		-- 	damage = source:getAttrib(GE.AttribType.Bombard)
		-- elseif (damageType == GE.SkillDamageType.AirTorpedo) then
		-- 	damage = source:getAttrib(GE.AttribType.Torpedo)
	else
		BattleCore.es("SkillManager:doSkill wrong SkillDamageType", damageType)
	end
	local canFly = target.roleConfig.canFly == 1
	if canFly then
		local airDefense = source:getAttrib(GE.AttribType.AirDefense)
		damage = airDefense * 2 + damageAttrib * 0.2
	else
		damage = damageAttrib
	end
	local battleMgr = BattleCore:getBattleMgr()
	local lucky = source:getAttrib(GE.AttribType.Lucky)
	local critRateRatio = source:getAttrib(GE.AttribType.CritRateRatio, nil) * 1000
	local antiCritRateRatio = target:getAttrib(GE.AttribType.AntiCritRateRatio, nil) * 1000
	local charRestraintConfig = Config.GetCharacterRestraintInfo(source.roleConfig.attribute)
	local targetRestraintType = target.restraintType
	local tbNum = charRestraintConfig.ratio[targetRestraintType]
	local exNum = source:getAttrib(GE.AttribType.RestraintRatio, targetRestraintType)
	local _restraintCorrect = tbNum + exNum --克制修正
	local _atkCalculateType = skillConfig.atkCalculateType
	local isRepair = _atkCalculateType == GE.SkillCalculateType.Repair
	local _healthRatio = isRepair and source:getAttrib(GE.AttribType.HealthRatio, nil) or 0
	--去skin表获取子弹数量
	local isCrit = false
	local bulletNum = 0
	---目前展示预处理血量不需要计算暴击和子弹数量
	if skinConfig ~= nil then
		isCrit = (lucky + critRateRatio - antiCritRateRatio) >= battleMgr:getRandomNum(1, 1000)
		bulletNum = self:GetBulletNum(skillConfig, skinConfig)
	end
	if hasCritData ~= nil then
		isCrit = hasCritData
	end
	if not GV.IsServer then
		BattleCore.ds("SkillManager:doSkill bulletNum", bulletNum)
	end
	---@type damageData
	local damageData = {
		source = source,
		damage = damage,
		damageType = damageType,
		atkCalculateType = _atkCalculateType,
		restraintCorrect = _restraintCorrect,
		baseDamageRate = source:getAttrib(GE.AttribType.BaseDamageRate) +
			source:getAttrib(GE.AttribType.DamageRatio),
		healthRatio = _healthRatio,
		skillAddRatio = skillConfig.skillAddRatio + source:getAttrib(GE.AttribType.SkillAddRatio),
		hitRate = skillConfig.hitRate,
		bulletNum = bulletNum,
		isCrit = isCrit,
		exCritRatio = source:getAttrib(GE.AttribType.CritRatio),
		exDamageRatio = source:getAttrib(GE.AttribType.DamageRatio),
		exDamageRatioB = source:getAttrib(GE.AttribType.DamageRatioB),
		terrainCfg = terrainConfig,
	}
	return damageData
end

---获取待生效效果
---@param id integer 效果id
---@param source BattleRole 效果源
---@param target integer[] 效果目标
---@param delay number? 表现延迟
---@return pendingAffixData[]
function SkillManager:getPendingAffixes(id, source, target, delay, sourceSkillID)
	return self:checkEffect(id, source, target, delay, true, sourceSkillID)
end

---@class pendingAffixData
---@field priority integer  buff生效优先级，处理覆盖相关
---@field sourceSkillId integer?
---@field source BattleRole
---@field target BattleRole?
---@field effectConfig EffectTable
---@field triggerConfig EffectTriggerTable?
---@field triggerBuffIds integer[]?
---@field sourceSkillID integer? 当前检测来源技能
---@field isDoAffix boolean? 是否是执行效果，false表示执行取消效果
---@field delay number?

---获取技能能覆盖到的所有目标，一次选择请用下面这个
---@param role BattleRole
---@param curSkillTarget integer[]? 当前技能目标
---@param config EffectTriggerTable|SkillTable
---@param sourceSkillID integer? 当前检测来源技能
function SkillManager:GetAllTarget(role, curSkillTarget, config, sourceSkillID)
	local targetsList = nil
    local targetHandler = BattleCore:getSkillTargetHandler()
	local checkSkillId = sourceSkillID or role.selectedSkill
    targetsList = targetHandler:findTargets(role, curSkillTarget, config.effectSoldierType, config,
        checkSkillId)
    if config.SiftCondition then
        targetsList = targetHandler:targetFilterList(role, targetsList, config.SiftCondition)
    end
    return targetsList
end

---获得技能一次覆盖的所有目标，需要考虑到技能目标类型和目标是否有无法被选中的状态等
---@param role BattleRole
---@param curSkillTarget integer[]? 当前技能目标
---@param config SkillTable
---@param sourceSkillID integer? 当前检测来源技能
function SkillManager:GetAllSelectTarget(role, curSkillTarget, config, sourceSkillID)
	local targetList = self:GetAllTarget(role, curSkillTarget, config, sourceSkillID)
	local r = {}
	if not targetList then
		return r
	end
	for _, block in ipairs(targetList) do
		local isPass = self:checkBlockRoleCanBeSelect(config, role, block, true)
		if isPass then
			r[#r + 1] = block
		end
	end
	return r
end

---检测效果
---@param id integer 效果id
---@param source BattleRole 效果源
---@param target integer[]? 效果目标
---@param delay number? 表现延迟
---@param getPendingAffixes boolean? 获取待生效效果
---@param sourceSkillID integer?
---@return pendingAffixData[]
function SkillManager:checkEffect(id, source, target, delay, getPendingAffixes, sourceSkillID)
	if not GV.IsServer then
		BattleCore.ds("SkillManager:checkEffect", id, source.id)
	end
	---@type pendingAffixData[]
	local pendingAffixes = {}
	if (not id) then
		BattleCore.es("SkillManager:checkEffect no effect id!!!!!!!!!!")
		return pendingAffixes
	end

	---@type EffectTriggerTable
	local effectTriggerConfig = tablex.clone(Config.GetEffectTriggerInfo(id))

	---检测效果生效次数限制
    local canTakeEffect = source:getCanTakeEffectById(effectTriggerConfig)
    if canTakeEffect == false then
        return pendingAffixes
    end

	--检测Trigger免疫
	local tags = effectTriggerConfig.immuneType
	if (tags) then
		if source then
            for _, tag in ipairs(tags) do
                if (self:_checkImmune(source, tag, GE.SkillAffixType.ImmuneEffectTrigger)) then
					if not GV.IsServer then
                    	BattleCore.ds("SkillManager:checkEffect 效果Trigger被免疫 id:", id)
					end
                    return pendingAffixes
                end
            end
		end
	end

	--检测触发概率
	local battleMgr = BattleCore:getBattleMgr()
	local randomValue = battleMgr:getRandomNum(1, 100, id)
	if (randomValue > effectTriggerConfig.probability) then
		if not GV.IsServer then
			BattleCore.ds("SkillManager:checkEffect probability", randomValue, effectTriggerConfig.probability)
		end
		return pendingAffixes
	end

	--获取效果目标
	local targets = self:GetAllTarget(source, target, effectTriggerConfig, sourceSkillID)
	if not GV.IsServer then
		BattleCore.ds("SkillManager:checkEffect targetsList", id, targets)
	end

	---效果影响的目标数量
	local index = 1
	for _, block in ipairs(targets) do
		if index > effectTriggerConfig.effectNum then
			break
		end
		local t = block:tryGetRole()
		local hasRole = t ~= nil
		local isPass = self:checkConditions(effectTriggerConfig.condition, source, t, nil, sourceSkillID)
		if isPass == false and not GV.IsServer then
			BattleCore.ds("SkillManager:checkEffect 条件不满足", effectTriggerConfig.id)
		end
		if (isPass) then
            if t then
                source:SetRoleEffectActionList(t.id)
            end
            if hasRole and effectTriggerConfig.effectSoldierType ~= 4 then
				index = index + 1
			elseif effectTriggerConfig.effectSoldierType == 4 then
				index = index + 1
			end
			source:reduceEffectLimitNumById(effectTriggerConfig.id)
			local effectCondition = effectTriggerConfig.effectCondition
			local valueType = GE.EffectTriggerValueType.All
			local triggerbuffList = {}
			local triggerEffectList = {}
			if (effectCondition) then
				local methodType = effectCondition[1]
				valueType = effectCondition[2]
				local probability = effectCondition[3]
				local count = effectCondition[4]
				if (methodType == GE.EffectTriggerMethodType.Whole) then
					local randomV = battleMgr:getRandomNum(1, 100, id)
					if (randomV <= probability) then
						triggerbuffList = effectTriggerConfig.buffId or {}
						triggerEffectList = effectTriggerConfig.effectId or {}
					end
				elseif (methodType == GE.EffectTriggerMethodType.Draw) then
					triggerbuffList, triggerEffectList = self:_getDrawTriggerList(valueType, count,
						effectTriggerConfig.buffId or {}, effectTriggerConfig.effectId or {}, id)
				elseif (methodType == GE.EffectTriggerMethodType.OneByOne) then
					triggerbuffList, triggerEffectList = self:_getOneByOneTriggerList(valueType, probability,
						count, effectTriggerConfig.buffId or {}, effectTriggerConfig.effectId or {}, id)
				end
			else
				triggerbuffList = effectTriggerConfig.buffId or {}
				triggerEffectList = effectTriggerConfig.effectId or {}
			end

			if next(triggerbuffList) or next(triggerEffectList) then

				if tablex.next(triggerbuffList) then
					---@type pendingAffixData
					local pendingAffixeData = {
						priority = 0,
						source = source,
						target = t,
						effectConfig = nil,
						sourceSkillID = sourceSkillID,
						triggerConfig = effectTriggerConfig,
						triggerBuffIds = triggerbuffList,
						delay = delay
					}
					pendingAffixes[#pendingAffixes + 1] = pendingAffixeData
				end
				--执行效果
				for _, effectId in ipairs(triggerEffectList) do
					local effectConfig = Config.GetEffectInfo(effectId)
					---@type pendingAffixData
					local pendingAffixData = {
						priority = effectConfig.priority,
						source = source,
						target = t,
						effectConfig = effectConfig,
						sourceSkillID = sourceSkillID,
						triggerConfig = effectTriggerConfig,
						delay = delay
					}
					table.insert(pendingAffixes, pendingAffixData)
				end
			end
		end
	end
	if not getPendingAffixes then
		local lastTriggerId = nil
		for _, pending in ipairs(pendingAffixes) do
			if source.doAffixesByData then
				lastTriggerId = source:doAffixesByData(pending, lastTriggerId)
			else
				lastTriggerId = nil
				self:checkPendingAffix(pending)
			end
		end
		-- battleMgr:getReporter():packStep()
	end
	return pendingAffixes
end

---@param valueType EffectTriggerValueType
---@param methodType EffectTriggerMethodType
---@param probability integer
---@param effectList integer[]?
---@param buffList integer[]?
---@param buffCount integer
---@param effectCfgId integer? 当前检测效果id
---@return integer[], integer[] buffList和EffectList
function SkillManager:getBuffOrEffectList(valueType, methodType, probability, effectList, buffList, buffCount, effectCfgId)
	--检测触发概率
	local battleMgr = BattleCore:getBattleMgr()
    valueType = valueType and GE.EffectTriggerValueType.All
    local triggerbuffList = {}
    local triggerEffectList = {}
	local buffId = buffList or {}
	local effectId = effectList or {}
    if (methodType) then
        local count = buffCount
        if (methodType == GE.EffectTriggerMethodType.Whole) then
            local randomV = battleMgr:getRandomNum(1, 100, effectCfgId)
            if (randomV <= probability) then
                triggerbuffList = buffId
                triggerEffectList = effectList or {}
            end
        elseif (methodType == GE.EffectTriggerMethodType.Draw) then
            triggerbuffList, triggerEffectList = self:_getDrawTriggerList(valueType, count,
			buffId, effectId, effectCfgId)
        elseif (methodType == GE.EffectTriggerMethodType.OneByOne) then
            triggerbuffList, triggerEffectList = self:_getOneByOneTriggerList(valueType, probability,
                count, buffId, effectId, effectCfgId)
        end
    else
        triggerbuffList = buffId
        triggerEffectList = effectId
    end

	return triggerbuffList, triggerEffectList
end

---@param triggerbuffList integer[] 触发的buff列表
---@param buffCondition integer[] 检查条件列表
---@param t BattleRole
---@param source BattleRole
function SkillManager:checkAddBuff(triggerbuffList, buffCondition, t, source, delay)
	if not t then
		return
	end
	buffCondition = buffCondition or {}
	-- local battleMgr = BattleCore:getBattleMgr()
	for _, buffData in ipairs(triggerbuffList) do
		if (t.addBuff) then
			local buffId = buffData[1]
			local buffRounds = buffData[2]
			local buffConfig = Config.GetBuffInfo(buffId)

			--检测Buff免疫
			local buffTags = buffConfig.immuneType
			local isImmune = false
			if (buffTags) then
				for _, tag in ipairs(buffTags) do
					if (self:_checkImmune(t, tag, GE.SkillAffixType.ImmuneBuff)) then
						isImmune = true
						break
					end
				end
			end
			if (not isImmune) then
				local buff = self.buffHandler:createBuff(buffId, buffRounds,
					buffCondition, source, buffConfig)
				local buffTags = buff:getTags()
				---获取buff回合数相关修正值
				local sourceBuffRound = source:getSetBuffRoundOffset(buffTags)
				local targetBuffRound = t:getAddBuffRoundOffset(buffTags)
				buff:changeRemainRound(sourceBuffRound + targetBuffRound)
				t:addBuff(buff, delay)
			else
				BattleCore.ds("SkillManager:checkEffect Buff被免疫 buffId:", buffId)
			end
		end
	end
end

---检查免疫
function SkillManager:_checkImmune(obj, affixType, immuneType)
	if (obj.getImmuneList) then
		local immuneList = obj:getImmuneList(immuneType)
		if (tablex.contains(immuneList, affixType)) then
			if not GV.IsServer then
				BattleCore.ds("SkillManager:_checkImmune affixType", affixType)
			end
			return true
		end
	end
	return false
end

function SkillManager:randomElements(elements, num, effectCfgId)
    local ret = {}
    local eleNum = #elements
    local rdNum = 0
    elements = shallowclone(elements)
    local battleMgr = BattleCore:getBattleMgr()
    while eleNum > 0 and rdNum < num do
        local index = battleMgr:getRandomNum(1, eleNum, effectCfgId)
        local r = elements[index]
        table.insert(ret, r)
        rdNum = rdNum + 1
        table.remove(elements, index)
        eleNum = eleNum - 1
    end

    return ret
end

---获取平均触发列表
---@param valueType EffectTriggerValueType 效果触发内容类型
---@param count integer 最大触发数量
---@param buffList integer[] 需要检测的buff列表
---@param effectList integer[] 需要检测的effect列表
---@param effectCfgId integer? 当前检测效果id
---@return integer[], integer[] 触发的buff列表和触发的effect列表
function SkillManager:_getDrawTriggerList(valueType, count, buffList, effectList, effectCfgId)
	local triggerbuffList = {}
	local triggerEffectList = {}
	local indexList = {}
	local effectStartIndex = 1
	local buffListCount = buffList == nil and 0 or #buffList
	local effectListCount = effectList == nil and 0 or #effectList

	local hasBuff = valueType == GE.EffectTriggerValueType.All or valueType == GE.EffectTriggerValueType.Buff
	if (hasBuff) then
		local listCount = buffListCount
		for i = 1, listCount do
			indexList[i] = i
		end
		effectStartIndex = listCount + 1
	end

	local hasEffect = valueType == GE.EffectTriggerValueType.All or valueType == GE.EffectTriggerValueType.Effect
	if (hasEffect) then
		local listCount = effectListCount
		for i = effectStartIndex, effectStartIndex + listCount do
			indexList[i] = i
		end
	end
	local triggerList = self:randomElements(indexList, count, effectCfgId)

	if (hasBuff) then
		local listIndex = 1
		for _, buffIndex in ipairs(triggerList) do
			if buffIndex <= buffListCount then
				triggerbuffList[listIndex] = buffList[buffIndex]
				listIndex = listIndex + 1
			end
		end
	else
		triggerbuffList = buffList
	end

	if (hasEffect) then
		local listIndex = 1
		for _, effectIndex in ipairs(triggerList) do
            if effectIndex > effectStartIndex then
                local offsetIndex = effectIndex - effectStartIndex
                if offsetIndex <= buffListCount then
                    triggerEffectList[listIndex] = effectList[offsetIndex]
                    listIndex = listIndex + 1
                end
            end
		end
	else
		triggerEffectList = effectList
	end

	return triggerbuffList, triggerEffectList
end

---获取逐个触发列表
---@param valueType EffectTriggerValueType 效果触发内容类型
---@param probability integer 概率
---@param count integer 最大触发数量
---@param buffList integer[] 需要检测的buff列表
---@param effectList integer[] 需要检测的effect列表
---@param effectCfgId integer? 当前检测效果id
---@return integer[], integer[] 触发的buff列表和触发的effect列表
function SkillManager:_getOneByOneTriggerList(valueType, probability, count, buffList, effectList, effectCfgId)
	local triggerbuffList = {}
	local triggerEffectList = {}
	local triggerCount = 0
	local battleMgr = BattleCore:getBattleMgr()
	local listIndex = 1
	if (buffList) then
		if (valueType == GE.EffectTriggerValueType.All or valueType == GE.EffectTriggerValueType.Buff) then
			for _, buffData in ipairs(buffList) do
				if (triggerCount >= count) then
					break
				end
				local randomValue = battleMgr:getRandomNum(1, 100, effectCfgId)
				if (randomValue <= probability) then
					triggerbuffList[listIndex] = buffData
					listIndex = listIndex + 1
					triggerCount = triggerCount + 1
				end
			end
		else
			triggerbuffList = buffList
		end
	end

	if (effectList) then
		listIndex = 1
		if (valueType == GE.EffectTriggerValueType.All or valueType == GE.EffectTriggerValueType.Effect) then
			for _, effectId in ipairs(effectList) do
				if (triggerCount >= count) then
					break
				end
				local randomValue = battleMgr:getRandomNum(1, 100, effectCfgId)
				if (randomValue <= probability) then
					triggerEffectList[listIndex] = effectId
					listIndex = listIndex + 1
					triggerCount = triggerCount + 1
				end
			end
		else
			triggerEffectList = effectList
		end
	end

	return triggerbuffList, triggerEffectList
end

---检测目标是否有护卫效果
---@param skillId integer
---@param targets integer[] 地格的idList
function SkillManager:checkGuardTarget(skillId, targets)
	local resultList = {}

	local skillConfig = nil
	if skillId then
		skillConfig = Config.GetSkillInfo(skillId)
	end

    if skillConfig == nil or skillConfig.attackAttriType ~= 1 or 
        skillConfig.atkCalculateType > GE.SkillCalculateType.AirDefense then
		return targets
	end

	local battleMgr = BattleCore:getBattleMgr()
	local roleMgr = BattleCore:getBattleRoleMgr()
	for i, blockId in ipairs(targets) do
		resultList[i] = blockId
		local block = battleMgr:getBlockById(blockId)
        local target = block:tryGetRole()
        if target then
            local hasGuard, curBuff = target:checkHasGuard()
            local newTarget = nil
            if hasGuard then
                local effectIds = curBuff.configData.effectId
                if effectIds then
                    for _, id in ipairs(effectIds) do
                        local effectData = Config.GetEffectInfo(id)
                        if effectData and effectData.effectAttriType == GE.SkillAffixType.guardTarget then
                            for _, v in ipairs(effectData.otherParam1) do
								if v == skillConfig.attackDamageType then
                                    local newRoleId = curBuff.sourceId
                                    if newRoleId ~= target.id then
                                        newTarget = roleMgr:getRole(newRoleId)
                                        if newTarget then
											local canDoAction = target:checkCanDoAction()
											if canDoAction then
                                                local roleId = target.id
                                                newTarget:setGuardRoleId(roleId)
                                                resultList[i] = newTarget.block.id
											end
                                        end
                                    end
									break
								end
							end
                        end
                    end
				end
            end
		end
	end

    return resultList
end

---检测所有条件
---@param conditions table 条件表数据
---@param sourceSkillId integer?
---@param source BattleRole
---@param target BattleRole? 目标
---@param targetList BattleBlock[]?
---@return boolean 条件是否达成
function SkillManager:checkConditions(conditions, source, target, targetList, sourceSkillId)
	local conditionHandler = BattleCore:getSkillConditionHandler()
    return conditionHandler:checkAllConditions(conditions, source, target, targetList, sourceSkillId)
end

function SkillManager:getSkillAffixHandler()
	return self.affixHandler
end

---@param pendingAffix pendingAffixData
function SkillManager:checkPendingAffix(pendingAffix)
	local buffList = pendingAffix.triggerBuffIds
	if buffList then
		self:checkAddBuff(buffList, pendingAffix.triggerConfig.buffCondition,
			pendingAffix.target, pendingAffix.source, pendingAffix.delay)
	else
		self:checkAffixData(pendingAffix.source, pendingAffix.target,
			pendingAffix.effectConfig, pendingAffix.isDoAffix, pendingAffix.delay)
	end
end

---@param source BattleRole
---@param target BattleRole?
---@param affixConfig EffectTable
---@param isDoAffix boolean?
---@param delay number?
function SkillManager:checkAffixData(source, target, affixConfig, isDoAffix, delay)
	if isDoAffix ~= false then
		self:doAffix(source, target, affixConfig, delay)
	else
		self:removeAffix(source, target, affixConfig, delay)
	end
end

---执行效果
---@param source BattleRole
---@param target BattleRole?
---@param affixConfig EffectTable
---@param delay number?
function SkillManager:doAffix(source, target, affixConfig, delay)
	self.affixHandler:doAffix(source, target, affixConfig, delay)
end

---取消效果
---@param source BattleRole
---@param target BattleRole?
---@param affixConfig EffectTable
---@param delay number?
function SkillManager:removeAffix(source, target, affixConfig, delay)
    self.affixHandler:removeAffix(source, target, affixConfig, delay)
end

---执行表现
---@param ... any
function SkillManager:doPerformance(...)
	return self.perfHandler:doPerformance(...)
end

---检查护卫表现
function SkillManager:checkProtectAction(...)
	return self.perfHandler:checkProtectAction(...)
end

---检查技能目标所能覆盖的地格数据
---@param blockRole BattleRole
---@param sourceRole BattleRole
---@param skillConfig SkillTable
---@return integer[]?
function SkillManager:GetBlockDataListInSkillRange(blockRole, sourceRole, skillConfig)
    local block = blockRole:getShowBlock()
	---@type integer[]?
	local blockIDList = nil
    blockIDList = self:GetBlockDataListInSkillRangeByBlock(block, sourceRole, skillConfig)
    return blockIDList
end

---检查技能目标所能二次覆盖的地格id列表(传入地格)
---@param block BattleBlock
---@param sourceRole BattleRole
---@param skillConfig SkillTable
---@return integer[]?
function SkillManager:GetBlockDataListInSkillRangeByBlock(block, sourceRole, skillConfig)
	local battleMgr = BattleCore:getBattleMgr()
	local map = battleMgr:getMap()
	---@type BlockData[]?
	local result = nil
	---@type integer[]?
	local blockIDList = nil
	local skillRangeType = skillConfig.rangeSelectType
	local isPass = self:checkBlockRoleCanBeSelect(skillConfig, sourceRole, block, false)
	if isPass then
		local skillEffectRange = self:GetSkillEffectRangeByRole(skillConfig, sourceRole)
		result = map:getDiffuseRange(skillRangeType, block, skillEffectRange)
	end
	if result then
		blockIDList = {}
		for i, v in ipairs(result) do
			blockIDList[i] = v.blockId
		end
	end
	return blockIDList
end

---检测当前角色是否可以被选中
---@param skillConfig SkillTable
---@param sourceRole BattleRole
---@param block BattleBlock
---@param isSelect boolean? 是否是一次覆盖阶段，选中阶段需要考虑技能预览等因素
---@return boolean
function SkillManager:checkBlockRoleCanBeSelect(skillConfig, sourceRole, block, isSelect)
	local battleMgr = BattleCore:getBattleMgr()
	local isPass = false
	local checkBlockRoleCanBeSelect = true
	local skillTargetHandle = BattleCore:getSkillTargetHandler()
	local blockRole = block and block:tryGetRole() or nil
	if (skillConfig.skillOperateType == GE.SkillOperateType.Enemy) then
		if blockRole then
			local isEnemyCamp = battleMgr:isEnemyCamp(sourceRole, blockRole)
			local canBeSelect = true
			if isEnemyCamp and isSelect ~= false then
				canBeSelect = battleMgr:compareRoleskillSelectState(blockRole, isEnemyCamp)
			end
			isPass = isEnemyCamp and canBeSelect
		end
	elseif (skillConfig.skillOperateType == GE.SkillOperateType.Friend) then
		if blockRole then
			local isEnemyCamp = battleMgr:isEnemyCamp(sourceRole, blockRole)
			local canBeSelect = true
			if not isEnemyCamp and isSelect ~= false then
				canBeSelect = battleMgr:compareRoleskillSelectState(blockRole, isEnemyCamp)
			end
			isPass = not isEnemyCamp and canBeSelect
		end
	elseif (skillConfig.skillOperateType == GE.SkillOperateType.FriendNoSelf) then
		if (blockRole and sourceRole.id ~= blockRole.id) then
			local isEnemyCamp = battleMgr:isEnemyCamp(sourceRole, blockRole)
			local canBeSelect = true
			if not isEnemyCamp and isSelect ~= false then
				canBeSelect = battleMgr:compareRoleskillSelectState(blockRole, isEnemyCamp)
			end
			isPass = not isEnemyCamp and canBeSelect
		end
	elseif (skillConfig.skillOperateType == GE.SkillOperateType.NonRoleBlock) then
		if not blockRole then
			isPass = true
			checkBlockRoleCanBeSelect = false
		end
	else
		isPass = true
		checkBlockRoleCanBeSelect = false
		BattleCore.ds("BattleManager:getSelectableTargets wrong SkillOperateType", skillConfig.skillOperateType)
	end
	--- 空中单位仅可被炮击类型攻击到
	if isPass and checkBlockRoleCanBeSelect and blockRole then
		if skillConfig.SiftCondition then
			local targetsList = skillTargetHandle:targetFilterList(sourceRole, { block }, skillConfig.SiftCondition)
			isPass = next(targetsList) ~= nil
		end
	end
	return isPass
end

---获取技能的一次选择范围的修正值
---@param skillConfig SkillTable
---@param role BattleRole
---@return integer[]
function SkillManager:GetSkillSelectRangeByRole(skillConfig, role)
    ---@type integer[]
    local r = {skillConfig.skillRange, 0}
    local exRange = 0
    local searchType = nil
    if skillConfig.skillType == GE.SkillType.Normal then
        searchType = GE.SkillRangeChangeType.Normal
    elseif skillConfig.skillType == GE.SkillType.Active then
        searchType = GE.SkillRangeChangeType.Skill
    end
    if searchType then
        exRange = role:getAdditionSkillSelectRangeNum(searchType)
    end
	local skillTagExRange = role:getAdditionSkillSelectRangeChangeBySkillTag(skillConfig.skillTag)
	exRange = exRange + skillTagExRange

    if exRange ~= 0 then
        local changeIndex = 1
        r[changeIndex] = math.max(r[changeIndex] + exRange, 0)
    end

    return r
end

---获取技能的二次范围的修正值
---@param skillConfig SkillTable
---@param role BattleRole
---@return integer[]
function SkillManager:GetSkillEffectRangeByRole(skillConfig, role)
	---@type integer[]
	local r = tablex.clone(skillConfig.effectRange)
	local exRange = 0
    local searchType = nil
    if skillConfig.skillType == GE.SkillType.Normal then
        searchType = GE.SkillRangeChangeType.Normal
    elseif skillConfig.skillType == GE.SkillType.Active then
        searchType = GE.SkillRangeChangeType.Skill
    end
    if searchType then
        exRange = role:getAdditionSkillCoverRangeNum(searchType)
    end

	if exRange ~= 0 then
		local changeIndex = skillConfig.skillOperateType == GE.SkillOperateType.Direction and 2 or 1
		r[changeIndex] = math.max(r[changeIndex] + exRange, 0)
	end

	return r
end

---检测鱼雷类技能是否可以攻击到目标
---@return BattleBlock?
function SkillManager:checkTorpedoSkillCanAttack(sourceBlock, endBlock)
	local lineBlock = nil
	local mapMar = BattleCore:getBattleMgr():getMap()
	local calculateLineList = mapMar:GetCalculateLine(sourceBlock, endBlock)
	for _, block in ipairs(calculateLineList) do
		if block:GetBlockCanBlockTorpedo() then
			lineBlock = block
			break
		end
	end

	return lineBlock
end

function SkillManager:getBuffHandler()
	return self.buffHandler
end

return SkillManager