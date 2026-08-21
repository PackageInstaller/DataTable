
---@class GameEvent : Entity
local GameEvent = BaseClass("GameEvent",Entity)
local base = Entity
local this = GameEvent

---@param gameEvent protocol.GameEvent
function this:Awake(gameEvent)
    base.Awake(self)

    self.eventId = gameEvent.event_id
    self.startTime = gameEvent.start_time
    self.endTime = gameEvent.end_time
    self.status = gameEvent.status

    self.config = Z_GameEvents[self.eventId]

    self.entryModuleId = nil
    for key, value in pairs(self.config) do
        if value.ModuleType == GameEventModuleType.GameEventModuleEntry then
            self.entryModuleId = value.ModuleId
            break
        end
    end
end

---@param gameEvent protocol.GameEvent
function this:UpdateData(gameEvent)
    self.eventId = gameEvent.event_id or self.eventId
    self.startTime = gameEvent.start_time or self.startTime
    self.endTime = gameEvent.end_time or self.endTime
    self.status = gameEvent.status or self.status
end

function this.Dispose(self)
    base.Dispose(self)
end

return this