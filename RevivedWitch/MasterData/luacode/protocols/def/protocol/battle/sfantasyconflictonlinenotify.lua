-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sfantasyconflictonlinenotify.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SFantasyConflictOnlineNotify = dataclass("SFantasyConflictOnlineNotify", require("framework.net.protocol"))
SFantasyConflictOnlineNotify.ProtocolType = 4154
SFantasyConflictOnlineNotify.MaxSize = 65535
SFantasyConflictOnlineNotify.award = 0
SFantasyConflictOnlineNotify.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SFantasyConflictOnlineNotify
  ((SFantasyConflictOnlineNotify.super).Ctor)(self, client)
end

SFantasyConflictOnlineNotify.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.award) then
    return false
  end
  return true
end

SFantasyConflictOnlineNotify.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SFantasyConflictOnlineNotify

