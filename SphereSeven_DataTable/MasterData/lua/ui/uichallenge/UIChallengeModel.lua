---
---

local UIChallengeModel = BaseClass("UIChallengeModel",UIBaseModel)
local base = UIBaseModel
local this = UIChallengeModel

function this.OnCreate(self)
    base.OnCreate(self)
end


function this.OnEnable(self)
    base.OnEnable(self);
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


return this