-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/cgetactiveaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetActiveAward = dataclass("CGetActiveAward", require("framework.net.protocol"))
CGetActiveAward.ProtocolType = 1617
CGetActiveAward.MaxSize = 65535
CGetActiveAward.value = 0
CGetActiveAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetActiveAward
  ((CGetActiveAward.super).Ctor)(self, client)
end

CGetActiveAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.value) then
    return false
  end
  return true
end

CGetActiveAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetActiveAward

