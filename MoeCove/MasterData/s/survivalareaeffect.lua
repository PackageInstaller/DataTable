require "class"

---区域效果实例：冲击波、导弹落点 AoE、脚下光环等
---区域效果：起点(origin)决定范围圆心；伤害结算类型(settle)决定判定时机
---@class SurvivalAreaEffect
local SurvivalAreaEffect = class("SurvivalAreaEffect")
---预制体默认表现直径（localScale=1 时）
local DEFAULT_VISUAL_DIAMETER = 1
---激光粒子 Shape 默认高度（Box scale.y）
local DEFAULT_BEAM_SHAPE_HEIGHT = 0.12

---点到线段距离（XZ 平面）
local function DistancePointToSegment2D(px, pz, ox, oz, dx, dz, length)
    local ex = ox + dx * length
    local ez = oz + dz * length
    local segX = ex - ox
    local segZ = ez - oz
    local segLenSq = segX * segX + segZ * segZ
    if segLenSq <= 0 then
        local ddx = px - ox
        local ddz = pz - oz
        return math.sqrt(ddx * ddx + ddz * ddz)
    end
    local t = ((px - ox) * segX + (pz - oz) * segZ) / segLenSq
    t = math.max(0, math.min(1, t))
    local cx = ox + segX * t
    local cz = oz + segZ * t
    local ddx = px - cx
    local ddz = pz - cz
    return math.sqrt(ddx * ddx + ddz * ddz)
end

function SurvivalAreaEffect:ctor()
    self.id = 0
    self.skillId = 0            --所属技能配置 id
    self.ownerRoleId = 0        --释放者角色实例 id
    self.team = GE.SurvivalTeam.friend
    ---@type GE.SurvivalBulletDamageType
    self.damageType = GE.SurvivalBulletDamageType.Bullet
    self.alive = false
    ---创建时快照的角色属性，用于 RefreshAttr 计算最终伤害/范围
    ---@type table<SurvivalAttribType, number>
    self._roleAttribute = {}
    ---区域效果最终属性（技能基础 + 角色加权）
    ---@type table<SurvivalAttribType, number>
    self._attribute = {}
    ---仅对指定舰装类型生效
    self.onlyList = {}
    ---不对指定舰装类型生效
    self.forbiddenList = {}
    ---起点：Self / FixedPoint / AimTarget
    ---@type SurvivalSkillOrigin
    self.originType = GE.SurvivalSkillOrigin.Self
    ---伤害结算类型：ExpandSweep / ExpandOnce / FixedTick
    ---@type SurvivalAreaSettle
    self.settleMode = GE.SurvivalAreaSettle.ExpandSweep
    self.centerPos = Vector3.zero   --FixedPoint / AimTarget 创建时写入的圆心
    ---@type SurvivalAreaShape
    self.shapeType = GE.SurvivalAreaShape.Circle
    self.beamDirection = Vector3.forward --激光束方向（最后锁定朝向，无目标时保持）
    self.beamTargetRoleId = 0       --激光索敌目标 id
    self.beamAimType = 0            --仅 NearbyFollow 时实时跟随/重索敌
    self.priorityList = {}          --激光索敌优先级
    self.maxRadius = 0              --最大作用半径（由 A14 直径 / 2 得出）
    self.maxBeamLength = 0          --激光束最大长度（A17）
    self.beamHalfWidth = 0          --激光束半宽（A18 直径 / 2）
    self.expandMaxTime = 0          --扩散到最大半径耗时（秒）
    self.sustainTime = 0.5          --持续时间；expandMaxTime < sustainTime 时满半径后额外持续
    self.interval = 0.5             --FixedTick 检测间隔（仅 settle=3）
    self.knockbackSpeed = 0         --单次击退速度（effectParameter[5].knockbackSpeed）
    self.knockbackDuration = 0    --击退持续时间（effectParameter[5].knockbackDuration）
    self.elapsed = 0                --已存在时间
    self.tickTimer = 0              --FixedTick 距下次检测的计时
    self._firstTickDone = false     --FixedTick 是否已执行首跳（创建当帧立即检测）
    self._settled = false           --ExpandOnce 是否已结算
    ---ExpandSweep 已命中角色，同一波每人只打一次
    ---@type table<integer, boolean>
    self._hitRoleIds = {}
    ---蓄力属性倍率
    ---@type table<integer, number>|nil
    self._chargeBonus = nil
    self.obj = nil
    self._rangeMaxTrans = nil
    self._rangeTrans = nil
    self._rangeEffectObj = nil      --bullet 表现，挂在 range 下
    self._rangeMaxEffectObj = nil   --bullet 表现，挂在 rangeMax 下
    self._hasBulletEffect = false
    ---激光 Shape 缓存，避免每帧重复写粒子模块
    self._beamShapeCache = {
        range = { width = -1, length = -1 },
        rangeMax = { width = -1, length = -1 },
    }
