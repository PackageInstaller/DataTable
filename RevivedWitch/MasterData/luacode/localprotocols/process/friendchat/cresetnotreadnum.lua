-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/friendchat/cresetnotreadnum.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CResetNotReadNum = require("localprotocols.def.friendchat.cresetnotreadnum")
CResetNotReadNum.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CResetNotReadNum Process")
  end
  ;
  (SqlConnection.ResetNotReadNum)(self.userId)
end

return CResetNotReadNum

