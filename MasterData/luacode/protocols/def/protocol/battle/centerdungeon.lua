-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/centerdungeon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CEnterDungeon = dataclass("CEnterDungeon", require("framework.net.protocol"))
CEnterDungeon.ProtocolType = 1912
CEnterDungeon.MaxSize = 65535
CEnterDungeon.WaitProtocol = "protocol.notify.scancelloading"
CEnterDungeon.dungeonType = 0
CEnterDungeon.id = 0
CEnterDungeon.lineupId = 0
CEnterDungeon.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CEnterDungeon
  ((CEnterDungeon.super).Ctor)(self, client)
end

CEnterDungeon.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dungeonType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineupId) then
    return false
  end
  return true
end

CEnterDungeon.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CEnterDungeon

