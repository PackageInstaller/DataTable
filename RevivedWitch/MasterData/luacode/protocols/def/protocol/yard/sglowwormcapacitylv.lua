-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/sglowwormcapacitylv.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGlowwormCapacityLv = dataclass("SGlowwormCapacityLv", require("framework.net.protocol"))
SGlowwormCapacityLv.ProtocolType = 2341
SGlowwormCapacityLv.MaxSize = 65535
SGlowwormCapacityLv.glowwormLevel = 0
SGlowwormCapacityLv.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGlowwormCapacityLv
  ((SGlowwormCapacityLv.super).Ctor)(self, client)
end

SGlowwormCapacityLv.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.glowwormLevel) then
    return false
  end
  return true
end

SGlowwormCapacityLv.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGlowwormCapacityLv

