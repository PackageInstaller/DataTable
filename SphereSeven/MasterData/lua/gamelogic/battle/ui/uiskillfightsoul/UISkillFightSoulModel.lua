---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/6/21 17:53
---
local UISkillFightSoulModel = BaseClass("UISkillFightSoulModel",UIBaseModel)
local this = UISkillFightSoulModel
local base = UIBaseModel

function this.OnCreate(self)
    base.OnCreate(self)
end

function this.OnEnable(self,...)
    base.OnEnable(self)
    local arg = {...}
    self.card = arg[1]
    self:OnRefresh()
end

function this.OnAddListener(self)
end

function this.OnRefresh(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end
return this