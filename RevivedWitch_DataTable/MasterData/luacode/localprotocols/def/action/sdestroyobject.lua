-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sdestroyobject.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SDestroyObject = dataclass("SDestroyObject")
SDestroyObject.ProtocolType = 7
SDestroyObject.entityid = 0
SDestroyObject.skillid = 0
SDestroyObject.isimageentity = 0
SDestroyObject.ispartner = 0
SDestroyObject.Ctor = function(self, client)
  -- function num : 0_0
end

SDestroyObject.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.skillid = self.skillid
  data.isimageentity = self.isimageentity
  data.ispartner = self.ispartner
end

SDestroyObject.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.skillid = data.skillid
  self.isimageentity = data.isimageentity
  self.ispartner = data.ispartner
  return true
end

SDestroyObject.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  if type(self.isimageentity) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isimageentity) = %s. number required.", type(self.isimageentity))
    return false
  end
  if type(self.ispartner) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.ispartner) = %s. number required.", type(self.ispartner))
    return false
  end
  return true
end

return SDestroyObject

