-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sfinishautoexplore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SFinishAutoExplore = dataclass("SFinishAutoExplore", require("framework.net.protocol"))
SFinishAutoExplore.ProtocolType = 1965
SFinishAutoExplore.MaxSize = 65535
SFinishAutoExplore.dungeonType = 0
SFinishAutoExplore.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SFinishAutoExplore, _ENV
  ((SFinishAutoExplore.super).Ctor)(self, client)
  self.battleResult = ((require("protocols.bean.protocol.battle.battleresult")).Create)()
end

SFinishAutoExplore.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dungeonType) then
    return false
  end
  if not (self.battleResult):Marshal(buffer) then
    return false
  end
  return true
end

SFinishAutoExplore.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.battleResult):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SFinishAutoExplore

