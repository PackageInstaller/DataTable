

---@class UIFightSoulMainModel : UIBaseModel
---@field fightSoulList table<number, FightSoul> @ key - id, value - FightSoul
local UIFightSoulMainModel = BaseClass("UIFightSoulMainModel",UIBaseModel);
local base = UIBaseModel
local this = UIFightSoulMainModel


local function OnFightSoulDataUpdate(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end

function this.OnCreate(self)
    base.OnCreate(self);
end

function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh();
end

function this.OnRefresh(self)
    self.fightSoulList = Game.Scene.Player:GetComponent("FightSoulComponent").FightSouls
    self.allEquipFightSoulIds = Game.Scene.Player:GetComponent("TeamComponent"):GetAllEquipFightSoulIds()
end

---@param self UIFightSoulMainModel
function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddDataListener(DataMessageNames.ON_FIGHTSOUL_DATA_UPDATE, OnFightSoulDataUpdate)
end

---@param self UIFightSoulMainModel
function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end

function this.OnDisable(self)
    base.OnDisable(self);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;
