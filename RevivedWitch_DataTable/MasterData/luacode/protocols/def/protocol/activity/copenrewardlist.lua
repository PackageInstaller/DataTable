-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copenrewardlist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenRewardList = dataclass("COpenRewardList", require("framework.net.protocol"))
COpenRewardList.ProtocolType = 2487
COpenRewardList.MaxSize = 65535
COpenRewardList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenRewardList
  ((COpenRewardList.super).Ctor)(self, client)
end

COpenRewardList.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenRewardList.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenRewardList

