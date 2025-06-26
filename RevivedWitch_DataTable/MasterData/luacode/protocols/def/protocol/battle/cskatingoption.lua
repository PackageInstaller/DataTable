-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cskatingoption.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSkatingOption = dataclass("CSkatingOption", require("framework.net.protocol"))
CSkatingOption.ProtocolType = 1966
CSkatingOption.MaxSize = 65535
CSkatingOption.option = 0
CSkatingOption.instanceId = 0
CSkatingOption.switchId = 0
CSkatingOption.END = 1
CSkatingOption.RECOVER = 2
CSkatingOption.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSkatingOption
  ((CSkatingOption.super).Ctor)(self, client)
end

CSkatingOption.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteByte)(buffer, self.option) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.instanceId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.switchId) then
    return false
  end
  return true
end

CSkatingOption.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadByte)(buffer)
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

return CSkatingOption

