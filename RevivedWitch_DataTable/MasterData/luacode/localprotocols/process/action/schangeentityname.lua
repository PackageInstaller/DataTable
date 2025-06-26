-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/schangeentityname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SChangeEntityName = require("localprotocols.def.action.schangeentityname")
SChangeEntityName.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SChangeEntityName Process")
  end
  if controller.OnSChangeEntityName then
    controller:OnSChangeEntityName(self)
  end
end

return SChangeEntityName

