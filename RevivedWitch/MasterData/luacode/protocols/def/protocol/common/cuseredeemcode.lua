-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/common/cuseredeemcode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUseRedeemCode = dataclass("CUseRedeemCode", require("framework.net.protocol"))
CUseRedeemCode.ProtocolType = 201
CUseRedeemCode.MaxSize = 10240
CUseRedeemCode.code = ""
CUseRedeemCode.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUseRedeemCode
  ((CUseRedeemCode.super).Ctor)(self, client)
end

CUseRedeemCode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.code) then
    return false
  end
  return true
end

CUseRedeemCode.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUseRedeemCode

