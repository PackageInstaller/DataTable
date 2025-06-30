
---@class RecruitComponent
---@field poolList RecruitPool[]
---@field poolMap table<number, RecruitPool>
local RecruitComponent = BaseClass("RecruitComponent", Component)
local base = Component
local this = RecruitComponent

function this:Awake()
    base.Awake(self)

    self.poolList = {}
    self.poolMap = {}
    self.rookie = {}

    self.guarantees = {}

    self.logBeginId = 0
    self.logEndId = 0

    ---@type HintComponent
    local hintComponent = Game.Scene:GetComponent("HintComponent")
    self.recruitHint = hintComponent.Recruit
    self.recruitHint:SetCount(0)
end

function this:CoLoadData()
    local response = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            PROTOCOL.RecruitInfoReq, {} )
    self:UpdateRecruit(response)

    return coroutine.yieldbreak(response)
end

---@param msg protocol.RecruitInfoResp
function this:UpdateRecruit(msg)
    for _, value in ipairs(msg.recruit.recruit_pools) do
        self:AddOrUpdate(value)
    end

    if msg.recruit.recruit_rookie_pools ~= nil then
        for _, value in pairs(msg.recruit.recruit_rookie_pools) do
            self.rookie[value.id] = {
                id = value.id,
                rewards = value.rewards,
                isReceived = false,
            }
        end
    end
    
    for key, value in pairs(msg.recruit.recruit_guarantees) do
        self.guarantees[value.type] = value.count
    end

    self.logBeginId = msg.recruit.log_begin_id or self.logBeginId
    self.logEndId = msg.recruit.log_end_id or self.logEndId
end

---@param data protocol.RecruitPool
function this:AddOrUpdate(poolData)
    if self.poolMap[poolData.id] then
        self.poolMap[poolData.id]:UpdateData(poolData)
        table.first(self.poolList, function(v) return v.id == poolData.id end):UpdateData(poolData)
    else
        ---@type RecruitPool
        local pool = Game.Registry:NewObject("RecruitPool", poolData)
        table.insert(self.poolList, pool)
        self.poolMap[pool.id] = pool
        self.recruitHint:AddChild(pool.id)
        self.recruitHint:GetChild(pool.id):AddChild("Click", 1, true)
        if pool.status ~= RecruitPoolStatus.RecruitPoolStatusOpen then
            self.recruitHint:GetChild(pool.id):GetChild("Click"):SetCount(0)
        end
        pool:UpdateHint()
    end
    table.sort(self.poolList, function(a, b) return a.id < b.id end)
end

function this:GetRecruitGuaranteeCount(recruitPoolId)
    local zRecruit = Z_Recruit[recruitPoolId]
    if zRecruit == nil then
        Logger.LogError("RecruitComponent:GetRecruitGuaranteeCount: recruitPoolId not found: " .. recruitPoolId)
        return 0
    end
    local count = self.guarantees[zRecruit.CardPoolType] or 0
    return zRecruit.Guarantee - count
end

function this:GetPoolList()
    return self.poolList
end

function this:GetPool(id)
    return self.poolMap[id]
end

function this:CheckRookiePoolHasReward(poolId)
    if self.rookie[poolId] == nil then
        return false
    end
    if self.rookie[poolId].rewards == nil or table.count(self.rookie[poolId].rewards) == 0 then
        return false
    end
    return not self.rookie[poolId].isReceived
end

function this.SummonIsOpen(self, type)
    -- if not self.SummonTimes[type] then
    --     return false
    -- end
    -- if self.SummonTimes[type].Start <= 0 or self.SummonTimes[type].Start > TimeUtil.OSTime() or self.SummonTimes[type].End < TimeUtil.OSTime() then
    --     return false
    -- end

    return true
end

function this.SummonShopIsOpen(self, type)--活动星尘商店
    if not self.SummonTimes[type] then
        return false
    end
    if self.SummonTimes[type].Start <= 0 or self.SummonTimes[type].Start > TimeUtil.OSTime() 
            or TimeUtil.getNewDate(self.SummonTimes[type].End, 7, "DAY") < TimeUtil.OSTime() then
        return false
    end

    return true
    
end


function this.IsPickUP(id)--普通pick up星石卡池
    if id > 2000 and id < 3000 then
        return true
    end
    return false
end

return this