require "class"
---@class SkillAffixHandler
local SkillAffixHandler = class("SkillAffixHandler")
local BattleCore = require "BattleCore"


function SkillAffixHandler:ctor()
    self:_initAffixEvent()
end

---实例化
---@return SkillAffixHandler SkillAffixHandler
function SkillAffixHandler:instance()
    if (self._instance == nil) then
        self._instance = self:new()
    end
    return self._instance
end

---初始化效果事件
function SkillAffixHandler:_initAffixEvent()
    self._affixEvent = {
        [GE.SkillAffixType.ModifyAttrib] = self._modifyAttrib,
        [GE.SkillAffixType.ModifyRestraintRatio] = self._modifyRestraintRatio,
        [GE.SkillAffixType.ModifyTerrainRatio] = self._modifyTerrainRatio,
        [GE.SkillAffixType.ModifyAttribByOther] = self._modifyAttribByOther,
        [GE.SkillAffixType.ModifyHp] = self._modifyHp,
        [GE.SkillAffixType.ModifyHpToSetValue] = self._modifyHpToSetValue,
        [GE.SkillAffixType.ModifyHpByDamageValue] = self._modifyHpByDamageValue,
        [GE.SkillAffixType.ModifyTargetHpByBeDamageValue] = self._modifyTargetHpByBeDamageValue,
        [GE.SkillAffixType.MoveAgain] = self._moveAgain,
        [GE.SkillAffixType.ActionAgain] = self._actionAgain,
        [GE.SkillAffixType.ResetActionState] = self._resetActionstate,
        [GE.SkillAffixType.ImmuneEffect] = self._immuneEffect,
        [GE.SkillAffixType.ImmuneEffectTrigger] = self._immuneEffectTrigger,
        [GE.SkillAffixType.ImmuneBuff] = self._immuneBuff,
        [GE.SkillAffixType.ImmuneBuffEffect] = self._immuneBuffEffect,
        [GE.SkillAffixType.DoSkill] = self._doSkill,
        [GE.SkillAffixType.DoSkillOnTarget] = self._doSkillOnTarget,
        [GE.SkillAffixType.DispelBuff] = self._dispelBuff,
		[GE.SkillAffixType.StealBuff] = self._stealBuffFormTarget,
        [GE.SkillAffixType.DispelAndAddBuff] = self._dispelAndAddBuff,
        [GE.SkillAffixType.MoveCostChange] = self.changeMoveCost,
        [GE.SkillAffixType.OnlyFriendCanSelectRole] = self.changeSkillSelectState,
        [GE.SkillAffixType.HaloBuff] = self.setBlockEffect,
        [GE.SkillAffixType.repelOrZoomInTaget] = self.repelOrZoomInTaget,
        [GE.SkillAffixType.repelOrZoomInTagetByDir] = self.repelOrZoomInTagetByDir,
        [GE.SkillAffixType.repelOrZoomInTargetBySourceSkillDir] = self.repelOrZoomInTagetBySourceSelectDir,
        [GE.SkillAffixType.replaceActiveSkill] = self._changeReplaceActiveSkill,
        [GE.SkillAffixType.replacePassiveSkill] = self._replacePassiveSkill,
        [GE.SkillAffixType.additionalPassiveSkill] = self._additionalPassiveSkill,
        [GE.SkillAffixType.ReduceTargetSkillCDNum] = self._reduceSkillCD,
        [GE.SkillAffixType.ChangeTargetCurSkillCDNum] = self._changeCurSkillCD,
        [GE.SkillAffixType.ChangeSkillAmmo] = self._changeSkillAmmo,
        [GE.SkillAffixType.ChangeSkillSelectRange] = self._changeSkillSelectRange,
        [GE.SkillAffixType.ChangeSkillCoverRange] = self._changeSkillCoverRange,
        [GE.SkillAffixType.ChangeSkillSelectRangeBySkillTag] = self._changeSkillSelectRangeBySkillTag,
        [GE.SkillAffixType.CreateRole] = self._createRole,
        [GE.SkillAffixType.AddBuffRoundOffset] = self._addBuffRoundOffset,
        [GE.SkillAffixType.SetBuffRoundOffset] = self._setBuffRoundOffset,
        [GE.SkillAffixType.KeepBuffRoundByTagOffset] = self._keepBuffRoundByTagOffset,
    }


    self._removeAffixEvent = {
        -- [GE.SkillAffixType.ModifyAttrib] = self._removeModifyAttrib,
        -- [GE.SkillAffixType.MoveCostChange] = self.removeChangeMoveCost,
        [GE.SkillAffixType.OnlyFriendCanSelectRole] = self.removeChangeSkillSelectState,
        [GE.SkillAffixType.HaloBuff] = self.removeBlockEffect
    }
end

---执行效果
---@param target BattleRole? 目标
---@param affixConfig EffectTable 效果数据
---@param delay table 表现延迟
function SkillAffixHandler:doAffix(source, target, affixConfig, delay)
    if not GV.IsServer then
        BattleCore.ds("SkillAffixHandler:doAffix", affixConfig.id, affixConfig.effectAttriType)
    end
    if (not affixConfig) then
        return
    end
    local type = affixConfig.effectAttriType

    local func = self._affixEvent[type]
    if func then
        func(self, source, target, affixConfig, delay)
    end
end

---取消效果
---@param source BattleRole
---@param target BattleRole? 目标
---@param affixConfig EffectTable 效果数据
---@param delay number? 表现延迟
function SkillAffixHandler:removeAffix(source, target, affixConfig, delay)
    if (not affixConfig) then
        return
    end
    local type = affixConfig.effectAttriType

    local f = self._removeAffixEvent[type]
    if f then
        f(self, source, target, affixConfig, delay)
    end
end

---尝试获取上层参数
---@param value any 当前参数
---@param upperData table 上层数据
---@return any
function SkillAffixHandler:_tryGetUpperParam(value, upperData)
    if (not value) then
        return nil
    end
    local upperParam = upperData[value]
    if (upperParam) then
        return upperParam
    end
    return value
end

---检查免疫
---@param obj BattleRole
---@param tags integer[]
function SkillAffixHandler:_checkAffixImmune(obj, tags)
    if (tags and obj) then
        for _, tag in ipairs(tags) do
            if (self:_checkImmune(obj, tag)) then
                return true
            end
        end
    end
    return false
end

---检查免疫
---@param obj BattleRole
---@param tag integer
---@return boolean
function SkillAffixHandler:_checkImmune(obj, tag)
    if (obj.getImmuneList) then
        local immuneList = obj:getImmuneList(GE.SkillAffixType.ImmuneEffect)
        if (tablex.contains(immuneList, tag)) then
            return true
        end
    end
    return false
end

---affixEvent--------------------------------------------------------------------------------------

---调整属性(目前只有buff使用该效果)
---@param source Buff 效果源
---@param target BattleRole 目标
---@param affixConfig EffectTable 效果表数据
---@param delay number? 表现延迟
function SkillAffixHandler:_modifyAttrib(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local attrib = affixConfig.otherParam1[1]
    local attribId = GE.AttribType[attrib]
    local isAdd = affixConfig.isAdd
    local adjustValue = affixConfig.effectValue
    if (affixConfig.effectAddType == 1) then
        attrib = string.format("%sPB", attrib)
    else
        attrib = string.format("%sB", attrib)
    end
    if (isAdd == 2) then
        adjustValue = -adjustValue
        -- elseif (isAdd == 3) then
        -- 	attrib = string.format("%sOverride", attrib)
    end
    if not GV.IsServer then
        BattleCore.ds("SkillAffixHandler:_modifyAttrib setExAttrib", attrib, adjustValue)
    end
    source:setExAttrib(attrib, adjustValue)

    if not attribId then
        BattleCore.es("SkillAffixHandler:_modifyAttrib setExAttrib can not find", attrib)
    end
end

---调整舰种克制修正属性(目前只有buff使用该效果)
---@param source Buff 效果源
---@param target BattleRole 目标
---@param affixConfig EffectTable 效果表数据
---@param delay number? 表现延迟
function SkillAffixHandler:_modifyRestraintRatio(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    source:setRestraintRatioList(affixConfig.otherParam1)
end

---调整地形修正属性(目前只有buff使用该效果)
---@param source Buff 效果源
---@param target BattleRole 目标
---@param affixConfig EffectTable 效果表数据
---@param delay number? 表现延迟
function SkillAffixHandler:_modifyTerrainRatio(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local offsetValue = affixConfig.otherParam1[1]
    source:setTerrainRatioList(affixConfig.otherParam2, offsetValue)
end

---基于某项属性，调整另一属性(目前只有buff使用该效果)
---@param source Buff 效果源
---@param target BattleRole 目标
---@param affixConfig EffectTable 效果表数据
---@param delay number? 表现延迟
function SkillAffixHandler:_modifyAttribByOther(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local attrib = GE.AttribType[affixConfig.otherParam1[1]]
    local sourceAttrib = GE.AttribType[affixConfig.otherParam2[1]]
    local isAdd = affixConfig.isAdd
    local adjustValue = affixConfig.effectValue
    if (isAdd == 2) then
        adjustValue = -adjustValue
    end
    if not GV.IsServer then
        BattleCore.ds("SkillAffixHandler:_modifyAttribByOther", attrib, sourceAttrib, adjustValue)
    end
    source:setFormOtherAttribData(attrib, sourceAttrib, adjustValue)
end

---修改生命值
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay integer
function SkillAffixHandler:_modifyHp(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end

    local dataType = affixConfig.otherParam1[1]
    local attribType = affixConfig.otherParam2[1]

    ---@type BattleRole
    local affixSource = source     --效果添加对象

    local value = 0
    local offsetNum = affixConfig.effectAddType == 1 and source:getAttrib(GE.AttribType.BaseDamageRate, nil) or 1
    if (dataType == 1) then
        if (target.getAttrib) then
            value = target:getAttrib(GE.AttribType[attribType]) * affixConfig.effectValue
        else
            LuaLogger("SkillAffixHandler:_modifyHp 无法获取目标属性", target)
        end
    else
        if (affixSource.getAttrib) then
            value = affixSource:getAttrib(GE.AttribType[attribType]) * affixConfig.effectValue
        else
            LuaLogger("SkillAffixHandler:_modifyHp 无法获取来源属性", affixSource)
        end
    end
    value = value * offsetNum
    local isRepair = affixConfig.isAdd == 1
    if value > 0 then
        if isRepair then
            local repairAddition = 1
            local radio1 = source:getAttrib(GE.AttribType.HealthRatio, nil)
            local radio2 = target:getAttrib(GE.AttribType.BeHealthRatio, nil)
            repairAddition = 1 + radio1 + radio2
            repairAddition = math.max(repairAddition, 0)
            value = value * repairAddition
        else
            local modifyHpRatio = source:getAttrib(GE.AttribType.ModifyHpRatio, nil)
            value = value * modifyHpRatio
        end
    end
    ---@type HitData
    local hitData = {}
    hitData.dmgValue = value
    hitData.singleBulletDmg = value
    hitData.hitNumCorrect = 1
    hitData.bulletNum = 0
    hitData.isCrit = false
    hitData.effectTag = affixConfig.immuneType
    target:modifyHp(value, hitData, affixSource, affixConfig.isAdd == 1, 1, delay)
end

---使用技能
---@param source BattleRole
---@param target BattleRole
function SkillAffixHandler:_doSkill(source, target, affixConfig, delay)
    if (not source) then
        return
    end
    if (self:_checkAffixImmune(source, affixConfig.immuneType)) then
        return
    end
    local skillId = affixConfig.otherParam1[1]
    local canDoAction = source:checkCanDoAction()
    if canDoAction then
        local targetBlock = target:getShowBlock()
        local report = BattleCore:getBattleMgr():getReporter()
        report:packStep()
        source:faceToBlock(targetBlock, true)
        report:packStep()
        source:doSkill(skillId, {targetBlock})
    end
end

---对目标使用技能
---@param source BattleRole
---@param target BattleRole
function SkillAffixHandler:_doSkillOnTarget(source, target, affixConfig, delay)
    if (not source or not target) then
        return
    end
    if (self:_checkAffixImmune(source, affixConfig.immuneType)) then
        return
    end
    local skillId = affixConfig.otherParam1[1]
    -- source:doSkill(skillId, target)
    local canDoAction = source:checkCanDoAction()
    if canDoAction then
        local targetBlock = target:getShowBlock()
        local report = BattleCore:getBattleMgr():getReporter()
        report:packStep()
        target:faceToBlock(targetBlock, true)
        report:packStep()
        target:doSkill(skillId, {targetBlock})
    end
end

---再移动
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_moveAgain(source, target, affixConfig, delay)
    if (not source) then
        return
    end
    if (self:_checkAffixImmune(source, affixConfig.immuneType)) then
        return
    end
    local moveAgainType = affixConfig.otherParam1[1]
    local movePower = nil
    local param2 = affixConfig.otherParam2
    if moveAgainType == GE.MovePowerType.Fixed and param2 ~= nil then
        movePower = param2[1] or 0
    end
    source:moveAgain(moveAgainType, movePower)
end

---再行动
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_actionAgain(source, target, affixConfig, delay)
    if (not source) then
        return
    end
    if (self:_checkAffixImmune(source, affixConfig.immuneType)) then
        return
    end
    local actionAgainType = affixConfig.otherParam1[1]
    local movePower = nil
    local param2 = affixConfig.otherParam2
    if actionAgainType == GE.MovePowerType.Fixed and param2 ~= nil then
        movePower = param2[1] or 0
    end
    source:actionAgain(actionAgainType, movePower)
end

---重置行动状态
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_resetActionstate(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local roleMgr = BattleCore:getBattleRoleMgr()
    roleMgr:removeRoleInCompleteActionList(target)
end

---驱散Buff
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_dispelBuff(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local buffTags = affixConfig.otherParam1
    local dispelCnt = affixConfig.otherParam2[1]
    target:dispelBuff(buffTags, dispelCnt)
end

---恢复HP到指定数值
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_modifyHpToSetValue(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local dataType = affixConfig.otherParam1[1]
    local configValue = affixConfig.otherParam1[2]

    ---@type BattleRole
    local affixSource = source --效果添加对象

	local isRepair = affixConfig.isAdd == 1
    local value = 0
    local targetHp = 0
    local curHp = target:getAttrib(GE.AttribType.Hp)
    if (dataType == 1) then
        local maxHp = target:getAttrib(GE.AttribType.MaxHp)
        targetHp = maxHp * configValue
    else
        targetHp = configValue
    end
    if isRepair and targetHp > curHp then
        value = targetHp - curHp
	elseif isRepair == false and curHp > targetHp then
		value = curHp - targetHp
    end
    ---@type HitData
    local hitData = {}
    hitData.dmgValue = value
    hitData.effectTag = affixConfig.immuneType
    target:modifyHp(value, hitData, affixSource, isRepair, 1, delay)
end

---依据造成的伤害恢复HP
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_modifyHpByDamageValue(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local offsetValue = affixConfig.otherParam1[1]

	local isRepair = affixConfig.isAdd == 1
    local value = 0
    local damageValue = source:getDamageValue()
    local v1 = damageValue * offsetValue
    local repairAddition = 1
    if damageValue > 0 and isRepair then
        local radio1 = source:getAttrib(GE.AttribType.HealthRatio, nil)
        local radio2 = target:getAttrib(GE.AttribType.BeHealthRatio, nil)
        repairAddition = 1 + radio1 + radio2
        repairAddition = math.max(repairAddition, 0)
        value = v1 * repairAddition
    end
    value = math.floor(math.max(value, 0))
    ---@type HitData
    local hitData = {}
    hitData.dmgValue = value
    hitData.effectTag = affixConfig.immuneType
    target:modifyHp(value, hitData, source, isRepair, 1, delay)
end

---依据受到的伤害修改目标HP
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_modifyTargetHpByBeDamageValue(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local offsetValue = affixConfig.otherParam1[1]

    local isRepair = affixConfig.isAdd == 1
    local value = 0
    local beDamageValue = source:getBeDamagedValue()
    local v1 = beDamageValue * offsetValue
    local repairAddition = 1
    if beDamageValue > 0 and isRepair then
        local radio1 = source:getAttrib(GE.AttribType.HealthRatio, nil)
        local radio2 = target:getAttrib(GE.AttribType.BeHealthRatio, nil)
        repairAddition = 1 + radio1 + radio2
        repairAddition = math.max(repairAddition, 0)
        v1 = v1 * repairAddition
    end
    value = math.floor(math.max(v1, 0))
    ---@type HitData
    local hitData = {}
    hitData.dmgValue = value
    hitData.effectTag = affixConfig.immuneType
    target:modifyHp(value, hitData, source, isRepair, 1, delay)
end

---窃取目标的buff
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_stealBuffFormTarget(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local tags = affixConfig.otherParam1
    local num = affixConfig.otherParam2[1]

    ---@type BattleRole
    local affixSource = source --效果添加对象

    local targetBuffController = target:getBuffController()
	local sourceBuffController = affixSource:getBuffController()
	local buffList = targetBuffController:getBuffsByTags(tags)
	for _, buff in ipairs(buffList) do
		sourceBuffController:addBuff(buff, nil)
	end
    target:dispelBuff(tags, num)
end

---转化对应类型的buff
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_dispelAndAddBuff(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local tags = affixConfig.otherParam1[1]
    local num = affixConfig.otherParam1[2]
    local buffId = affixConfig.otherParam2

    local skillMgr = BattleCore:getSkillMgr()
    local targetBuffController = target:getBuffController()
	-- local sourceBuffController = affixSource:getBuffController()
	local buffList = targetBuffController:getBuffsByTags(tags)
    local buffCount = #buffList
    num = math.min(buffCount, num)
    if num <= 0 then
        return
    end
    target:dispelBuff(tags, num, delay)
    local triggerbuffList, triggerEffectList = skillMgr:getBuffOrEffectList(GE.EffectTriggerValueType.Buff,
        GE.EffectTriggerMethodType.Draw,
        100, nil, buffId, num)
    skillMgr:checkAddBuff(triggerbuffList, {}, target, source, delay)
end

---改变移动消耗
---@param source Buff
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:changeMoveCost(source, target, affixConfig, delay)
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local param1 = affixConfig.otherParam1
    local param2 = affixConfig.otherParam2
    for i, v in ipairs(param1) do
        local terrainId = v
        local offset = param2[i]
        source:setMoveCostOffsetDic(terrainId, offset)
    end
end

---设置目标的可被选中的状态
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:changeSkillSelectState(source, target, affixConfig, delay)
    -- local param1 = tableData.otherParam1
    -- local param2 = tableData.otherParam2
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local state = GE.SkillSelectType.None
    if affixConfig.otherParam1 then
        state = affixConfig.otherParam1[1] or GE.SkillSelectType.None
    end
    target:setSkilSelecctState(state)
end

---在地格上设置effect
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:setBlockEffect(source, target, affixConfig, delay)
    local param1 = affixConfig.otherParam1
    local param2 = affixConfig.otherParam2
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()
    local roleId = target.id
    -- mapMgr:removeBlockEffectGroup(roleId)

    local nowBlock = target:getShowBlock()
    local blocks = mapMgr:getDiffuseRange(param1[1], nowBlock, {param1[2], 0})
    local blockIdList = {}
    for i, v in ipairs(blocks) do
        local blockId = v.blockId
        blockIdList[i] = blockId
    end
    mapMgr:setBlockEffectGroup(roleId, affixConfig.id, blockIdList, param2)
end

---在地格上设置effect
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:setBlockEffectByWayPath(source, target, affixConfig, delay)
    local param1 = affixConfig.otherParam1
    local param2 = affixConfig.otherParam2
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()

    local blocks = target._waypointList
    for _, bolckId in ipairs(blocks) do
        local block = mapMgr:getBlockById(bolckId)
        block:setEffectGroup(param2, source.id)
    end
end

---击退或拉近目标
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:repelOrZoomInTaget(source, target, affixConfig, delay)
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end

    ---触发防卫的角色不会被击退
    if target == nil or target:getGuardRoleId() ~= nil then
        return
    end

    local param1 = affixConfig.otherParam1[1]
    local changeOffset = affixConfig.isAdd == 1 and 1 or -1

    local sourceBlock = source:getShowBlock()
    local targetBlock = target:getShowBlock()
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()

    local colDir = 0
    local rowDir = 0

    local col = targetBlock.col - sourceBlock.col
    local row = targetBlock.row - sourceBlock.row
    if col ~= 0 then
        local num = col > 0 and 1 or -1
        colDir = num * changeOffset
    end
    if row ~= 0 then
        local num = row > 0 and 1 or -1
        rowDir = num * changeOffset
    end

    local finalBlock = targetBlock
    local path = {}
    path[1] = targetBlock.id
    for i = 1, param1 do
        local newCol = colDir * i + targetBlock.col
        local newRow = rowDir * i + targetBlock.row
        local newBlock = mapMgr:getBlock(newCol, newRow)
        if newBlock and newBlock.roleId == nil then
            local moveCost = mapMgr:getBlockMoveCost(newBlock, target.roleConfig.moveType)
            if moveCost < 99 then
                path[#path + 1] = newBlock.id
                finalBlock = newBlock
            else
                break
            end
        else
            break
        end
    end
    target:moveByOther(finalBlock, path, delay)
end

---击退或拉近目标
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:repelOrZoomInTagetByDir(source, target, affixConfig, delay)
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end

    ---触发防卫的角色不会被击退
    if target == nil or target:getGuardRoleId() ~= nil then
        return
    end
    local param1 = affixConfig.otherParam1[1]
    local param2 = affixConfig.otherParam2[1]
    local changeOffset = affixConfig.isAdd == 1 and 1 or -1

    local targetBlock = target:getShowBlock()
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()

    local colDir = 0
    local rowDir = 0
    if param2 == 1 then
        colDir = changeOffset
    else
        rowDir = changeOffset
    end

    local finalBlock = targetBlock
    local path = {}
    path[1] = targetBlock.id
    for i = 1, param1 do
        local newCol = colDir * i + targetBlock.col
        local newRow = rowDir * i + targetBlock.row
        local newBlock = mapMgr:getBlock(newCol, newRow)
        if newBlock and newBlock.roleId == nil then
            local moveCost = mapMgr:getBlockMoveCost(newBlock, target.roleConfig.moveType)
            if moveCost < 99 then
                path[#path + 1] = newBlock.id
                finalBlock = newBlock
            else
                break
            end
        else
            break
        end
    end
    target:moveByOther(finalBlock, path, delay)
end

---击退或拉近目标,通过source释放技能的格子确定方向
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:repelOrZoomInTagetBySourceSelectDir(source, target, affixConfig, delay)
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end

    ---触发防卫的角色不会被击退
    if target == nil or target:getGuardRoleId() ~= nil then
        return
    end
    local param1 = affixConfig.otherParam1[1]
    local changeOffset = affixConfig.isAdd == 1 and 1 or -1

    local targetBlock = target:getShowBlock()
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()

    local skillDir = source:getSkillDir()
    if skillDir == nil then
        return
    end

    local colDir = changeOffset * skillDir[1]
    local rowDir = changeOffset * skillDir[2]

    local finalBlock = targetBlock
    local path = {}
    path[1] = targetBlock.id
    for i = 1, param1 do
        local newCol = colDir * i + targetBlock.col
        local newRow = rowDir * i + targetBlock.row
        local newBlock = mapMgr:getBlock(newCol, newRow)
        if newBlock and newBlock.roleId == nil then
            local moveCost = mapMgr:getBlockMoveCost(newBlock, target.roleConfig.moveType)
            if moveCost < 99 then
                path[#path + 1] = newBlock.id
                finalBlock = newBlock
            else
                break
            end
        else
            break
        end
    end
    target:moveByOther(finalBlock, path, delay)
end

---替换主动技能
---@param source Buff
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_changeReplaceActiveSkill(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local param1 = affixConfig.otherParam1
    local param2 = affixConfig.otherParam2
    local list = {}

    for i, v in ipairs(param1) do
        local replaceSkillId = param2[i]
        if replaceSkillId == nil then
            break
        end
        list[v] = replaceSkillId
    end

    source:setReplaceActiveSkillList(list)
end

---替换被动技能
---@param source Buff
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_replacePassiveSkill(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local param1 = affixConfig.otherParam1
    local param2 = affixConfig.otherParam2
    local list = {}

    for i, v in ipairs(param1) do
        local replaceSkillId = param2[i]
        if replaceSkillId == nil then
            break
        end
        list[v] = replaceSkillId
    end

    source:setReplacePassiveSkillList(list)
end

---添加被动技能
---@param source Buff
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_additionalPassiveSkill(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local list = affixConfig.otherParam1
    source:setAdditionalPassiveSkillList(list)
end

---改变当前技能CD
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_changeCurSkillCD(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local param2 = affixConfig.otherParam2
    local exceptSkillList = {}
    if param2 then
        for _, skillId in ipairs(param2) do
            exceptSkillList[skillId] = 1
        end
    end
    local skillId = target.selectedSkill
    if skillId == nil then
        BattleCore.ds("没找到当前使用的技能")
        return
    end
    local param1 = affixConfig.otherParam1[1]
    local isAdd = affixConfig.isAdd == 1
    local offsetNum = isAdd and 1 or -1
    local changeNum = param1 * offsetNum
    local skillConig = Config.GetSkillInfo(skillId)
    local isPass = true
    if skillConig and skillConig.skillTag then
        for _, tag in ipairs(skillConig.skillTag) do
            if exceptSkillList[tag] then
                isPass = false
                break
            end
        end
    end

    if isPass then
        target:dealSkillCDBySkillID(skillId, changeNum)
    end
end

---减少所有技能CD
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_reduceSkillCD(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local param2 = affixConfig.otherParam2
    local exceptSkillList = {}
    if param2 then
        for _, skillId in ipairs(param2) do
            exceptSkillList[skillId] = 1
        end
    end
    local skillList = target:getAllInCDSkill()
    local param1 = affixConfig.otherParam1[1]
    local offsetNum = -1
    local changeNum = param1 * offsetNum

    for skillId, _ in pairs(skillList) do
        local skillConig = Config.GetSkillInfo(skillId)
        local isPass = true
        if skillConig and skillConig.skillTag then
            for _, tag in ipairs(skillConig.skillTag) do
                if exceptSkillList[tag] then
                    isPass = false
                    break
                end
            end
        end

        if isPass then
            target:dealSkillCDBySkillID(skillId, changeNum)
        end
    end
end

---改变技能弹药量
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_changeSkillAmmo(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local param2 = affixConfig.otherParam2
    local isAdd = affixConfig.isAdd == 1
    local exceptSkillList = {}
    if param2 then
        for _, skillId in ipairs(param2) do
            exceptSkillList[skillId] = 1
        end
    end
    local skillList = target:getSkillAmmoUsedList()
    local param1 = affixConfig.otherParam1[1]
    local offsetNum = isAdd and 1 or -1
    local changeNum = param1 * offsetNum

    for skillId, _ in pairs(skillList) do
        local skillConig = Config.GetSkillInfo(skillId)
        local isPass = true
        if skillConig and skillConig.skillTag then
            for _, tag in ipairs(skillConig.skillTag) do
                if exceptSkillList[tag] then
                    isPass = false
                    break
                end
            end
        end

        if isPass then
            target:setSkillAmmoUsedNum(skillId, changeNum)
        end
    end
end

---改变技能覆盖范围
---@param source Buff
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_changeSkillCoverRange(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local param2 = affixConfig.otherParam2[1]
    local isAdd = affixConfig.isAdd == 1
    local param1 = affixConfig.otherParam1[1]
    local offsetNum = isAdd and 1 or -1
    local changeNum = param2 * offsetNum

    local changeTypeList = {}
    if param1 == GE.SkillRangeChangeType.All then
        changeTypeList[1] = GE.SkillRangeChangeType.Normal
        changeTypeList[2] = GE.SkillRangeChangeType.Skill
    else
        changeTypeList[1] = param1
    end

    for _, value in ipairs(changeTypeList) do
        source:setSkillCoverRangeChangeList(value, changeNum)
    end
end

---改变技能选择范围
---@param source Buff
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_changeSkillSelectRange(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local param2 = affixConfig.otherParam2[1]
    local isAdd = affixConfig.isAdd == 1
    local param1 = affixConfig.otherParam1[1]
    local offsetNum = isAdd and 1 or -1
    local changeNum = param2 * offsetNum

    local changeTypeList = {}
    if param1 == GE.SkillRangeChangeType.All then
        changeTypeList[1] = GE.SkillRangeChangeType.Normal
        changeTypeList[2] = GE.SkillRangeChangeType.Skill
    else
        changeTypeList[1] = param1
    end

    for _, value in ipairs(changeTypeList) do
        source:setSkillSelectRangeChangeList(value, changeNum)
    end
end

---根据技能标签改变技能选择范围
---@param source Buff
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_changeSkillSelectRangeBySkillTag(source, target, affixConfig, delay)
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local param2 = affixConfig.otherParam2[1]
    local isAdd = affixConfig.isAdd == 1
    local offsetNum = isAdd and 1 or -1
    local changeNum = param2 * offsetNum

    local changeTypeList = affixConfig.otherParam1

    for _, value in ipairs(changeTypeList) do
        source:setSkillSelectRangeChangeBySkillTag(value, changeNum)
    end
end

---创建角色（召唤机制）
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_createRole(source, target, affixConfig, delay)
    local battleMgr = BattleCore:getBattleMgr()
    local roleMgr = battleMgr:getRoleManager()
    local block = nil
    if target then
        block = target:getShowBlock()
    else
        block = source:getSkillTargetBlock() or source:getShowBlock()
    end
    local mapMgr = battleMgr:getMap()
    local roleCfgId = affixConfig.otherParam1[1]
    local roleCfg = Config.GetMonsterInfo(roleCfgId)
    if not roleCfg then
        return
    end
    local attribList = affixConfig.otherParam2
    if not attribList or next(attribList) == nil then
        return
    end
    local limitNum = affixConfig.otherParam1[2] or math.huge
    local effectDataId = affixConfig.id
    local hasSummonRoleList = battleMgr:GetSummonRoleDataByEffectId(effectDataId)
    local listCount = hasSummonRoleList and #hasSummonRoleList or 0
    if listCount >= limitNum then
        local removeRoleCount = listCount - limitNum + 1
        for i = 1, removeRoleCount do
            local waitRemoveData = hasSummonRoleList[i]
            local removeRoleId = waitRemoveData[1]
            local role = roleMgr:getRole(removeRoleId)
            if role then
                role:RemoveSelf(nil, 0)
            end
        end
    end
    local monsterConfig = Config.GetMonsterInfo(roleCfgId)
    local attribValueList = battleMgr:SetBaseAttribByList(attribList, source, monsterConfig)
    local noOneBlock = mapMgr:getNearsetNoOneBlockByBlock(block, roleCfg.moveType)
    if not noOneBlock then
        BattleCore.es("未找到空地格，无法召唤")
        return
    end
    local _baseMaxHp = attribValueList[GE.AttribType.MaxHp]
    ---@type LevelRoleData
    local data = {
        block = noOneBlock,
        camp = source.camp,
        cid = roleCfgId,
        isMonster = true,
        level = source.level,
        showLevel = source.showLevel,
        direction = source.direction,
        delay = 0,
        group = source.groupId,
        baseMaxHp = _baseMaxHp,
    }
    local role = roleMgr:createRole(data)
    for key, value in pairs(attribValueList) do
        role:setBaseAttrib(key, value)
    end
    role:SetSummonEffectId(effectDataId)
    battleMgr:SetSummonRoleData(effectDataId, role.id, attribValueList)
    role:checkInitEffects()
end

---被添加buff时的回合数修正
---@param source Buff
---@param affixConfig EffectTable
function SkillAffixHandler:_addBuffRoundOffset(source, target, affixConfig, delay)
    local param1 = affixConfig.otherParam1
    local param2 = affixConfig.otherParam2[1]
    for _, value in ipairs(param1) do
        source:setAddBuffRoundOffsetDic(value, param2)
    end
end

---为其他角色添加buff的回合数修正
---@param source Buff
---@param affixConfig EffectTable
function SkillAffixHandler:_setBuffRoundOffset(source, target, affixConfig, delay)
    local param1 = affixConfig.otherParam1
    local param2 = affixConfig.otherParam2[1]
    for _, value in ipairs(param1) do
        source:setSetBuffRoundOffsetDic(value, param2)
    end
end

---保持特定标签的buff回合数不变
---@param source Buff
---@param affixConfig EffectTable
function SkillAffixHandler:_keepBuffRoundByTagOffset(source, target, affixConfig, delay)
    local param1 = affixConfig.otherParam1
    for _, value in ipairs(param1) do
        source:setKeepBuffRoundDic(value)
    end
end

-------------------取消效果列表----------------------

---取消技能目标限制
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:removeChangeSkillSelectState(source, target, affixConfig, delay)
    -- local param1 = tableData.otherParam1
    -- local param2 = tableData.otherParam2
    local state = GE.SkillSelectType.None
    target:setSkilSelecctState(state)
end

---取消光环设置的地格effect
---@param source BattleRole
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:removeBlockEffect(source, target, affixConfig, delay)
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()
    local roleId = target.id
    mapMgr:removeBlockEffectGroup(roleId, affixConfig.id)
end

---region 检查免疫列表，该效果source均为buff----------------------

---免疫效果
---@param source Buff
---@param target BattleRole 拥有该buff的角色
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_immuneEffect(source, target, affixConfig, delay)
    if not GV.IsServer then
        BattleCore.ds("SkillAffixHandler:_immuneEffect")
    end
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local immuneList = affixConfig.otherParam1
    source:setImmuneList(GE.SkillAffixType.ImmuneEffect, immuneList)
end

---免疫效果触发器
---@param source Buff
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_immuneEffectTrigger(source, target, affixConfig, delay)
    if not GV.IsServer then
        BattleCore.ds("SkillAffixHandler:_immuneEffectTrigger")
    end
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local immuneList = affixConfig.otherParam1
    source:setImmuneList(GE.SkillAffixType.ImmuneEffectTrigger, immuneList)
end

---免疫Buff添加
---@param source Buff
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_immuneBuff(source, target, affixConfig, delay)
    if not GV.IsServer then
        BattleCore.ds("SkillAffixHandler:_immuneBuff")
    end
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local immuneList = affixConfig.otherParam1
    source:setImmuneList(GE.SkillAffixType.ImmuneBuff, immuneList)
end

---免疫Buff效果
---@param source Buff
---@param target BattleRole
---@param affixConfig EffectTable
---@param delay any
function SkillAffixHandler:_immuneBuffEffect(source, target, affixConfig, delay)
    if not GV.IsServer then
        BattleCore.ds("SkillAffixHandler:_immuneBuffEffect")
    end
    if (not target) then
        return
    end
    if (self:_checkAffixImmune(target, affixConfig.immuneType)) then
        return
    end
    local immuneList = affixConfig.otherParam1
    source:setImmuneList(GE.SkillAffixType.ImmuneBuffEffect, immuneList)
    target:refreshHaloBuff()
    target:updateAttributeBaseValue()
    target:updateAttributeTotalValue()
end

---endregion ------------------------------------------------

return SkillAffixHandler
