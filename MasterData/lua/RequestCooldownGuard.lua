local this = {}

function this.New(options)
    this.__index = this.__index or this
    local tab = {}
    setmetatable(tab, this)
    tab:Init(options)
    return tab
end

function this:Init(options)
    options = options or {}
    self.maxFailCount = options.maxFailCount or 1
    self.cooldownSeconds = options.cooldownSeconds or 0
    self.timeoutSeconds = options.timeoutSeconds or 0
    self.records = {}
end

function this:GetNowTime()
    return TimeUtil:GetTime()
end

function this:GetRecord(scopeKey)
    self.records = self.records or {}
    local record = self.records[scopeKey]
    if record == nil then
        record = {
            failCount = 0,
            cooldownEndTime = 0,
            lastTriggerKey = nil,
            isPending = false,
            pendingExpireTime = 0,
            lastFailReason = nil
        }
        self.records[scopeKey] = record
    end
    return record
end

function this:BuildState(record, nowTime)
    nowTime = nowTime or self:GetNowTime()
    local cooldownEndTime = record.cooldownEndTime or 0
    return {
        failCount = record.failCount or 0,
        cooldownEndTime = cooldownEndTime,
        lastTriggerKey = record.lastTriggerKey,
        isPending = record.isPending == true,
        pendingExpireTime = record.pendingExpireTime or 0,
        lastFailReason = record.lastFailReason,
        canRequest = cooldownEndTime <= nowTime and record.isPending ~= true
    }
end

function this:MarkFailure(scopeKey, reason, nowTime)
    local record = self:GetRecord(scopeKey)
    nowTime = nowTime or self:GetNowTime()
    record.failCount = (record.failCount or 0) + 1
    record.lastFailReason = reason
    record.isPending = false
    record.pendingExpireTime = 0
    if self.maxFailCount > 0 and record.failCount >= self.maxFailCount then
        record.cooldownEndTime = nowTime + self.cooldownSeconds
    end
    return self:BuildState(record, nowTime)
end

function this:ClearPending(scopeKey)
    local record = self:GetRecord(scopeKey)
    record.isPending = false
    record.pendingExpireTime = 0
end

function this:Reset(scopeKey)
    if self.records then
        self.records[scopeKey] = nil
    end
end

function this:MarkSuccess(scopeKey)
    self:ClearPending(scopeKey)
end

function this:ResolveTriggerKey(scopeKey, triggerKey)
    local record = self:GetRecord(scopeKey)
    if record.lastTriggerKey ~= triggerKey then
        return self:BuildState(record)
    end
    record.lastTriggerKey = nil
    record.failCount = 0
    record.cooldownEndTime = 0
    record.lastFailReason = nil
    record.isPending = false
    record.pendingExpireTime = 0
    return self:BuildState(record)
end

function this:GetState(scopeKey)
    local nowTime = self:GetNowTime()
    local record = self:GetRecord(scopeKey)
    return self:BuildState(record, nowTime)
end

function this:RefreshState(scopeKey, nowTime)
    local record = self:GetRecord(scopeKey)
    local isTimedOut = false
    nowTime = nowTime or self:GetNowTime()
    if record.isPending == true and record.pendingExpireTime > 0 and nowTime >= record.pendingExpireTime then
        self:MarkFailure(scopeKey, "timeout", nowTime)
        record = self:GetRecord(scopeKey)
        isTimedOut = true
    end
    if record.cooldownEndTime > 0 and nowTime >= record.cooldownEndTime then
        record.failCount = 0
        record.cooldownEndTime = 0
        record.lastFailReason = nil
    end
    return record, isTimedOut
end

function this:CanRequest(scopeKey)
    local nowTime = self:GetNowTime()
    local record, isTimedOut = self:RefreshState(scopeKey, nowTime)
    local state = self:BuildState(record, nowTime)
    if isTimedOut then
        return false, state, "timeout"
    end
    if record.cooldownEndTime > nowTime then
        return false, state, "cooldown"
    end
    if record.isPending == true then
        return false, state, "pending"
    end
    return true, state, nil
end

--triggerKey：两次传入同样的值时，记为1次失败
function this:RecordTriggerKey(scopeKey, triggerKey)
    local nowTime = self:GetNowTime()
    local record, isTimedOut = self:RefreshState(scopeKey, nowTime)
    if isTimedOut then
        return false, self:BuildState(record, nowTime), "timeout"
    end
    if record.cooldownEndTime > nowTime then
        return false, self:BuildState(record, nowTime), "cooldown"
    end
    if record.isPending == true then
        return false, self:BuildState(record, nowTime), "pending"
    end
    if triggerKey ~= nil and record.lastTriggerKey ~= nil and triggerKey == record.lastTriggerKey then
        local state = self:MarkFailure(scopeKey, "repeat_key", nowTime)
        return record.failCount < self.maxFailCount, state, "repeat_key"
    end
    record.lastTriggerKey = triggerKey
    record.failCount = 0
    record.lastFailReason = nil
    return true, self:BuildState(record, nowTime), nil
end

function this:BeginRequest(scopeKey)
    local record = self:GetRecord(scopeKey)
    local nowTime = self:GetNowTime()
    record.isPending = true
    record.pendingExpireTime = self.timeoutSeconds > 0 and (nowTime + self.timeoutSeconds) or 0
end

function this:Dispose()
    self.records = {}
end

return this
