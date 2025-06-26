local UIActivityModel = BaseClass("UIActivityModel",UIBaseModel);
local base = UIBaseModel
local this = UIActivityModel
--local parent


function this.OnCreate(self)
    base.OnCreate(self);
end

function this.OnEnable(self,info)
    base.OnEnable(self);
    self:OnRefresh();
end

function this.OnRefresh(self)
end

local function ON_GAME_EVENT_UPDATE(self)
    self:UIBroadcast(UIMessageNames.ON_GAME_EVENT_UPDATE)
end

local function ON_CHECK_IN_UPDATE(self)
    self:UIBroadcast(UIMessageNames.ON_CHECK_IN_UPDATE)
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddDataListener(DataMessageNames.ON_GAME_EVENT_UPDATE, ON_GAME_EVENT_UPDATE)
    self:AddDataListener(DataMessageNames.ON_CHECK_IN_UPDATE, ON_CHECK_IN_UPDATE)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveDataListener(DataMessageNames.ON_GAME_EVENT_UPDATE)
    self:RemoveDataListener(DataMessageNames.ON_CHECK_IN_UPDATE)
end

function this.OnDisable(self)
    base.OnDisable(self);

end


function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;
