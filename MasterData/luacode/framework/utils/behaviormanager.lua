local BehaviorManager = {}

function BehaviorManager.NewBehavior(behaviorName)
  local b = require("luabehavior.behavior")
  return b.Create(behaviorName)
end

return BehaviorManager
