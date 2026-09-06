local AgentBase = require("logic.sdk.agent.agentbase")
local quick = class("quickAgent", AgentBase)

function quick:Init()
end

function quick:OpenLoginDialog()
  local plat = self:GetPlat()
  local channelId = SdkManager.GetChannelID()
  LogInfoFormat("quick sdk", "=======OpenLoginDialog plat = %s, channelId = %s", tostring(plat), tostring(channelId))
  DialogManager.CreateSingletonDialog("login.sdklogindialog")
end

function quick:Login(type)
  LogWarning("quick sdk", "=======Login")
  quick.super.Login(self, JSON.encode({loginType = type}))
end

function quick:Logout(args)
  LogWarning("quick sdk", "=======Logout")
  CS.PixelNeko.P1.PlatformManager.Logout()
end

function quick:Pay(orderInfo)
  LogWarning("quick sdk", "=======Pay")
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
    productName = productName,
    money = money,
    count = "1",
    goodId = gameGoodId,
    price = money,
    flowType = "sdkpay",
    productDesc = roleId,
    extparam = "",
    callbackurl = notifyUri
  })
  CS.PixelNeko.Log.LogInfo("SdkManager", "Pay parmeter: " .. jsonStr)
  CS.PixelNeko.P1.PlatformManager.Pay(jsonStr)
end

function quick:Report(type, info)
  LogWarning("quick sdk", "=======Report type" .. type)
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local hasDiamond = NekoData.BehaviorManager.BM_Currency:GetDiamond()
  local roleId = userInfo.userid
  local roleName = userInfo.username
  local roleLevel = userInfo.userlevel
  local zoneId = userInfo.zoneid
  local zoneName = "大通服"
  local partyName = ""
  local guildId = ""
  local flowType = ""
  local roleCreateTime = ""
  if type == "CreateRole" then
    flowType = "createrole"
    roleCreateTime = tostring(os.time())
  elseif type == "Login" then
    flowType = "enterServer"
  elseif type == "LevelUp" then
    flowType = "levelup"
  end
  if roleName == "" then
    roleName = "未知魔女"
  end
  local jsonStr = JSON.encode({
    flowType = flowType,
    zoneId = zoneId,
    zoneName = zoneName,
    roleId = roleId,
    roleName = roleName,
    roleLevel = roleLevel,
    roleGender = "女",
    rolePower = "0",
    gameBalance = tostring(hasDiamond),
    vipLevel = "0",
    partyName = partyName,
    partyId = guildId,
    partyRoleId = "0",
    partyRoleName = roleName,
    professionId = "0",
    profession = "魔女",
    createTime = roleCreateTime
  })
  LogWarning("quick sdk", "report data " .. jsonStr)
  CS.PixelNeko.P1.PlatformManager.Report(jsonStr)
end

function quick:GetLoginExtInfo()
  return {
    plat = self:GetPlat(),
    channelId = SdkManager.GetChannelID()
  }
end

function quick:ShowPrivacy()
  CS.PixelNeko.P1.PlatformManager.ShowPrivacy()
end

function quick:IsChannelPackage()
  return false
end

function quick:GetChannelID()
  return CS.PixelNeko.P1.PlatformManager.GetChannelID()
end

return quick
