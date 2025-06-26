local UIRechargePopUpModel = BaseClass("UIRechargePopUpModel",UIBaseModel)
local base = UIBaseModel
local this = UIRechargePopUpModel

function this.OnCreate(self)
    base.OnCreate(self)
    self.data = nil
end

function this.OnEnable(self, data)
    base.OnEnable(self)
    self.data = data
    self:OnRefresh()
end

function this.OnRefresh(self)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    self.data = nil
    base.OnDestroy(self)
end

return this

