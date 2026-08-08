require "class"
local SurvivalRole = class("SurvivalRole")
-- 角色模型 prefab 默认水平直径（世界单位），用于把 Range（直径）换算成缩放
local ROLE_MODEL_BASE_DIAMETER = 0.6
-- 角色模型水平转向角速度（度/秒）
local ROLE_ROTATE_SPEED = 720

function SurvivalRole:ctor(...)
    self.isRole = true
    self.roleModel = nil    --角色模型obj
    self.modelController = nil    --模型控制器
    self.obj = nil    --survivalRole对象
    self.position = Vector3.zero    --当前位置
    ---@class SurvivalRoleSkill
    ---@field skillId integer 技能配置id
    ---@field cdRemain number 技能CD剩余时间
    ---@field MaxCd number    技能最大cd
    ---@field trigger table|nil 技能触发条件（配置表 trigger 字段）
    ---@type table<integer, SurvivalRoleSkill> 技能列表
    self.skillList = {} --技能列表
    self.direction = Vector3.zero --朝向
    self.id = 0 --角色id
    self.team = nil --阵营
    self.shipType = nil --角色舰装类型
    self.isPlayer = false --是否是玩家角色
    self.playerSlot = nil --玩家编队槽位 1~3
    self.roleCfgId = nil --角色配置id（用于头像等资源）
    self.survivorRoleId = nil --SurvivorRoleTable id（掉落等）
    self._isOnField = true --是否在场（上场角色可见且参与战斗）
    self.block = {
        x = 0,
        z = 0
    }

    -- 受击 CD
    self._colliderCdRemain = 0          -- 剩余 CD（秒）
    self._colliderCdDuration = 0.5      -- 默认受击 CD，可放 _baseAttribute 或配置
    -- 击退
    self._knockbackRemain = 0      -- 剩余击退时间
    self._knockbackSpeed = 0
    self._knockbackDirection = Vector3.zero

    self._currentHp = 0 --当前血量
    self._isAlive = true --是否存活
    ---@type table<SurvivalAttribType, number> 角色真实属 经性过各种加成后的最终属性
    self._attribute = {} --角色真实属性
    ---@type table<SurvivalAttribType, number> 默认属性
    self._baseAttribute = {
        [GE.SurvivalAttribType.Hp] = 1,
        [GE.SurvivalAttribType.BulletAttack] = 0,
        [GE.SurvivalAttribType.TorpedoAttack] = 0,
        [GE.SurvivalAttribType.CollisionAttack] = 0,
        [GE.SurvivalAttribType.Armor] = 0,
        [GE.SurvivalAttribType.Evade] = 0,
        [GE.SurvivalAttribType.AirDefense] = 0,
        [GE.SurvivalAttribType.Lucky] = 0,
        [GE.SurvivalAttribType.ExtraBulletNum] = 0,
        [GE.SurvivalAttribType.BulletSpeed] = 0,
        [GE.SurvivalAttribType.BulletAngle] = 0,
        [GE.SurvivalAttribType.MoveSpeed] = 0,
        [GE.SurvivalAttribType.Range] = 0,
        [GE.SurvivalAttribType.BulletRange] = 0,
    }
    --角色技能索引
    self.skillIndex = 0
    -- 技能攻击期间 roleModel 朝向锁定（不影响 self.direction 与移动）
    self._skillDirection = nil
    self._isSkillActing = false
    self._playingAnimName = nil
end

--帧同步
function SurvivalRole:Update(deltaTime)
    if not self._isAlive or not self._isOnField then
        return
    end
    --技能CD
    for index, skill in pairs(self.skillList) do
        if skill.cdRemain > 0 then
            skill.cdRemain = skill.cdRemain - deltaTime
            if skill.cdRemain <= 0 then
                skill.cdRemain = 0
            end
            self:_notifySkillCdChange(index)
        end
        --触发自动技能（skillType=Auto 且 CD 结束）
        local cfg = Config.GetSurvivorSkillInfo(skill.skillId)
        if skill.cdRemain == 0
            and skill.trigger
            and skill.trigger[1] == GE.SurvivalSkillTriggerType.CdEnd then
            local isUsed, feedBack = SurvivalManager.instance():GetSkillMgr():DoSkill(self, index)
            if isUsed then
                skill.cdRemain = skill.MaxCd
                self:_notifySkillCdChange(index)
                --取消转向
                -- if feedBack and feedBack.direction and feedBack.direction ~= Vector3.zero then
                --     self:PlaySkillAttack(feedBack)
                -- end
            end
        end
    end
    --受击CD
    if self._colliderCdRemain > 0 then
        self._colliderCdRemain = self._colliderCdRemain - deltaTime
        if self._colliderCdRemain <= 0 then
            self._colliderCdRemain = 0
        end
    end
    --击退
    if self._knockbackRemain > 0 then
        self._knockbackRemain = self._knockbackRemain - deltaTime
        if self._knockbackRemain <= 0 then
            self._knockbackRemain = 0
            self._knockbackDirection = Vector3.zero
            self._knockbackSpeed = 0
        end
    end
    self:UpdatePosition(deltaTime)
end


---初始化基础属性
function SurvivalRole:InitBaseAttr(baseAttr)
    -- LuaLogger.ds("SurvivalRole:InitBaseAttr baseAttr", tablex.dump(baseAttr))
    for attribType, value in pairs(baseAttr) do
        self._baseAttribute[attribType] = value
    end
end

---初始化属性 基础属性和技能 角色真实属性等于默认属性加上技能加成
---@param isInit boolean 是否是初始化
---@param typeList GE.SurvivalAttribType[] 需要刷新属性列表 没有则全量刷新
function SurvivalRole:RefreshAttr(isInit, typeList)
    local targetTypeList = typeList or {}
    if #targetTypeList == 0 then
        for attribType, value in pairs(self._baseAttribute) do
            table.insert(targetTypeList, attribType)
        end
    end
    --刷新最大血量显示
    local needRefreshHpUi = tablex.contains(targetTypeList, GE.SurvivalAttribType.Hp)
    local oldMaxHp = needRefreshHpUi and (self:GetMaxHp() or 0) or nil
    --刷新角色真实属性
    for _, attribType in pairs(targetTypeList) do
        local baseValue = self._baseAttribute[attribType] or 0
        local skillBonus = SurvivalManager.instance():GetSkillMgr():CollectSkillAttrBonus(self)
        self._attribute[attribType] = baseValue + (skillBonus[attribType] or 0)
    end
    --若当前血量大于最大血量，则设置为最大血量
    if isInit or self._currentHp > self:GetMaxHp() then
        self._currentHp = self:GetMaxHp()
    end
    --刷新最大碰撞范围（Range 为直径）
    local shouldUpdateRange =  tablex.contains(targetTypeList, GE.SurvivalAttribType.Range)
    if shouldUpdateRange then
        local roleMgr = SurvivalManager.instance():GetRoleMgr()
        local roleRange = self:GetAttr(GE.SurvivalAttribType.Range) or 0
        if roleRange > roleMgr:GetTeamMaxRange(self:GetTeam()) then
            roleMgr:SetTeamMaxRange(self:GetTeam(), roleRange)
        elseif roleRange < roleMgr:GetTeamMaxRange(self:GetTeam()) then
            roleMgr:ReCalMaxRange(self:GetTeam())
        end
        self:UpdateRangeVisual()
    end
    --编队成员最大血量变更时刷新 UI（hpText 与右上角头像血条）
    if needRefreshHpUi and self.playerSlot then
        local newMaxHp = self:GetMaxHp()
        if isInit or oldMaxHp ~= newMaxHp then
            SurvivalManager.instance():GetEventMgr():AddEvent(0, GE.SurvivalEventType.PlayerHpChange)
        end
    end
end

---获取基础属性
---@param attribType SurvivalAttribType 属性类型
---@return number 属性值
function SurvivalRole:GetBaseAttr(attribType)
    return self._baseAttribute[attribType]
end

---获取真实属性
---@param attribType SurvivalAttribType 属性类型
---@return number 属性值
function SurvivalRole:GetAttr(attribType)
    return self._attribute[attribType]
end

---获取全部真实属性
---@return table<SurvivalAttribType, number> 全部真实属性
function SurvivalRole:GetAllAttr()
    return self._attribute
end

--获取血量
function SurvivalRole:GetHp()
    return self._currentHp
end

---根据伤害类型获取防御力
---@param type GE.SurvivalBulletDamageType 伤害类型
---@return number 防御力
function SurvivalRole:GetDefenseByDmgType(type)
    local defense = 0
    if type == GE.SurvivalBulletDamageType.Torpedo then
        defense = self._attribute[GE.SurvivalAttribType.Evade]
    elseif type == GE.SurvivalBulletDamageType.Bullet then
        defense = self._attribute[GE.SurvivalAttribType.Armor]
    end
    return defense
