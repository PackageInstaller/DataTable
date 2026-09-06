local StateBase = class("StateBase")
StateBase.StateType = {
  Normal = 1,
  Damage = 2,
  SP = 3
}

function StateBase:Ctor()
end

function StateBase:GetCurrentState()
  assert(false)
end

function StateBase:NextState()
  assert(false)
end

function StateBase:OnUpdate(deltaTime)
end

function StateBase:OnStateChange()
end

return StateBase
