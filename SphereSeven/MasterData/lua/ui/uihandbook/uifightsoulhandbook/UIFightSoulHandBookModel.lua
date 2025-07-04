---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/7/1 16:21
---

local UIFightSoulHandBookModel = BaseClass("UIFightSoulHandBookModel",UIBaseModel)
local base = UIBaseModel
local this = UIFightSoulHandBookModel

function this.OnCreate(self)
    base.OnCreate(self)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self:OnRefresh()
end

function this.OnRefresh(self)
    self.fightSoulIds = {}
    self.fightSoulIds[0] = {} -- 全部
    for k,v in table.pairsByKeys(Z_FightSoul) do
        if v.NotOpen ~= 1 then
            local class = UIPublic.GetFightSoulClass(v.ClassLimit)
            if self.fightSoulIds[class] == nil then
                self.fightSoulIds[class] = {}
            end
            table.insert(self.fightSoulIds[class], v.Id)
            if class ~= 0 then
                table.insert(self.fightSoulIds[0], v.Id)
            end
        end
    end
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
    base.OnDestroy(self)
end

return this