-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sdk/agent/yostar.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AgentBase = require("logic.sdk.agent.agentbase")
local Yostar = class("YostarAgent", AgentBase)
Yostar.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (((CS.PixelNeko).Log).LogInfo)("Yostar", "init")
end

Yostar.OpenLoginDialog = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("login.logindialog")
end

Yostar.Logout = function(self)
  -- function num : 0_2
end

Yostar.Pay = function(self, orderInfo)
  -- function num : 0_3 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.gm.csendcommand")
  req.cmd = "//reviveorder " .. tostring((math.tointeger)(orderInfo.gameorderid // 10000))
  req:Send()
end

Yostar.GetLoginExtInfo = function(self)
  -- function num : 0_4
  return {plat = self:GetPlat()}
end

return Yostar

