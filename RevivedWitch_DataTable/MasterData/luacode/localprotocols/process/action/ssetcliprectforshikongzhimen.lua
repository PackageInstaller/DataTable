-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/ssetcliprectforshikongzhimen.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSetClipRectForShiKongZhiMen = require("localprotocols.def.action.ssetcliprectforshikongzhimen")
SSetClipRectForShiKongZhiMen.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SSetClipRectForShiKongZhiMen Process")
  end
  if controller.OnSSetClipRectForShiKongZhiMen then
    controller:OnSSetClipRectForShiKongZhiMen(self)
  end
end

return SSetClipRectForShiKongZhiMen

