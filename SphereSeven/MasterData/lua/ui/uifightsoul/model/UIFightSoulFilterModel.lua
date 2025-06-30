---@class UIFightSoulFilterModel : UIBaseModel
local UIFightSoulFilterModel = BaseClass("UIFightSoulFilterModel",UIBaseModel);
local base = UIBaseModel
local this = UIFightSoulFilterModel

function this.OnCreate(self)
    base.OnCreate(self);
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
