local acMgr = AutoChessManager.instance()

--- 条件判定状态机
---@class ConditionChecker
local ConditionChecker = {}

---@class ConditionContext
---@field owner AutoChessEntity 当前操作者
---@field buffCaster AutoChessEntity buff释放者对象
---@field eventType AutoChessCombatEvent 事件类型
---@field skillDamageInfo AutoChessDamageInfo? 技能信息
---@field buffStack integer?


---@type table<AutoChessConditionType, fun(target:AutoChessEntity, objectTarget:AutoChessEntity?, cfg:AutoChessConditionTable, context:ConditionContext):boolean, boolean?>
ConditionChecker.handlers = {}

---@type table<AutoChessConditionType, string> 条件类型对应字符串
local conditionStr = {}

for k, v in pairs(GE.AutoChessConditionType) do
    conditionStr[v] = k
end

---@generic T
---@param leftValue T
---@param rightValue T
---@param compareType AutoChessCompareType
local function Compare(leftValue, rightValue, compareType)
    if compareType == GE.AutoChessCompareType.None then
        return true
    end
    if compareType == GE.AutoChessCompareType.Equal then
        return leftValue == rightValue
    elseif compareType == GE.AutoChessCompareType.NotEqual then
        return leftValue ~= rightValue
    elseif compareType == GE.AutoChessCompareType.Greater then
        return leftValue > rightValue
    elseif compareType == GE.AutoChessCompareType.GreaterEqual then
        return leftValue >= rightValue
    elseif compareType == GE.AutoChessCompareType.Less then
        return leftValue < rightValue
    elseif compareType == GE.AutoChessCompareType.LessEqual then
        return leftValue <= rightValue
    end
    return false
end


---@param targetType AutoChessConditionTargetType
---@param context ConditionContext 当前操作者
---@return AutoChessEntity[]?
local function GetTarget(targetType,context)

    if targetType == GE.AutoChessConditionTargetType.None then
       return nil
    end
    if targetType == GE.AutoChessConditionTargetType.Self then
        return {context.owner}
    elseif targetType == GE.AutoChessConditionTargetType.Actor then  ---技能发起方
        if context.skillDamageInfo == nil then
           return nil 
        end
        return {context.skillDamageInfo.caster}
    elseif targetType == GE.AutoChessConditionTargetType.Receiver then  ---技能作用对象
        if context.skillDamageInfo == nil then
           return nil 
        end
        return {context.skillDamageInfo.target}
    elseif targetType == GE.AutoChessConditionTargetType.BuffSource then
        return {context.buffCaster}
    elseif targetType == GE.AutoChessConditionTargetType.Source then
        if context.skillDamageInfo == nil then
           return nil 
        end
        return {context.skillDamageInfo.source}
    elseif targetType == GE.AutoChessConditionTargetType.AllEntity then
        return acMgr:GetAllEntity()
    end
    return nil
end

---@param targets AutoChessEntity[]
---@param conditionIds integer[]
---@param context ConditionContext
function ConditionChecker:FilterTargets(targets, conditionIds, context)
    if not targets or #targets == 0 then 
        return targets 
    end
    if not conditionIds or #conditionIds == 0 then
        return targets 
    end
    ---@type AutoChessConditionTable?
    local sortCfg = nil -- 记录排序条件，延迟到最后统一处理
    for i = 1, #conditionIds do
        local id = conditionIds[i]
        local cfg = Config.GetAutoChessConditionTable(id)
        if cfg == nil then
           return 
        end
        local fun = ConditionChecker.handlers[cfg.type]
        if fun == nil then
           return 
        end
        ---计算数组长度 不能用来处理
        if cfg.type == GE.AutoChessConditionType.Count then
            LuaLogger.es("count(数量检测) 条件绝对不能配置在流水线(targetFlow)中！打断执行。ConditionId:" .. id)
            return
        end
        if cfg.isSort == 0 then
            for j = #targets, 1, -1 do
                local target = targets[j]
                local objectTargets = GetTarget(cfg.conditionTarget, context)
                local objectTarget = context.owner
                if objectTargets ~= nil then
                    objectTarget = objectTargets[1]
                end
                local isSuccess = fun(target, objectTarget, cfg, context)
                if not isSuccess then
                   table.remove(targets, j) 
                end
            end
        else
            sortCfg = cfg
        end
    end
    ---排序
    if sortCfg ~= nil and #targets > 1 then
        local sortFun = ConditionChecker.handlers[sortCfg.type]
        if sortFun ~= nil then
            table.sort(targets, function(a, b)
                if a == b then 
                    return false 
                end 
                local isSuccess, isEqual = sortFun(a, b, sortCfg, context)
                if isEqual == false then
                    if sortCfg.compareType == GE.AutoChessCompareType.Less then
                        return not isSuccess
                    else
                        return isSuccess 
                    end
                end
                return a:GetUID() > b:GetUID()
            end)
        end
    end
end

---@param conditionId integer 
---@param owner AutoChessEntity Buff的拥有者
---@param buffCaster AutoChessEntity buff来源
---@param eventType AutoChessCombatEvent? 事件类型
---@param skillDamageInfo AutoChessDamageInfo? 技能信息
---@param buffStack integer?
---@return boolean
function ConditionChecker:Check(conditionId, owner, buffCaster, eventType, skillDamageInfo, buffStack)

    local cfg = Config.GetAutoChessConditionTable(conditionId)
    if cfg == nil then
       return false 
    end
    local type = cfg.type
    if type == nil then
        LuaLogger.es("该功能未实现 type:" .. type)
        return false
    end
    local fun = self.handlers[type]
    if fun == nil then
        LuaLogger.es("该Condition方法未实现 type:" .. type)
        return false
    end
    
    ---@type ConditionContext
    local context = {
        owner = owner,
        buffCaster = buffCaster,
        eventType = eventType,
        skillDamageInfo = skillDamageInfo,
        buffStack = buffStack
    }

    ---@type AutoChessEntity?
    local target = nil
    local targets = GetTarget(cfg.targetType, context)
    if targets ~= nil and #targets > 0 and cfg.targetFlow ~= nil then
        self:FilterTargets(targets,cfg.targetFlow, context) 
    end
    if targets ~= nil and #targets > 0 then
       target = targets[1] 
    end

    if target == nil then
        return false
    end
    if cfg.type == GE.AutoChessConditionType.Count then
       target = targets
    end


    local objectTarget = owner
    local targets = GetTarget(cfg.conditionTarget, context)
    if targets ~= nil and #targets > 0 and cfg.conditionTargetFlow ~= nil then
        self:FilterTargets(targets, cfg.conditionTargetFlow, context) 
    end
    if targets ~= nil and #targets > 0 then
       objectTarget = targets[1] 
    end
    if objectTarget == nil then
        objectTarget = owner
    end

    local isSuccess = fun(target, objectTarget, cfg, context)
    return isSuccess
end

---比较距离
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean isSuccess 是否满足条件,是否相等
---@return boolean isEqual 是否相等
ConditionChecker.handlers[GE.AutoChessConditionType.Distance] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false, false
    end
    if target == nil then
       return false, false
    end
    if objectTarget == nil then
       return false, false
    end

    if cfg.isSort == 1 then
        local dis1 = acMgr:GetEnitytDistance(context.owner:GetUID(), target :GetUID())
        local dis2 = acMgr:GetEnitytDistance(context.owner:GetUID(), objectTarget:GetUID())
        local res = Compare(dis1, dis2, cfg.compareType) 
        return res, dis1 == dis2
    end

    local condDis = cfg.params[1]
    if condDis == nil then
        return false, false
    end
   if condDis <= 0 then
        return true, false
    end
    local dis = acMgr:GetEnitytDistance(target:GetUID(), objectTarget:GetUID())
    if dis < 0 then
       return false, false
    end
    local res = Compare(dis, condDis, cfg.compareType)
    return res, dis == condDis
end


---比较HP百分比
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.HpRatio] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false, false
    end
    local condVal = cfg.params[1]
    if objectTarget ~= nil then
        local hp = objectTarget:GetHp()
        local hpMax = objectTarget:GetHpMax()
        condVal = hp / hpMax
    end
    local hp = target:GetHp()
    local hpMax = target:GetHpMax()
    local hpRatio = hp / hpMax
    local res = Compare(hpRatio, condVal, cfg.compareType)
    return res, hpRatio == condVal
end


---比较HP百分比
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.MpRatio] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false, false
    end
    local condVal = cfg.params[1]

    if objectTarget ~= nil then
        local mp = objectTarget:GetMp()
        local mpMax = objectTarget:GetMpMax()
        condVal = mp / mpMax
    end

    local mp = target:GetMp()
    local mpMax = target:GetMpMax()
    local mpRatio = mp / mpMax
    local res = Compare(mpRatio, condVal, cfg.compareType)
    return res, mpRatio == condVal
end

---比较属性值
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.Attribute] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false, false
    end
    local key = cfg.params[1]
    local condVal = cfg.params[2]

    if objectTarget ~= nil then
        condVal = objectTarget:GetAttribute(key)
    end
    local targetVal = target:GetAttribute(key)
    local res = Compare(targetVal, condVal, cfg.compareType)
    return res, targetVal == condVal
end


---是否拥有buff
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.HasBuff] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false 
    end

    local condVal = cfg.params[1]
    local hasBuff = target.buffControl:HasBuff(condVal)
    if cfg.compareType == GE.AutoChessCompareType.Equal then
        return hasBuff
    else
        return not hasBuff 
    end
end


---判断目标类型
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.TargetType] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false 
    end
    if target == nil then
        return false
    end
    local skillDamageInfo = context.skillDamageInfo
    local buffCaster = context.buffCaster
    if skillDamageInfo == nil then
        return false
    end
    local val = false
    ---@type int
    local condVal = cfg.params[1]
    ---1攻击方 2目标方, 3buff来源方, 4攻击方主人
    if condVal == 1 then        ---
        val = target == skillDamageInfo.caster 
    end
    if condVal == 2 then        ---
       val = target == skillDamageInfo.target 
    end
    if condVal == 3 then        ---buff 来源
       val = target == buffCaster
    end
    if condVal == 4 then        ---
       val = target == skillDamageInfo.source 
    end

    if cfg.compareType == GE.AutoChessCompareType.Equal then
       return val
    else
        return not val
    end
end

---判断事件类型
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.EventType] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false 
    end
    local eventType = context.eventType
    if eventType == nil then
        return false
    end
    local condVal = cfg.params[1]
    local val = condVal == eventType
    if cfg.compareType == GE.AutoChessCompareType.Equal then
       return val
    else
        return not val
    end
end

---判断伤害类型
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.DamageType] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false
    end
    local skillDamageInfo = context.skillDamageInfo
    if skillDamageInfo == nil then
       return false
    end

    local condVal = cfg.params[1]
    local skillCfg = Config.GetAutoChessSkillTable(skillDamageInfo.skillId)
    if skillCfg == nil then
       return false
    end
    local val = condVal == skillCfg.damageType
    if cfg.compareType == GE.AutoChessCompareType.Equal then
       return val
    else
        return not val
    end
end

---判断技能类型
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.SkillType] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false 
    end
    local skillDamageInfo = context.skillDamageInfo
    if skillDamageInfo == nil then
       return false 
    end

    local condVal = cfg.params[1]
    local skillCfg = Config.GetAutoChessSkillTable(skillDamageInfo.skillId)
    if skillCfg == nil then
       return false 
    end
    local val = condVal == skillCfg.skillType
    if cfg.compareType == GE.AutoChessCompareType.Equal then
       return val
    else
        return not val
    end
end


---检测目标职业
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.TargetClass] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false 
    end

    if target == nil then
       return false 
    end
    local condVal = cfg.params
    local id = target:GetID()
    local heroCfg = Config.GetAutoChessHeroTable(id)
    if heroCfg == nil then
       return false
    end
    local isHas = tablex.indexof(condVal, heroCfg.restraintType) ~= -1
    if cfg.compareType == GE.AutoChessCompareType.Equal then
       return isHas
    else
        return not isHas
    end
end

---是否在技能攻击范围内
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.SkillScope] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false 
    end
    if target == nil then
       return false
    end
    local skillDamageInfo = context.skillDamageInfo
    if skillDamageInfo == nil then
       return false 
    end
    if objectTarget == nil then
       return false 
    end

    local skillCfg = Config.GetAutoChessSkillTable(skillDamageInfo.skillId)
    if skillCfg == nil then
       return false 
    end

    local condVal = skillCfg.attackRange
    condVal = condVal * condVal
    local val = acMgr:GetEnitytSqrDistance(target:GetUID(), objectTarget:GetUID())
    local res = Compare(val, condVal, cfg.compareType)
    return res
end


---判断目标Mask
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.TargetMask] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false 
    end
    if target == nil then
       return false
    end
    local skillDamageInfo = context.skillDamageInfo
    if skillDamageInfo == nil then
       return false 
    end
    if objectTarget == nil then
       return false 
    end

    local searchMask = cfg.params[1]

    local isHas = acMgr:CheckSearchFilter(target, objectTarget, searchMask)
    
    if cfg.compareType == GE.AutoChessCompareType.Equal then
        return isHas
    else
        return not isHas
    end
end


---检测目标数量
---@param target AutoChessEntity
---@param objectTarget AutoChessEntity
---@param cfg AutoChessConditionTable
---@param context ConditionContext
---@return boolean issuccess 是否满足条件
ConditionChecker.handlers[GE.AutoChessConditionType.Count] = function(target, objectTarget, cfg, context)
    if cfg == nil then
       return false 
    end
    if cfg.isSort ~= 0 then
       return false 
    end
    
    if target == nil then
       return false 
    end

    if target[1] == nil then
       return false 
    end

    local count = #target
    local condVal = cfg.params[1]
    if objectTarget ~= nil and objectTarget[1] ~= nil then
        count = #objectTarget
    end
    local res = Compare(count, condVal, cfg.compareType)
    return res
end
return ConditionChecker