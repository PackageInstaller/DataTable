
local acMgr = AutoChessManager.instance()
local ConditionChecker = require("ConditionChecker")

-- 伤害信息结构
---@class DamageInfo
---@field skillId integer 技能 ID
---@field damageType integer 伤害类型
---@field defaultVal number 基础伤害
---@field damageVal number 固定加成伤害
---@field damageAddPercentage number 伤害加成系数 (例如 0.1 表示 10%)
---@field finalVal number (计算后的最终伤害)

---@class ModifierBase
local ModifiersBase = class("ModifierBase")



--- 初始化修饰器
---@param id integer 修饰器 ID
---@param buff AutoChessBuff 挂载此 Modifier 的 Buff 容器
function ModifiersBase:Init(id, buff)
    self.id = id
    self.buff = buff
    self.modefierCfg = Config.GetAutoChessModifierTable(id)
    -- 记录在这个 Modifier 期间添加的状态标记，用于销毁时自动清理
    ---@type AutoChessFlag
    self._addedFlags = 0
    -- 记录在这个 Modifier 期间创建的特效 ID，用于销毁时自动清理
    ---@type int[]
    self._spawnedEffects = {}

    ---@type int buff层数
    self.stackCount = 0
end


--- 获取被挂载 Buff 的实体 (受击者/受增益者)
---@return AutoChessEntity
function ModifiersBase:GetOwner()
    return self.buff.owner
end

--- 获取施放这个 Buff 的实体 (攻击者/施法者)
---@return AutoChessEntity?
function ModifiersBase:GetCaster()
    return acMgr:GetEntity(self.buff.data.source)
end


--- 给宿主添加状态标记 (如 眩晕、无敌)
---@param flag AutoChessFlag
function ModifiersBase:AddFlag(flag)
    local owner = self:GetOwner()
    if owner == nil then
       return 
    end
    owner:AddFlag(flag)
end



--- 检测条件是否满足
--- @param eventType AutoChessCombatEvent
--- @param skillDamageInfo AutoChessDamageInfo?
--- @return boolean
function ModifiersBase:CheckConditions(eventType, skillDamageInfo)
    local cfg = self.modefierCfg
    if cfg == nil then
        return false
    end
    ---@type int[]
    local c = cfg.conditionList
    if c == nil then
       return true 
    end
    local buffSource = acMgr:GetEntity(self.buff.data.source)
    for i = 1, #c do
        local check = ConditionChecker:Check(c[i], self.buff.owner, buffSource, eventType, skillDamageInfo, self.stackCount)
        if not check then
           return false 
        end
    end
    return true
end



--- 主动销毁此 Modifier (会连带销毁整个 Buff 容器)
function ModifiersBase:Destroy()
    if self.buff.isRemoved then
       return 
    end
    self:GetOwner().buffControl:RemoveBuff(self.buff.data.id)
end


function ModifiersBase:OnUpdate(dt) 


end

---添加时调用
function ModifiersBase:OnAdd() 


end

---移除时候调用
function ModifiersBase:OnRemove() 
    local owner = self:GetOwner()
    if owner == nil then
       return 
    end

    owner:RemoveFlag(self._addedFlags)
    for i = 1, #self._spawnedEffects do
        local id = self._spawnedEffects[i]
        owner:RemoveEffect(id)
    end
end


---刷新时(重新添加时)调用
function ModifiersBase:OnRefresh() 


end


---受到伤害前
---@param damageInfo DamageInfo
---@param attacker AutoChessEntity? 攻击者
function ModifiersBase:OnBeforeTakeDamage(damageInfo, attacker, ...)

end

---受到伤害后
---@param damageInfo DamageInfo
---@param attacker AutoChessEntity? 攻击者
function ModifiersBase:OnAfterTakeDamage(damageInfo, attacker)


end

--- 收到承受致命伤 锁血判定
---@param damageInfo DamageInfo
---@param attacker AutoChessEntity
---@return boolean canDead 是否允许死亡(返回 false 代表锁血不死)
function ModifiersBase:OnFatalDamage(damageInfo, attacker)
    return true 
end

--- 造成伤害前 修改自己的输出 (暴击倍率增加、破甲)
---@param damageInfo DamageInfo
---@param target AutoChessEntity
function ModifiersBase:OnBeforeDealDamage(damageInfo, target) 


end

--- 造成伤害后 (吸血、溅射、叠毒)
---@param damageInfo DamageInfo
---@param target AutoChessEntity
function ModifiersBase:OnAfterDealDamage(damageInfo, target) 

end

--- 命中目标 (冰锤减速、电刃弹射)
---@param target AutoChessEntity
function ModifiersBase:OnAttackHit(target) 


end

--- 击杀目标(击杀回血、大招刷新)
---@param target AutoChessEntity
function ModifiersBase:OnKill(target) 


end

--- 自身死亡 (复活甲、死后自爆)
function ModifiersBase:OnDeath() 


end

---buff层数改变时调用
---@param stackCount integer
function ModifiersBase:OnStackChanged(stackCount)

end

return ModifiersBase