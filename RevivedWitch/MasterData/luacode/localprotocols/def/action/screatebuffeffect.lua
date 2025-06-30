-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/screatebuffeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SCreateBuffEffect = dataclass("SCreateBuffEffect")
SCreateBuffEffect.ProtocolType = 21
SCreateBuffEffect.entityid = 0
SCreateBuffEffect.point = ""
SCreateBuffEffect.packagename = ""
SCreateBuffEffect.effectname = ""
SCreateBuffEffect.isImaged = 0
SCreateBuffEffect.rad = 0
SCreateBuffEffect.Ctor = function(self, client)
  -- function num : 0_0
end

SCreateBuffEffect.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.point = self.point
  data.packagename = self.packagename
  data.effectname = self.effectname
  data.isImaged = self.isImaged
  data.rad = self.rad
end

SCreateBuffEffect.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.point = data.point
  self.packagename = data.packagename
  self.effectname = data.effectname
  self.isImaged = data.isImaged
  self.rad = data.rad
  return true
end

SCreateBuffEffect.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.point) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.point) = %s. string required.", type(self.point))
    return false
  end
  if type(self.packagename) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.packagename) = %s. string required.", type(self.packagename))
    return false
  end
  if type(self.effectname) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectname) = %s. string required.", type(self.effectname))
    return false
  end
  if type(self.isImaged) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isImaged) = %s. number required.", type(self.isImaged))
    return false
  end
  if type(self.rad) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.rad) = %s. number required.", type(self.rad))
    return false
  end
  return true
end

return SCreateBuffEffect

