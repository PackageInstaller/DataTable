-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/41.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local curTeamId = ((NekoData.BehaviorManager).BM_Team):GetCurrentTeamId()
  if curTeamId then
    local teamsInfo = ((NekoData.BehaviorManager).BM_Team):GetTeamsInfo()
    if teamsInfo and teamsInfo[curTeamId] then
      local currentRoleList = (teamsInfo[curTeamId]).roles
      if currentRoleList[1] then
        local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(currentRoleList[1])
        if role then
          local weapon = role:GetWeapon()
          return not weapon or weapon ~= 0
        end
      end
    end
  end
  do return false end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return func

