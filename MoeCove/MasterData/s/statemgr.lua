---@class StateMgr
local StateMgr = class("StateMgr")

local func

function StateMgr:ctor()
	func = function ()
		self:OnSceneLoaded(self.toState)
	end
	SMTransition.actionSceneLoaded = SMTransition.actionSceneLoaded + func
	---@type boolean
	self.stateChanging = false
	---@type FSMState
	self.toState = nil
	---@type FSMState
	self.nowState = nil
	---@type FSMState
	self.lastState = nil
	---@type FSMState
	self.baseState = GameFlowState.GameState
end  

function StateMgr:Clear()
	if func then
		SMTransition.actionSceneLoaded = SMTransition.actionSceneLoaded - func
	end
end


function StateMgr:ChangeToState(toState, ...)
	if self.stateChanging == true then
		return
	end
	
	self.toState = toState

	local args = {...}
	if true then
		if toState ~= GameFlowState.EmptyState then
			if (toState ~= self.nowState) then
				self.lastState = self.nowState
			end
			self.nowState = toState
		end
		GameFlowFSM:changeState(toState)
	end
end

function StateMgr:OnSceneLoaded(toState)
	--场景切换以后 状态清空
	if UIMgr then
        UIMgr:ClearUI()
    end
	if toState ~= nil then
		GameFlowFSM:changeState(toState)
	end
    self.stateChanging = false
end

function StateMgr:BackLastState()
	if (self.lastState) then
		self:ChangeToState(self.lastState)
	else
		self:ChangeToState(self.baseState)
	end
end

--获取当前state
function StateMgr:GetNowState()
	return self.nowState
end

return StateMgr