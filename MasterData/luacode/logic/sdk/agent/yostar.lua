local AgentBase = require("logic.sdk.agent.agentbase")
local Yostar = class("YostarAgent", AgentBase)

function Yostar:Init()
  CS.PixelNeko.Log.LogInfo("Yostar", "init")
end

function Yostar:OpenLoginDialog()
  DialogManager.CreateSingletonDialog("login.logindialog")
end

function Yostar:Logout()
end

function Yostar:Pay(orderInfo)
  local req = LuaNetManager.CreateProtocol("protocol.gm.csendcommand")
  req.cmd = "//reviveorder " .. tostring(math.tointeger(orderInfo.gameorderid // 10000))
  req:Send()
end

function Yostar:GetLoginExtInfo()
  return {
    plat = self:GetPlat()
  }
end

return Yostar
