local AgentBase = class("AgentBase")

function AgentBase:Init()
  self._account = nil
end

function AgentBase:OpenLoginDialog()
end

function AgentBase:SetSDKAccount(account)
  self._account = account
end

function AgentBase:GetSDKAccount()
  return self._account
end

function AgentBase:Login(args)
  CS.PixelNeko.P1.PlatformManager.Login(args)
end

function AgentBase:Logout(args)
  CS.PixelNeko.P1.PlatformManager.Logout(args)
end

function AgentBase:Quit()
  CS.PixelNeko.P1.PlatformManager.Quit()
end

function AgentBase:Pay(orderInfo)
end

function AgentBase:Report(type, info)
end

function AgentBase:OpenAccountCenter()
  CS.PixelNeko.P1.PlatformManager.AccountCenter()
end

function AgentBase:SwitchAccount()
  CS.PixelNeko.P1.PlatformManager.SwitchAccount()
end

function AgentBase:GetLoginExtInfo()
  return {}
end

function AgentBase:GetPlat()
  local channel = CS.PixelNeko.P1.PlatformManager.GetChannel()
  if channel == "none" then
    return "apps"
  elseif channel == "leit" then
    return "leit"
  elseif channel == "yost" then
    return "yost"
  elseif channel == "qian" then
    return "qian"
  elseif channel == "mqan" then
    return "mqan"
  elseif channel == "quka" then
    return "quka"
  elseif channel == "qukb" then
    return "qukb"
  end
end

function AgentBase:ShowPrivacy()
end

return AgentBase