end

---获取受击CD剩余时间
---@return number 剩余时间
function SurvivalRole:GetHitCdRemain()
    return self._colliderCdRemain
end

---设置受击CD 仅玩家角色可以设置
---@param cdRemain number 剩余时间
function SurvivalRole:SetHitCdRemain(cdRemain)
    if not self:IsPlayer() then
        return
    end
    self._colliderCdRemain = cdRemain
end

---获取是否存活
function SurvivalRole:IsAlive()
    return self._isAlive
end

---获取最大血量
function SurvivalRole:GetMaxHp()
    return self._attribute[GE.SurvivalAttribType.Hp]
end

---设置阵营
function SurvivalRole:SetTeam(team)
    self.team = team
end

---获取阵营
function SurvivalRole:GetTeam()
    return self.team
end

---设置舰装类型
function SurvivalRole:SetShipType(shipType)
    self.shipType = shipType
end

---获取舰装类型
function SurvivalRole:GetShipType()
    return self.shipType
end

---设置角色id
function SurvivalRole:SetId(id)
    self.id = id
end

---获取是否为主控角色
function SurvivalRole:IsPlayer()
    return self.isPlayer
end

---设置是否为主控角色
function SurvivalRole:SetIsPlayer(isPlayer)
    self.isPlayer = isPlayer
end

---设置玩家编队槽位
function SurvivalRole:SetPlayerSlot(slot)
    self.playerSlot = slot
end

---获取玩家编队槽位
function SurvivalRole:GetPlayerSlot()
    return self.playerSlot
end

---设置角色配置id
function SurvivalRole:SetRoleCfgId(roleCfgId)
    self.roleCfgId = roleCfgId
end
---获取角色配置id
function SurvivalRole:GetRoleCfgId()
    return self.roleCfgId
end

function SurvivalRole:SetSurvivorRoleId(survivorRoleId)
    self.survivorRoleId = survivorRoleId
end

function SurvivalRole:GetSurvivorRoleId()
    return self.survivorRoleId
end

---设置是否在场
function SurvivalRole:SetOnField(isOnField)
    self._isOnField = isOnField
    if self.obj then
        self.obj:SetActive(isOnField)
        if isOnField then
            local rangeObj = self.obj.transform:Find("range")
            if rangeObj then
                rangeObj.gameObject:SetActive(SurvivalManager.instance():GetIsShowRange())
            end
        end
    end
end

---是否在场
function SurvivalRole:IsOnField()
    return self._isOnField
end

---是否为纯被动技能（skillType = Passive）
---@param skillId integer
---@return boolean
function SurvivalRole:IsPassiveSkillId(skillId)
    local cfg = Config.GetSurvivorSkillInfo(skillId)
    return cfg ~= nil and cfg.skillType == GE.SurvivalSkillReleaseType.Passive
end

---技能是否会改变角色真实属性（effectType = AttributeBonus）
---@param skillId integer
---@return boolean
function SurvivalRole:DoesSkillAffectRoleAttr(skillId)
    local cfg = Config.GetSurvivorSkillInfo(skillId)
    return cfg ~= nil and cfg.effectType == GE.SurvivalSkillType.AttributeBonus
end

---是否为手动释放技能（skillType = Manual）
---@param skillId integer
---@return boolean
function SurvivalRole:IsActiveSkillId(skillId)
    local cfg = Config.GetSurvivorSkillInfo(skillId)
    return cfg ~= nil and cfg.skillType == GE.SurvivalSkillReleaseType.Manual
end

---是否为自动释放技能（skillType = Auto，显示在自动技能栏）
---@param skillId integer
---@return boolean
function SurvivalRole:IsAutoSkillId(skillId)
    local cfg = Config.GetSurvivorSkillInfo(skillId)
    return cfg ~= nil and cfg.skillType == GE.SurvivalSkillReleaseType.Auto
end

---获取主动释放技能及索引
---@return SurvivalRoleSkill|nil skill
---@return integer|nil index
function SurvivalRole:GetActiveSkill()
    for index = 1, self.skillIndex do
        local skill = self.skillList[index]
        if skill and self:IsActiveSkillId(skill.skillId) then
            return skill, index
        end
    end
    return nil, nil
end

---获取自动释放技能列表（最多6个，按持有顺序）
---@return SurvivalRoleSkill[]
function SurvivalRole:GetAutoSkillList()
    local list = {}
    for index = 1, self.skillIndex do
        local skill = self.skillList[index]
        if skill and self:IsAutoSkillId(skill.skillId) then
            list[#list + 1] = skill
        end
    end
    return list
end

function SurvivalRole:_notifySkillUI()
    if not self.isPlayer then
        return
    end
    local ui = SurvivalManager.instance():GetMainUI()
    if ui and ui.UpdateSkillButtons then
        ui:UpdateSkillButtons()
    end
end

---主控角色技能CD变化时通知UI
---@param skillIndex integer
function SurvivalRole:_notifySkillCdChange(skillIndex)
    if not self.isPlayer then
        return
    end
    local skill = self.skillList[skillIndex]
    if not skill then
        return
    end
    local ui = SurvivalManager.instance():GetMainUI()
    if ui and ui.UpdateSkillCdByIndex then
        ui:UpdateSkillCdByIndex(skillIndex, skill.cdRemain, skill.MaxCd)
    end
end

---新增技能列表
---@param skillList integer[] 技能列表
function SurvivalRole:AddSkillList(skillList)
    local needRefreshAttr = false
    for _, id in pairs(skillList) do
        local cfg = Config.GetSurvivorSkillInfo(id)
        if not cfg then
            LuaLogger.ws("SurvivalRole:AddSkillList skill not found", id)
            goto continue
        end
        ---@type SurvivalRoleSkill
        local temp = {
            skillId = id,
            cdRemain = 0,
            MaxCd = cfg.cd,
            trigger = cfg.trigger,
        }
        self.skillIndex = self.skillIndex + 1
        self.skillList[self.skillIndex] = temp
        if self:DoesSkillAffectRoleAttr(id) then
            needRefreshAttr = true
        end
        ::continue::
    end
    if needRefreshAttr then
        self:RefreshAttr(false)
    end
    self:_notifySkillUI()
end

---按技能配置id移除技能
---@param skillId integer
---@return boolean
function SurvivalRole:RemoveSkillById(skillId)
    for index, skill in pairs(self.skillList) do
        if skill.skillId == skillId then
            local needRefreshAttr = self:DoesSkillAffectRoleAttr(skillId)
            self.skillList[index] = nil
            if needRefreshAttr then
                self:RefreshAttr(false)
            end
            self:_notifySkillUI()
            return true
        end
    end
    return false
end

---按技能id列表移除技能
---@param skillList integer[]
function SurvivalRole:RemoveSkillList(skillList)
    local changed = false
    local needRefreshAttr = false
    for _, skillId in pairs(skillList) do
        for index, skill in pairs(self.skillList) do
            if skill and skill.skillId == skillId then
                if self:DoesSkillAffectRoleAttr(skillId) then
                    needRefreshAttr = true
                end
                self.skillList[index] = nil
                changed = true
                break
            end
        end
    end
    if changed then
        if needRefreshAttr then
            self:RefreshAttr(false)
        end
        self:_notifySkillUI()
    end
end

---根据索引获取技能
---@param index integer 技能索引
---@return SurvivalRoleSkill 技能
function SurvivalRole:GetSkillByIndex(index)
    return self.skillList[index] or nil
end

---获取主动释放技能索引
---@return integer|nil index
function SurvivalRole:GetManualSkillIndex()
    local _, index = self:GetActiveSkill()
    return index
end

---获取朝向
---@return Vector3 朝向
function SurvivalRole:GetDirection()
    return self.direction
end

---当前是否有 Trigger 动画正在播放
function SurvivalRole:IsAnimPlaying()
    if not self._playingAnimName or not self.modelController then
        return false
    end
    local anim = self.modelController.anim
    if not anim then
        self._playingAnimName = nil
        return false
    end
    local stateInfo = anim:GetCurrentAnimatorStateInfo(0)
    local t = stateInfo.normalizedTime
    local finished = t >= 0.99 or (stateInfo.loop and (t % 1) >= 0.99)
    if stateInfo:IsName(self._playingAnimName) and not finished then
        return true
    end
    self._playingAnimName = nil
    return false
end

---播放 Trigger 动画；若已有动画在播则跳过
---@param animName string 动画名（RoleModelAnimEnum）
---@param onComplete function|nil 播放结束回调
---@param force boolean 是否强制播放
---@return boolean 是否成功开始播放
function SurvivalRole:PlayAnim(animName, onComplete, force)
    if not self.modelController then
        return false
    end
    if not force and self:IsAnimPlaying() then
        return false
    end
    self._playingAnimName = animName
    self.modelController:PlayAnim(animName, function()
        if self._playingAnimName == animName then
            self._playingAnimName = nil
        end
        if onComplete then
            onComplete()
        end
    end)
    return true
end

---技能攻击：锁定 roleModel 朝向、播放攻击动作，结束后恢复为移动朝向
---@param feedBack table 技能反馈
function SurvivalRole:PlaySkillAttack(feedBack)
    if not self.modelController then
        return
    end
    local direction = feedBack.direction
    direction = Vector3(direction.x, 0, direction.z)

    self._skillDirection = direction.normalized
    self._isSkillActing = true
    self._skillTarget = feedBack.target
    if not self:PlayAnim(RoleModelAnimEnum.Attack, function()
        self:OnSkillAttackComplete()
    end) then
        self:OnSkillAttackComplete()
    end
end

---技能攻击动作结束，恢复 roleModel 为当前移动朝向
function SurvivalRole:OnSkillAttackComplete()
    if not self._isAlive then
        return
    end
    self._isSkillActing = false
    self._skillDirection = nil
    self._skillTarget = nil
end

---立即同步 roleRoot 朝向（仅 Y 轴，无视匀速旋转）
---@param targetDirection Vector3 目标朝向
function SurvivalRole:SyncRoleRootDirection(targetDirection)
    if not self.roleRoot or targetDirection == Vector3.zero then
        return
    end
    local flatTarget = Vector3(targetDirection.x, 0, targetDirection.z)
    if flatTarget == Vector3.zero then
        return
    end
    self.roleRoot.transform.forward = flatTarget.normalized
end

---匀速旋转 roleRoot 朝向目标方向（仅 Y 轴）
---@param targetDirection Vector3 目标朝向
---@param deltaTime number 帧间隔
function SurvivalRole:RotateRoleRootTowards(targetDirection, deltaTime)
    if not self.roleRoot or targetDirection == Vector3.zero then
        return
    end
    local flatTarget = Vector3(targetDirection.x, 0, targetDirection.z)
    if flatTarget == Vector3.zero then
        return
    end
    --敌人朝向直接设置
    if self.team == GE.SurvivalTeam.enemy then
        self.roleRoot.transform.forward = flatTarget
        return
    end
    flatTarget = flatTarget.normalized

    local forward = self.roleRoot.transform.forward
    local currentX, currentZ = forward.x, forward.z
    local currentSqrMag = currentX * currentX + currentZ * currentZ
    if currentSqrMag < 1e-6 then
        self.roleRoot.transform.forward = flatTarget
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

    local maxRotate = ROLE_ROTATE_SPEED * Mathf.Deg2Rad * deltaTime
    local newAngle
    if math.abs(angleDiff) <= maxRotate then
        newAngle = targetAngle
    else
        newAngle = currentAngle + maxRotate * (angleDiff > 0 and 1 or -1)
    end
    self.roleRoot.transform.forward = Vector3(math.sin(newAngle), 0, math.cos(newAngle))
end

---更新朝向（self.direction 仅用于移动，视觉朝向作用于 roleModel）
---@param deltaTime number 帧间隔
function SurvivalRole:UpdateDirection(deltaTime)
    --玩家朝向
    if self.isPlayer then
        local inputDirection = SurvivalManager.instance():GetInputDirection()
        if inputDirection == Vector2.zero
            or (SurvivalManager.instance():IsSkillCharging()
                and not SurvivalManager.instance():CanMoveWhileSkillCharging()) then
            self.direction = Vector3.zero
        else
            local cameraRotationY = SurvivalManager.instance():GetCameraRotationY()
            local theta_cam = cameraRotationY * Mathf.Deg2Rad
            local theta_ui = math.atan2(inputDirection.x, inputDirection.y)
            local theta_world  = theta_ui + theta_cam
            self.direction = Vector3(
                math.sin(theta_world),
                0,
                math.cos(theta_world)
            )
        end
    end
    --敌人朝向
    if self.team == GE.SurvivalTeam.enemy then
        --todo target类型区分 现在默认为主角
        local playerRole = SurvivalManager.instance():GetRoleMgr():GetPlayerRole()
        if playerRole then
            self.direction = (playerRole.position - self.position).normalized
            self.direction.y = 0
        end
    end

    local targetForward = nil
    --模型朝向 技能瞄准阶段
    if self.isPlayer and SurvivalManager.instance():IsSkillAiming() then
        local aimDir = SurvivalManager.instance():GetSkillAimDirection()
        if aimDir ~= Vector3.zero then
            targetForward = aimDir
        end
    end
    --模型朝向 有技能释放时
    if not targetForward and self._isSkillActing then
        --有目标优先朝向目标
        if self._skillTarget and self._skillTarget:IsAlive() and self._skillTarget:IsOnField() then
            local dir = (self._skillTarget:GetPosition() - self.position).normalized
            targetForward = Vector3(dir.x, 0, dir.z)
        --没有目标朝向技能方向
        elseif self._skillDirection then
            targetForward = self._skillDirection
        --没有目标也没有技能方向朝向当前移动朝向
        elseif self.direction ~= Vector3.zero then
            targetForward = self.direction
        end
    elseif self.direction ~= Vector3.zero then
        targetForward = self.direction
    end

    if targetForward then
        self:RotateRoleRootTowards(targetForward, deltaTime)
    end
end

---获取位置
---@return Vector3 位置
function SurvivalRole:GetPosition()
    return self.position
end

---获取半径
---@return number 半径
function SurvivalRole:GetHalfRange()
    return self:GetAttr(GE.SurvivalAttribType.Range)/2
end

---改变位置
function SurvivalRole:ChangePos(Vec3)
    self.position = Vec3
    --同步角色地格
    self.block.x = math.floor(Vec3.x)
    self.block.z = math.floor(Vec3.z)
    -- LuaLogger.ds("SurvivalRole:ChangePos self.block", tablex.dump(self.block))
    -- 更新角色模型位置
    if self.obj then
        self.obj.transform.position = Vec3
    end
    if self.movingEffect and not self.isInitMovingEffect then
        self:SetTrailEmitting(self.movingEffect.gameObject, true)
        self.isInitMovingEffect = true
    end
end

---更新下一帧位置
function SurvivalRole:UpdatePosition(deltaTime)
    self:UpdateDirection(deltaTime)
    local newPosition = self.position
    --自身移动
    if self.direction ~= Vector3.zero then
        local moveDistance = self:GetAttr(GE.SurvivalAttribType.MoveSpeed) * deltaTime
        newPosition = self.position + self.direction * moveDistance
    end

    --被动移动
    --被击退中
    if self._knockbackRemain > 0 then
        newPosition = newPosition + self._knockbackDirection * self._knockbackSpeed * deltaTime
    end
    --更新位置
    if newPosition ~= self.position then
        self.modelController:SetDefaultState(RoleAnimStateType.Into)
        self:ChangePos(newPosition)
    else
        self.modelController:SetDefaultState(RoleAnimStateType.IdleShip)
    end
end

---@param duration number 击退持续时间(秒)
---@param speed number 击退速度
---@param direction Vector3 击退方向（内部会归一化，Y 置 0）
---@param stack boolean|nil true=与当前击退速度向量叠加（默认 true；remain=0 时仍为新击退）
function SurvivalRole:ApplyKnockback(duration, speed, direction, stack)
    if stack == nil then
        stack = true
    end
    if duration <= 0 or speed <= 0 then
        return
    end
    direction.y = 0
    if direction == Vector3.zero then
        return
    end
    local dir = direction.normalized
    if stack and self._knockbackRemain > 0 then
        local vx = self._knockbackDirection.x * self._knockbackSpeed + dir.x * speed
        local vz = self._knockbackDirection.z * self._knockbackSpeed + dir.z * speed
        local newSpeed = math.sqrt(vx * vx + vz * vz)
        if newSpeed > 0 then
            self._knockbackDirection = Vector3(vx / newSpeed, 0, vz / newSpeed)
            self._knockbackSpeed = newSpeed
        end
        self._knockbackRemain = math.max(self._knockbackRemain, duration)
    else
        self._knockbackRemain = duration
        self._knockbackSpeed = speed
        self._knockbackDirection = dir
    end
end

---绑定对象
function SurvivalRole:BindObj(obj)
    self.obj = obj
    local rangeObj = obj.transform:Find("range")
    if rangeObj then
        rangeObj.gameObject:SetActive(SurvivalManager.instance():GetIsShowRange())
    end
    self.movingEffect = obj.transform:Find("roleRoot/MoveEffect")
    if self.movingEffect then
        self:SetTrailEmitting(self.movingEffect.gameObject, false)
        self.isInitMovingEffect = false
    end
end

--设置拖尾发射状态
function SurvivalRole:SetTrailEmitting(obj, isEmitting)
	local trails = self:findComponent(obj, typeof(UnityEngine.TrailRenderer))
	for _, trail in pairs(trails) do
		trail.emitting = isEmitting
	end
end

function SurvivalRole:findComponent(obj, component, result)
    result = result or {}
    local trans = obj.transform
    
    for i = 0, trans.childCount - 1 do
        local child = trans:GetChild(i)
        local childObj = child.gameObject
        
        local target = child:GetComponent(component)
        if target then
            table.insert(result, target)
        end
        
        -- 继续递归遍历
        self:findComponent(childObj, component, result)
    end
    
    return result
end

---同步碰撞范围可视化（Range 为直径，碰撞半径 = Range/2）
function SurvivalRole:UpdateRangeVisual()
    local range = self:GetAttr(GE.SurvivalAttribType.Range) or 0
    if self.roleModel and range ~= 0 then
        -- 模型默认水平直径约 1，按 Range（直径）缩放 XZ，与碰撞圆一致
        local scale = range
        self.obj.transform.localScale = Vector3(scale, scale, scale)
        local scale = 1/ROLE_MODEL_BASE_DIAMETER
        self.roleModel.transform.localScale = Vector3(scale, scale, scale)
    end
end

--绑定模型
function SurvivalRole:BindModel(modelObj)
    self.roleModel = modelObj
    self.roleRoot = self.obj.transform:Find("roleRoot")
    self.roleRoot.transform.localRotation = Quaternion.identity
    self.parentConstraint = self.roleRoot:GetComponent("ParentConstraint")
    self.roleModel.transform.parent = self.roleRoot
    self.roleModel.transform.localPosition = Vector3.zero
    self.roleModel.transform.localRotation = Quaternion.identity
    self.modelController = self.roleModel.transform:GetComponent("RoleModelController")
    self.roleModel.transform:GetComponent("CapsuleCollider").enabled = false
end

----------------------技能相关----------------------

---计算最终伤害（扣防后向下取整）
---@param attack number 攻击力
---@param defense number|nil 防御力
---@return number
function SurvivalRole:CalcFinalDamage(attack, defense)
    if not attack or attack <= 0 then
        return 0
    end
    local damage = attack
    if defense and defense > 0 then
        damage = attack - defense
    end
    return math.max(0, math.floor(damage))
end

---修改血量
---@param value number 变化值
function SurvivalRole:ChangeHp(value)
    --根据技能计算伤害衰减等
    self._currentHp = self._currentHp + value
    if self._currentHp < 0 then
        self._currentHp = 0
    end
    if self._currentHp > self:GetMaxHp() then
        self._currentHp = self:GetMaxHp()
    end
    --跳字
    local scale = self:GetAttr(GE.SurvivalAttribType.Range)/ROLE_MODEL_BASE_DIAMETER
    -- local x = math.random(-0.1, 0.1)
    -- local z = math.random(-0.1, 0.1)
    SurvivalManager.instance():ShowHitNumber(self.position + Vector3(0, scale, 0), value)
    --广播血量变更
    if self.playerSlot then
        SurvivalManager.instance():GetEventMgr():AddEvent(0, GE.SurvivalEventType.PlayerHpChange)
    end
    --如果血量小于0 则死亡
    if self._currentHp <= 0 then
        self:Die()
    end
end

---角色死亡
function SurvivalRole:Die()
    self._isAlive = false
    self._isSkillActing = false
    self._skillDirection = nil
    SurvivalManager.instance():GetAreaEffectMgr():RemoveFollowByOwner(self.id)
    self:PlayAnim(RoleModelAnimEnum.Die, function()
        if self.team == GE.SurvivalTeam.enemy then
            SurvivalManager.instance():GetItemMgr():TryDropFromRole(self)
        end
        local roleMgr = SurvivalManager.instance():GetRoleMgr()
        --判断是否为编队成员死亡
        if roleMgr:IsSquadMember(self) then
            roleMgr:OnSquadMemberDie(self)
        else
            roleMgr:RemoveRole(self.id)
        end
    end, true)
end

---角色受击角色伤害
---@param role SurvivalRole 攻击方
function SurvivalRole:BeHitByRole(role)
    --todo 根据技能计算伤害衰减等 护甲
    local damage = self:CalcFinalDamage(role:GetAttr(GE.SurvivalAttribType.CollisionAttack))
    if damage > 0 then
        --受击动画
        self:PlayAnim(RoleModelAnimEnum.Hit)
        self:ChangeHp(-damage)
    end
    --反伤
    local reflectDamage = self:CalcFinalDamage(self:GetAttr(GE.SurvivalAttribType.CollisionAttack))
    if reflectDamage > 0 then
        --攻击动画
        role:PlayAnim(RoleModelAnimEnum.Attack)
        role:ChangeHp(-reflectDamage)
    end
    --击退
    self:ApplyKnockback(0.5, 1, self.position - role.position, true)
    role:ApplyKnockback(0.5, 1, role.position - self.position, true)
    --受击CD
    self:SetHitCdRemain(self._colliderCdDuration)
    role:SetHitCdRemain(role._colliderCdDuration)
end

---角色受击子弹伤害
---@param bullet SurvivalBullet 子弹
function SurvivalRole:BeHitByBullet(bullet)
    --todo 根据技能计算伤害衰减等 护甲
    local damageType = bullet:GetDamageType()
    local damage = self:CalcFinalDamage(
        bullet:GetDamageByDmgType(damageType),
        self:GetDefenseByDmgType(damageType)
    )
    --受击CD（碰撞成立即进入，与最终伤害无关）
    self:SetHitCdRemain(self._colliderCdDuration)
    --须在 OnHit 之前缓存：OnHit 可能销毁子弹并清空 ownerRoleId
    local ownerRoleId = bullet:GetOwnerRoleId()
    bullet:OnHit(self)
    if ownerRoleId and ownerRoleId > 0 then
        local owner = SurvivalManager.instance():GetRoleMgr():GetRole(ownerRoleId)
        if owner and owner:IsAlive() then
            local skillMgr = SurvivalManager.instance():GetSkillMgr()
            skillMgr:Trigger(owner, GE.SurvivalSkillTriggerType.OnHit)
            skillMgr:Trigger(owner, GE.SurvivalSkillTriggerType.OnHitByBullet)
        end
    end
    --伤害为0也要受击表现
    -- if damage > 0 then
        self:PlayAnim(RoleModelAnimEnum.Hit)
        if not self:IsPlayer() then
            self:ApplyKnockback(0.5, 1, self.position - bullet.position, true)
        end
        self:ChangeHp(-damage)
    -- end
end

---角色受击区域效果伤害
---@param areaEffect SurvivalAreaEffect 区域效果
function SurvivalRole:BeHitByAreaEffect(areaEffect)
    local damageType = areaEffect.damageType
    local damage = self:CalcFinalDamage(
        areaEffect:GetDamageByDmgType(damageType),
        self:GetDefenseByDmgType(damageType)
    )
    self:SetHitCdRemain(self._colliderCdDuration)
    local ownerRoleId = areaEffect.ownerRoleId
    if ownerRoleId and ownerRoleId > 0 then
        local owner = SurvivalManager.instance():GetRoleMgr():GetRole(ownerRoleId)
        if owner and owner:IsAlive() then
            local skillMgr = SurvivalManager.instance():GetSkillMgr()
            skillMgr:Trigger(owner, GE.SurvivalSkillTriggerType.OnHit)
            skillMgr:Trigger(owner, GE.SurvivalSkillTriggerType.OnHitByAreaEffect)
        end
    end
    if damage > 0 then
        self:PlayAnim(RoleModelAnimEnum.Hit)
        if not self:IsPlayer() then
            local center = areaEffect:GetCenter()
            self:ApplyKnockback(
                areaEffect:GetKnockbackDuration(),
                areaEffect:GetKnockbackSpeed(),
                self.position - center,
                true
            )
        end
        self:ChangeHp(-damage)
    end
end

function SurvivalRole:Clear()
    self._isSkillActing = false
    self._skillDirection = nil
    self._playingAnimName = nil
    if self.obj then
        PoolMgr.Free(self.obj)
    end
    if self.roleModel then
        PoolMgr.Free(self.roleModel)
    end
    self.obj = nil
    self.roleModel = nil
    self.modelController = nil
    self.roleRoot = nil
    self.parentConstraint = nil
end

return SurvivalRole