end

---@param id integer
function SurvivalAreaEffect:SetId(id)
    self.id = id
end

---@param skillId integer
function SurvivalAreaEffect:SetSkillId(skillId)
    self.skillId = skillId
end

---@param ownerRoleId integer
function SurvivalAreaEffect:SetOwnerRoleId(ownerRoleId)
    self.ownerRoleId = ownerRoleId
end

---@param chargeBonus table<integer, number>|nil
function SurvivalAreaEffect:SetChargeBonus(chargeBonus)
    self._chargeBonus = chargeBonus
end

---@param team GE.SurvivalTeam
function SurvivalAreaEffect:SetTeam(team)
    self.team = team
end

---@param damageType GE.SurvivalBulletDamageType
function SurvivalAreaEffect:SetDamageType(damageType)
    self.damageType = damageType
end

---@param onlyList table
function SurvivalAreaEffect:SetOnlyList(onlyList)
    self.onlyList = onlyList or {}
end

---@param forbiddenList table
function SurvivalAreaEffect:SetForbiddenList(forbiddenList)
    self.forbiddenList = forbiddenList or {}
end

---@param roleAttribute table<SurvivalAttribType, number>
function SurvivalAreaEffect:InitRoleAttr(roleAttribute)
    self._roleAttribute = roleAttribute or {}
end

---@return table<SurvivalAttribType, number>
function SurvivalAreaEffect:GetRoleAttr()
    return self._roleAttribute
end

---@param attrType SurvivalAttribType
---@return number|nil
function SurvivalAreaEffect:GetAttr(attrType)
    return self._attribute[attrType]
end

---@param alive boolean
function SurvivalAreaEffect:SetAlive(alive)
    self.alive = alive
end

---@return boolean
function SurvivalAreaEffect:IsAlive()
    return self.alive
end

---刷新区域效果属性（公式与子弹一致：技能基础 + 角色属性加权）
function SurvivalAreaEffect:RefreshAttr()
    local skillMgr = SurvivalManager.instance():GetSkillMgr()
    local cfg = Config.GetSurvivorSkillInfo(self.skillId)
    if not cfg then
        LuaLogger.ws("SurvivalAreaEffect:RefreshAttr: skill not found: ", self.skillId)
        return
    end
    local skillParam = cfg.effectParameter
    local roleAttr = self:GetRoleAttr()
    local skillBaseAttr = skillMgr:GetBaseAttrFormSkill(skillParam)
    skillMgr:ApplyChargeBonus(skillBaseAttr, self._chargeBonus)
    local roleAddAttr = skillMgr:GetBaseAttrFromRole(roleAttr, skillParam)
    self._attribute = {}
    for attrType, value in pairs(skillBaseAttr) do
        self._attribute[attrType] = value + (roleAddAttr[attrType] or 0)
    end
    for attrType, value in pairs(roleAddAttr) do
        if not self._attribute[attrType] then
            self._attribute[attrType] = value
        end
    end
    local range = self._attribute[GE.SurvivalAttribType.BulletRange] or 0
    self.maxRadius = range / 2
    self.maxBeamLength = self._attribute[GE.SurvivalAttribType.BeamLength] or 0
    local beamWidth = self._attribute[GE.SurvivalAttribType.BeamWidth] or 0
    self.beamHalfWidth = beamWidth / 2
end

---@return boolean
function SurvivalAreaEffect:IsBeamShape()
    return self.shapeType == GE.SurvivalAreaShape.Beam
end

---根据伤害类型获取攻击力
---@param type GE.SurvivalBulletDamageType
---@return number
function SurvivalAreaEffect:GetDamageByDmgType(type)
    if type == GE.SurvivalBulletDamageType.Torpedo then
        return self._attribute[GE.SurvivalAttribType.TorpedoAttack] or 0
    elseif type == GE.SurvivalBulletDamageType.Bullet then
        return self._attribute[GE.SurvivalAttribType.BulletAttack] or 0
    end
    return 0
end

---击退速度（AoE 命中时叠加到已有击退上）
---@return number
function SurvivalAreaEffect:GetKnockbackSpeed()
    return self.knockbackSpeed
end

---击退持续时间
---@return number
function SurvivalAreaEffect:GetKnockbackDuration()
    return self.knockbackDuration
end

---获取应命中的敌对阵营
---@return GE.SurvivalTeam
function SurvivalAreaEffect:GetTargetTeam()
    if self.team == GE.SurvivalTeam.enemy then
        return GE.SurvivalTeam.friend
    end
    return GE.SurvivalTeam.enemy
end

---@return SurvivalRole|nil
function SurvivalAreaEffect:GetOwner()
    if not self.ownerRoleId or self.ownerRoleId <= 0 then
        return nil
    end
    return SurvivalManager.instance():GetRoleMgr():GetRole(self.ownerRoleId)
end

---获取当前帧的范围圆心
---Self 每帧跟随释放者，其余使用创建时 centerPos
---@return Vector3
function SurvivalAreaEffect:GetCenter()
    if self.originType == GE.SurvivalSkillOrigin.Self then
        local owner = self:GetOwner()
        if owner and owner:IsAlive() then
            local pos = owner:GetPosition()
            return Vector3(pos.x, pos.y, pos.z)
        end
    end
    return self.centerPos
end

---@param origin Vector3
---@param tpos Vector3
---@return Vector3|nil
function SurvivalAreaEffect:CalcBeamDirectionToPos(origin, tpos)
    local dx = tpos.x - origin.x
    local dz = tpos.z - origin.z
    local mag = math.sqrt(dx * dx + dz * dz)
    if mag > 0 then
        return Vector3(dx / mag, 0, dz / mag)
    end
    return nil
end

---目标死亡后重新索敌（仅 NearbyFollow）；找不到则保持最后朝向
function SurvivalAreaEffect:TryRetargetBeam()
    if not self:IsAlive() or not self:IsBeamShape()
        or self.beamAimType ~= GE.SurvivalAimType.NearbyFollow then
        return
    end
    local owner = self:GetOwner()
    if not owner or not owner:IsAlive() then
        return
    end
    local skillMgr = SurvivalManager.instance():GetSkillMgr()
    local target = skillMgr:GetTarget(owner, self.beamAimType, self.onlyList, self.priorityList, self.forbiddenList)
    local roleMgr = SurvivalManager.instance():GetRoleMgr()
    if not roleMgr:IsCombatTarget(target) then
        target = nil
    end
    if target then
        self.beamTargetRoleId = target.id
    else
        self.beamTargetRoleId = 0
    end
end

