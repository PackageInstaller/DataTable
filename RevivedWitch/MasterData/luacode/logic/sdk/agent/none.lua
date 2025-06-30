-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sdk/agent/none.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AgentBase = require("logic.sdk.agent.agentbase")
local None = class("NoneAgent", AgentBase)
None.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (((CS.PixelNeko).Log).LogInfo)("None", "init")
end

None.OpenLoginDialog = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("login.logindialog")
end

None.Logout = function(self)
  -- function num : 0_2
end

None.Pay = function(self, orderInfo)
  -- function num : 0_3 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.gm.csendcommand")
  req.cmd = "//reviveorder " .. tostring((math.tointeger)(orderInfo.gameorderid // 10000))
  req:Send()
end

None.GetLoginExtInfo = function(self)
  -- function num : 0_4
  return {plat = self:GetPlat()}
end

return None

