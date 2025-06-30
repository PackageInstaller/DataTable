-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cacttimerefresh.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CActTimeRefresh = dataclass("CActTimeRefresh", require("framework.net.protocol"))
CActTimeRefresh.ProtocolType = 2658
CActTimeRefresh.MaxSize = 65535
CActTimeRefresh.activityId = 0
CActTimeRefresh.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CActTimeRefresh
  ((CActTimeRefresh.super).Ctor)(self, client)
end

CActTimeRefresh.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  return true
end

CActTimeRefresh.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CActTimeRefresh