---激光束起点（Self 从释放者发出，FixedPoint / AimTarget 用创建时 centerPos）
---@return Vector3
function SurvivalAreaEffect:GetBeamOrigin()
    if self.originType == GE.SurvivalSkillOrigin.Self then
        return self:GetCenter()
    end
    return self.centerPos
end

---激光束方向：NearbyFollow 实时跟随目标；其余类型保持创建时快照
---@return Vector3
function SurvivalAreaEffect:GetBeamDirection()
    if self.beamAimType ~= GE.SurvivalAimType.NearbyFollow then
        return self.beamDirection
    end
    local origin = self:GetBeamOrigin()
    local target = nil
    local roleMgr = SurvivalManager.instance():GetRoleMgr()
    if self.beamTargetRoleId and self.beamTargetRoleId > 0 then
        target = roleMgr:GetRole(self.beamTargetRoleId)
        if not roleMgr:IsCombatTarget(target) then
            self:TryRetargetBeam()
            target = self.beamTargetRoleId > 0 and roleMgr:GetRole(self.beamTargetRoleId) or nil
        end
    else
        self:TryRetargetBeam()
        target = self.beamTargetRoleId > 0 and roleMgr:GetRole(self.beamTargetRoleId) or nil
    end
    if roleMgr:IsCombatTarget(target) then
        local dir = self:CalcBeamDirectionToPos(origin, target:GetPosition())
        if dir then
            self.beamDirection = dir
            return dir
        end
    end
    return self.beamDirection
end

---获取当前帧的作用半径
---expandMaxTime > 0 时按 elapsed 线性扩散至 maxRadius；expandMaxTime = 0 时直接取 maxRadius（含 FixedTick）
---@return number
function SurvivalAreaEffect:GetCurrentRadius()
    if self.expandMaxTime <= 0 then
        return self.maxRadius
    end
    local t = math.min(1, self.elapsed / self.expandMaxTime)
    return self.maxRadius * t
end

---获取当前帧的激光束长度
---@return number
function SurvivalAreaEffect:GetCurrentBeamLength()
    if self.maxBeamLength <= 0 then
        return 0
    end
    if self.expandMaxTime <= 0 then
        return self.maxBeamLength
    end
    local t = math.min(1, self.elapsed / self.expandMaxTime)
    return self.maxBeamLength * t
end

---是否满足舰装类型命中规则
---@param role SurvivalRole
---@return boolean
function SurvivalAreaEffect:IsValidForHitRule(role)
    local shipType = role:GetShipType()
    if #self.onlyList > 0 and not tablex.contains(self.onlyList, shipType) then
        return false
    end
    if #self.forbiddenList > 0 and tablex.contains(self.forbiddenList, shipType) then
        return false
    end
    return true
end

---遍历敌对阵营，对范围内角色造成伤害
---@param useMaxSize boolean true=强制用最大范围（ExpandOnce），false=用当前扩散尺寸
function SurvivalAreaEffect:QueryAndHitRoles(useMaxSize)
    if self:IsBeamShape() then
        self:QueryAndHitRolesInBeam(useMaxSize)
        return
    end
    local roleMgr = SurvivalManager.instance():GetRoleMgr()
    local colliderMgr = SurvivalManager.instance():GetColliderMgr()
    local targetTeam = self:GetTargetTeam()
    local center = self:GetCenter()
    local radius = useMaxSize and self.maxRadius or self:GetCurrentRadius()
    if radius <= 0 then
        return
    end
    local extraHalfRange = roleMgr:GetEnemyMaxRange(self.team) / 2
    local grid = colliderMgr:GetRoleGrid(targetTeam)
    local targetList = colliderMgr:QueryGridByRange(grid, center.x, center.z, radius, extraHalfRange)
    for i = 1, #targetList do
        local role = targetList[i]
        if role:IsAlive() and self:IsValidForHitRule(role) then
            if self.settleMode == GE.SurvivalAreaSettle.ExpandOnce or not self._hitRoleIds[role.id] then
                local dx = center.x - role:GetPosition().x
                local dz = center.z - role:GetPosition().z
                local sumRange = radius + role:GetHalfRange()
                if dx * dx + dz * dz <= sumRange * sumRange then
                    if self.settleMode == GE.SurvivalAreaSettle.ExpandOnce then
                        role:BeHitByAreaEffect(self)
                    else
                        self._hitRoleIds[role.id] = true
                        role:BeHitByAreaEffect(self)
                    end
                end
            end
        end
    end
end

---激光束：地格 AABB 粗筛 + 点到线段距离精判
---@param useMaxLength boolean
function SurvivalAreaEffect:QueryAndHitRolesInBeam(useMaxLength)
    local roleMgr = SurvivalManager.instance():GetRoleMgr()
    local colliderMgr = SurvivalManager.instance():GetColliderMgr()
    local targetTeam = self:GetTargetTeam()
    local origin = self:GetBeamOrigin()
    local direction = self:GetBeamDirection()
    local length = useMaxLength and self.maxBeamLength or self:GetCurrentBeamLength()
    if length <= 0 or self.beamHalfWidth <= 0 then
        return
    end
    local dx, dz = direction.x, direction.z
    local mag = math.sqrt(dx * dx + dz * dz)
    if mag <= 0 then
        return
    end
    dx, dz = dx / mag, dz / mag
    local ox, oz = origin.x, origin.z
    local ex, ez = ox + dx * length, oz + dz * length
    local extraHalfRange = roleMgr:GetEnemyMaxRange(self.team) / 2
    local halfW = self.beamHalfWidth + extraHalfRange
    local minX = math.min(ox, ex) - halfW
    local maxX = math.max(ox, ex) + halfW
    local minZ = math.min(oz, ez) - halfW
    local maxZ = math.max(oz, ez) + halfW
    local grid = colliderMgr:GetRoleGrid(targetTeam)
    local targetList = colliderMgr:QueryGridByAABB(grid, minX, maxX, minZ, maxZ)
    for i = 1, #targetList do
        local role = targetList[i]
        if role:IsAlive() and self:IsValidForHitRule(role) then
            if self.settleMode == GE.SurvivalAreaSettle.ExpandOnce or not self._hitRoleIds[role.id] then
                local pos = role:GetPosition()
                local dist = DistancePointToSegment2D(pos.x, pos.z, ox, oz, dx, dz, length)
                if dist <= self.beamHalfWidth + role:GetHalfRange() then
                    if self.settleMode == GE.SurvivalAreaSettle.ExpandOnce then
                        role:BeHitByAreaEffect(self)
                    else
                        self._hitRoleIds[role.id] = true
                        role:BeHitByAreaEffect(self)
                    end
                end
            end
        end
    end
end

---ExpandSweep：扩散波前扫过，敌人第一次进入当前半径时命中
function SurvivalAreaEffect:SweepHit()
    self:QueryAndHitRoles(false)
end

---ExpandOnce：扩散结束后对最大半径内全体结算一次（导弹落点）
function SurvivalAreaEffect:SettleOnce()
    if self._settled then
        return
    end
    self._settled = true
    self:QueryAndHitRoles(true)
end

---FixedTick：每跳清空去重表，允许同一敌人多次受伤
function SurvivalAreaEffect:TickHit()
    self._hitRoleIds = {}
    self:QueryAndHitRoles(false)
end

---是否显示最大范围预览（导弹落点 / 激光生长）
---@return boolean
function SurvivalAreaEffect:IsGrowPreviewVisual()
    if self:IsBeamShape() then
        return self.settleMode == GE.SurvivalAreaSettle.ExpandOnce
            or self.expandMaxTime > 0
    end
    return self.settleMode == GE.SurvivalAreaSettle.ExpandOnce
end

---是否导弹类表现（ExpandOnce：落点预览最大圈 + 当前扩散圈）
---@return boolean
function SurvivalAreaEffect:IsMissileVisual()
    return not self:IsBeamShape() and self.settleMode == GE.SurvivalAreaSettle.ExpandOnce
end

---绑定表现预制体（rangeMax/range=容器，bullet 表现挂在其下）
---@param obj UnityEngine.GameObject
function SurvivalAreaEffect:BindObj(obj)
    self.obj = obj
    self._rangeMaxTrans = obj.transform:Find("rangeMax")
    self._rangeTrans = obj.transform:Find("range")
    if self._rangeTrans then
        self._rangeTrans.localScale = Vector3.one
    end
    if self._rangeMaxTrans then
        self._rangeMaxTrans.localScale = Vector3.one
    end
    self:UpdateVisual()
end

---隐藏 range/rangeMax 自带调试 Mesh，有 bullet 表现时使用
---@param trans UnityEngine.Transform|nil
---@param visible boolean
function SurvivalAreaEffect:SetRangeMeshVisible(trans, visible)
    if not trans then
        return
    end
    local mr = trans:GetComponent("MeshRenderer")
    if mr then
        mr.enabled = visible
    end
end

---将 bullet 表现挂到 range/rangeMax 节点下
---@param effectObj UnityEngine.GameObject
---@param parentTrans UnityEngine.Transform|nil
---@return UnityEngine.GameObject|nil
function SurvivalAreaEffect:AttachBulletEffect(effectObj, parentTrans)
    if not parentTrans then
        PoolMgr.Free(effectObj)
        return nil
    end
    effectObj.transform:SetParent(parentTrans, false)
    effectObj.transform.localPosition = Vector3.zero
    effectObj.transform.localScale = Vector3.one
    self:SetRangeMeshVisible(parentTrans, false)
    return effectObj
end

---重置激光 Shape 缓存（换特效或销毁时）
function SurvivalAreaEffect:ResetBeamShapeCache()
    self._beamShapeCache.range.width = -1
    self._beamShapeCache.range.length = -1
    self._beamShapeCache.rangeMax.width = -1
    self._beamShapeCache.rangeMax.length = -1
end

---激光表现：改粒子 Shape 长宽（不改 Transform scale，避免形变）
---@param effectRoot UnityEngine.GameObject
---@param width number
---@param length number
function SurvivalAreaEffect:ApplyBeamEffectShape(effectRoot, width, length)
    if not effectRoot or IsNull(effectRoot) then
        return
    end
    DUtil.ApplyParticleBoxShape(effectRoot, width, math.max(length, 0), DEFAULT_BEAM_SHAPE_HEIGHT)
end

---仅在宽/长变化时写 Shape（expandMaxTime=0 时首帧后不再刷新）
---@param effectRoot UnityEngine.GameObject|nil
---@param width number
---@param length number
---@param cache table
function SurvivalAreaEffect:ApplyBeamEffectShapeIfChanged(effectRoot, width, length, cache)
    if not effectRoot or IsNull(effectRoot) then
        return
    end
    length = math.max(length, 0)
    if cache.width == width and cache.length == length then
        return
    end
    cache.width = width
    cache.length = length
    self:ApplyBeamEffectShape(effectRoot, width, length)
end

---异步加载 bullet 表现到 range / rangeMax
---@param effectName string
---@param onComplete function|nil
function SurvivalAreaEffect:LoadBulletEffects(effectName, onComplete)
    if not effectName or effectName == "" then
        self._hasBulletEffect = false
        if onComplete then
            onComplete()
        end
        return
    end
    local effectPath = string.format(Config.PrefabPath.SurvivalAreaEffectPrefab, effectName)
    local cameraObj = SurvivalManager.instance().cameraObj
    local pending = 0
    local function onLoaded()
        pending = pending - 1
        if pending <= 0 then
            self._hasBulletEffect = self._rangeEffectObj ~= nil
            if onComplete then
                onComplete()
            end
        end
    end

    pending = pending + 1
    PoolMgr:Get(effectPath, function(effectObj)
        if not self:IsAlive() then
            PoolMgr.Free(effectObj)
            onLoaded()
            return
        end
        self._rangeEffectObj = self:AttachBulletEffect(effectObj, self._rangeTrans)
        onLoaded()
    end, cameraObj)

    local needMaxEffect = self:IsGrowPreviewVisual() and self._rangeMaxTrans
    if needMaxEffect then
        pending = pending + 1
        PoolMgr:Get(effectPath, function(effectObj)
            if not self:IsAlive() then
                PoolMgr.Free(effectObj)
                onLoaded()
                return
            end
            self._rangeMaxEffectObj = self:AttachBulletEffect(effectObj, self._rangeMaxTrans)
            onLoaded()
        end, cameraObj)
    end
end

---释放 bullet 表现实例
function SurvivalAreaEffect:FreeBulletEffects()
    if self._rangeEffectObj and not IsNull(self._rangeEffectObj) then
        PoolMgr.Free(self._rangeEffectObj)
    end
    self._rangeEffectObj = nil
    if self._rangeMaxEffectObj and not IsNull(self._rangeMaxEffectObj) then
        PoolMgr.Free(self._rangeMaxEffectObj)
    end
    self._rangeMaxEffectObj = nil
    self._hasBulletEffect = false
    self:ResetBeamShapeCache()
end

---刷新表现：圆形 AoE / 激光束
function SurvivalAreaEffect:UpdateVisual()
    if not self:IsAlive() or not self.obj or IsNull(self.obj) then
        return
    end
    --激光束
    if self:IsBeamShape() then
        self:UpdateBeamVisual()
        return
    end
    local center = self:GetCenter()
    self.obj.transform.position = Vector3(center.x, center.y + 0.05, center.z)
    local maxDiameter = math.max(self.maxRadius * 2, 0)
    local curDiameter = math.max(self:GetCurrentRadius() * 2, 0)
    local showMaxRange = self:IsMissileVisual()
    if self._rangeMaxTrans then
        self._rangeMaxTrans.gameObject:SetActive(showMaxRange)
        if showMaxRange then
            local scale = maxDiameter / DEFAULT_VISUAL_DIAMETER
            self._rangeMaxTrans.localScale = Vector3(scale, scale, scale)
        end
    end
    if self._rangeTrans then
        self._rangeTrans.gameObject:SetActive(true)
        local scale = curDiameter / DEFAULT_VISUAL_DIAMETER
        self._rangeTrans.localScale = Vector3(scale, scale, scale)
    end
end

---激光束表现：shape=2 且有 bullet 时改粒子 Shape；否则 fallback 到 range scale
function SurvivalAreaEffect:UpdateBeamVisual()
    if not self:IsAlive() or not self.obj or IsNull(self.obj) then
        return
    end
    local origin = self:GetBeamOrigin()
    local direction = self:GetBeamDirection()
    local curLength = self:GetCurrentBeamLength()
    local maxLength = self.maxBeamLength
    local beamWidth = self.beamHalfWidth * 2
    local dx, dz = direction.x, direction.z
    local mag = math.sqrt(dx * dx + dz * dz)
    if mag > 0 then
        dx, dz = dx / mag, dz / mag
    else
        dx, dz = 0, 1
    end
    self.obj.transform.position = Vector3(origin.x, origin.y + 0.05, origin.z)
    local angleY = math.deg(math.atan2(dx, dz))
    self.obj.transform.rotation = Quaternion.Euler(0, angleY, 0)
    local showMaxRange = self:IsGrowPreviewVisual()

    if self._hasBulletEffect then
        if self._rangeTrans then
            self._rangeTrans.gameObject:SetActive(true)
            self._rangeTrans.localScale = Vector3.one
        end
        if self._rangeEffectObj then
            self:ApplyBeamEffectShapeIfChanged(
                self._rangeEffectObj, beamWidth, curLength, self._beamShapeCache.range)
        end
        if self._rangeMaxTrans then
            local showMax = showMaxRange and self._rangeMaxEffectObj ~= nil
            self._rangeMaxTrans.gameObject:SetActive(showMax)
            self._rangeMaxTrans.localScale = Vector3.one
            if showMax then
                self:ApplyBeamEffectShapeIfChanged(
                    self._rangeMaxEffectObj, beamWidth, maxLength, self._beamShapeCache.rangeMax)
            end
        end
        return
    end

    local midX = origin.x + dx * (curLength * 0.5)
    local midZ = origin.z + dz * (curLength * 0.5)
    self.obj.transform.position = Vector3(midX, origin.y + 0.05, midZ)
    if self._rangeMaxTrans then
        self._rangeMaxTrans.gameObject:SetActive(showMaxRange)
        if showMaxRange and maxLength > 0 then
            local scaleX = beamWidth / DEFAULT_VISUAL_DIAMETER
            local scaleZ = maxLength / DEFAULT_VISUAL_DIAMETER
            self._rangeMaxTrans.localScale = Vector3(scaleX, 1, scaleZ)
        end
    end
    if self._rangeTrans then
        self._rangeTrans.gameObject:SetActive(true)
        local scaleX = beamWidth / DEFAULT_VISUAL_DIAMETER
        local scaleZ = math.max(curLength, 0) / DEFAULT_VISUAL_DIAMETER
        self._rangeTrans.localScale = Vector3(scaleX, 1, scaleZ)
    end
end

--帧同步
---@param deltaTime number
function SurvivalAreaEffect:Update(deltaTime)
    if not self:IsAlive() then
        return
    end
    self.elapsed = self.elapsed + deltaTime

    if self.settleMode == GE.SurvivalAreaSettle.ExpandSweep then
        --扩散扫过：sustainTime 内持续判定，expandMaxTime 后半径保持最大
        self:SweepHit()
        if self.elapsed >= self.sustainTime then
            SurvivalManager.instance():GetAreaEffectMgr():DestroyAreaEffect(self.id)
            return
        end
    elseif self.settleMode == GE.SurvivalAreaSettle.ExpandOnce then
        --扩散到最大时结算一次，仅使用 expandMaxTime
        if not self._settled and self.elapsed >= self.expandMaxTime then
            self:SettleOnce()
            SurvivalManager.instance():GetAreaEffectMgr():DestroyAreaEffect(self.id)
            return
        end
    elseif self.settleMode == GE.SurvivalAreaSettle.FixedTick then
        --定时检测：首帧立即第一跳，之后按 interval 周期；expandMaxTime > 0 时半径随时间扩散
        if not self._firstTickDone then
            self._firstTickDone = true
            self:TickHit()
        end
        self.tickTimer = self.tickTimer + deltaTime
        if self.tickTimer >= self.interval then
            self.tickTimer = self.tickTimer - self.interval
            self:TickHit()
        end
        if self.sustainTime > 0 and self.elapsed >= self.sustainTime then
            SurvivalManager.instance():GetAreaEffectMgr():DestroyAreaEffect(self.id)
            return
        end
    end
    self:UpdateVisual()
end

function SurvivalAreaEffect:OnDestroy()
    if not self.alive and not self.obj and not self._rangeEffectObj and not self._rangeMaxEffectObj then
        return
    end
    self.alive = false
    self:FreeBulletEffects()
    self._rangeTrans = nil
    self._rangeMaxTrans = nil
    if self.obj and not IsNull(self.obj) then
        PoolMgr.Free(self.obj)
    end
    self.obj = nil
end

function SurvivalAreaEffect:Clear()
    self:OnDestroy()
end

return SurvivalAreaEffect
