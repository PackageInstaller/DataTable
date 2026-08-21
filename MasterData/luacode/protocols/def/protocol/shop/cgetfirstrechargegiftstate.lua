-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/cgetfirstrechargegiftstate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetFirstRechargeGiftState = dataclass("CGetFirstRechargeGiftState", require("framework.net.protocol"))
CGetFirstRechargeGiftState.ProtocolType = 3629
CGetFirstRechargeGiftState.MaxSize = 65535
CGetFirstRechargeGiftState.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetFirstRechargeGiftState
  ((CGetFirstRechargeGiftState.super).Ctor)(self, client)
end

CGetFirstRechargeGiftState.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGetFirstRechargeGiftState.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGetFirstRechargeGiftState

