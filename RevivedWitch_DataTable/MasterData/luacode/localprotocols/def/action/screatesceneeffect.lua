-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/screatesceneeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SCreateSceneEffect = dataclass("SCreateSceneEffect")
SCreateSceneEffect.ProtocolType = 25
SCreateSceneEffect.effectid = 0
SCreateSceneEffect.posX = 0
SCreateSceneEffect.posY = 0
SCreateSceneEffect.posZ = 0
SCreateSceneEffect.rad = 0
SCreateSceneEffect.camp = 0
SCreateSceneEffect.Ctor = function(self, client)
  -- function num : 0_0
end

SCreateSceneEffect.Marshal = function(self, data)
  -- function num : 0_1
  data.effectid = self.effectid
  data.posX = self.posX
  data.posY = self.posY
  data.posZ = self.posZ
  data.rad = self.rad
  data.camp = self.camp
end

SCreateSceneEffect.Unmarshal = function(self, data)
  -- function num : 0_2
  self.effectid = data.effectid
  self.posX = data.posX
  self.posY = data.posY
  self.posZ = data.posZ
  self.rad = data.rad
  self.camp = data.camp
  return true
end

SCreateSceneEffect.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.effectid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectid) = %s. number required.", type(self.effectid))
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
  if type(self.posZ) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posZ) = %s. number required.", type(self.posZ))
    return false
  end
  if type(self.rad) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.rad) = %s. number required.", type(self.rad))
    return false
  end
  if type(self.camp) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.camp) = %s. number required.", type(self.camp))
    return false
  end
  return true
end

return SCreateSceneEffect

