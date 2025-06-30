-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/schangeentityhpcellvisible.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SChangeEntityHpCellVisible = require("localprotocols.def.action.schangeentityhpcellvisible")
SChangeEntityHpCellVisible.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SChangeEntityHpCellVisible Process")
  end
  if controller.OnSChangeEntityHpCellVisible then
    controller:OnSChangeEntityHpCellVisible(self)
  end
end

return SChangeEntityHpCellVisible

