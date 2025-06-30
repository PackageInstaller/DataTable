-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/sgamelogin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local DeepLinkTag = {No = 0, Have = 1}
  local tag = DeepLinkTag.No
  if ((NekoData.BehaviorManager).BM_Login):GetGameOpenFromDeepLinkTag() then
    tag = DeepLinkTag.Have
  end
  LogInfoFormat("sgamelogin", "deeplink tag %s", tag)
  local center = (LuaNetManager.CreateProtocol)("protocol.user.center")
  if center then
    center.deepLink = tag
    center:Send()
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

