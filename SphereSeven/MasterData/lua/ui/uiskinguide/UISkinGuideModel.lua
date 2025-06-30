local UISkinGuideModel = BaseClass("UISkinGuideModel",UIBaseModel);
local base = UIBaseModel
local this = UISkinGuideModel

function this.OnCreate(self)
    base.OnCreate(self)
end

function this.OnEnable(self, info)
    base.OnEnable(self)
    self.info = info
end

return this

