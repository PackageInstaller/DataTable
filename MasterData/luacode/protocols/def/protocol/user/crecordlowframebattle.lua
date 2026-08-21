-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/crecordlowframebattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRecordLowFrameBattle = dataclass("CRecordLowFrameBattle", require("framework.net.protocol"))
CRecordLowFrameBattle.ProtocolType = 2262
CRecordLowFrameBattle.MaxSize = 65535
CRecordLowFrameBattle.fps = 0
CRecordLowFrameBattle.roles = ""
CRecordLowFrameBattle.effect = ""
CRecordLowFrameBattle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRecordLowFrameBattle
  ((CRecordLowFrameBattle.super).Ctor)(self, client)
end

CRecordLowFrameBattle.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolFloat)(buffer, self.fps) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.roles) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.effect) then
    return false
  end
  return true
end

CRecordLowFrameBattle.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadFloat)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordLowFrameBattle

