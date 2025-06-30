-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/saddglowworm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAddGlowworm = dataclass("SAddGlowworm", require("framework.net.protocol"))
SAddGlowworm.ProtocolType = 2346
SAddGlowworm.MaxSize = 65535
SAddGlowworm.taskId = 0
SAddGlowworm.glowwormTotalNums = 0
SAddGlowworm.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAddGlowworm
  ((SAddGlowworm.super).Ctor)(self, client)
end

SAddGlowworm.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.taskId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.glowwormTotalNums) then
    return false
  end
  return true
end

SAddGlowworm.Unmarshal = function(self, buffer)
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

return SAddGlowworm

