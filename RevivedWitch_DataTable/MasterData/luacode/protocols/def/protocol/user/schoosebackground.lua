-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/schoosebackground.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChooseBackground = dataclass("SChooseBackground", require("framework.net.protocol"))
SChooseBackground.ProtocolType = 2272
SChooseBackground.MaxSize = 65535
SChooseBackground.roleId = 0
SChooseBackground.skin = 0
SChooseBackground.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChooseBackground
  ((SChooseBackground.super).Ctor)(self, client)
end

SChooseBackground.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.skin) then
    return false
  end
  return true
end

SChooseBackground.Unmarshal = function(self, buffer)
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

return SChooseBackground

