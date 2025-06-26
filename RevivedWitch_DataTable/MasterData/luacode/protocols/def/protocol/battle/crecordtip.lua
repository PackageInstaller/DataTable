-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/crecordtip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRecordTip = dataclass("CRecordTip", require("framework.net.protocol"))
CRecordTip.ProtocolType = 4120
CRecordTip.MaxSize = 65535
CRecordTip.id = 0
CRecordTip.kind = 0
CRecordTip.TIP = 1
CRecordTip.NPC = 2
CRecordTip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRecordTip
  ((CRecordTip.super).Ctor)(self, client)
end

CRecordTip.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.kind) then
    return false
  end
  return true
end

CRecordTip.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordTip

