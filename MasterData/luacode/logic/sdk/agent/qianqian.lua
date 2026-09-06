local AgentBase = require("logic.sdk.agent.agentbase")
local Qianqian = class("QianqianAgent", AgentBase)

function Qianqian:Init()
end

function Qianqian:OpenLoginDialog()
  LogWarning("qianqian sdk", "=======OpenLoginDialog")
  DialogManager.CreateSingletonDialog("login.sdklogindialog")
end

function Qianqian:Login(type)
  LogWarning("qianqian sdk", "=======Login")
  Qianqian.super.Login(self, JSON.encode({loginType = type}))
end

function Qianqian:Logout(args)
  LogWarning("qianqian sdk", "=======Logout")
  CS.PixelNeko.P1.PlatformManager.Logout()
end

function Qianqian:Pay(orderInfo)
  LogWarning("qianqian sdk", "=======Pay")
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local userId = self._account
  local roleId = tostring(userInfo.userid)
  local roleName = userInfo.username
  local roleLevel = userInfo.userlevel
  local zoneId = tostring(userInfo.zoneid)
  local zoneName = ""
  local money = tostring(orderInfo.price)
  local orderId = orderInfo.gameorderid
  local gameGoodId = orderInfo.goodid
  local goodGearId = orderInfo.gearid
  local productName = orderInfo.goodname
  local sdkProductId = orderInfo.extraparam
  local platType = orderInfo.platType
  local notifyUri = orderInfo.url
  local extInfo = ""
  local ratio = 100
  local jsonStr = JSON.encode({
    orderId = orderId,
    sdkProductId = sdkProductId,
    productName = productName,
    money = money,
    count = "1",
    notifyUri = notifyUri,
    flowType = "sdkpay",
    roleId = roleId,
    roleName = roleName,
    roleLevel = roleLevel,
    zoneId = zoneId,
    zoneName = zoneName,
    vipLevel = "0"
  })
  CS.PixelNeko.Log.LogInfo("SdkManager", "Pay parmeter: " .. jsonStr)
  CS.PixelNeko.P1.PlatformManager.Pay(jsonStr)
end

function Qianqian:Report(type, info)
  LogWarning("qianqian sdk", "=======Report type" .. type)
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local roleId = userInfo.userid
  local roleName = userInfo.username
  local roleLevel = userInfo.userlevel
  local zoneId = userInfo.zoneid
  local zoneName = "大通服"
  local flowType = ""
  if type == "CreateRole" then
    flowType = "createrole"
  elseif type == "Login" then
    flowType = "enterServer"
  elseif type == "LevelUp" then
    flowType = "levelup"
  end
  local jsonStr = JSON.encode({
    flowType = flowType,
    roleId = roleId,
    roleName = roleName,
    roleLevel = roleLevel,
    zoneId = zoneId,
    zoneName = zoneName,
    vipLevel = "0",
    roleCreateTime = os.time()
  })
  LogWarning("qianqian sdk", "report data " .. jsonStr)
  CS.PixelNeko.P1.PlatformManager.Report(jsonStr)
end

function Qianqian:GetLoginExtInfo()
  return {
    plat = self:GetPlat(),
    channelId = SdkManager.GetChannelID()
  }
end

function Qianqian:ShowPrivacy()
  CS.PixelNeko.P1.PlatformManager.ShowPrivacy()
end

function Qianqian:IsChannelPackage()
  return false
end

function Qianqian:GetChannelID()
  if SdkManager.GetPlatform() == "iOS" then
    return "10002"
  end
  return CS.PixelNeko.P1.PlatformManager.GetChannelID()
end

function Qianqian:ShowCustomerService(info)
  CS.PixelNeko.P1.PlatformManager.ShowCustomerService(info or "{}")
end

return Qianqian
