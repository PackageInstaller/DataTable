-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sfinishtowermap.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SFinishTowerMap = dataclass("SFinishTowerMap", require("framework.net.protocol"))
SFinishTowerMap.ProtocolType = 1989
SFinishTowerMap.MaxSize = 65535
SFinishTowerMap.result = 0
SFinishTowerMap.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SFinishTowerMap
  ((SFinishTowerMap.super).Ctor)(self, client)
end

SFinishTowerMap.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SFinishTowerMap.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SFinishTowerMap

