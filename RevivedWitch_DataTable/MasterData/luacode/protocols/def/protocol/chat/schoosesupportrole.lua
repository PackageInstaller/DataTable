-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/schoosesupportrole.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChooseSupportRole = dataclass("SChooseSupportRole", require("framework.net.protocol"))
SChooseSupportRole.ProtocolType = 1148
SChooseSupportRole.MaxSize = 65535
SChooseSupportRole.userId = 0
SChooseSupportRole.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChooseSupportRole
  ((SChooseSupportRole.super).Ctor)(self, client)
end

SChooseSupportRole.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  return true
end

SChooseSupportRole.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChooseSupportRole

