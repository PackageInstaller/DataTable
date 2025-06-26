-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/caddglowworm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAddGlowworm = dataclass("CAddGlowworm", require("framework.net.protocol"))
CAddGlowworm.ProtocolType = 2334
CAddGlowworm.MaxSize = 65535
CAddGlowworm.taskId = 0
CAddGlowworm.addNums = 0
CAddGlowworm.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAddGlowworm
  ((CAddGlowworm.super).Ctor)(self, client)
end

CAddGlowworm.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.taskId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.addNums) then
    return false
  end
  return true
end

CAddGlowworm.Unmarshal = function(self, buffer)
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

return CAddGlowworm

