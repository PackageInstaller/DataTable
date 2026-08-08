
local acMgr = AutoChessManager.instance()

---@class Bullet_Default
local Bullet_Default = class("Bullet_Default")
local temp_v3 = Vector3.New()

---@param bullet AutoChessBullet
function Bullet_Default:OnInit(bullet)
    local cfg = bullet.bulletCfg
    if cfg == nil then
        return
    end

    local owner = bullet.data.owner
    local entity = acMgr:GetEntity(owner)
    if entity == nil then
        return
    end

    local dir = nil
    local bindTrs = nil
    local worldPos = nil
    if cfg.fireNode ~= nil then
        local bindType, bindIndex = cfg.fireNode[1], cfg.fireNode[2]
        bindTrs, worldPos = entity:GetBindPointOrRoot(bindType, bindIndex)
        bullet:SetPosition(worldPos)
        if bindTrs ~= nil then
            dir = bindTrs.right
        end
    else
        bullet:SetPosition(entity:GetPosition())
    end
    if dir == nil then
       local dx, dy = entity:GetDir()
       dir = Vector3.New(dx, 0, dy)
    end
    ---设置朝向
    bullet:SetRotation(dir)
    --播放出生特效
    ---@type Quaternion
    local rotation = nil
    if bindTrs ~= nil then
        rotation = Quaternion.LookRotation(bindTrs.right, bindTrs.up)
    else
        rotation = Quaternion.LookRotation(dir, Vector3.up)
    end
    ---创建出生特效
    if cfg.birthEffect ~= 0 then
        local efId = cfg.birthEffect
        acMgr:PlayEffect(bullet:GetUID(), efId, bullet:GetPosition(),  rotation, nil, 2)
    end
end

function Bullet_Default:OnModelLoadFinish(bullet)


end


---@param bullet AutoChessBullet
function Bullet_Default:OnUpdate(bullet, dt)

end

---开始发射
---@param bullet AutoChessBullet
---@return boolean success 发射是否成功
function Bullet_Default:OnFire(bullet)
    local cfg = bullet.bulletCfg
    local owner = bullet.data.owner
    local entity = acMgr:GetEntity(owner)
    if entity == nil then
        return false
    end

    local targetId = entity.attackId
    bullet.attackId = targetId
    ---@type Vector3
    local targetPos = temp_v3
    targetPos:Set(0, 0, 0)
    ---@type UnityEngine.Transform?
    local targetTrs = nil

    if bullet.targetPos:SqrMagnitude() <= 1e-10 then
        if targetId ~= nil then
            local targetEntity = acMgr:GetEntity(targetId)
            if targetEntity ~= nil then
                if cfg.targetNode ~= nil and not tablex.empty(cfg.targetNode) then
                    local bindType, bindIndex = cfg.targetNode[1], cfg.targetNode[2]
                    local aimPos
                    targetTrs, aimPos = targetEntity:GetBindPointOrRoot(bindType, bindIndex)
                    targetPos:Set(aimPos:Get())
                else
                    targetTrs = targetEntity.rootObj ~= nil and not IsNull(targetEntity.rootObj)
                        and targetEntity.rootObj.transform or nil
                    targetPos:Set(targetEntity:GetPosition():Get())
                end
            end
        end
    else
        targetPos:Set(bullet.targetPos:Get())    
    end
    if targetPos:SqrMagnitude() <= 1e-10 then
        targetPos:Set(bullet.targetPos:Get()) 
    end


    local fun = function(val)
        if val == nil then
           return 0 
        end
        if type(val) == "number" then
            return val
        end
        if type(val) == "table" then
           local v1 = val[1]
           local v2 = val[2]
            if v1 == nil or v2 == nil or type(v1) ~= "number" or type(v2) ~= "number" then
               return 0 
            end
            local r = math.random(v1, v2)
            return r
        end
        return 0
    end

    if cfg.targetPosOffset ~= nil then
        local x = 0
        if cfg.targetPosOffset[1] ~= nil then
            x = fun(cfg.targetPosOffset[1])
        end
        local y = 0
        if cfg.targetPosOffset[2] ~= nil then
            y = fun(cfg.targetPosOffset[2])
        end
         local z = 0
        if cfg.targetPosOffset[3] ~= nil then
            z = fun(cfg.targetPosOffset[3])
        end
        targetPos:Set(targetPos.x + x,targetPos.y + y, targetPos.z + z)
    end
    

    if targetPos:SqrMagnitude() <= 1e-10 then
       LuaLogger.es("子弹目标点错误 id:")
       return false
    end

    if cfg.moveType == GE.AutoChessMoveType.Line then
        targetPos:Sub(bullet:GetPosition())
        targetPos:SetNormalize()
        bullet.moveController:MoveTo(targetPos, cfg.moveType, nil, nil)
    elseif cfg.moveType == GE.AutoChessMoveType.Point then
        bullet.moveController:MoveTo(targetPos, cfg.moveType, nil, function(entity)
            bullet:OnArrive()
        end)
    elseif cfg.moveType == GE.AutoChessMoveType.Bezier then
        bullet.moveController:MoveTo(targetPos, cfg.moveType, cfg.bezierCtrl, function(entity)
            bullet:OnArrive()
        end)
    elseif cfg.moveType == GE.AutoChessMoveType.target then
        local targetEntity = acMgr:GetEntity(targetId)
        if targetEntity == nil then
            LuaLogger.es("子弹目标不存在 targetId:" .. targetId)
            return false
        end
        if targetTrs == nil then
            bullet.moveController:MoveTo(targetPos, GE.AutoChessMoveType.Point, nil, function(entity)
                bullet:OnHit(targetEntity)
                bullet:OnArrive()
            end)
        else
            bullet.moveController:MoveTo(targetTrs, cfg.moveType, targetEntity, function(entity)
                bullet:OnHit(targetEntity)
                bullet:OnArrive()
            end)
        end
    end
    return true
end


---子弹移动到目标点
---@param bullet AutoChessBullet
function Bullet_Default:OnArrive(bullet)

end

---子弹死亡回调
---@param bullet AutoChessBullet
function Bullet_Default:OnDeath(bullet)

    ---执行爆炸逻辑
    local cfg = bullet.bulletCfg
    if cfg.explosionRadius ~= 0 then
        bullet:AttackExplosionDamage()
    end

    local yieldDelTime = cfg.yieldDeadTime
    if yieldDelTime == 0 then
        acMgr:RemoveEntity(bullet:GetUID())
        return
    end
    bullet.moveController:MoveTo(bullet:GetRotation(), GE.AutoChessMoveType.Line, nil)
    TimeMgr:AddWaitTimeExecute(yieldDelTime, function(bullet)
        if bullet == nil or bullet.destroyed then
            return 
        end
        acMgr:RemoveEntity(bullet:GetUID())
    end, bullet)
end

---@param bullet AutoChessBullet
function Bullet_Default:OnHit(bullet, target)
    -- 默认状态附加逻辑
    local cfg = bullet.bulletCfg
    if cfg.addBuffs ~= nil then
        for i = 1, #cfg.addBuffs do
            acMgr:AddBuff(target:GetUID(), cfg.addBuffs[i], bullet.data.owner)
        end
    end
    bullet:AttackDamage(target)
    -- 如果有穿透次数限制(hitTypeParam)，可以在这里加上逻辑
    bullet.pierceCount = bullet.pierceCount + 1
    if bullet.pierceCount >= cfg.hitCount then
        bullet:OnDeath()
    end
    
end

---@param bullet AutoChessBullet
function Bullet_Default:OnDestroy(bullet)


end

return Bullet_Default

