-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/sroleconverskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("OnSconverSkill", tostring(protocol.skillKey))
  if protocol.ifSuccess == 1 then
    if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(7) and protocol.roleid == 5 then
      ((NekoData.DataManager).DM_AllRoles):OnSRoleConverSkill(protocol)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_RoleConverSkill, nil, protocol)
    end
    local Role = require("logic.manager.experimental.types.role")
    local role = (Role.Create)(protocol.roleid)
    if not role:GetIsMaterial() then
      ((DialogManager.CreateSingletonDialog)("soulrefine.soulrefineresultdialog")):OnSRoleConverSkill(tonumber(protocol.skillKey), tonumber(protocol.roleid))
    else
      ;
      ((DialogManager.CreateSingletonDialog)("soulrefine.soulrefineresultskilldialog")):SetData(tonumber(protocol.skillKey))
    end
  else
    do
      LogError("soulRefineFail")
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

