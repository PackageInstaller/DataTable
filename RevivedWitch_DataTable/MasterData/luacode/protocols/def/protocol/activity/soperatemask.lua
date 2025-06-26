-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/soperatemask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOperateMask = dataclass("SOperateMask", require("framework.net.protocol"))
SOperateMask.ProtocolType = 2508
SOperateMask.MaxSize = 65535
SOperateMask.result = 0
SOperateMask.mask = 0
SOperateMask.state = 0
SOperateMask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOperateMask
  ((SOperateMask.super).Ctor)(self, client)
end

SOperateMask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.mask) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  return true
end

SOperateMask.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOperateMask

