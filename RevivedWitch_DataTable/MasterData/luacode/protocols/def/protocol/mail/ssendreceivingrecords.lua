-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/mail/ssendreceivingrecords.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendReceivingRecords = dataclass("SSendReceivingRecords", require("framework.net.protocol"))
SSendReceivingRecords.ProtocolType = 1405
SSendReceivingRecords.MaxSize = 65535
SSendReceivingRecords.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendReceivingRecords
  ((SSendReceivingRecords.super).Ctor)(self, client)
  self.records = {}
end

SSendReceivingRecords.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.records)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.records)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SSendReceivingRecords.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.records)[i] = ((require("protocols.bean.protocol.mail.receivingrecord")).Create)()
    if not ((self.records)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SSendReceivingRecords

