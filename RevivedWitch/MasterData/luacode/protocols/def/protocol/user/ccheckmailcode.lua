-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/ccheckmailcode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCheckMailCode = dataclass("CCheckMailCode", require("framework.net.protocol"))
CCheckMailCode.ProtocolType = 2257
CCheckMailCode.MaxSize = 65535
CCheckMailCode.code = ""
CCheckMailCode.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCheckMailCode
  ((CCheckMailCode.super).Ctor)(self, client)
end

CCheckMailCode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.code) then
    return false
  end
  return true
end

CCheckMailCode.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckMailCode

