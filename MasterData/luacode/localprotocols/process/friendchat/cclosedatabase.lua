-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/friendchat/cclosedatabase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCloseDataBase = require("localprotocols.def.friendchat.cclosedatabase")
CCloseDataBase.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CCloseDataBase Process")
  end
  ;
  (SqlConnection.UnInit)()
end

return CCloseDataBase

