
---@class MonthCard : Entity
local MonthCard = BaseClass("MonthCard",Entity)
local base = Entity
local this = MonthCard

---@param card protocol.MonthlyCard
function this:Awake(card)
    base.Awake(self)
    self.id = card.id
    self.config = Z_MonthlyCard[card.id]
    self.expireTime = card.expire_time
    self.isReceived = card.is_received
    self.totalDay = card.total_day
end

---@param card protocol.MonthlyCard
function this:UpdateData(card)
    self.expireTime = card.expire_time
    self.isReceived = card.is_received
    self.totalDay = card.total_day
end

function this:GetLastTime()
    if TimeUtil.GetServerTime() > self.expireTime then
        return 0
    else
        return self.expireTime - TimeUtil.GetServerTime()
    end
end

function this.Dispose(self)
    base.Dispose(self)
end

return this