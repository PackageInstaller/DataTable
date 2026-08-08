require "class"
local SurvivalBullet = class("SurvivalBullet")
-- 追踪弹重新索敌间隔（秒），锁定有效目标期间不搜索
local TRACK_SEARCH_INTERVAL = 0.1

function SurvivalBullet:ctor()
    self.isBullet = true
    self.skillId = 0    --子弹所属技能id
    self.ownerRoleId = 0    --发射者角色实例id
	self.id = 0
	self.direction = Vector3.zero
    self.position = Vector3.zero
    ---角色属性
    ---@type table<SurvivalAttribType, number> 
    self._roleAttribute = {}
    ---子弹属性
    ---@type table<SurvivalAttribType, number>
    self._attribute = {}
    ---子弹伤害类型
    ---@type GE.SurvivalBulletDamageType
    self.damageType = GE.SurvivalBulletDamageType.Bullet
    ---子弹穿透次数 每命中一次+1 达到穿透次数后消失
    self.penetrationTime = 0
    ---子弹持续时间 大于持续时间后消失
    self.sustain = 0
    self.alive = false
    ---子弹血量 todo
    self.currentHp = 1
    self.obj = nil
    self.team = nil
    self.block = {
        x = 0,
        z = 0
    }
    ---仅目标列表
    self.onlyList = {}
    ---禁止目标列表
    self.forbiddenList = {}
    ---已命中过的角色id，穿透弹对同一敌人只造成一次伤害
    ---@type table<integer, boolean>
    self._hitRoleIds = {}
    ---蓄力属性倍率
    ---@type table<integer, number>|nil
    self._chargeBonus = nil
    ---追踪开关（track=1 开启）
    self._trackEnabled = false
    ---自动追踪范围
    self._trackRange = 0
    ---追踪转向角速度（度/秒）
    self._turnSpeed = 0
    ---锁定追踪目标角色 id
    self._trackTargetId = nil
    ---距下次索敌剩余时间（秒）
    self._trackSearchCooldown = 0
    ---拖尾是否已开启（避免生成时拖尾残留）
    self._trailEmittingInited = false
    ---是否已设置过初始发射位置
    self._spawnPosSet = false
    ---拖尾渐隐回收定时器
    self._trailEndTimer = nil
end

--帧同步
function SurvivalBullet:Update(deltaTime)
    if not self:IsAlive() then
        return
    end
    self.sustain = self.sustain + deltaTime
    if self.sustain >= self._attribute[GE.SurvivalAttribType.BulletSustain] then
        SurvivalManager.instance():GetBulletMgr():DestroyBullet(self.id)
    end
    self:UpdatePosition(deltaTime)
end

---更新位置
function SurvivalBullet:UpdatePosition(deltaTime)
    local speed = self._attribute[GE.SurvivalAttribType.BulletSpeed]
    if not speed then
        return
    end
    if self._trackEnabled and self._trackRange > 0 and self._turnSpeed > 0 then
        self:UpdateTrackDirection(deltaTime)
    end
    local newPos = self.position + self.direction * speed * deltaTime
    self:ChangePos(newPos)
end

---追踪：锁定目标持续转向，失效后降频重新索敌
---@param deltaTime number
function SurvivalBullet:UpdateTrackDirection(deltaTime)
    self._trackSearchCooldown = self._trackSearchCooldown - deltaTime

    local targetRole = self:GetLockedTrackTarget()
    if not targetRole then
        self._trackTargetId = nil
        if self._trackSearchCooldown <= 0 then
            targetRole = self:FindTrackTarget()
            if targetRole then
                self._trackTargetId = targetRole.id
            end
            self._trackSearchCooldown = TRACK_SEARCH_INTERVAL
        end
    end

    if not targetRole then
        return
    end
    local targetPos = targetRole:GetPosition()
    local dx = targetPos.x - self.position.x
    local dz = targetPos.z - self.position.z
    if dx * dx + dz * dz < 1e-6 then
        return
    end
    self:RotateDirectionTowards(Vector3(dx, 0, dz), deltaTime)
end

---获取当前锁定的有效追踪目标
---@return SurvivalRole|nil
function SurvivalBullet:GetLockedTrackTarget()
    if not self._trackTargetId then
        return nil
    end
    local role = SurvivalManager.instance():GetRoleMgr():GetRole(self._trackTargetId)
    if not self:IsValidTrackTarget(role) then
        return nil
    end
    return role
end

---追踪目标是否仍有效（存活、未命中、规则允许、在追踪范围内）
---@param role SurvivalRole|nil
---@return boolean
function SurvivalBullet:IsValidTrackTarget(role)
    if not role then
        return false
    end
    local roleMgr = SurvivalManager.instance():GetRoleMgr()
    local colliderMgr = SurvivalManager.instance():GetColliderMgr()
    if not roleMgr:IsCombatTarget(role) then
        return false
    end
    if self:HasHitRole(role) then
        return false
    end
    if not colliderMgr:IsValidForHitRule(self, role) then
        return false
    end
    local rpos = role:GetPosition()
    local dx = rpos.x - self.position.x
    local dz = rpos.z - self.position.z
    local trackRangeSqr = self._trackRange * self._trackRange
    return dx * dx + dz * dz <= trackRangeSqr
end

---在追踪范围内查找最近可命中角色
---@return SurvivalRole|nil
function SurvivalBullet:FindTrackTarget()
    local roleMgr = SurvivalManager.instance():GetRoleMgr()
    local colliderMgr = SurvivalManager.instance():GetColliderMgr()
    local targetTeam = self.team == GE.SurvivalTeam.friend and GE.SurvivalTeam.enemy or GE.SurvivalTeam.friend
    local roleGrid = colliderMgr:GetRoleGrid(targetTeam)
    local extraHalfRange = roleMgr:GetTeamMaxRange(targetTeam) / 2
    local candidates = colliderMgr:QueryGridByRange(
        roleGrid, self.position.x, self.position.z, self._trackRange, extraHalfRange)

    local nearest = nil
    local minDistSqr = nil
    local trackRangeSqr = self._trackRange * self._trackRange
    local pos = self.position

    for i = 1, #candidates do
        local role = candidates[i]
        if roleMgr:IsCombatTarget(role)
            and not self:HasHitRole(role)
            and colliderMgr:IsValidForHitRule(self, role) then
            local rpos = role:GetPosition()
            local dx = rpos.x - pos.x
            local dz = rpos.z - pos.z
            local distSqr = dx * dx + dz * dz
            if distSqr <= trackRangeSqr and (minDistSqr == nil or distSqr < minDistSqr) then
                minDistSqr = distSqr
                nearest = role
            end
        end
    end
    return nearest
end

---匀速旋转飞行方向（仅 Y 轴）
---@param targetDirection Vector3 目标朝向（可未归一化）
---@param deltaTime number
function SurvivalBullet:RotateDirectionTowards(targetDirection, deltaTime)
    local flatTarget = Vector3(targetDirection.x, 0, targetDirection.z)
    if flatTarget == Vector3.zero then
        return
    end
    flatTarget = flatTarget.normalized

    local currentX, currentZ = self.direction.x, self.direction.z
    local currentSqrMag = currentX * currentX + currentZ * currentZ
    if currentSqrMag < 1e-6 then
        self:ChangeDirection(flatTarget)
        return
    end

    local currentAngle = math.atan2(currentX, currentZ)
    local targetAngle = math.atan2(flatTarget.x, flatTarget.z)
    local angleDiff = targetAngle - currentAngle
    while angleDiff > math.pi do
        angleDiff = angleDiff - 2 * math.pi
    end
    while angleDiff < -math.pi do
        angleDiff = angleDiff + 2 * math.pi
    end

    local maxRotate = self._turnSpeed * Mathf.Deg2Rad * deltaTime
    local newAngle
    if math.abs(angleDiff) <= maxRotate then
        newAngle = targetAngle
    else
        newAngle = currentAngle + maxRotate * (angleDiff > 0 and 1 or -1)
    end
    self:ChangeDirection(Vector3(math.sin(newAngle), 0, math.cos(newAngle)))
end

---设置位置
---@param position Vector3 起始位置
function SurvivalBullet:ChangePos(position)
    self.position = position
    --同步位置
    self.block.x = math.floor(position.x)
    self.block.z = math.floor(position.z)
    if self.obj then
        self.obj.transform.position = position
    end
    if self.modelObj then
        if not self._spawnPosSet then
            self._spawnPosSet = true
        elseif not self._trailEmittingInited then
            self:ClearTrail(self.modelObj)
            self:SetTrailEmitting(self.modelObj, true)
            self:SetTorpedoEffect(self.modelObj, true)
            self._trailEmittingInited = true
        end
    end
end

---获取位置
function SurvivalBullet:GetPosition()
    return self.position
end

---设置方向
---@param direction Vector3 方向
function SurvivalBullet:ChangeDirection(direction)
    self.direction = direction
    if self.obj then
        self.obj.transform.forward = direction
    end
end

---获取方向
function SurvivalBullet:GetDirection()
    return self.direction
end

---设置技能id
---@param skillId integer 技能id
function SurvivalBullet:SetSkillId(skillId)
    self.skillId = skillId
end

---获取技能id
function SurvivalBullet:GetSkillId()
    return self.skillId
end

---设置发射者角色实例id
---@param ownerRoleId integer
function SurvivalBullet:SetOwnerRoleId(ownerRoleId)
    self.ownerRoleId = ownerRoleId
end

---获取发射者角色实例id
---@return integer
function SurvivalBullet:GetOwnerRoleId()
    return self.ownerRoleId
end

---设置子弹伤害类型
---@param damageType GE.SurvivalBulletDamageType 伤害类型
function SurvivalBullet:SetDamageType(damageType)
    self.damageType = damageType
end

---获取子弹伤害类型
function SurvivalBullet:GetDamageType()
    return self.damageType
end

---设置仅目标列表
---@param onlyList table<integer> 仅目标列表
function SurvivalBullet:SetOnlyList(onlyList)
    self.onlyList = onlyList
end

---获取仅目标列表
function SurvivalBullet:GetOnlyList()
    return self.onlyList
end

---设置禁止目标列表
---@param forbiddenList table<integer> 禁止目标列表
function SurvivalBullet:SetForbiddenList(forbiddenList)
    self.forbiddenList = forbiddenList
end

---获取禁止目标列表
function SurvivalBullet:GetForbiddenList()
    return self.forbiddenList
end

---获取子弹半径
---@return number 半径
function SurvivalBullet:GetHalfRange()
    return self:GetAttr(GE.SurvivalAttribType.BulletRange)/2
end

---根据伤害类型获取子弹伤害
---@param type GE.SurvivalBulletDamageType 伤害类型
---@return number 伤害
function SurvivalBullet:GetDamageByDmgType(type)
    local damage = 0
    if type == GE.SurvivalBulletDamageType.Torpedo then
        damage = self._attribute[GE.SurvivalAttribType.TorpedoAttack]
    elseif type == GE.SurvivalBulletDamageType.Bullet then
        damage = self._attribute[GE.SurvivalAttribType.BulletAttack]
    end
    return damage
end

---@param chargeBonus table<integer, number>|nil
function SurvivalBullet:SetChargeBonus(chargeBonus)
    self._chargeBonus = chargeBonus
end

---解析 effectParameter[5] 追踪参数（startPos 在 SkillManager:ResolveBulletStartPos 中解析）
---@param trackParam table|nil {track, trackRange, turnSpeed, startPos}
function SurvivalBullet:InitTrackParam(trackParam)
    self._trackEnabled = false
    self._trackRange = 0
    self._turnSpeed = 0
    self._trackTargetId = nil
    self._trackSearchCooldown = 0
    if not trackParam then
        return
    end
    self._trackEnabled = trackParam.track == 1
    self._trackRange = trackParam.trackRange or 0
    self._turnSpeed = trackParam.turnSpeed or 0
end

---刷新子弹属性 根据角色属性、角色属性权重、技能基础属性来计算
---@param typeList table<SurvivalAttribType, number> 需要刷新属性列表 没有则全量刷新
function SurvivalBullet:RefreshAttr(typeList)
    local skillMgr = SurvivalManager.instance():GetSkillMgr()
    local cfg = Config.GetSurvivorSkillInfo(self.skillId)
    if not cfg then
        LuaLogger.ws("SurvivalBullet:RefreshAttr: skill not found: ", self.skillId)
        return
    end
    local skillParam = cfg.effectParameter
    local roleAttr = self:GetRoleAttr()
    local skillBaseAttr = skillMgr:GetBaseAttrFormSkill(skillParam)
    skillMgr:ApplyChargeBonus(skillBaseAttr, self._chargeBonus)
    self:InitTrackParam(skillParam[5])
    -- LuaLogger.ds("SurvivalBullet:RefreshAttr: skillBaseAttr: ", tablex.dump(skillBaseAttr))
    local roleAddAttr = skillMgr:GetBaseAttrFromRole(roleAttr, skillParam)
    -- LuaLogger.ds("SurvivalBullet:RefreshAttr: roleAddAttr: ", tablex.dump(roleAddAttr))
    local changeList = {}
    --全量刷新
    if not typeList then
        self._attribute = {}
        for attrType, value in pairs(skillBaseAttr) do
            self._attribute[attrType] = value + (roleAddAttr[attrType] or 0)
            changeList[#changeList + 1] = attrType
        end
        for attrType, value in pairs(roleAddAttr) do
            if not self._attribute[attrType] then
                self._attribute[attrType] = value
                changeList[#changeList + 1] = attrType
            end
        end
    --指定属性列表刷新
    else
        for _, attrType in pairs(typeList) do
            local skillValue = skillBaseAttr[attrType] or 0
            local roleValue = roleAddAttr[attrType] or 0
            self._attribute[attrType] = skillValue + roleValue
            changeList[#changeList + 1] = attrType
        end
    end
    -- LuaLogger.ds("SurvivalBullet:RefreshAttr: 属性变更列表changeList: ", tablex.dump(changeList))
    -- LuaLogger.ds("SurvivalBullet:RefreshAttr: 子弹属性: ", tablex.dump(self._attribute))
    ---碰撞有修改
    if tablex.contains(changeList, GE.SurvivalAttribType.BulletRange) then
        local bulletMgr = SurvivalManager.instance():GetBulletMgr()
        local bulletRange = self:GetAttr(GE.SurvivalAttribType.BulletRange) or 0
        if bulletRange > bulletMgr:GetTeamMaxRange(self:GetTeam()) then
            bulletMgr:SetTeamMaxRange(self:GetTeam(), bulletRange)
        elseif bulletRange < bulletMgr:GetTeamMaxRange(self:GetTeam()) then
            bulletMgr:ReCalMaxRange(self:GetTeam())
        end
    end
end

---获取属性
function SurvivalBullet:GetAttr(attrType)
    return self._attribute[attrType]
end

---初始化角色属性 角色属性在子弹生成时确定 后续不再变化
---@param roleAttribute table<SurvivalAttribType, number> 角色属性
function SurvivalBullet:InitRoleAttr(roleAttribute)
    self._roleAttribute = roleAttribute
end

---获取角色属性
function SurvivalBullet:GetRoleAttr()
    return self._roleAttribute
end

---设置阵营
---@param team GE.SurvivalTeam 阵营
function SurvivalBullet:SetTeam(team)
    self.team = team
end

---获取阵营
function SurvivalBullet:GetTeam()
    return self.team
end

---绑定对象
---@param obj UnityEngine.GameObject 对象
function SurvivalBullet:BindObj(obj, modelObj)
    self.obj = obj
    self.modelObj = modelObj
    self.modelObj.transform.parent = self.obj.transform
    self.modelObj.transform.localPosition = Vector3.zero
    self.modelObj.transform.localRotation = Quaternion.identity
    self.modelObj.transform.localScale = Vector3(1, 1, 1)
    local range = self:GetAttr(GE.SurvivalAttribType.BulletRange)
    if range then
        -- self.obj.transform.localScale = Vector3(range, range, range)
        self.modelObj.transform.localScale = Vector3(range, range, range)
    end
    local rangeObj = obj.transform:Find("range")
    if rangeObj then
        rangeObj.gameObject:SetActive(SurvivalManager.instance():GetIsShowRange())
        if SurvivalManager.instance():GetIsShowRange() then
            rangeObj.transform.localScale = Vector3(range, 0, range)
        end
    end
    self._trailEmittingInited = false
    self._spawnPosSet = false
    if self.modelObj then
        self:ClearTrail(self.modelObj)
        self:SetTorpedoEffect(self.modelObj, false)
    end
end

---设置鱼雷特效（Effect 子节点显隐）
---@param obj UnityEngine.GameObject
---@param isShow boolean
function SurvivalBullet:SetTorpedoEffect(obj, isShow)
    if not obj then
        return
    end
    local trans = UICommonUtils.FindDeepChild(obj.transform, "Effect")
    if trans then
        trans.gameObject:SetActive(isShow)
    end
end

---是否包含拖尾渲染器
---@param obj UnityEngine.GameObject
---@return boolean
function SurvivalBullet:HasTrailRenderer(obj)
    if not obj then
        return false
    end
    local trails = self:findComponent(obj, typeof(UnityEngine.TrailRenderer))
    return #trails > 0
end

---拖尾渐隐结束后再回收对象（隐藏 Mesh，等待拖尾消失）
---@param obj UnityEngine.GameObject
---@param onComplete function|nil
function SurvivalBullet:TrailEmittingEnd(obj, onComplete)
    local maxTime = 0
    local trails = self:findComponent(obj, typeof(UnityEngine.TrailRenderer))
    for _, trail in pairs(trails) do
        trail.emitting = false
        maxTime = math.max(maxTime, trail.time)
    end
    local meshRenders = self:findComponent(obj, typeof(UnityEngine.MeshRenderer))
    for _, meshRender in pairs(meshRenders) do
        meshRender.enabled = false
    end
    self:SetTorpedoEffect(obj, false)
    self._trailEndTimer = SurvivalManager.instance():_DoAfter(maxTime, function()
        self._trailEndTimer = nil
        for _, meshRender in pairs(meshRenders) do
            meshRender.enabled = true
        end
        if onComplete then
            onComplete()
        end
    end)
end

---设置拖尾发射状态
function SurvivalBullet:SetTrailEmitting(obj, isEmitting)
    local trails = self:findComponent(obj, typeof(UnityEngine.TrailRenderer))
    for _, trail in pairs(trails) do
        trail.emitting = isEmitting
    end
end

---清空拖尾残留（对象池复用时调用）
---@param obj UnityEngine.GameObject
function SurvivalBullet:ClearTrail(obj)
    if not obj then
        return
    end
    local trails = self:findComponent(obj, typeof(UnityEngine.TrailRenderer))
    for _, trail in pairs(trails) do
        trail.emitting = false
        trail:Clear()
    end
end

function SurvivalBullet:findComponent(obj, component, result)
    result = result or {}
    local trans = obj.transform
    for i = 0, trans.childCount - 1 do
        local child = trans:GetChild(i)
        local childObj = child.gameObject
        local target = child:GetComponent(component)
        if target then
            table.insert(result, target)
        end
        self:findComponent(childObj, component, result)
    end
    return result
end

---获取对象
function SurvivalBullet:GetObj()
    return self.obj
end

---设置ID
---@param id integer ID
function SurvivalBullet:SetId(id)
    self.id = id
end

---获取ID
function SurvivalBullet:GetId()
    return self.id
end

---设置子弹是否存活
function SurvivalBullet:SetAlive(alive)
    self.alive = alive
end

---获取子弹是否存活
function SurvivalBullet:IsAlive()
    return self.alive
end

---获取子弹穿透次数
function SurvivalBullet:GetPenetrationTime()
    return self.penetrationTime
end

---是否已命中过该角色
---@param role SurvivalRole
---@return boolean
function SurvivalBullet:HasHitRole(role)
    return role ~= nil and self._hitRoleIds[role.id] == true
end

---子弹命中角色
---@param role SurvivalRole 命中角色
function SurvivalBullet:OnHit(role)
    self._hitRoleIds[role.id] = true
    if self._trackTargetId == role.id then
        self._trackTargetId = nil
        self._trackSearchCooldown = 0
    end
    --增加命中次数
    self.penetrationTime = self.penetrationTime + 1
    if self.penetrationTime > (self._attribute[GE.SurvivalAttribType.BulletPenetration] or 0) then
        SurvivalManager.instance():GetBulletMgr():DestroyBullet(self.id)
    end
end

---销毁子弹
function SurvivalBullet:OnDestroy()
    self:SetAlive(false)
    local visualObj = self.modelObj
    if visualObj and self:HasTrailRenderer(visualObj) then
        self:TrailEmittingEnd(visualObj, function()
            self:FreeObjects()
            self:ResetState()
        end)
    else
        self:Clear()
    end
end

function SurvivalBullet:ResetState()
    self._hitRoleIds = {}
    self._chargeBonus = nil
    self._trackEnabled = false
    self._trackRange = 0
    self._turnSpeed = 0
    self._trackTargetId = nil
    self._trackSearchCooldown = 0
    self._trailEmittingInited = false
    self._spawnPosSet = false
    self.ownerRoleId = 0
end

function SurvivalBullet:FreeObjects()
    if self.modelObj then
        self:ClearTrail(self.modelObj)
        self:SetTorpedoEffect(self.modelObj, false)
        PoolMgr.Free(self.modelObj)
        self.modelObj = nil
    end
    if self.obj then
        PoolMgr.Free(self.obj)
        self.obj = nil
    end
end

function SurvivalBullet:Clear()
    if self._trailEndTimer then
        DLuaTimer:RemoveTimer(self._trailEndTimer)
        self._trailEndTimer = nil
    end
    self:ResetState()
    self:FreeObjects()
end

return SurvivalBullet