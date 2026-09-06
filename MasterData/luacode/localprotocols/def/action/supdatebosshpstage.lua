local SUpdateBossHpStage = dataclass("SUpdateBossHpStage")
SUpdateBossHpStage.ProtocolType = 62
SUpdateBossHpStage.entityId = 0

function SUpdateBossHpStage:Ctor(client)
  self.bosshpstage = {}
end

function SUpdateBossHpStage:Marshal(data)
  data.entityId = self.entityId
  data.bosshpstage = {}
  for index, value in ipairs(self.bosshpstage) do
    data.bosshpstage[index] = {}
    self.bosshpstage[index]:Marshal(data.bosshpstage[index])
  end
end

function SUpdateBossHpStage:Unmarshal(data)
  self.entityId = data.entityId
  for index, value in ipairs(data.bosshpstage) do
    self.bosshpstage[index] = require("localprotocols.bean.int").Create()
    self.bosshpstage[index]:Unmarshal(data.bosshpstage[index])
  end
  return true
end

function SUpdateBossHpStage:CheckVariable()
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.bosshpstage) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.bosshpstage) = %s. table required.", type(self.bosshpstage))
    return false
  end
  for index, value in ipairs(self.bosshpstage) do
    if type(value) ~= "number" then
      LogErrorFormat("LocalProtocols", "type error!type(self.bosshpstage -> value) = %s. number required.", type(value))
      return false
    end
  end
  return true
end

return SUpdateBossHpStage
