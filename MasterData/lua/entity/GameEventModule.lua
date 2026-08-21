
---@class GameEventModule : Entity
local GameEventModule = BaseClass("GameEventModule",Entity)
local base = Entity
local this = GameEventModule

---@param gameEventModule protocol.GameEventModule
function this:Awake(gameEventModule)
    base.Awake(self)

    self.eventId = gameEventModule.event_id
    self.moduleId = gameEventModule.module_id
    self.startTime = gameEventModule.start_time
    self.endTime = gameEventModule.end_time
    self.status = gameEventModule.status

    self.config = Z_GameEvents[self.eventId][self.moduleId]
end

---@param gameEventModule protocol.GameEventModule
function this:UpdateData(gameEventModule)
    self.eventId = gameEventModule.event_id or self.eventId
    self.moduleId = gameEventModule.module_id or self.moduleId
    self.startTime = gameEventModule.start_time or self.startTime
    self.endTime = gameEventModule.end_time or self.endTime
    self.status = gameEventModule.status or self.status
end

function this.Dispose(self)
    base.Dispose(self)
end

return this