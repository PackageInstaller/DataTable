

---@class UIFightSoulMergeModel : UIBaseModel
---@field fightSoulList table<number, FightSoul> @ key - id, value - FightSoul
---@field fightSoulId number
---@field callback function
local UIFightSoulMergeModel = BaseClass("UIFightSoulMergeModel",UIBaseModel);
local base = UIBaseModel
local this = UIFightSoulMergeModel

local function OnFightSoulDataUpdate(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end

function this.OnCreate(self)
    base.OnCreate(self);
end

function this.OnEnable(self, data)
    base.OnEnable(self);
    self.fightSoulId = data.fightSoulId
    self.callback = data.callback
    self:OnRefresh();
end

function this.OnRefresh(self)
    self.fightSoulList = Game.Scene.Player:GetComponent("FightSoulComponent").FightSouls
end

---@param self UIFightSoulMergeModel
function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddDataListener(DataMessageNames.ON_FIGHTSOUL_DATA_UPDATE, OnFightSoulDataUpdate)
end

---@param self UIFightSoulMergeModel
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
