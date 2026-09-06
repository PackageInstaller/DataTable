local SDamageMiss = require("localprotocols.def.action.sdamagemiss")

function SDamageMiss:Process(battleWorld)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SDamageMiss Process")
  end
  if battleWorld.OnSDamageMiss then
    battleWorld:OnSDamageMiss(self)
  end
end

return SDamageMiss
