-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sdk/agent/leiting.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AgentBase = require("logic.sdk.agent.agentbase")
local Leiting = class("LeitingAgent", AgentBase)
Leiting.Init = function(self)
  -- function num : 0_0
end

Leiting.OpenLoginDialog = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("login.sdklogindialog")
end

Leiting.Login = function(self, type)
  -- function num : 0_2 , upvalues : Leiting, _ENV
  ((Leiting.super).Login)(self, (JSON.encode)({loginType = type}))
end

Leiting.Logout = function(self, args)
  -- function num : 0_3 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).Logout)()
  if global_var_thinkingAnalyticsOpen then
    (self.Logout_TA)()
  end
end

Leiting.Activate = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).Activate)()
end

Leiting.Pay = function(self, orderInfo)
  -- function num : 0_5 , upvalues : _ENV
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
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
  local jsonStr = (JSON.encode)({userId = userId, roleId = roleId, roleName = roleName, zoneId = zoneId, money = money, orderId = orderId, gameGoodId = gameGoodId, goodGearId = goodGearId, sdkProductId = sdkProductId, productName = productName, notifyUri = notifyUri, ratio = ratio, extInfo = platType})
  ;
  (((CS.PixelNeko).Log).LogInfo)("SdkManager", "Pay parmeter: " .. jsonStr)
  ;
  ((((CS.PixelNeko).P1).PlatformManager).Pay)(jsonStr)
end

Leiting.Report = function(self, type, info)
  -- function num : 0_6 , upvalues : _ENV
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  local roleId = userInfo.userid
  local roleName = userInfo.username
  local roleLevel = userInfo.userlevel
  local zoneId = userInfo.zoneid
  local zoneName = ""
  LogWarning("sdk", "report type " .. type)
  if type == "CreateRole" then
    local jsonStr = (JSON.encode)({roleId = roleId, roleName = roleName, roleLevel = roleLevel, zoneId = zoneId, zoneName = zoneName, roleCreateTime = (os.time)()})
    ;
    ((((CS.PixelNeko).P1).PlatformManager).Invoke)("CreateRoleReport", jsonStr)
    LogWarning("sdk", "report data " .. jsonStr)
  else
    do
      if type == "Login" then
        local jsonStr = (JSON.encode)({roleId = roleId, roleName = roleName, roleLevel = roleLevel, zoneId = zoneId, zoneName = zoneName})
        ;
        ((((CS.PixelNeko).P1).PlatformManager).Invoke)("LoginReport", jsonStr)
      else
        do
          do
            if type == "LevelUp" then
              local jsonStr = (JSON.encode)({roleId = roleId, roleName = roleName, roleLevel = roleLevel, zoneId = zoneId, zoneName = zoneName})
              ;
              ((((CS.PixelNeko).P1).PlatformManager).Invoke)("LevelUpReport", jsonStr)
            end
            ;
            ((((CS.PixelNeko).P1).PlatformManager).Report)((JSON.encode)({key = type, value = jsonStr}))
          end
        end
      end
    end
  end
end

Leiting.ShowCustomHelpPage = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).Invoke)("ShowCustomHelpPage")
end

Leiting.ShowCustomerService = function(self, info)
  -- function num : 0_8 , upvalues : _ENV
  ;
  ((((CS.PixelNeko).P1).PlatformManager).ShowCustomerService)(info or "{}")
end

Leiting.GetSDKChannel = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local info = ((NekoData.BehaviorManager).BM_Login):GetSDKLoginResult()
  return info.channelNo
end

Leiting.GetDeviceInfo = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local platform = (SdkManager.GetPlatform)()
  if platform == "iOS" then
    local info = {imei = ((((CS.PixelNeko).P1).PlatformManager).GetData)("SdkGetProperties", "imei"), mac = ((((CS.PixelNeko).P1).PlatformManager).GetData)("getMac", ""), oaid = "", osVer = ((((CS.PixelNeko).P1).PlatformManager).GetData)("SdkGetProperties", "osVer")}
    local json_additional = ((((CS.PixelNeko).P1).PlatformManager).GetData)("SdkGetDeviceInfo", "0")
    do
      do
        if not ((JSON.decode)(json_additional)).new_caid then
          local new_caid = not json_additional or json_additional == "" or ""
        end
        info.oaid = new_caid
        do return info end
        if platform == "Android" then
          local json = ((((CS.PixelNeko).P1).PlatformManager).GetData)("GetDeviceInfo", "")
          local json_additional = ((((CS.PixelNeko).P1).PlatformManager).GetData)("GetDeviceInfo", "0")
          local info = {}
          info = (JSON.decode)(json)
          do
            do
              if not ((JSON.decode)(json_additional)).androidId then
                local androidId = not json_additional or json_additional == "" or ""
              end
              info.additional = androidId
              do return info end
              do return {} end
            end
          end
        end
      end
    end
  end
end

Leiting.GetMedia = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local platform = (SdkManager.GetPlatform)()
  if platform == "iOS" then
    return ""
  else
    if platform == "Android" then
      return ((((CS.PixelNeko).P1).PlatformManager).GetData)("GetProperty", "media")
    else
      return ""
    end
  end
end

Leiting.GetLoginExtInfo = function(self)
  -- function num : 0_12
  local info = self:GetDeviceInfo()
  if info.additional then
    info.mac = info.mac .. "#" .. info.additional
  end
  return {plat = self:GetPlat(), deviceId = info.mac, imei = info.imei, oaid = info.oaid, osver = info.osVer, channelId = self:GetSDKChannel(), media = self:GetMedia()}
end

Leiting.ShowPrivacy = function(self)
  -- function num : 0_13 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).ShowPrivacy)()
end

Leiting.IsChannelPackage = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local channelid = tonumber((SdkManager.GetChannelID)())
  do return (SdkManager.GetPlatform)() ~= "iOS" and channelid ~= 110001 and channelid ~= 610001 and channelid ~= 610002 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Leiting.GetChannelID = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if (SdkManager.GetPlatform)() == "iOS" then
    return "210009"
  end
end

Leiting.Init_TA = function(parmeter)
  -- function num : 0_16 , upvalues : _ENV
  if (((CS.PixelNeko).P1).PlatformManager).Init_TA then
    ((((CS.PixelNeko).P1).PlatformManager).Init_TA)(parmeter)
  end
end

Leiting.Login_TA = function(parmeter)
  -- function num : 0_17 , upvalues : _ENV
  if (((CS.PixelNeko).P1).PlatformManager).Login_TA then
    ((((CS.PixelNeko).P1).PlatformManager).Login_TA)(parmeter)
  end
end

Leiting.Logout_TA = function()
  -- function num : 0_18 , upvalues : _ENV
  if (((CS.PixelNeko).P1).PlatformManager).Logout_TA then
    ((((CS.PixelNeko).P1).PlatformManager).Logout_TA)()
  end
end

Leiting.UploadEvent_TA = function(parmeter)
  -- function num : 0_19 , upvalues : _ENV
  if (((CS.PixelNeko).P1).PlatformManager).UploadEvent_TA then
    ((((CS.PixelNeko).P1).PlatformManager).UploadEvent_TA)(parmeter)
  end
end

Leiting.AddUserProperties_TA = function(parmeter)
  -- function num : 0_20 , upvalues : _ENV
  if (((CS.PixelNeko).P1).PlatformManager).AddUserProperties_TA then
    ((((CS.PixelNeko).P1).PlatformManager).AddUserProperties_TA)(parmeter)
  end
end

Leiting.SetUserPropertiesOnce_TA = function(parmeter)
  -- function num : 0_21 , upvalues : _ENV
  if (((CS.PixelNeko).P1).PlatformManager).SetUserPropertiesOnce_TA then
    ((((CS.PixelNeko).P1).PlatformManager).SetUserPropertiesOnce_TA)(parmeter)
  end
end

Leiting.TimeEvent_TA = function(parmeter)
  -- function num : 0_22 , upvalues : _ENV
  if (((CS.PixelNeko).P1).PlatformManager).TimeEvent_TA then
    ((((CS.PixelNeko).P1).PlatformManager).TimeEvent_TA)(parmeter)
  end
end

return Leiting

