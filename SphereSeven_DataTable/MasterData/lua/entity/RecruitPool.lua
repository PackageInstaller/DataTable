---@class RecruitPool
local RecruitPool = BaseClass("RecruitPool",Entity);
local base = Entity

---@param pool protocol.RecruitPool
---@param self RecruitPool
local function Awake(self, pool)
    base.Awake(self)
    if pool == nil then return end
    self.id = pool.id
    self.count = pool.count
    self.startTime = pool.startTime
    self.endTime = pool.endTime
    self.status = pool.status
    self.config = Z_Recruit[self.id]

    self.hasFreeRecruitItem = false
    for index, value in ipairs(Z_RecruitItem[self.config.Item]) do
        if UIPublic.isFreeRecruitItemId(value.ItemId) then
            self.hasFreeRecruitItem = true
            break
        end
    end

end

---@param pool protocol.RecruitPool
function RecruitPool:UpdateData(pool)
    if pool == nil then return end
    self.id = pool.id or self.id
    self.count = pool.count or self.count
    self.startTime = pool.startTime or self.startTime
    self.endTime = pool.endTime or self.endTime
    self.status = pool.status or self.status
    self:UpdateHint()
end

local function Dispose(self)
    base.Dispose(self)
end

local FREE_RECRUIT_ITEM_IDs = Z_Misc.FREE_RECRUIT_ITEM_ID.Value

function RecruitPool:UpdateHint()
    ---@type HintComponent
    local hintComponent = Game.Scene:GetComponent("HintComponent")
    local hint = hintComponent.Recruit:GetChild(self.id)

    -- 免费抽卡
    if self.hasFreeRecruitItem and self.config.CardPoolType ~= RecruitPoolType.RecruitPoolRookie then
        local hintCount = 0
        for index, id in ipairs(FREE_RECRUIT_ITEM_IDs) do
            if UIPublic.GetItemAmount(tonumber(id)) > 0 then
                hintCount = 1
            end
        end
        if self.status ~= RecruitPoolStatus.RecruitPoolStatusOpen then
            hintCount = 0
        end

        if hint:GetChild("FreeRecruitItem") then
            hint:GetChild("FreeRecruitItem"):SetCount(hintCount)
        else
            hint:AddChild("FreeRecruitItem", hintCount)
        end
    end

end

RecruitPool.Awake = Awake
RecruitPool.Dispose = Dispose

return RecruitPool