-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/notify/ssendmsgnotify.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendMsgNotify = dataclass("SSendMsgNotify", require("framework.net.protocol"))
SSendMsgNotify.ProtocolType = 1801
SSendMsgNotify.MaxSize = 65535
SSendMsgNotify.msgId = 0
SSendMsgNotify.GM_MESSAGE_ID = 100106
SSendMsgNotify.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendMsgNotify
  ((SSendMsgNotify.super).Ctor)(self, client)
  self.parameters = {}
end

SSendMsgNotify.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.msgId) then
    return false
  end
  local length = (table.slen)(self.parameters)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, (self.parameters)[i]) then
      return false
    end
  end
  return true
end

SSendMsgNotify.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SSendMsgNotify

