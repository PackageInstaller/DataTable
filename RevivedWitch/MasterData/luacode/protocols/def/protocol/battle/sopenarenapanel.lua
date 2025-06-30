-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sopenarenapanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenArenaPanel = dataclass("SOpenArenaPanel", require("framework.net.protocol"))
SOpenArenaPanel.ProtocolType = 4108
SOpenArenaPanel.MaxSize = 65535
SOpenArenaPanel.waiting = 0
SOpenArenaPanel.seasonId = 0
SOpenArenaPanel.arenaId = 0
SOpenArenaPanel.camp = 0
SOpenArenaPanel.firstEnter = 0
SOpenArenaPanel.apAddTimes = 0
SOpenArenaPanel.leftTime = 0
SOpenArenaPanel.NOCAMP = 0
SOpenArenaPanel.CAMP1 = 1
SOpenArenaPanel.CAMP2 = 2
SOpenArenaPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenArenaPanel
  ((SOpenArenaPanel.super).Ctor)(self, client)
end

SOpenArenaPanel.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.waiting) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.seasonId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.arenaId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.camp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.firstEnter) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.apAddTimes) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftTime) then
    return false
  end
  return true
end

SOpenArenaPanel.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenArenaPanel

