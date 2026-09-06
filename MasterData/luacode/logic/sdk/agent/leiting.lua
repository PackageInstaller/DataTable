local AgentBase = require("logic.sdk.agent.agentbase")
local Leiting = class("LeitingAgent", AgentBase)

function Leiting:Init()
end

function Leiting:OpenLoginDialog()
  DialogManager.CreateSingletonDialog("login.sdklogindialog")
end

function Leiting:Login(type)
  Leiting.super.Login(self, JSON.encode({loginType = type}))
end

function Leiting:Logout(args)
  CS.PixelNeko.P1.PlatformManager.Logout()
  if global_var_thinkingAnalyticsOpen then
    self.Logout_TA()
  end
end

function Leiting:Activate()
  CS.PixelNeko.P1.PlatformManager.Activate()
end

function Leiting:Pay(orderInfo)
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local userId = self._account
  local roleId = tostring(userInfo.userid)
  local roleName = userInfo.username
  local zoneId = tostring(userInfo.zoneid)
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
    userId = userId,
    roleId = roleId,
    roleName = roleName,
    zoneId = zoneId,
    money = money,
    orderId = orderId,
    gameGoodId = gameGoodId,
    goodGearId = goodGearId,
    sdkProductId = sdkProductId,
    productName = productName,
    notifyUri = notifyUri,
    ratio = ratio,
    extInfo = platType
  })
  CS.PixelNeko.Log.LogInfo("SdkManager", "Pay parmeter: " .. jsonStr)
  CS.PixelNeko.P1.PlatformManager.Pay(jsonStr)
end

function Leiting:Report(type, info)
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local roleId = userInfo.userid
  local roleName = userInfo.username
  local roleLevel = userInfo.userlevel
  local zoneId = userInfo.zoneid
  local zoneName = ""
  LogWarning("sdk", "report type " .. type)
  if type == "CreateRole" then
    local jsonStr = JSON.encode({
      roleId = roleId,
      roleName = roleName,
      roleLevel = roleLevel,
      zoneId = zoneId,
      zoneName = zoneName,
      roleCreateTime = os.time()
    })
    CS.PixelNeko.P1.PlatformManager.Invoke("CreateRoleReport", jsonStr)
    LogWarning("sdk", "report data " .. jsonStr)
  elseif type == "Login" then
    local jsonStr = JSON.encode({
      roleId = roleId,
      roleName = roleName,
      roleLevel = roleLevel,
      zoneId = zoneId,
      zoneName = zoneName
    })
    CS.PixelNeko.P1.PlatformManager.Invoke("LoginReport", jsonStr)
  elseif type == "LevelUp" then
    local jsonStr = JSON.encode({
      roleId = roleId,
      roleName = roleName,
      roleLevel = roleLevel,
      zoneId = zoneId,
      zoneName = zoneName
    })
    CS.PixelNeko.P1.PlatformManager.Invoke("LevelUpReport", jsonStr)
  end
  CS.PixelNeko.P1.PlatformManager.Report(JSON.encode({
    key = type,
    value = jsonStr
  }))
end

function Leiting:ShowCustomHelpPage()
  CS.PixelNeko.P1.PlatformManager.Invoke("ShowCustomHelpPage")
end

function Leiting:ShowCustomerService(info)
  CS.PixelNeko.P1.PlatformManager.ShowCustomerService(info or "{}")
end

function Leiting:GetSDKChannel()
  local info = NekoData.BehaviorManager.BM_Login:GetSDKLoginResult()
  return info.channelNo
end

function Leiting:GetDeviceInfo()
  local platform = SdkManager.GetPlatform()
  if platform == "iOS" then
    local info = {
      imei = CS.PixelNeko.P1.PlatformManager.GetData("SdkGetProperties", "imei"),
      mac = CS.PixelNeko.P1.PlatformManager.GetData("getMac", ""),
      oaid = "",
      osVer = CS.PixelNeko.P1.PlatformManager.GetData("SdkGetProperties", "osVer")
    }
    local json_additional = CS.PixelNeko.P1.PlatformManager.GetData("SdkGetDeviceInfo", "0")
    if json_additional and json_additional ~= "" then
      local new_caid = JSON.decode(json_additional).new_caid or ""
      info.oaid = new_caid
    end
    return info
  elseif platform == "Android" then
    local json = CS.PixelNeko.P1.PlatformManager.GetData("GetDeviceInfo", "")
    local json_additional = CS.PixelNeko.P1.PlatformManager.GetData("GetDeviceInfo", "0")
    local info = {}
    info = JSON.decode(json)
    if json_additional and json_additional ~= "" then
      local androidId = JSON.decode(json_additional).androidId or ""
      info.additional = androidId
    end
    return info
  else
    return {}
  end
end

function Leiting:GetMedia()
  local platform = SdkManager.GetPlatform()
  if platform == "iOS" then
    return ""
  elseif platform == "Android" then
    return CS.PixelNeko.P1.PlatformManager.GetData("GetProperty", "media")
  else
    return ""
  end
end

function Leiting:GetLoginExtInfo()
  local info = self:GetDeviceInfo()
  if info.additional then
    info.mac = info.mac .. "#" .. info.additional
  end
  return {
    plat = self:GetPlat(),
    deviceId = info.mac,
    imei = info.imei,
    oaid = info.oaid,
    osver = info.osVer,
    channelId = self:GetSDKChannel(),
    media = self:GetMedia()
  }
end

function Leiting:ShowPrivacy()
  CS.PixelNeko.P1.PlatformManager.ShowPrivacy()
end

function Leiting:IsChannelPackage()
  local channelid = tonumber(SdkManager.GetChannelID())
  return SdkManager.GetPlatform() ~= "iOS" and channelid ~= 110001 and channelid ~= 610001 and channelid ~= 610002
end

function Leiting:GetChannelID()
  if SdkManager.GetPlatform() == "iOS" then
    return "210009"
  end
end

function Leiting.Init_TA(parmeter)
  if CS.PixelNeko.P1.PlatformManager.Init_TA then
    CS.PixelNeko.P1.PlatformManager.Init_TA(parmeter)
  end
end

function Leiting.Login_TA(parmeter)
  if CS.PixelNeko.P1.PlatformManager.Login_TA then
    CS.PixelNeko.P1.PlatformManager.Login_TA(parmeter)
  end
end

function Leiting.Logout_TA()
  if CS.PixelNeko.P1.PlatformManager.Logout_TA then
    CS.PixelNeko.P1.PlatformManager.Logout_TA()
  end
end

function Leiting.UploadEvent_TA(parmeter)
  if CS.PixelNeko.P1.PlatformManager.UploadEvent_TA then
    CS.PixelNeko.P1.PlatformManager.UploadEvent_TA(parmeter)
  end
end

function Leiting.AddUserProperties_TA(parmeter)
  if CS.PixelNeko.P1.PlatformManager.AddUserProperties_TA then
    CS.PixelNeko.P1.PlatformManager.AddUserProperties_TA(parmeter)
  end
end

function Leiting.SetUserPropertiesOnce_TA(parmeter)
  if CS.PixelNeko.P1.PlatformManager.SetUserPropertiesOnce_TA then
    CS.PixelNeko.P1.PlatformManager.SetUserPropertiesOnce_TA(parmeter)
  end
end

function Leiting.TimeEvent_TA(parmeter)
  if CS.PixelNeko.P1.PlatformManager.TimeEvent_TA then
    CS.PixelNeko.P1.PlatformManager.TimeEvent_TA(parmeter)
  end
end

return Leiting
