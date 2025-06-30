---@class EquipComponent
---@field equipMap table<number, Equip>
local EquipComponent = BaseClass("EquipComponent", Component)
local base = Component
local this = EquipComponent

function this:Awake()
    base.Awake(self)
    self.equipMap = {}
    self.Equips = {}
    self.bagCapacity = 0
end

function this:CoLoadData()
    local response = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            PROTOCOL.EquipmentPackReq, {} )
    self:UpdateEquip(response.equipment_pack)

    return coroutine.yieldbreak(response)
end

---@param equipmentPack protocol.EquipmentPack
function this:UpdateEquip(equipmentPack)
    for index, value in ipairs(equipmentPack.equipments) do
        self:AddOrUpdate(value)
    end
    self.bagCapacity = equipmentPack.capacity
end

---@param equipData protocol.Equipment
function this:AddOrUpdate(equipData)
    if self.equipMap[equipData.Id] then
        self.equipMap[equipData.Id]:UpdateData(equipData)

        table.removeget(self.Equips, function(equip)
            return equip.Id == equipData.Id
        end)
        table.insert(self.Equips, self.equipMap[equipData.Id])
    else
        ---@type Equip
        local equip = Game.Registry:NewObject("Equip", equipData)
        self.equipMap[equip.Id] = equip
        table.insert(self.Equips, equip)
    end
end

function this:Get(equipId)
    return self.equipMap[equipId]
end

function this:GetSameEquipList(cid)
    local equips = {}
    for key, value in pairs(self.equipMap) do
        if value.TemplateId == cid then
            table.insert(equips, value)
        end
    end
    return equips
end

function this:GetEquipList(part, characterId)
    local equipList = {}

    if part == nil then
        for key, value in pairs(self.equipMap) do
            table.insert(equipList, value)
        end
    else
        for key, value in pairs(self.equipMap) do
            if value.config.Part == part then
                table.insert(equipList, value)
            end
        end
    end
    
    local equips = {}
    if characterId ~= nil then
        local zCharacter = Z_Character[characterId]
        
        for key, value in pairs(equipList) do
            local classIsOn = false -- 满足职业限制
            local exclusiveIsOn = false -- 满足专属限制
            if value.config.Class ~= nil and table.count(value.config.Class) ~= 0 then
                -- 有职业限制
                if table.contains(value.config.Class, zCharacter.Class) then
                    classIsOn = true
                else
                    classIsOn = false
                end
            else
                classIsOn = true
            end

            if value.config.Exclusive ~= 0 then
                if value.config.Exclusive == characterId then
                    exclusiveIsOn = true
                else
                    exclusiveIsOn = false
                end
            else
                exclusiveIsOn = true
            end

            if classIsOn and exclusiveIsOn then
                table.insert(equips, value)
            end
        end
    else
        equips = equipList
    end

    table.sort(equips, function(a, b) return a.Id < b.Id end)
    return equips

end

function this:GetAllEquipKindCount()
    return table.count(table.choose(Z_Equip,function(k,v) return v.NotOpen ~= 1 end))
end

function this:Remove(equipId)
    self.equipMap[equipId] = nil
    table.removeget(self.Equips, function(equip)
        return equip.Id == equipId
    end)
end

function this:Dispose()
    base.Dispose(self)

    for _,v in pairs(self.equipMap) do
        v:Dispose()
    end
end

function this:GetBagCapacity()
    return self.bagCapacity
end

return this