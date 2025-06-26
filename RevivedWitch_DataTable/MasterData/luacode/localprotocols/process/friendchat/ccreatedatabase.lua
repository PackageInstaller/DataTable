-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/friendchat/ccreatedatabase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCreateDataBase = require("localprotocols.def.friendchat.ccreatedatabase")
CCreateDataBase.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CCreateDataBase Process")
  end
  ;
  (SqlConnection.Init)(self.userId, self.clientId)
end

return CCreateDataBase

