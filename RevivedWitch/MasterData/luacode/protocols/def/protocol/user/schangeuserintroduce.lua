-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/schangeuserintroduce.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeUserIntroduce = dataclass("SChangeUserIntroduce", require("framework.net.protocol"))
SChangeUserIntroduce.ProtocolType = 2223
SChangeUserIntroduce.MaxSize = 65535
SChangeUserIntroduce.introduce = ""
SChangeUserIntroduce.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeUserIntroduce
  ((SChangeUserIntroduce.super).Ctor)(self, client)
end

SChangeUserIntroduce.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.introduce) then
    return false
  end
  return true
end

SChangeUserIntroduce.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeUserIntroduce

