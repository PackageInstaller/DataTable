-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sdk/agent/agentbase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AgentBase = class("AgentBase")
AgentBase.Init = function(self)
  -- function num : 0_0
  self._account = nil
end

AgentBase.OpenLoginDialog = function(self)
  -- function num : 0_1
end

AgentBase.SetSDKAccount = function(self, account)
  -- function num : 0_2
  self._account = account
end

AgentBase.GetSDKAccount = function(self)
  -- function num : 0_3
  return self._account
end

AgentBase.Login = function(self, args)
  -- function num : 0_4 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).Login)(args)
end

AgentBase.Logout = function(self, args)
  -- function num : 0_5 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).Logout)(args)
end

AgentBase.Quit = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).Quit)()
end

AgentBase.Pay = function(self, orderInfo)
  -- function num : 0_7
end

AgentBase.Report = function(self, type, info)
  -- function num : 0_8
end

AgentBase.OpenAccountCenter = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).AccountCenter)()
end

AgentBase.SwitchAccount = function(self)
  -- function num : 0_10 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).SwitchAccount)()
end

AgentBase.GetLoginExtInfo = function(self)
  -- function num : 0_11
  return {}
end

AgentBase.GetPlat = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local channel = ((((CS.PixelNeko).P1).PlatformManager).GetChannel)()
  if channel == "none" then
    return "apps"
  else
    if channel == "leit" then
      return "leit"
    else
      if channel == "yost" then
        return "yost"
      else
        if channel == "qian" then
          return "qian"
        else
          if channel == "mqan" then
            return "mqan"
          end
        end
      end
    end
  end
end

AgentBase.ShowPrivacy = function(self)
  -- function num : 0_13
end

return AgentBase

