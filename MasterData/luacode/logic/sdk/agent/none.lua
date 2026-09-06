local AgentBase = require("logic.sdk.agent.agentbase")
local None = class("NoneAgent", AgentBase)

function None:Init()
  CS.PixelNeko.Log.LogInfo("None", "init")
end

function None:OpenLoginDialog()
  DialogManager.CreateSingletonDialog("login.logindialog")
end

function None:Logout()
end

function None:Pay(orderInfo)
  local req = LuaNetManager.CreateProtocol("protocol.gm.csendcommand")
  req.cmd = "//reviveorder " .. tostring(math.tointeger(orderInfo.gameorderid // 10000))
  req:Send()
end

function None:GetLoginExtInfo()
  return {
    plat = self:GetPlat()
  }
end

return None
