
---@class Equip : Entity
local Equip = BaseClass("Equip",Entity);
local base = Entity
local this = Equip

---@param equipInfo protocol.Equipment
function this:Awake(equipInfo)
    base.Awake(self)
    if equipInfo ~= nil then
        self.Id = equipInfo.eid
        self.TemplateId = equipInfo.cid
        self.Level = equipInfo.level
        self.Lock = equipInfo.lock
        self.characterId = equipInfo.character_id or 0
        if Z_Equip[self.TemplateId] ~= nil then
            self.config = Z_Equip[self.TemplateId]
        else
            Logger.LogError("equip表中不存在装备" .. self.TemplateId)
            self.config = {}
        end
        self.Star = self.config.Star
        self.BaseAttr = 1 --
    end
end

---@param equip protocol.Equipment
function this:UpdateData(equip)
    if equip == nil then return end
    self.Id = equip.eid or self.Id
    self.TemplateId = equip.cid or self.TemplateId
    self.Level = equip.level or self.Level
    self.Lock = equip.lock or self.Lock
    self.characterId = equip.character_id or self.characterId
end

function this:GetCharacter()
    return Game.Scene.Player:GetComponent("CardComponent"):Get(self.characterId)
end

function this:Dispose()
    base.Dispose(self)
end

return this