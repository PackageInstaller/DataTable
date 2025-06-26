-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/supdatechristmasevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUpdateChristmasEvent = dataclass("SUpdateChristmasEvent", require("framework.net.protocol"))
SUpdateChristmasEvent.ProtocolType = 2527
SUpdateChristmasEvent.MaxSize = 65535
SUpdateChristmasEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUpdateChristmasEvent
  ((SUpdateChristmasEvent.super).Ctor)(self, client)
  self.updates = {}
end

SUpdateChristmasEvent.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.updates)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.updates)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SUpdateChristmasEvent.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.updates)[i] = ((require("protocols.bean.protocol.activity.christmasevent")).Create)()
    if not ((self.updates)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUpdateChristmasEvent

