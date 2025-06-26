-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sloginaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLoginAward = dataclass("SLoginAward", require("framework.net.protocol"))
SLoginAward.ProtocolType = 1068
SLoginAward.MaxSize = 65535
SLoginAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLoginAward, _ENV
  ((SLoginAward.super).Ctor)(self, client)
  self.totalSign = ((require("protocols.bean.protocol.login.totalsign")).Create)()
end

SLoginAward.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.totalSign):Marshal(buffer) then
    return false
  end
  return true
end

SLoginAward.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.totalSign):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SLoginAward

