require "class"
local SurvivalAreaEffect = require("SurvivalAreaEffect")

---区域效果管理器：创建、Update、按阵营维护实例列表
---@class SurvivalAreaEffectManager
local SurvivalAreaEffectManager = class("SurvivalAreaEffectManager")

function SurvivalAreaEffectManager:ctor()
    ---@type table<integer, SurvivalAreaEffect>
    self._friendAreaEffectList = {}
    ---@type table<integer, SurvivalAreaEffect>
    self._enemyAreaEffectList = {}
    self._areaEffectIndex = 0
end

--帧同步
---@param deltaTime number
function SurvivalAreaEffectManager:Update(deltaTime)
    for _, areaEffect in pairs(self._friendAreaEffectList) do
        areaEffect:Update(deltaTime)
    end
    for _, areaEffect in pairs(self._enemyAreaEffectList) do
        areaEffect:Update(deltaTime)
    end
end

---区域效果创建参数（由 SurvivalSkillManager:CreateAreaEffect 组装）
---@class areaEffectCreateData
---@field skillId integer 技能配置 id
---@field ownerRoleId integer 释放者角色实例 id
---@field roleAttribute table<SurvivalAttribType, number> 创建时角色属性快照
---@field team GE.SurvivalTeam 释放者阵营
---@field damageType GE.SurvivalBulletDamageType 伤害类型
---@field onlyList table 仅目标舰装类型
---@field forbiddenList table 禁止目标舰装类型
---@field originType SurvivalSkillOrigin 起点
---@field settleMode SurvivalAreaSettle 伤害结算类型
---@field centerPos Vector3 固定/索敌圆心（Self 跟随时可忽略）
---@field expandMaxTime number 扩散到最大半径耗时
---@field sustainTime number 持续时间（settle=2 时不使用）
---@field interval number 检测间隔（仅 settle=3）
---@field knockbackSpeed number 单次击退速度
---@field knockbackDuration number 击退持续时间（秒）
---@field chargeBonus table<integer, number>|nil 蓄力属性倍率
---@field shapeType SurvivalAreaShape 区域形状
---@field beamDirection Vector3 激光束方向
---@field beamTargetRoleId integer 激光索敌目标 id
---@field beamAimType integer 仅 NearbyFollow 时实时跟随/重索敌
---@field priorityList table 激光索敌优先级
---@field effectName string 表现预制体名（技能 bullet 字段）

---创建区域效果实例
---@param createData areaEffectCreateData
function SurvivalAreaEffectManager:CreateAreaEffect(createData)
    -- LuaLogger.ds("SurvivalAreaEffectManager:CreateAreaEffect: ", tablex.dump(createData))
    self._areaEffectIndex = self._areaEffectIndex + 1
    local areaEffect = SurvivalAreaEffect:new()
    areaEffect:SetId(self._areaEffectIndex)
    areaEffect:SetSkillId(createData.skillId)
    areaEffect:SetOwnerRoleId(createData.ownerRoleId or 0)
    areaEffect:SetDamageType(createData.damageType)
    areaEffect:SetChargeBonus(createData.chargeBonus)
    areaEffect:InitRoleAttr(createData.roleAttribute)
    areaEffect:RefreshAttr()
    areaEffect:SetTeam(createData.team)
    areaEffect:SetOnlyList(createData.onlyList)
    areaEffect:SetForbiddenList(createData.forbiddenList)
    areaEffect.originType = createData.originType or GE.SurvivalSkillOrigin.Self
    areaEffect.settleMode = createData.settleMode or GE.SurvivalAreaSettle.ExpandSweep
    areaEffect.shapeType = createData.shapeType or GE.SurvivalAreaShape.Circle
    areaEffect.centerPos = createData.centerPos or Vector3.zero
    local beamDir = createData.beamDirection or Vector3.forward
    areaEffect.beamDirection = Vector3(beamDir.x, 0, beamDir.z).normalized
    areaEffect.beamTargetRoleId = createData.beamTargetRoleId or 0
    areaEffect.beamAimType = createData.beamAimType or 0
    areaEffect.priorityList = createData.priorityList or {}
    areaEffect.expandMaxTime = createData.expandMaxTime or 0
    areaEffect.sustainTime = createData.sustainTime
    areaEffect.interval = createData.interval or 0.5
    areaEffect.knockbackSpeed = createData.knockbackSpeed or 0
    areaEffect.knockbackDuration = createData.knockbackDuration or 0
    areaEffect:SetAlive(true)

    local areaEffectId = self._areaEffectIndex
    if createData.team == GE.SurvivalTeam.friend then
        self._friendAreaEffectList[areaEffectId] = areaEffect
    else
        self._enemyAreaEffectList[areaEffectId] = areaEffect
    end

    PoolMgr:Get(Config.PrefabPath.SurvivalAreaEffect, function(obj)
        if not areaEffect:IsAlive() then
            PoolMgr.Free(obj)
            return
        end
        areaEffect:BindObj(obj)
        areaEffect:LoadBulletEffects(createData.effectName, function()
            if areaEffect:IsAlive() then
                areaEffect:UpdateVisual()
            end
        end)
    end, SurvivalManager.instance().cameraObj)
end

---销毁指定 id 的区域效果
---@param id integer
function SurvivalAreaEffectManager:DestroyAreaEffect(id)
    local areaEffect = self._friendAreaEffectList[id] or self._enemyAreaEffectList[id]
    if not areaEffect then
        return
    end
    areaEffect:OnDestroy()
    self._friendAreaEffectList[id] = nil
    self._enemyAreaEffectList[id] = nil
end

---释放者死亡时，清除其跟随型区域效果（定点/导弹不受影响）
---@param ownerRoleId integer
function SurvivalAreaEffectManager:RemoveFollowByOwner(ownerRoleId)
    for id, areaEffect in pairs(self._friendAreaEffectList) do
        if areaEffect.ownerRoleId == ownerRoleId
            and areaEffect.originType == GE.SurvivalSkillOrigin.Self then
            self:DestroyAreaEffect(id)
        end
    end
    for id, areaEffect in pairs(self._enemyAreaEffectList) do
        if areaEffect.ownerRoleId == ownerRoleId
            and areaEffect.originType == GE.SurvivalSkillOrigin.Self then
            self:DestroyAreaEffect(id)
        end
    end
end

---清除指定释放者的全部区域效果
---@param ownerRoleId integer
function SurvivalAreaEffectManager:RemoveByOwner(ownerRoleId)
    for id, areaEffect in pairs(self._friendAreaEffectList) do
        if areaEffect.ownerRoleId == ownerRoleId then
            self:DestroyAreaEffect(id)
        end
    end
    for id, areaEffect in pairs(self._enemyAreaEffectList) do
        if areaEffect.ownerRoleId == ownerRoleId then
            self:DestroyAreaEffect(id)
        end
    end
end

function SurvivalAreaEffectManager:Clear()
    for _, areaEffect in pairs(self._friendAreaEffectList) do
        areaEffect:Clear()
    end
    for _, areaEffect in pairs(self._enemyAreaEffectList) do
        areaEffect:Clear()
    end
    self._friendAreaEffectList = {}
    self._enemyAreaEffectList = {}
    self._areaEffectIndex = 0
end

---实例化
---@return SurvivalAreaEffectManager
function SurvivalAreaEffectManager.instance()
    if SurvivalAreaEffectManager._instance == nil then
        SurvivalAreaEffectManager._instance = SurvivalAreaEffectManager:new()
    end
    return SurvivalAreaEffectManager._instance
end

return SurvivalAreaEffectManager
