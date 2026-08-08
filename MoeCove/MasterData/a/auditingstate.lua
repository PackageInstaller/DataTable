require "FSM"
require "GameFlowState"

---@class AuditingState : FSMState
local AuditingState = FSMState:new("AuditingState", GameFlowState.AuditingState)

function AuditingState:enter()
	LuaLogger.ds("enter AuditingState")
	self:doLogic()
end

function AuditingState:doLogic()
 	UIMgr:popUI("AuditingPanel")
end

function AuditingState:update()
    --print(string.format("AuditingState %s update", self.name))  
end

function AuditingState:exit()
 	UIMgr:removeUI("ServerListUI", nil, nil, true)
end

return AuditingState