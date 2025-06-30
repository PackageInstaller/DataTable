local UIEchoChromeSettleModel = BaseClass("UIEchoChromeSettleModel",UIBaseModel);
local base = UIBaseModel;
local this = UIEchoChromeSettleModel;

function this.OnCreate(self)
    base.OnCreate(self);
end

function this.OnEnable(self,data)
    base.OnEnable(self);
    self:OnRefresh(data);
end

function this.OnRefresh(self,data)
    self.data = data
end

function this.OnAddListener(self)
    base.OnAddListener(self);
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;
