-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/stouchmanacollector.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local STouchManaCollector = dataclass("STouchManaCollector", require("framework.net.protocol"))
STouchManaCollector.ProtocolType = 1939
STouchManaCollector.MaxSize = 65535
STouchManaCollector.sceneId = 0
STouchManaCollector.key = 0
STouchManaCollector.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : STouchManaCollector
  ((STouchManaCollector.super).Ctor)(self, client)
  self.manas = {}
end

STouchManaCollector.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sceneId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  local length = (table.slen)(self.manas)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.manas)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

STouchManaCollector.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
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
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.manas)[i] = ((require("protocols.bean.protocol.battle.randomitem")).Create)()
    if not ((self.manas)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return STouchManaCollector

