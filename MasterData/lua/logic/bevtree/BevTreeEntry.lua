local BevTreeManager = require("Logic/BevTree/BevTreeManager")

function BevTreeManagerInit(team, xmlBytes, fightActiveData, aiData)
  BevTreeManager.init(aiData)
  BevTreeManager.createBevTreeFromJson(team, xmlBytes, fightActiveData)
end

function BevTreeManagerUpdate(param, fightActiveData, aiData)
  return BevTreeManager.updateAi(param, fightActiveData, aiData)
end

return {
  BevTreeManagerInit,
  BevTreeManagerUpdate
}
