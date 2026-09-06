local function p1(protocol)
  LogInfo("OnSconverSkill", tostring(protocol.skillKey))
  
  if protocol.ifSuccess == 1 then
    if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(7) and protocol.roleid == 5 then
      NekoData.DataManager.DM_AllRoles:OnSRoleConverSkill(protocol)
      LuaNotificationCenter.PostNotification(Common.n_RoleConverSkill, nil, protocol)
    end
    local Role = require("logic.manager.experimental.types.role")
    local role = Role.Create(protocol.roleid)
    if not role:GetIsMaterial() then
      DialogManager.CreateSingletonDialog("soulrefine.soulrefineresultdialog"):OnSRoleConverSkill(tonumber(protocol.skillKey), tonumber(protocol.roleid))
    else
      DialogManager.CreateSingletonDialog("soulrefine.soulrefineresultskilldialog"):SetData(tonumber(protocol.skillKey))
    end
  else
    LogError("soulRefineFail")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
