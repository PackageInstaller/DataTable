-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/notify/ssendtopmessage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendTopMessage = dataclass("SSendTopMessage", require("framework.net.protocol"))
SSendTopMessage.ProtocolType = 1802
SSendTopMessage.MaxSize = 65535
SSendTopMessage.messageId = 0
SSendTopMessage.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendTopMessage
  ((SSendTopMessage.super).Ctor)(self, client)
  self.parameters = {}
end

SSendTopMessage.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.messageId) then
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

SSendTopMessage.Unmarshal = function(self, buffer)
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

return SSendTopMessage

