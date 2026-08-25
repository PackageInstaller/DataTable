local System = require("System.System")
local BattleStateData = System.NewClass("BattleStateData")

function BattleStateData.Create(createArgs)
  local data = {
    layer = createArgs.layer or 1,
    changedLayer = createArgs.layer or 1
  }
  if createArgs.casterLayerList then
    data.casterLayerList = createArgs.casterLayerList
  else
    data.casterLayerList = {}
    data.casterLayerList[createArgs.castRoleUid] = data.layer
  end
  return data
end

return BattleStateData
