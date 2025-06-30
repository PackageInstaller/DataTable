-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/srolepositionchange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRolePositionChange = dataclass("SRolePositionChange")
SRolePositionChange.ProtocolType = 3
SRolePositionChange.entityId = 0
SRolePositionChange.posX = 0
SRolePositionChange.posY = 0
SRolePositionChange.Ctor = function(self, client)
  -- function num : 0_0
end

SRolePositionChange.Marshal = function(self, data)
  -- function num : 0_1
  data.entityId = self.entityId
  data.posX = self.posX
  data.posY = self.posY
end

SRolePositionChange.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityId = data.entityId
  self.posX = data.posX
  self.posY = data.posY
  return true
end

SRolePositionChange.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.posX) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posX) = %s. number required.", type(self.posX))
    return false
  end
  if type(self.posY) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posY) = %s. number required.", type(self.posY))
    return false
  end
  return true
end

return SRolePositionChange

