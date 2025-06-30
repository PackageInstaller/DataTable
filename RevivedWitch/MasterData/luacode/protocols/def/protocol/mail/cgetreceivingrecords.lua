-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/mail/cgetreceivingrecords.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetReceivingRecords = dataclass("CGetReceivingRecords", require("framework.net.protocol"))
CGetReceivingRecords.ProtocolType = 1404
CGetReceivingRecords.MaxSize = 65535
CGetReceivingRecords.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetReceivingRecords
  ((CGetReceivingRecords.super).Ctor)(self, client)
end

CGetReceivingRecords.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGetReceivingRecords.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGetReceivingRecords

