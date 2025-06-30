

---@class UIFightSoulLevelUpModel
---@field fightSoul FightSoul
---@field levelUpItemIds number[]
---@field callback function @ 关闭后的回调
local UIFightSoulLevelUpModel = BaseClass("UIFightSoulLevelUpModel",UIBaseModel)
local base = UIBaseModel
local this = UIFightSoulLevelUpModel

---@param self UIFightSoulLevelUpModel
local function OnFightSoulDataUpdate(self)
    self:OnRefresh()
    self.fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(self.fightSoul.Id)
    self:UIBroadcast(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end

local function OnItemDataUpdate(self, updateIds, removeIds)
    self:UIBroadcast(UIMessageNames.ON_ITEM_DATA_UPDATE, updateIds, removeIds)
end

function this.OnCreate(self)
    base.OnCreate(self)
end

---@param self UIFightSoulLevelUpModel
function this.OnEnable(self, data)
    base.OnEnable(self)
    self.fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(data.fightSoulId)
    self.callback = data.callback
    self.levelUpItemIds = {}
    for key, value in pairs(Z_Item) do
        if value.UseType == ItemUseType.ItemUseTypeFightSoulLevelUp then
            table.insert(self.levelUpItemIds, key)
        end
    end
    table.sort(self.levelUpItemIds, function(a, b) return a < b end)
    self:OnRefresh()
end

function this.OnRefresh(self)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_FIGHTSOUL_DATA_UPDATE, OnFightSoulDataUpdate)
    self:AddDataListener(DataMessageNames.ON_ITEM_DATA_UPDATE, OnItemDataUpdate)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
    self:RemoveDataListener(DataMessageNames.ON_ITEM_DATA_UPDATE)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this
