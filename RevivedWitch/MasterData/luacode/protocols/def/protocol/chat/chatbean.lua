-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/chatbean.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local ChatBean = dataclass("ChatBean", require("framework.net.protocol"))
ChatBean.ProtocolType = 1101
ChatBean.MaxSize = 65535
ChatBean.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : ChatBean, _ENV
  ((ChatBean.super).Ctor)(self, client)
  self.b1 = ((require("protocols.bean.protocol.chat.channeltype")).Create)()
end

ChatBean.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.b1):Marshal(buffer) then
    return false
  end
  return true
end

ChatBean.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.b1):Unmarshal(buffer) then
    return false
  end
  return ret
end

return ChatBean

