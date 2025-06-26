-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/crepairhandbook.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRepairHandbook = dataclass("CRepairHandbook", require("framework.net.protocol"))
CRepairHandbook.ProtocolType = 2277
CRepairHandbook.MaxSize = 65535
CRepairHandbook.id = 0
CRepairHandbook.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRepairHandbook
  ((CRepairHandbook.super).Ctor)(self, client)
end

CRepairHandbook.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CRepairHandbook.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRepairHandbook

