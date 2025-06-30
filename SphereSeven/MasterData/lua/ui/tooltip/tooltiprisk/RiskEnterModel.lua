

local RiskEnterModel = BaseClass("RiskEnterModel",UIBaseModel)
local base = UIBaseModel
local this = RiskEnterModel

function this.OnCreate(self)
    base.OnCreate(self);
    self.data = nil;
end

function this.OnEnable(self,data)
    base.OnEnable(self);
    self.data = data;
end

function this.OnDisable(self)
    base.OnDisable(self);

end

function this.OnDestroy(self)
    self.data = nil;
    base.OnDestroy(self);
end

return this