local UIExpeditionModel = BaseClass("UIExpeditionModel",UIBaseModel);
local base = UIBaseModel
local this = UIExpeditionModel



function this.OnCreate(self)
    base.OnCreate(self);
    self.taskItem = {}
    self.taskItemHide = {}
end

function this.OnEnable(self,data)
    base.OnEnable(self);
    self.data =  data
    self:OnRefresh();
end

function this.OnRefresh(self)

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
