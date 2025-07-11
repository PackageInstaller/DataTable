---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/12 10:59
---

---@class UISummonModel : UIBaseModel
---@field poolList RecruitPool[]
local UISummonModel = BaseClass("UISummonModel",UIBaseModel)
local base = UIBaseModel
local this = UISummonModel

function this.OnCreate(self)
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    if data == nil then data = {} end

    local poolList = Game.Scene.Player:GetComponent("RecruitComponent"):GetPoolList()
    self.showPoolIds = data.showPoolIds or {}
    self.poolList = {}
    if self.showPoolIds ~= nil and table.count(self.showPoolIds) > 0 then
        for index, value in ipairs(poolList) do
            if table.contains(self.showPoolIds, value.id) and value.status == RecruitPoolStatus.RecruitPoolStatusOpen then
                table.insert(self.poolList, value)
            end
        end
    end
    if table.count(self.poolList) == 0 then
        self.poolList = {}
        for index, value in ipairs(poolList) do
            if value.status == RecruitPoolStatus.RecruitPoolStatusOpen then
                table.insert(self.poolList, value)
            end
        end
    end

    -- 根据 .ShowWeight排序 大的在前面
    table.sort(self.poolList, function (a, b)
        if a.config.ShowWeight ~= b.config.ShowWeight then
            return a.config.ShowWeight > b.config.ShowWeight
        end
        return a.id < b.id
    end)
    self.poolId = data.id or self.poolList[1].id
    self:OnRefresh()
end

function this.OnRefresh(self)

end

local function OnReadyToRecruit(self)
    self:UIBroadcast(UIMessageNames.ON_READY_TO_RECRUIT)
end

local function OnRecruitUpdate(self)
    local poolList = Game.Scene.Player:GetComponent("RecruitComponent"):GetPoolList()
    self.poolList = {}
    if self.showPoolIds ~= nil then
        for index, value in ipairs(poolList) do
            if table.contains(self.showPoolIds, value.id) and value.status == RecruitPoolStatus.RecruitPoolStatusOpen then
                table.insert(self.poolList, value)
            end
        end
    end
    if table.count(self.poolList) == 0 then
        self.poolList = {}
        for index, value in ipairs(poolList) do
            if value.status == RecruitPoolStatus.RecruitPoolStatusOpen then
                table.insert(self.poolList, value)
            end
        end
    end
    -- 根据 .ShowWeight排序 大的在前面
    table.sort(self.poolList, function (a, b)
        if a.config.ShowWeight ~= b.config.ShowWeight then
            return a.config.ShowWeight > b.config.ShowWeight
        end
        return a.id < b.id
    end)
    self:UIBroadcast(UIMessageNames.ON_RECRUIT_UPDATE)
end

local function ON_ITEM_DATA_UPDATE(self)
    self:UIBroadcast(UIMessageNames.ON_ITEM_DATA_UPDATE)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_READY_TO_RECRUIT, OnReadyToRecruit)
    self:AddDataListener(DataMessageNames.ON_RECRUIT_UPDATE, OnRecruitUpdate)
    self:AddDataListener(DataMessageNames.ON_ITEM_DATA_UPDATE, ON_ITEM_DATA_UPDATE)
    
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_READY_TO_RECRUIT)
    self:RemoveDataListener(DataMessageNames.ON_RECRUIT_UPDATE)
    self:RemoveDataListener(DataMessageNames.ON_ITEM_DATA_UPDATE)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end


return this
