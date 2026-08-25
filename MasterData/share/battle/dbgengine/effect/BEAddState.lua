local System = require("System.System")
local BEAddStateParent = require("Battle.DbgEngine.Effect.BEAddStateParent")
local BEAddState, Super = System.NewClass("BEAddState", BEAddStateParent)

function BEAddState:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local stateId = self.params[1]
  local layer = math.ceil(self.params[2] or 1)
  if not targets then
    return false
  end
  if layer <= 0 then
    return true
  end
  local stateParams = {}
  if #self.params > 2 then
    for i = 3, #self.params do
      table.insert(stateParams, self.params[i])
    end
  end
  for _, target in ipairs(targets) do
    self:AddState(target, stateId, layer, stateParams)
  end
  return true
end

return BEAddState
