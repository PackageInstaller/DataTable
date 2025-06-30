-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_team.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local Friend = require("logic.manager.experimental.types.friend")
local BM_Team = class("BM_Team")
BM_Team.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._teams = (NekoData.Data).teams
  self._towerTeam = (NekoData.Data).towerteams
  self._dm = (NekoData.DataManager).DM_Team
end

BM_Team.GetTeamsInfo = function(self)
  -- function num : 0_1
  return (self._teams).teamInfo
end

BM_Team.GetCurrentTeamId = function(self)
  -- function num : 0_2
  return (self._teams).curTeamId
end

BM_Team.GetSupportRole = function(self)
  -- function num : 0_3
  return (self._teams).SupportRoleInfo
end

BM_Team.GetCurrentRoleKeys = function(self)
  -- function num : 0_4
  return (self._dm):GetCurrentRoleKeys()
end

BM_Team.GetTowerCurrentRoleKeys = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in pairs((self._towerTeam).teamInfo) do
    if v.id == (self._towerTeam).curTeamId then
      return v.roles
    end
  end
  return {}
end

BM_Team.GetTeamRoles = function(self, teamID)
  -- function num : 0_6
  if ((self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).Normal or (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).OffLinePVP or (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).AutoExplore) and ((self._teams).teamInfo)[teamID] then
    return (((self._teams).teamInfo)[teamID]).roles
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).Tower and ((self._towerTeam).teamInfo)[teamID] then
    return (((self._towerTeam).teamInfo)[teamID]).roles
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).BOSS and (((self._teams).bossTeams).teamInfo)[teamID] then
    return ((((self._teams).bossTeams).teamInfo)[teamID]).roles
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).ResourceDefendAndRecover and (((self._teams).defendRecoverResourceTeams).teamInfo)[teamID] then
    return ((((self._teams).defendRecoverResourceTeams).teamInfo)[teamID]).roles
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).ResourceAssassinAndDamage and (((self._teams).assassinDamageResourceTeams).teamInfo)[teamID] then
    return ((((self._teams).assassinDamageResourceTeams).teamInfo)[teamID]).roles
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).ResourceMagicAndImpair and (((self._teams).magicImpairResourceTeams).teamInfo)[teamID] then
    return ((((self._teams).magicImpairResourceTeams).teamInfo)[teamID]).roles
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).UndecidedRoad and (((self._teams).undecidedRoadTeams).teamInfo)[teamID] then
    return ((((self._teams).undecidedRoadTeams).teamInfo)[teamID]).roles
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).Spring and (((self._teams).springTeams).teamInfo)[teamID] then
    return ((((self._teams).springTeams).teamInfo)[teamID]).roles
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).SRChallenge and (((self._teams).srChallengeTeams).teamInfo)[teamID] then
    return ((((self._teams).srChallengeTeams).teamInfo)[teamID]).roles
  end
  return {}
end

BM_Team.GetTowerCurrentTeamId = function(self)
  -- function num : 0_7
  return (self._towerTeam).curTeamId
end

BM_Team.GetTowerTeamsInfo = function(self)
  -- function num : 0_8
  return (self._towerTeam).teamInfo
end

BM_Team.GetRandomRoleKeyInCurrentTeam = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local teamID = self:GetCurrentTeamId()
  if teamID == nil then
    return -1
  end
  local team = ((self._teams).teamInfo)[teamID]
  if not team then
    return -1
  end
  local roleList = {}
  for k,v in pairs(team.roles) do
    if v > 0 then
      (table.insert)(roleList, v)
    end
  end
  local roleCount = #roleList
  local randomIndex = (math.random)(roleCount)
  return roleList[randomIndex]
end

BM_Team.GetRandomRoleKeyInTeam = function(self, teamID)
  -- function num : 0_10 , upvalues : _ENV
  if teamID == nil then
    return -1
  end
  local team = ((self._teams).teamInfo)[teamID]
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).Tower then
    team = ((self._towerTeam).teamInfo)[teamID]
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).BOSS then
    team = (((self._teams).bossTeams).teamInfo)[teamID]
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).ResourceDefendAndRecover then
    team = (((self._teams).defendRecoverResourceTeams).teamInfo)[teamID]
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).ResourceAssassinAndDamage then
    team = (((self._teams).assassinDamageResourceTeams).teamInfo)[teamID]
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).ResourceMagicAndImpair then
    team = (((self._teams).magicImpairResourceTeams).teamInfo)[teamID]
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).UndecidedRoad then
    team = (((self._teams).undecidedRoadTeams).teamInfo)[teamID]
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).Spring then
    team = (((self._teams).springTeams).teamInfo)[teamID]
  end
  if (self._dm):GetTeamType(teamID) == ((self._dm).TeamTypeEnum).SRChallenge then
    team = (((self._teams).srChallengeTeams).teamInfo)[teamID]
  end
  if not team then
    return -1
  end
  local roleList = {}
  for k,v in pairs(team.roles) do
    if v > 0 then
      (table.insert)(roleList, v)
    end
  end
  local roleCount = #roleList
  local randomIndex = (math.random)(roleCount)
  return roleList[randomIndex]
end

BM_Team.GetTeamFilterCondition = function(self)
  -- function num : 0_11
  return (self._teams).filterCondition
end

BM_Team.SaveTeamFilterCondition = function(self, filterCond)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._teams).filterCondition = filterCond
end

BM_Team.SaveChooseSupportRole = function(self, userId)
  -- function num : 0_13 , upvalues : _ENV, Role, Friend
  (self._dm):ClearSupportRole()
  local supportRoleList = ((NekoData.BehaviorManager).BM_Friends):GetSupportRoleList()
  if supportRoleList then
    local data = (supportRoleList.rolesFromFriends)[userId]
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

    if data then
      ((self._teams).SupportRoleInfo).role = (Role.Create)(data.id)
      ;
      (((self._teams).SupportRoleInfo).role):SetLevel(data.lv)
      ;
      (((self._teams).SupportRoleInfo).role):SetBreakLv(data.breakLv)
      ;
      (((self._teams).SupportRoleInfo).role):SetSupportSkill((data.contractSkill)[1])
      ;
      (((self._teams).SupportRoleInfo).role):SetFashionId(data.skin)
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self._teams).SupportRoleInfo).user = ((NekoData.BehaviorManager).BM_Friends):GetFriend(userId)
    else
      for k,v in pairs(supportRoleList.rolesFromStrangers) do
        -- DECOMPILER ERROR at PC70: Confused about usage of register: R9 in 'UnsetPending'

        if userId == ((v.userInfo).baseUserData).userId then
          ((self._teams).SupportRoleInfo).role = (Role.Create)((v.roleInfo).id)
          ;
          (((self._teams).SupportRoleInfo).role):SetLevel((v.roleInfo).lv)
          ;
          (((self._teams).SupportRoleInfo).role):SetBreakLv((v.roleInfo).breakLv)
          ;
          (((self._teams).SupportRoleInfo).role):SetSupportSkill(((v.roleInfo).contractSkill)[1])
          ;
          (((self._teams).SupportRoleInfo).role):SetFashionId((v.roleInfo).skin)
          -- DECOMPILER ERROR at PC104: Confused about usage of register: R9 in 'UnsetPending'

          ;
          ((self._teams).SupportRoleInfo).user = (Friend.Create)()
          ;
          (((self._teams).SupportRoleInfo).user):SetDataFromProtol(v.userInfo)
          break
        end
      end
    end
  end
end

BM_Team.GetBossCurrentTeamId = function(self)
  -- function num : 0_14
  return ((self._teams).bossTeams).curTeamId
end

BM_Team.GetBossTeamsInfo = function(self)
  -- function num : 0_15
  return ((self._teams).bossTeams).teamInfo
end

BM_Team.GetAutoExploreTeamsInfo = function(self)
  -- function num : 0_16
  return ((self._teams).teamInfo)[5001]
end

BM_Team.GetDefendRecoverCurrentTeamId = function(self)
  -- function num : 0_17
  return ((self._teams).defendRecoverResourceTeams).curTeamId
end

BM_Team.GetDefendRecoverTeamsInfo = function(self)
  -- function num : 0_18
  return ((self._teams).defendRecoverResourceTeams).teamInfo
end

BM_Team.GetAssassinDamageCurrentTeamId = function(self)
  -- function num : 0_19
  return ((self._teams).assassinDamageResourceTeams).curTeamId
end

BM_Team.GetAssassinDamageTeamsInfo = function(self)
  -- function num : 0_20
  return ((self._teams).assassinDamageResourceTeams).teamInfo
end

BM_Team.GetMagicImpairCurrentTeamId = function(self)
  -- function num : 0_21
  return ((self._teams).magicImpairResourceTeams).curTeamId
end

BM_Team.GetMagicImpairTeamsInfo = function(self)
  -- function num : 0_22
  return ((self._teams).magicImpairResourceTeams).teamInfo
end

BM_Team.GetUndecidedRoadTeamId = function(self)
  -- function num : 0_23
  return ((self._teams).undecidedRoadTeams).curTeamId
end

BM_Team.GetUndecidedRoadTeamsInfo = function(self)
  -- function num : 0_24
  return ((self._teams).undecidedRoadTeams).teamInfo
end

BM_Team.GetSpringFestivalTeamId = function(self)
  -- function num : 0_25
  return ((self._teams).springTeams).curTeamId
end

BM_Team.GetSpringFestivalTeamsInfo = function(self)
  -- function num : 0_26
  return ((self._teams).springTeams).teamInfo
end

BM_Team.GetSRChallengeTeamId = function(self)
  -- function num : 0_27
  return ((self._teams).srChallengeTeams).curTeamId
end

BM_Team.GetSRChallengeTeamInfo = function(self)
  -- function num : 0_28
  return ((self._teams).srChallengeTeams).teamInfo
end

BM_Team.GetBossCurrentRoleKeys = function(self)
  -- function num : 0_29 , upvalues : _ENV
  local num = 0
  for k,v in pairs(((self._teams).bossTeams).teamInfo) do
    num = num + 1
    if v.id == ((self._teams).bossTeams).curTeamId then
      return v.roles
    end
  end
  LogErrorFormat("BM_Team", "bossTeams curTeamId %s teamInfo data num %s", ((self._teams).bossTeams).curTeamId, num)
  return {}
end

BM_Team.SaveTeamEditCopyInfo = function(self, copyType, id, additionalData)
  -- function num : 0_30
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  if copyType == "Resource" and not id then
    (self._teams).editCopyInfo = nil
  else
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

    if not (self._teams).editCopyInfo then
      (self._teams).editCopyInfo = {}
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self._teams).editCopyInfo).copyInfo = copyType
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self._teams).editCopyInfo).id = id
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self._teams).editCopyInfo).additionalData = additionalData
    end
  end
end

BM_Team.GetTeamEditCopyInfo = function(self)
  -- function num : 0_31
  return (self._teams).editCopyInfo
end

return BM_Team

