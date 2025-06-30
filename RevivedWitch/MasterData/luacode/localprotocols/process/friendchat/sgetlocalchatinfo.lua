-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/friendchat/sgetlocalchatinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SGetLocalChatInfo = require("localprotocols.def.friendchat.sgetlocalchatinfo")
SGetLocalChatInfo.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SGetLocalChatInfo Process")
  end
  ;
  ((NekoData.DataManager).DM_FriendsChat):OnSGetLocalChatInfo(self)
end

return SGetLocalChatInfo

