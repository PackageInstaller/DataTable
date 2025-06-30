-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/ssendhistorychatmsg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendHistoryChatMsg = dataclass("SSendHistoryChatMsg", require("framework.net.protocol"))
SSendHistoryChatMsg.ProtocolType = 1154
SSendHistoryChatMsg.MaxSize = 65535
SSendHistoryChatMsg.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendHistoryChatMsg
  ((SSendHistoryChatMsg.super).Ctor)(self, client)
  self.msgInfo = {}
end

SSendHistoryChatMsg.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.msgInfo)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.msgInfo)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SSendHistoryChatMsg.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.msgInfo)[i] = ((require("protocols.bean.protocol.chat.msginfo")).Create)()
    if not ((self.msgInfo)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SSendHistoryChatMsg

