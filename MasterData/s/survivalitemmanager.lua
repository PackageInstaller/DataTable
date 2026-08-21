require "class"
local SurvivalItem = require("SurvivalItem")

---@class SurvivalItemManager
local SurvivalItemManager = class("SurvivalItemManager")

---道具最大碰撞半宽（与 SurvivalItem 默认半径一致，用于地格粗筛）
local ITEM_MAX_HALF_RANGE = 2
---掉落位置 XZ 随机偏移（脚下散开，避免重叠）
local DROP_SPAWN_OFFSET_MIN = 0.4
local DROP_SPAWN_OFFSET_MAX = 1.2
---同一敌人多个掉落之间的间隔（秒）
local DROP_SPAWN_INTERVAL = 0.12

function SurvivalItemManager:ctor()
    ---@type table<integer, SurvivalItem>
    self._itemList = {}
    self._itemIndex = 0
    ---@type {remain:number, itemId:integer, position:Vector3}[]
    self._pendingDrops = {}
end

---@return SurvivalItemManager
function SurvivalItemManager.instance()
    if not SurvivalItemManager._instance then
        SurvivalItemManager._instance = SurvivalItemManager:new()
    end
    return SurvivalItemManager._instance
end

---@param deltaTime number
function SurvivalItemManager:Update(deltaTime)
    self:UpdatePendingDrops(deltaTime)

    local roleMgr = SurvivalManager.instance():GetRoleMgr()
    local colliderMgr = SurvivalManager.instance():GetColliderMgr()
    local player = roleMgr:GetPlayerRole()

    local aliveItems = {}
    for _, item in pairs(self._itemList) do
        if item:IsAlive() then
            aliveItems[#aliveItems + 1] = item
        end
    end

    colliderMgr:RebuildItemGrid(aliveItems)

    if player and player:IsAlive() and player:IsOnField() and #aliveItems > 0 then
        local candidates = colliderMgr:QueryGrid(
            colliderMgr:GetItemGrid(), player, ITEM_MAX_HALF_RANGE)
        for i = 1, #candidates do
            local item = candidates[i]
            if item:IsAlive() and not item:IsSucking() then
                self:TryStartSuck(item, player)
            end
        end
    end

    for i = 1, #aliveItems do
        aliveItems[i]:Update(deltaTime)
    end
end

---处理间隔掉落队列
---@param deltaTime number
function SurvivalItemManager:UpdatePendingDrops(deltaTime)
    local i = 1
    while i <= #self._pendingDrops do
        local pending = self._pendingDrops[i]
        pending.remain = pending.remain - deltaTime
        if pending.remain <= 0 then
            self:CreateItem(pending.itemId, pending.position)
            table.remove(self._pendingDrops, i)
        else
            i = i + 1
        end
    end
end

---@param itemId integer
---@param position Vector3
---@param delay number 延迟秒数
function SurvivalItemManager:ScheduleCreateItem(itemId, position, delay)
    if not delay or delay <= 0 then
        self:CreateItem(itemId, position)
        return
    end
    self._pendingDrops[#self._pendingDrops + 1] = {
        remain = delay,
        itemId = itemId,
        position = position,
    }
end

---主控角色进入道具碰撞范围后开始吸入
---@param item SurvivalItem
---@param player SurvivalRole|nil
function SurvivalItemManager:TryStartSuck(item, player)
    if not player or not player:IsAlive() or not player:IsOnField() then
        return
    end
    local dx = item.position.x - player.position.x
    local dz = item.position.z - player.position.z
    local sumRange = item:GetHalfRange() + player:GetHalfRange()
    if dx * dx + dz * dz <= sumRange * sumRange then
        item:StartSucking()
    end
end

---敌人死亡时按 SurvivorRoleTable.drop 掉落道具
---@param role SurvivalRole
function SurvivalItemManager:TryDropFromRole(role)
    if not role or role:GetTeam() ~= GE.SurvivalTeam.enemy then
        return
    end
    local survivorRoleId = role:GetSurvivorRoleId()
    if not survivorRoleId then
        return
    end
    local roleCfg = Config.GetSurvivorRoleInfo(survivorRoleId)
    if not roleCfg or not roleCfg.drop then
        return
    end
    local pos = role:GetPosition()
    local dropSlot = 0
    for _, dropEntry in pairs(roleCfg.drop) do
        local rate = dropEntry[1]
        -- rate = 100
        local itemId = dropEntry[2]
        if itemId and rate and math.random(1, 100) <= rate then
            self:ScheduleCreateItem(itemId, pos, dropSlot * DROP_SPAWN_INTERVAL)
            dropSlot = dropSlot + 1
        end
    end
end

---@param position Vector3 掉落基准点（通常为敌人脚下）
---@return Vector3
function SurvivalItemManager:RandomizeDropPosition(position)
    local angle = math.random() * 2 * math.pi
    local radius = DROP_SPAWN_OFFSET_MIN + math.random() * (DROP_SPAWN_OFFSET_MAX - DROP_SPAWN_OFFSET_MIN)
    return Vector3(
        position.x + math.cos(angle) * radius,
        position.y,
        position.z + math.sin(angle) * radius
    )
end

---创建掉落道具
---@param itemId integer SurvivorItemTable id
---@param position Vector3
function SurvivalItemManager:CreateItem(itemId, position)
    local itemCfg = Config.GetSurvivorItemInfo(itemId)
    if not itemCfg then
        LuaLogger.ws("SurvivalItemManager:CreateItem item not found: ", itemId)
        return
    end
    local modelName = itemCfg.model
    if not modelName or modelName == "" then
        LuaLogger.ws("SurvivalItemManager:CreateItem model empty: ", itemId)
        return
    end

    local spawnPos = self:RandomizeDropPosition(position)

    self._itemIndex = self._itemIndex + 1
    local item = SurvivalItem:new()
    local instanceId = self._itemIndex
    item:SetId(instanceId)
    item:SetItemId(itemId)
    item:SetAlive(true)
    item:StartDrop(position, spawnPos)
    self._itemList[instanceId] = item

    PoolMgr:Get(Config.PrefabPath.SurvivalItem, function(obj)
        if not item:IsAlive() or item.itemId ~= itemId then
            PoolMgr.Free(obj)
            return
        end
        item:BindObj(obj)
        local rootTrans = item._rootTrans
        if not rootTrans then
            return
        end
        local modelPath = string.format(Config.PrefabPath.SurvivalItemPrefab, modelName)
        PoolMgr:Get(modelPath, function(modelObj)
            if not item:IsAlive() or item.itemId ~= itemId then
                PoolMgr.Free(modelObj)
                return
            end
            item:BindModelObj(modelObj)
        end, SurvivalManager.instance().cameraObj)
    end, SurvivalManager.instance().cameraObj)
end

---拾取道具并应用效果（按实例绑定的 itemId 读表，与表现模型一致）
---@param id integer
function SurvivalItemManager:PickupItem(id)
    local item = self._itemList[id]
    if not item or not item:IsAlive() then
        return
    end
    local pickItemId = item.itemId
    self:DestroyItem(id)
    local itemCfg = Config.GetSurvivorItemInfo(pickItemId)
    if itemCfg then
        self:ApplyItemEffect(itemCfg)
    end
end

---@param itemCfg SurvivorItemTable
function SurvivalItemManager:ApplyItemEffect(itemCfg)
    if itemCfg.effectType == GE.SurvivalItemEffectType.Exp then
        local expValue = itemCfg.effectParameter and itemCfg.effectParameter[1] or 0
        if expValue > 0 then
            SurvivalManager.instance():AddPlayerExp(expValue)
        end
    elseif itemCfg.effectType == GE.SurvivalItemEffectType.Heal then
        local player = SurvivalManager.instance():GetRoleMgr():GetPlayerRole()
        if not player or not player:IsAlive() or not player:IsOnField() then
            return
        end
        local percent = itemCfg.effectParameter and itemCfg.effectParameter[1] or 0
        if percent <= 0 then
            return
        end
        local healAmount = math.floor(player:GetMaxHp() * percent / 100)
        if healAmount > 0 then
            player:ChangeHp(healAmount)
        end
    end
end

---@param id integer
function SurvivalItemManager:DestroyItem(id)
    local item = self._itemList[id]
    if not item then
        return
    end
    item:OnDestroy()
    self._itemList[id] = nil
end

function SurvivalItemManager:Clear()
    self._pendingDrops = {}
    for id, item in pairs(self._itemList) do
        item:Clear()
        self._itemList[id] = nil
    end
    self._itemIndex = 0
end

return SurvivalItemManager
