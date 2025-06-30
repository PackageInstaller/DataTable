-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/csendchatmsg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSendChatMsg = dataclass("CSendChatMsg", require("framework.net.protocol"))
CSendChatMsg.ProtocolType = 1102
CSendChatMsg.MaxSize = 65535
CSendChatMsg.channelType = 0
CSendChatMsg.msg = ""
CSendChatMsg.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSendChatMsg
  ((CSendChatMsg.super).Ctor)(self, client)
  self.hyperlinks = {}
end

CSendChatMsg.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.channelType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.msg) then
    return false
  end
  local length = (table.slen)(self.hyperlinks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.hyperlinks)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

CSendChatMsg.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.hyperlinks)[i] = ((require("protocols.bean.protocol.chat.hyperlink")).Create)()
    if not ((self.hyperlinks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return CSendChatMsg

