-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cchangeskin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeSkin = dataclass("CChangeSkin", require("framework.net.protocol"))
CChangeSkin.ProtocolType = 1247
CChangeSkin.MaxSize = 65535
CChangeSkin.roleId = 0
CChangeSkin.skin2Change = 0
CChangeSkin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeSkin
  ((CChangeSkin.super).Ctor)(self, client)
end

CChangeSkin.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.skin2Change) then
    return false
  end
  return true
end

CChangeSkin.Unmarshal = function(self, buffer)
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

return CChangeSkin

