-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sdk/agent/qianqian.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AgentBase = require("logic.sdk.agent.agentbase")
local Qianqian = class("QianqianAgent", AgentBase)
Qianqian.Init = function(self)
  -- function num : 0_0
end

Qianqian.OpenLoginDialog = function(self)
  -- function num : 0_1 , upvalues : _ENV
  LogWarning("qianqian sdk", "=======OpenLoginDialog")
  ;
  (DialogManager.CreateSingletonDialog)("login.sdklogindialog")
end

Qianqian.Login = function(self, type)
  -- function num : 0_2 , upvalues : _ENV, Qianqian
  LogWarning("qianqian sdk", "=======Login")
  ;
  ((Qianqian.super).Login)(self, (JSON.encode)({loginType = type}))
end

Qianqian.Logout = function(self, args)
  -- function num : 0_3 , upvalues : _ENV
  LogWarning("qianqian sdk", "=======Logout")
  ;
  ((((CS.PixelNeko).P1).PlatformManager).Logout)()
end

Qianqian.Pay = function(self, orderInfo)
  -- function num : 0_4 , upvalues : _ENV
  LogWarning("qianqian sdk", "=======Pay")
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
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
  local jsonStr = (JSON.encode)({orderId = orderId, sdkProductId = sdkProductId, productName = productName, money = money, count = "1", notifyUri = notifyUri, flowType = "sdkpay", roleId = roleId, roleName = roleName, roleLevel = roleLevel, zoneId = zoneId, zoneName = zoneName, vipLevel = "0"})
  ;
  (((CS.PixelNeko).Log).LogInfo)("SdkManager", "Pay parmeter: " .. jsonStr)
  ;
  ((((CS.PixelNeko).P1).PlatformManager).Pay)(jsonStr)
end

Qianqian.Report = function(self, type, info)
  -- function num : 0_5 , upvalues : _ENV
  LogWarning("qianqian sdk", "=======Report type" .. type)
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  local roleId = userInfo.userid
  local roleName = userInfo.username
  local roleLevel = userInfo.userlevel
  local zoneId = userInfo.zoneid
  local zoneName = "大通服"
  local flowType = ""
  if type == "CreateRole" then
    flowType = "createrole"
  else
    if type == "Login" then
      flowType = "enterServer"
    else
      if type == "LevelUp" then
        flowType = "levelup"
      end
    end
  end
  local jsonStr = (JSON.encode)({flowType = flowType, roleId = roleId, roleName = roleName, roleLevel = roleLevel, zoneId = zoneId, zoneName = zoneName, vipLevel = "0", roleCreateTime = (os.time)()})
  LogWarning("qianqian sdk", "report data " .. jsonStr)
  ;
  ((((CS.PixelNeko).P1).PlatformManager).Report)(jsonStr)
end

Qianqian.GetLoginExtInfo = function(self)
  -- function num : 0_6
  return {plat = self:GetPlat()}
end

Qianqian.ShowPrivacy = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).ShowPrivacy)()
end

Qianqian.IsChannelPackage = function(self)
  -- function num : 0_8
  return false
end

Qianqian.GetChannelID = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (SdkManager.GetPlatform)() == "iOS" then
    return "111"
  end
  return "222"
end

Qianqian.ShowCustomerService = function(self, info)
  -- function num : 0_10 , upvalues : _ENV
  ;
  ((((CS.PixelNeko).P1).PlatformManager).ShowCustomerService)(info or "{}")
end

return Qianqian

