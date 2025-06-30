-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sgamelogin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGameLogin = dataclass("SGameLogin", require("framework.net.protocol"))
SGameLogin.ProtocolType = 1082
SGameLogin.MaxSize = 65535
SGameLogin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGameLogin
  ((SGameLogin.super).Ctor)(self, client)
end

SGameLogin.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SGameLogin.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SGameLogin

