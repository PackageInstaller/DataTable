require "class"

---@class SurvivalItem
local SurvivalItem = class("SurvivalItem")

---默认碰撞半径（直径 4，GetHalfRange 返回 2）
local DEFAULT_ITEM_DIAMETER = 4
---吸入移动速度
local SUCK_SPEED = 18
---拾取距离阈值
local PICKUP_DISTANCE = 0.35
---掉落动画时长（秒）
local DROP_DURATION = 0.35
---掉落抛物线顶点抬高
local DROP_ARC_HEIGHT = 1.15
---落地后沿飞出方向额外滑行距离
local SLIDE_DISTANCE = 0.45
---落地滑行时长（秒）
local SLIDE_DURATION = 0.22

function SurvivalItem:ctor()
    self.isItem = true
    self.id = 0
    self.itemId = 0
    self.alive = false
    self.position = Vector3.zero
    self.block = { x = 0, z = 0 }
    self.halfRange = DEFAULT_ITEM_DIAMETER / 2
    self._dropping = false
    self._dropOrigin = Vector3.zero
    self._dropTarget = Vector3.zero
    self._dropElapsed = 0
    self._dropDuration = DROP_DURATION
    self._sliding = false
    self._slideOrigin = Vector3.zero
    self._slideDir = Vector3.zero
    self._slideElapsed = 0
    self._slideDuration = SLIDE_DURATION
    self._slideDistance = SLIDE_DISTANCE
    self._sucking = false
    self._suckSpeed = SUCK_SPEED
    self.obj = nil
    self._rootTrans = nil
    self._modelObj = nil
end

---@param id integer
function SurvivalItem:SetId(id)
    self.id = id
end

---@param itemId integer SurvivorItemTable id
function SurvivalItem:SetItemId(itemId)
    self.itemId = itemId
end

---@param alive boolean
function SurvivalItem:SetAlive(alive)
    self.alive = alive
end

---@return boolean
function SurvivalItem:IsAlive()
    return self.alive
end

---@return boolean
function SurvivalItem:IsDropping()
    return self._dropping
end

---@return boolean
function SurvivalItem:IsSliding()
    return self._sliding
end

---@return number
function SurvivalItem:GetHalfRange()
    return self.halfRange
end

---@return Vector3
function SurvivalItem:GetPosition()
    return self.position
end

---@param position Vector3
function SurvivalItem:ChangePos(position)
    self.position = position
    self.block.x = math.floor(position.x)
    self.block.z = math.floor(position.z)
    if self.obj then
        self.obj.transform.position = position
    end
end

---@param obj UnityEngine.GameObject
function SurvivalItem:BindObj(obj)
    self.obj = obj
    self._rootTrans = obj.transform:Find("root")
    self:ClearRootChildren()
    self:ChangePos(self.position)
end

---释放 root 下挂的表现模型（对象池复用时清掉上一任残留）
function SurvivalItem:ClearRootChildren()
    if self._modelObj and not IsNull(self._modelObj) then
        PoolMgr.Free(self._modelObj)
        self._modelObj = nil
    end
    if not self._rootTrans or IsNull(self._rootTrans) then
        return
    end
    local root = self._rootTrans
    for i = root.childCount - 1, 0, -1 do
        local child = root:GetChild(i)
        if child and not IsNull(child.gameObject) then
            PoolMgr.Free(child.gameObject)
        end
    end
end

---@param modelObj UnityEngine.GameObject
function SurvivalItem:BindModelObj(modelObj)
    self:ClearRootChildren()
    self._modelObj = modelObj
    if self._rootTrans and not IsNull(self._rootTrans) then
        modelObj.transform:SetParent(self._rootTrans, false)
        modelObj.transform.localPosition = Vector3.zero
        modelObj.transform.localRotation = Quaternion.identity
        modelObj.transform.localScale = Vector3.one
    end
end

---开始掉落动画：从脚下原点抛向目标点
---@param origin Vector3
---@param target Vector3
---@param duration number|nil
function SurvivalItem:StartDrop(origin, target, duration)
    self._sliding = false
    self._dropping = true
    self._dropOrigin = Vector3(origin.x, origin.y, origin.z)
    self._dropTarget = Vector3(target.x, target.y, target.z)
    self._dropElapsed = 0
    self._dropDuration = duration or DROP_DURATION
    self:ChangePos(self._dropOrigin)
end

---落地后沿抛出方向滑行
---@param fromPos Vector3
---@param dir Vector3 已归一化的 XZ 方向
function SurvivalItem:StartSlide(fromPos, dir)
    self._sliding = true
    self._slideOrigin = Vector3(fromPos.x, fromPos.y, fromPos.z)
    self._slideDir = Vector3(dir.x, 0, dir.z)
    self._slideElapsed = 0
    self._slideDuration = SLIDE_DURATION
    self._slideDistance = SLIDE_DISTANCE
    self:ChangePos(self._slideOrigin)
end

---掉落结束后根据轨迹启动滑行
function SurvivalItem:BeginSlideAfterDrop()
    local ox, oz = self._dropOrigin.x, self._dropOrigin.z
    local tx, ty, tz = self._dropTarget.x, self._dropTarget.y, self._dropTarget.z
    local dx = tx - ox
    local dz = tz - oz
    local mag = math.sqrt(dx * dx + dz * dz)
    if mag <= 0.01 then
        return
    end
    self:StartSlide(Vector3(tx, ty, tz), Vector3(dx / mag, 0, dz / mag))
end

---终止掉落/滑行，进入吸入
function SurvivalItem:StartSucking()
    self._dropping = false
    self._sliding = false
    self._sucking = true
    if self._rootTrans then
        self._rootTrans.localRotation = Quaternion.identity
    end
end

---@return boolean
function SurvivalItem:IsSucking()
    return self._sucking
end

---@param deltaTime number
function SurvivalItem:UpdateDrop(deltaTime)
    self._dropElapsed = self._dropElapsed + deltaTime
    local t = math.min(1, self._dropElapsed / self._dropDuration)
    local eased = 1 - (1 - t) * (1 - t)
    local ox, oy, oz = self._dropOrigin.x, self._dropOrigin.y, self._dropOrigin.z
    local tx, ty, tz = self._dropTarget.x, self._dropTarget.y, self._dropTarget.z
    local x = ox + (tx - ox) * eased
    local z = oz + (tz - oz) * eased
    local baseY = oy + (ty - oy) * eased
    local y = baseY + DROP_ARC_HEIGHT * math.sin(math.pi * t)
    self:ChangePos(Vector3(x, y, z))
    if self._rootTrans then
        self._rootTrans.localRotation = Quaternion.Euler(0, t * 360, 0)
    end
    if t >= 1 then
        self._dropping = false
        self:ChangePos(Vector3(tx, ty, tz))
        if self._rootTrans then
            self._rootTrans.localRotation = Quaternion.identity
        end
        self:BeginSlideAfterDrop()
    end
end

---@param deltaTime number
function SurvivalItem:UpdateSlide(deltaTime)
    self._slideElapsed = self._slideElapsed + deltaTime
    local t = math.min(1, self._slideElapsed / self._slideDuration)
    local eased = 1 - (1 - t) * (1 - t)
    local offset = self._slideDistance * eased
    self:ChangePos(Vector3(
        self._slideOrigin.x + self._slideDir.x * offset,
        self._slideOrigin.y,
        self._slideOrigin.z + self._slideDir.z * offset
    ))
    if t >= 1 then
        self._sliding = false
    end
end

---帧同步：吸入阶段向主控角色实时位置移动
---@param deltaTime number
function SurvivalItem:UpdateSuck(deltaTime)
    local player = SurvivalManager.instance():GetRoleMgr():GetPlayerRole()
    if not player or not player:IsAlive() or not player:IsOnField() then
        self._sucking = false
        return
    end
    local targetPos = player:GetPosition()
    local dx = targetPos.x - self.position.x
    local dy = targetPos.y - self.position.y
    local dz = targetPos.z - self.position.z
    local distSq = dx * dx + dy * dy + dz * dz
    if distSq <= PICKUP_DISTANCE * PICKUP_DISTANCE then
        SurvivalManager.instance():GetItemMgr():PickupItem(self.id)
        return
    end
    local dist = math.sqrt(distSq)
    local step = self._suckSpeed * deltaTime
    if step >= dist then
        self:ChangePos(Vector3(targetPos.x, targetPos.y, targetPos.z))
        SurvivalManager.instance():GetItemMgr():PickupItem(self.id)
        return
    end
    local ratio = step / dist
    self:ChangePos(Vector3(
        self.position.x + dx * ratio,
        self.position.y + dy * ratio,
        self.position.z + dz * ratio
    ))
end

---@param deltaTime number
function SurvivalItem:Update(deltaTime)
    if not self:IsAlive() then
        return
    end
    if self._sucking then
        self:UpdateSuck(deltaTime)
        return
    end
    if self._dropping then
        self:UpdateDrop(deltaTime)
        return
    end
    if self._sliding then
        self:UpdateSlide(deltaTime)
    end
end

function SurvivalItem:OnDestroy()
    self.alive = false
    self._dropping = false
    self._sliding = false
    self._sucking = false
    self:ClearRootChildren()
    if self.obj and not IsNull(self.obj) then
        PoolMgr.Free(self.obj)
    end
    self.obj = nil
    self._rootTrans = nil
    self._modelObj = nil
end

function SurvivalItem:Clear()
    self:OnDestroy()
end

return SurvivalItem
