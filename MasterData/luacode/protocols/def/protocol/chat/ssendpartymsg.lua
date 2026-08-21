-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/ssendpartymsg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendPartyMsg = dataclass("SSendPartyMsg", require("framework.net.protocol"))
SSendPartyMsg.ProtocolType = 1153
SSendPartyMsg.MaxSize = 65535
SSendPartyMsg.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendPartyMsg, _ENV
  ((SSendPartyMsg.super).Ctor)(self, client)
  self.msgInfo = ((require("protocols.bean.protocol.chat.msginfo")).Create)()
end

SSendPartyMsg.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.msgInfo):Marshal(buffer) then
    return false
  end
  return true
end

SSendPartyMsg.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.msgInfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SSendPartyMsg

