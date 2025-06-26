-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srefreshpoptips.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshPopTips = dataclass("SRefreshPopTips", require("framework.net.protocol"))
SRefreshPopTips.ProtocolType = 2561
SRefreshPopTips.MaxSize = 65535
SRefreshPopTips.activityID = 0
SRefreshPopTips.status = 0
SRefreshPopTips.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshPopTips
  ((SRefreshPopTips.super).Ctor)(self, client)
end

SRefreshPopTips.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  return true
end

SRefreshPopTips.Unmarshal = function(self, buffer)
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

return SRefreshPopTips

