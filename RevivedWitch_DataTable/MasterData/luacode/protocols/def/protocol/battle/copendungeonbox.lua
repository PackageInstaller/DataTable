-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/copendungeonbox.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenDungeonBox = dataclass("COpenDungeonBox", require("framework.net.protocol"))
COpenDungeonBox.ProtocolType = 1916
COpenDungeonBox.MaxSize = 65535
COpenDungeonBox.boxId = 0
COpenDungeonBox.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenDungeonBox
  ((COpenDungeonBox.super).Ctor)(self, client)
end

COpenDungeonBox.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.boxId) then
    return false
  end
  return true
end

COpenDungeonBox.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenDungeonBox

