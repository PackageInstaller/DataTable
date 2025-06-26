-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/schangeskin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeSkin = dataclass("SChangeSkin", require("framework.net.protocol"))
SChangeSkin.ProtocolType = 1248
SChangeSkin.MaxSize = 65535
SChangeSkin.roleId = 0
SChangeSkin.skin2Change = 0
SChangeSkin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeSkin
  ((SChangeSkin.super).Ctor)(self, client)
end

SChangeSkin.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.skin2Change) then
    return false
  end
  return true
end

SChangeSkin.Unmarshal = function(self, buffer)
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

return SChangeSkin

