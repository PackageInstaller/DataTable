local SSetClipRectForShiKongZhiMen = dataclass("SSetClipRectForShiKongZhiMen")
SSetClipRectForShiKongZhiMen.ProtocolType = 50
SSetClipRectForShiKongZhiMen.entityid = 0
SSetClipRectForShiKongZhiMen.w = 0
SSetClipRectForShiKongZhiMen.h = 0
SSetClipRectForShiKongZhiMen.camp = 0
SSetClipRectForShiKongZhiMen.objectname = ""
SSetClipRectForShiKongZhiMen.clipstate = ""

function SSetClipRectForShiKongZhiMen:Ctor(client)
end

function SSetClipRectForShiKongZhiMen:Marshal(data)
  data.entityid = self.entityid
  data.w = self.w
  data.h = self.h
  data.camp = self.camp
  data.objectname = self.objectname
  data.clipstate = self.clipstate
end

function SSetClipRectForShiKongZhiMen:Unmarshal(data)
  self.entityid = data.entityid
  self.w = data.w
  self.h = data.h
  self.camp = data.camp
  self.objectname = data.objectname
  self.clipstate = data.clipstate
  return true
end

function SSetClipRectForShiKongZhiMen:CheckVariable()
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
