-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/crecordtaskchoice.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRecordTaskChoice = dataclass("CRecordTaskChoice", require("framework.net.protocol"))
CRecordTaskChoice.ProtocolType = 1614
CRecordTaskChoice.MaxSize = 65535
CRecordTaskChoice.taskid = 0
CRecordTaskChoice.choice = ""
CRecordTaskChoice.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRecordTaskChoice
  ((CRecordTaskChoice.super).Ctor)(self, client)
end

CRecordTaskChoice.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.taskid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.choice) then
    return false
  end
  return true
end

CRecordTaskChoice.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordTaskChoice

