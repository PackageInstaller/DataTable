-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/cchangeuserintroduce.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeUserIntroduce = dataclass("CChangeUserIntroduce", require("framework.net.protocol"))
CChangeUserIntroduce.ProtocolType = 2222
CChangeUserIntroduce.MaxSize = 65535
CChangeUserIntroduce.introduce = ""
CChangeUserIntroduce.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeUserIntroduce
  ((CChangeUserIntroduce.super).Ctor)(self, client)
end

CChangeUserIntroduce.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.introduce) then
    return false
  end
  return true
end

CChangeUserIntroduce.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeUserIntroduce

