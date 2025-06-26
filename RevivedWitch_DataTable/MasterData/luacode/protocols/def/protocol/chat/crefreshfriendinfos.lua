-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/crefreshfriendinfos.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRefreshFriendInfos = dataclass("CRefreshFriendInfos", require("framework.net.protocol"))
CRefreshFriendInfos.ProtocolType = 1129
CRefreshFriendInfos.MaxSize = 65535
CRefreshFriendInfos.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRefreshFriendInfos
  ((CRefreshFriendInfos.super).Ctor)(self, client)
end

CRefreshFriendInfos.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRefreshFriendInfos.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRefreshFriendInfos

