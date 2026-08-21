local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")

function loadGame(param, activeData)
  if FH.isGameOver(activeData) then
    info("GamePlay", "game is over, can not process logic")
    return activeData
  end
  local id = param.playerId
  local progress = param.progress
  local fightData = activeData
  if fightData.gameStart == true then
    warning("GamePlay", "ERROR - load game run here?")
    return fightData
  end
  local loadList = fightData.loadList
  for i = 1, #loadList do
    if loadList[i].playerId == id then
      loadList[i].progress = progress
      break
    end
  end
  local loadEnd = true
  if FH.isMultiPlayerMode(fightData) then
    for i = 1, #loadList do
      if loadList[i].progress ~= 100 then
        loadEnd = false
        break
      end
    end
  end
  fightData.gameStart = loadEnd
  return fightData
end

return loadGame
