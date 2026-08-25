local System = require("System.System")
local BEAddStateParent = require("Battle.DbgEngine.Effect.BEAddStateParent")
local BEAddRandomState, Super = System.NewClass("BEAddRandomState", BEAddStateParent)

function BEAddRandomState:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local stateList = self.params[1]
  if not targets then
    return false
  end
  if not stateList or 0 == #stateList then
    return false
  end
  local layer = math.ceil(self.params[2] or 1)
  if layer <= 0 then
    return true
  end
  local stateParams = {}
  if #self.params > 2 then
    for i = 3, #self.params do
      table.insert(stateParams, self.params[i])
    end
  end
  local rand = self.battleEngine.rand
  for _, target in ipairs(targets) do
    local idx = rand:random(1, #stateList)
    local stateId = stateList[idx]
    self:AddState(target, stateId, layer, stateParams)
  end
  return true
end

return BEAddRandomState
