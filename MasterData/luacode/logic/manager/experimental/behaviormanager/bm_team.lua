local Role = require("logic.manager.experimental.types.role")
local Friend = require("logic.manager.experimental.types.friend")
local BM_Team = class("BM_Team")

function BM_Team:Ctor()
  self._teams = NekoData.Data.teams
  self._towerTeam = NekoData.Data.towerteams
  self._dm = NekoData.DataManager.DM_Team
end

function BM_Team:GetTeamsInfo()
  return self._teams.teamInfo
end

function BM_Team:GetCurrentTeamId()
  return self._teams.curTeamId
end

function BM_Team:GetSupportRole()
  return self._teams.SupportRoleInfo
end

function BM_Team:GetCurrentRoleKeys()
  return self._dm:GetCurrentRoleKeys()
end

function BM_Team:GetTowerCurrentRoleKeys()
  for k, v in pairs(self._towerTeam.teamInfo) do
    if v.id == self._towerTeam.curTeamId then
      return v.roles
    end
  end
  return {}
end

function BM_Team:GetTeamRoles(teamID)
  if (self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.Normal or self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.AutoExplore) and self._teams.teamInfo[teamID] then
    return self._teams.teamInfo[teamID].roles
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.Tower and self._towerTeam.teamInfo[teamID] then
    return self._towerTeam.teamInfo[teamID].roles
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.BOSS and self._teams.bossTeams.teamInfo[teamID] then
    return self._teams.bossTeams.teamInfo[teamID].roles
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.ResourceDefendAndRecover and self._teams.defendRecoverResourceTeams.teamInfo[teamID] then
    return self._teams.defendRecoverResourceTeams.teamInfo[teamID].roles
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.ResourceAssassinAndDamage and self._teams.assassinDamageResourceTeams.teamInfo[teamID] then
    return self._teams.assassinDamageResourceTeams.teamInfo[teamID].roles
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.ResourceMagicAndImpair and self._teams.magicImpairResourceTeams.teamInfo[teamID] then
    return self._teams.magicImpairResourceTeams.teamInfo[teamID].roles
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.UndecidedRoad and self._teams.undecidedRoadTeams.teamInfo[teamID] then
    return self._teams.undecidedRoadTeams.teamInfo[teamID].roles
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.Spring and self._teams.springTeams.teamInfo[teamID] then
    return self._teams.springTeams.teamInfo[teamID].roles
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.SRChallenge and self._teams.srChallengeTeams.teamInfo[teamID] then
    return self._teams.srChallengeTeams.teamInfo[teamID].roles
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.SeasonPVP and self._teams.SeasonPVPTeams.teamInfo[teamID] then
    return self._teams.SeasonPVPTeams.teamInfo[teamID].roles
  end
  return {}
end

function BM_Team:GetTowerCurrentTeamId()
  return self._towerTeam.curTeamId
end

function BM_Team:GetTowerTeamsInfo()
  return self._towerTeam.teamInfo
end

function BM_Team:GetRandomRoleKeyInCurrentTeam()
  local teamID = self:GetCurrentTeamId()
  if teamID == nil then
    return -1
  end
  local team = self._teams.teamInfo[teamID]
  if not team then
    return -1
  end
  local roleList = {}
  for k, v in pairs(team.roles) do
    if 0 < v then
      table.insert(roleList, v)
    end
  end
  local roleCount = #roleList
  local randomIndex = math.random(roleCount)
  return roleList[randomIndex]
end

function BM_Team:GetRandomRoleKeyInTeam(teamID)
  if teamID == nil then
    return -1
  end
  local team = self._teams.teamInfo[teamID]
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.Tower then
    team = self._towerTeam.teamInfo[teamID]
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.BOSS then
    team = self._teams.bossTeams.teamInfo[teamID]
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.ResourceDefendAndRecover then
    team = self._teams.defendRecoverResourceTeams.teamInfo[teamID]
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.ResourceAssassinAndDamage then
    team = self._teams.assassinDamageResourceTeams.teamInfo[teamID]
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.ResourceMagicAndImpair then
    team = self._teams.magicImpairResourceTeams.teamInfo[teamID]
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.UndecidedRoad then
    team = self._teams.undecidedRoadTeams.teamInfo[teamID]
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.Spring then
    team = self._teams.springTeams.teamInfo[teamID]
  end
  if self._dm:GetTeamType(teamID) == self._dm.TeamTypeEnum.SRChallenge then
    team = self._teams.srChallengeTeams.teamInfo[teamID]
  end
  if not team then
    return -1
  end
  local roleList = {}
  for k, v in pairs(team.roles) do
    if 0 < v then
      table.insert(roleList, v)
    end
  end
  local roleCount = #roleList
  local randomIndex = math.random(roleCount)
  return roleList[randomIndex]
end

function BM_Team:GetTeamFilterCondition()
  return self._teams.filterCondition
end

function BM_Team:SaveTeamFilterCondition(filterCond)
  self._teams.filterCondition = filterCond
end

function BM_Team:SaveChooseSupportRole(userId)
  self._dm:ClearSupportRole()
  local supportRoleList = NekoData.BehaviorManager.BM_Friends:GetSupportRoleList()
  if supportRoleList then
    local data = supportRoleList.rolesFromFriends[userId]
    if data then
      self._teams.SupportRoleInfo.role = Role.Create(data.id)
      self._teams.SupportRoleInfo.role:SetLevel(data.lv)
      self._teams.SupportRoleInfo.role:SetBreakLv(data.breakLv)
      self._teams.SupportRoleInfo.role:SetSupportSkill(data.contractSkill[1])
      self._teams.SupportRoleInfo.role:SetFashionId(data.skin)
      self._teams.SupportRoleInfo.user = NekoData.BehaviorManager.BM_Friends:GetFriend(userId)
    else
      for k, v in pairs(supportRoleList.rolesFromStrangers) do
        if userId == v.userInfo.baseUserData.userId then
          self._teams.SupportRoleInfo.role = Role.Create(v.roleInfo.id)
          self._teams.SupportRoleInfo.role:SetLevel(v.roleInfo.lv)
          self._teams.SupportRoleInfo.role:SetBreakLv(v.roleInfo.breakLv)
          self._teams.SupportRoleInfo.role:SetSupportSkill(v.roleInfo.contractSkill[1])
          self._teams.SupportRoleInfo.role:SetFashionId(v.roleInfo.skin)
          self._teams.SupportRoleInfo.user = Friend.Create()
          self._teams.SupportRoleInfo.user:SetDataFromProtol(v.userInfo)
          break
        end
      end
    end
  end
end

function BM_Team:GetBossCurrentTeamId()
  return self._teams.bossTeams.curTeamId
end

function BM_Team:GetBossTeamsInfo()
  return self._teams.bossTeams.teamInfo
end

function BM_Team:GetAutoExploreTeamsInfo()
  return self._teams.teamInfo[5001]
end

function BM_Team:GetDefendRecoverCurrentTeamId()
  return self._teams.defendRecoverResourceTeams.curTeamId
end

function BM_Team:GetDefendRecoverTeamsInfo()
  return self._teams.defendRecoverResourceTeams.teamInfo
end

function BM_Team:GetAssassinDamageCurrentTeamId()
  return self._teams.assassinDamageResourceTeams.curTeamId
end

function BM_Team:GetAssassinDamageTeamsInfo()
  return self._teams.assassinDamageResourceTeams.teamInfo
end

function BM_Team:GetMagicImpairCurrentTeamId()
  return self._teams.magicImpairResourceTeams.curTeamId
end

function BM_Team:GetMagicImpairTeamsInfo()
  return self._teams.magicImpairResourceTeams.teamInfo
end

function BM_Team:GetUndecidedRoadTeamId()
  return self._teams.undecidedRoadTeams.curTeamId
end

function BM_Team:GetUndecidedRoadTeamsInfo()
  return self._teams.undecidedRoadTeams.teamInfo
end

function BM_Team:GetSpringFestivalTeamId()
  return self._teams.springTeams.curTeamId
end

function BM_Team:GetSpringFestivalTeamsInfo()
  return self._teams.springTeams.teamInfo
end

function BM_Team:GetSRChallengeTeamId()
  return self._teams.srChallengeTeams.curTeamId
end

function BM_Team:GetSRChallengeTeamInfo()
  return self._teams.srChallengeTeams.teamInfo
end

function BM_Team:GetBossCurrentRoleKeys()
  local num = 0
  for k, v in pairs(self._teams.bossTeams.teamInfo) do
    num = num + 1
    if v.id == self._teams.bossTeams.curTeamId then
      return v.roles
    end
  end
  LogErrorFormat("BM_Team", "bossTeams curTeamId %s teamInfo data num %s", self._teams.bossTeams.curTeamId, num)
  return {}
end

function BM_Team:SaveTeamEditCopyInfo(copyType, id, additionalData)
  if copyType == "Resource" and not id then
    self._teams.editCopyInfo = nil
  else
    self._teams.editCopyInfo = self._teams.editCopyInfo or {}
    self._teams.editCopyInfo.copyInfo = copyType
    self._teams.editCopyInfo.id = id
    self._teams.editCopyInfo.additionalData = additionalData
  end
end

function BM_Team:GetTeamEditCopyInfo()
  return self._teams.editCopyInfo
end

function BM_Team:SetSeasonPvpTeam(teamid, roles)
  local info = {}
  info.id = teamid
  info.name = ""
  info.skill = 1
  info.power = 0
  info.roles = {}
  for k, v in pairs(roles) do
    info.roles[k] = v
  end
  self._teams.SeasonPVPTeams.teamInfo[teamid] = info
  self._teams.SeasonPVPTeams.curTeamId = teamid
end

return BM_Team
