-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/crougetowerresettype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRougeTowerResetType = dataclass("CRougeTowerResetType", require("framework.net.protocol"))
CRougeTowerResetType.ProtocolType = 2451
CRougeTowerResetType.MaxSize = 65535
CRougeTowerResetType.resetType = 0
CRougeTowerResetType.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRougeTowerResetType
  ((CRougeTowerResetType.super).Ctor)(self, client)
end

CRougeTowerResetType.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.resetType) then
    return false
  end
  return true
end

CRougeTowerResetType.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRougeTowerResetType

