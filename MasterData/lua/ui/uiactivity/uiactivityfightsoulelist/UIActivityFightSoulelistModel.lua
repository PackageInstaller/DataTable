local UIActivityFightSoulelistModel = BaseClass("UIActivityFightSoulelistModel", UIBaseModel);
local base = UIBaseModel
local this = UIActivityFightSoulelistModel
--local parent


function this.OnCreate(self)
    base.OnCreate(self);
end

function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh();
end

function this.OnRefresh(self)
end

local function OnActivityFightsouleChg(self)
    self:UIBroadcast(UIMessageNames.ON_ACTIVITY_FIGHTSOULE_CHG)
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddDataListener(DataMessageNames.ON_ACTIVITY_FIGHTSOULE_CHG, OnActivityFightsouleChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveDataListener(DataMessageNames.ON_ACTIVITY_FIGHTSOULE_CHG)
end

function this.OnDisable(self)
    base.OnDisable(self);

end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;
