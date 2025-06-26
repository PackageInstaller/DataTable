-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopendoubleelevenactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenDoubleElevenActivity = dataclass("SOpenDoubleElevenActivity", require("framework.net.protocol"))
SOpenDoubleElevenActivity.ProtocolType = 2522
SOpenDoubleElevenActivity.MaxSize = 65535
SOpenDoubleElevenActivity.poolId = 0
SOpenDoubleElevenActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenDoubleElevenActivity
  ((SOpenDoubleElevenActivity.super).Ctor)(self, client)
  self.openCards = {}
end

SOpenDoubleElevenActivity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.poolId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.openCards)) then
    return false
  end
  for key,value in pairs(self.openCards) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
    if not value:Marshal(R9_PC26) then
      return false
    end
  end
  return true
end

SOpenDoubleElevenActivity.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC39: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.openCards)[key] = value
  end
  return ret
end

return SOpenDoubleElevenActivity

