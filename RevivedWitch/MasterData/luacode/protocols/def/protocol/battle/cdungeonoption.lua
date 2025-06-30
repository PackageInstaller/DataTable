-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cdungeonoption.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDungeonOption = dataclass("CDungeonOption", require("framework.net.protocol"))
CDungeonOption.ProtocolType = 1926
CDungeonOption.MaxSize = 65535
CDungeonOption.optionId = 0
CDungeonOption.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDungeonOption
  ((CDungeonOption.super).Ctor)(self, client)
end

CDungeonOption.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.optionId) then
    return false
  end
  return true
end

CDungeonOption.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDungeonOption

