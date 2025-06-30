-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/coperatemask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COperateMask = dataclass("COperateMask", require("framework.net.protocol"))
COperateMask.ProtocolType = 2507
COperateMask.MaxSize = 65535
COperateMask.mask = 0
COperateMask.operate = 0
COperateMask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COperateMask
  ((COperateMask.super).Ctor)(self, client)
end

COperateMask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.mask) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.operate) then
    return false
  end
  return true
end

COperateMask.Unmarshal = function(self, buffer)
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
  return ret
end

return COperateMask

