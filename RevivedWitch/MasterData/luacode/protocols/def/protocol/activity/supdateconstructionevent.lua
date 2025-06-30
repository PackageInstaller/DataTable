-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/supdateconstructionevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUpdateConstructionEvent = dataclass("SUpdateConstructionEvent", require("framework.net.protocol"))
SUpdateConstructionEvent.ProtocolType = 2499
SUpdateConstructionEvent.MaxSize = 65535
SUpdateConstructionEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUpdateConstructionEvent
  ((SUpdateConstructionEvent.super).Ctor)(self, client)
  self.updates = {}
  self.updateConstructions = {}
end

SUpdateConstructionEvent.Marshal = function(self, buffer)
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
  local length = (table.slen)(self.updateConstructions)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.updateConstructions)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SUpdateConstructionEvent.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.updates)[i] = ((require("protocols.bean.protocol.activity.summerevent")).Create)()
    if not ((self.updates)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

    (self.updateConstructions)[i] = ((require("protocols.bean.protocol.activity.updateconstruction")).Create)()
    if not ((self.updateConstructions)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUpdateConstructionEvent

