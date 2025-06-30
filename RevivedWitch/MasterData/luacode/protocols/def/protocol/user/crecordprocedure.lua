-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/crecordprocedure.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRecordProcedure = dataclass("CRecordProcedure", require("framework.net.protocol"))
CRecordProcedure.ProtocolType = 2212
CRecordProcedure.MaxSize = 65535
CRecordProcedure.procedure = 0
CRecordProcedure.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRecordProcedure
  ((CRecordProcedure.super).Ctor)(self, client)
end

CRecordProcedure.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.procedure) then
    return false
  end
  return true
end

CRecordProcedure.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordProcedure

