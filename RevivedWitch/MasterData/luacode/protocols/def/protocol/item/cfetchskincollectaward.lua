-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cfetchskincollectaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFetchSkinCollectAward = dataclass("CFetchSkinCollectAward", require("framework.net.protocol"))
CFetchSkinCollectAward.ProtocolType = 1271
CFetchSkinCollectAward.MaxSize = 65535
CFetchSkinCollectAward.taskId = 0
CFetchSkinCollectAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFetchSkinCollectAward
  ((CFetchSkinCollectAward.super).Ctor)(self, client)
end

CFetchSkinCollectAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.taskId) then
    return false
  end
  return true
end

CFetchSkinCollectAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchSkinCollectAward

