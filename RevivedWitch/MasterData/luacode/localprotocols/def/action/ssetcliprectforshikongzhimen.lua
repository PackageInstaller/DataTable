-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/ssetcliprectforshikongzhimen.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSetClipRectForShiKongZhiMen = dataclass("SSetClipRectForShiKongZhiMen")
SSetClipRectForShiKongZhiMen.ProtocolType = 50
SSetClipRectForShiKongZhiMen.entityid = 0
SSetClipRectForShiKongZhiMen.w = 0
SSetClipRectForShiKongZhiMen.h = 0
SSetClipRectForShiKongZhiMen.camp = 0
SSetClipRectForShiKongZhiMen.objectname = ""
SSetClipRectForShiKongZhiMen.clipstate = ""
SSetClipRectForShiKongZhiMen.Ctor = function(self, client)
  -- function num : 0_0
end

SSetClipRectForShiKongZhiMen.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.w = self.w
  data.h = self.h
  data.camp = self.camp
  data.objectname = self.objectname
  data.clipstate = self.clipstate
end

SSetClipRectForShiKongZhiMen.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.w = data.w
  self.h = data.h
  self.camp = data.camp
  self.objectname = data.objectname
  self.clipstate = data.clipstate
  return true
end

SSetClipRectForShiKongZhiMen.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.w) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.w) = %s. number required.", type(self.w))
    return false
  end
  if type(self.h) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.h) = %s. number required.", type(self.h))
    return false
  end
  if type(self.camp) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.camp) = %s. number required.", type(self.camp))
    return false
  end
  if type(self.objectname) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.objectname) = %s. string required.", type(self.objectname))
    return false
  end
  if type(self.clipstate) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clipstate) = %s. string required.", type(self.clipstate))
    return false
  end
  return true
end

return SSetClipRectForShiKongZhiMen

