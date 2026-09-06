local Role = require("logic.manager.experimental.types.role")
local Friend = require("logic.manager.experimental.types.friend")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local DM_Team = class("DM_Team")
DM_Team.TeamTypeEnum = {
  Normal = 1,
  Tower = 2,
  BrokenMirror = 3,
  SeasonPVP = 4,
  BOSS = 5,
  AutoExplore = 6,
  ResourceDefendAndRecover = 7,
  ResourceAssassinAndDamage = 8,
  ResourceMagicAndImpair = 9,
  UndecidedRoad = 10,
  Spring = 11,
  SRChallenge = 12
}

function DM_Team:GetTeamType(lineUpId)
  if 0 < lineUpId and lineUpId < 1000 then
    return self.TeamTypeEnum.Normal
  end
  if 1000 < lineUpId and lineUpId < 2000 then
    return self.TeamTypeEnum.Tower
  end
  if lineUpId == 2000 then
    return self.TeamTypeEnum.BrokenMirror
  end
  if lineUpId == 3000 or lineUpId == 3100 then
    return self.TeamTypeEnum.SeasonPVP
  end
  if 4000 < lineUpId and lineUpId < 5000 then
    return self.TeamTypeEnum.BOSS
  end
  if lineUpId == 5001 then
    return self.TeamTypeEnum.AutoExplore
  end
  if lineUpId == 6001 or lineUpId == 6002 then
    return self.TeamTypeEnum.ResourceDefendAndRecover
  end
  if lineUpId == 6003 or lineUpId == 6004 then
    return self.TeamTypeEnum.ResourceAssassinAndDamage
  end
  if lineUpId == 6005 or lineUpId == 6006 then
    return self.TeamTypeEnum.ResourceMagicAndImpair
  end
  if lineUpId == 7000 or lineUpId == 7001 then
    return self.TeamTypeEnum.UndecidedRoad
  end
  if 8000 <= lineUpId and lineUpId <= 8003 then
    return self.TeamTypeEnum.Spring
  end
  if 9000 <= lineUpId and lineUpId <= 9001 then
    return self.TeamTypeEnum.SRChallenge
  end
end

function DM_Team:Ctor()
  self._teams = NekoData.Data.teams
  self._teams.teamInfo = {}
  self._teams.curTeamId = nil
  self._teams.SupportRoleInfo = {}
  self._teams.filterCondition = nil
  self._teams.bossTeams = {
    teamInfo = {},
    curTeamId = nil
  }
  self._teams.defendRecoverResourceTeams = {
    teamInfo = {},
    curTeamId = nil
  }
  self._teams.assassinDamageResourceTeams = {
    teamInfo = {},
    curTeamId = nil
  }
  self._teams.magicImpairResourceTeams = {
    teamInfo = {},
    curTeamId = nil
  }
  self._teams.undecidedRoadTeams = {
    teamInfo = {},
    curTeamId = nil
  }
  self._teams.springTeams = {
    teamInfo = {},
    curTeamId = nil
  }
  self._teams.srChallengeTeams = {
    teamInfo = {},
    curTeamId = nil
  }
  self._teams.SeasonPVPTeams = {
    teamInfo = {},
    curTeamId = nil
  }
  self._towerTeam = NekoData.Data.towerteams
  self._towerTeam.teamInfo = {}
  self._towerTeam.curTeamId = nil
end

function DM_Team:Clear()
  self._teams.teamInfo = {}
  self._teams.curTeamId = nil
  for k, v in pairs(self._teams.SupportRoleInfo) do
    self._teams.SupportRoleInfo[k] = nil
  end
  self._towerTeam.teamInfo = {}
  self._towerTeam.curTeamId = nil
  self._teams.bossTeams.teamInfo = {}
  self._teams.bossTeams.curTeamId = nil
  self._teams.defendRecoverResourceTeams.teamInfo = {}
  self._teams.defendRecoverResourceTeams.curTeamId = nil
  self._teams.assassinDamageResourceTeams.teamInfo = {}
  self._teams.assassinDamageResourceTeams.curTeamId = nil
  self._teams.magicImpairResourceTeams.teamInfo = {}
  self._teams.magicImpairResourceTeams.curTeamId = nil
  self._teams.undecidedRoadTeams.teamInfo = {}
  self._teams.undecidedRoadTeams.curTeamId = nil
  self._teams.springTeams.teamInfo = {}
  self._teams.springTeams.curTeamId = nil
  self._teams.srChallengeTeams.teamInfo = {}
  self._teams.srChallengeTeams.curTeamId = nil
  self._teams.SeasonPVPTeams.teamInfo = {}
  self._teams.SeasonPVPTeams.curTeamId = nil
  if self._teams.filterCondition then
    for k, _ in pairs(self._teams.filterCondition) do
      self._teams.filterCondition[k] = nil
    end
    self._teams.filterCondition = nil
  end
  self._teams.editCopyInfo = {}
end

function DM_Team:OnSLineInfo(protocol)
  self._teams.teamInfo = {}
  for index, team in ipairs(protocol.lineupList) do
    local info = {}
    info.id = team.id
    info.name = team.name
    info.skill = team.skill
    info.power = team.power or 0
    info.roles = {}
    for k, v in pairs(team.roles) do
      info.roles[k] = v
    end
    local lineUpId = team.id
    if self:GetTeamType(lineUpId) == self.TeamTypeEnum.Normal or self:GetTeamType(lineUpId) == self.TeamTypeEnum.AutoExplore then
      self._teams.teamInfo[team.id] = info
    end
    if self:GetTeamType(lineUpId) == self.TeamTypeEnum.Tower then
      self._towerTeam.teamInfo[team.id] = info
    end
    if self:GetTeamType(lineUpId) == self.TeamTypeEnum.BOSS then
      self._teams.bossTeams.teamInfo[team.id] = info
    end
    if self:GetTeamType(lineUpId) == self.TeamTypeEnum.ResourceDefendAndRecover then
      self._teams.defendRecoverResourceTeams.teamInfo[team.id] = info
    end
    if self:GetTeamType(lineUpId) == self.TeamTypeEnum.ResourceAssassinAndDamage then
      self._teams.assassinDamageResourceTeams.teamInfo[team.id] = info
    end
    if self:GetTeamType(lineUpId) == self.TeamTypeEnum.ResourceMagicAndImpair then
      self._teams.magicImpairResourceTeams.teamInfo[team.id] = info
    end
    if self:GetTeamType(lineUpId) == self.TeamTypeEnum.UndecidedRoad then
      self._teams.undecidedRoadTeams.teamInfo[team.id] = info
    end
    if self:GetTeamType(lineUpId) == self.TeamTypeEnum.Spring then
      self._teams.springTeams.teamInfo[team.id] = info
    end
    if self:GetTeamType(lineUpId) == self.TeamTypeEnum.SRChallenge then
      self._teams.srChallengeTeams.teamInfo[team.id] = info
    end
  end
  self._teams.curTeamId = protocol.commonLinupId
  self._towerTeam.curTeamId = protocol.towerLineupId
  self._teams.bossTeams.curTeamId = protocol.bossRushLineupId
  self._teams.defendRecoverResourceTeams.curTeamId = protocol.guardRestoreLineupId
  self._teams.assassinDamageResourceTeams.curTeamId = protocol.damageStabLineupId
  self._teams.magicImpairResourceTeams.curTeamId = protocol.magicImpairLineupId
  self._teams.undecidedRoadTeams.curTeamId = protocol.undecidedRoadLineupId
  self._teams.springTeams.curTeamId = protocol.springFestivalLineupId
  self._teams.srChallengeTeams.curTeamId = protocol.srChallengeLineupId
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.curTeamId %s", self._teams.curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _towerTeam.curTeamId %s", self._towerTeam.curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.bossTeam.curTeamId %s", self._teams.bossTeams.curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.defendRecoverResourceTeams.curTeamId %s", self._teams.defendRecoverResourceTeams.curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.assassinDamageResourceTeams.curTeamId %s", self._teams.assassinDamageResourceTeams.curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.magicImpairResourceTeams.curTeamId %s", self._teams.magicImpairResourceTeams.curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.undecidedRoadTeams.curTeamId %s", self._teams.magicImpairResourceTeams.curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.springTeams.curTeamId %s", self._teams.springTeams.curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.srChallengeTeams.curTeamId %s", self._teams.srChallengeTeams.curTeamId)
  if protocol.supportRole and protocol.supportRole.role and protocol.supportRole.role.id ~= 0 and protocol.supportRole.user then
    self._teams.SupportRoleInfo.role = Role.Create(protocol.supportRole.role.id, protocol.supportRole.role)
    self._teams.SupportRoleInfo.user = Friend.Create()
    self._teams.SupportRoleInfo.user:SetDataFromProtol(protocol.supportRole.user)
  end
end

function DM_Team:OnSChangeRoles(protocol)
  local lineUpId = protocol.lineupId
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.Normal or self:GetTeamType(lineUpId) == self.TeamTypeEnum.AutoExplore then
    self._teams.teamInfo[lineUpId].power = protocol.power
    for k, v in pairs(protocol.roles) do
      self._teams.teamInfo[lineUpId].roles[k] = v
    end
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.Tower then
    self._towerTeam.teamInfo[lineUpId].power = protocol.power
    for k, v in pairs(protocol.roles) do
      self._towerTeam.teamInfo[lineUpId].roles[k] = v
    end
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.BOSS then
    self._teams.bossTeams.teamInfo[lineUpId].power = protocol.power
    for k, v in pairs(protocol.roles) do
      self._teams.bossTeams.teamInfo[lineUpId].roles[k] = v
    end
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.ResourceDefendAndRecover then
    self._teams.defendRecoverResourceTeams.teamInfo[lineUpId].power = protocol.power
    for k, v in pairs(protocol.roles) do
      self._teams.defendRecoverResourceTeams.teamInfo[lineUpId].roles[k] = v
    end
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.ResourceAssassinAndDamage then
    self._teams.assassinDamageResourceTeams.teamInfo[lineUpId].power = protocol.power
    for k, v in pairs(protocol.roles) do
      self._teams.assassinDamageResourceTeams.teamInfo[lineUpId].roles[k] = v
    end
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.ResourceMagicAndImpair then
    self._teams.magicImpairResourceTeams.teamInfo[lineUpId].power = protocol.power
    for k, v in pairs(protocol.roles) do
      self._teams.magicImpairResourceTeams.teamInfo[lineUpId].roles[k] = v
    end
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.UndecidedRoad then
    self._teams.undecidedRoadTeams.teamInfo[lineUpId].power = protocol.power
    for k, v in pairs(protocol.roles) do
      self._teams.undecidedRoadTeams.teamInfo[lineUpId].roles[k] = v
    end
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.Spring then
    self._teams.springTeams.teamInfo[lineUpId].power = protocol.power
    for k, v in pairs(protocol.roles) do
      self._teams.springTeams.teamInfo[lineUpId].roles[k] = v
    end
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.SRChallenge then
    self._teams.srChallengeTeams.teamInfo[lineUpId].power = protocol.power
    for k, v in pairs(protocol.roles) do
      self._teams.srChallengeTeams.teamInfo[lineUpId].roles[k] = v
    end
  end
end

function DM_Team:OnSChangeLineUpName(protocol)
  local lineUpId = protocol.lineupId
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.Normal then
    self._teams.teamInfo[protocol.lineupId].name = protocol.name
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.Tower then
    self._towerTeam.teamInfo[protocol.lineupId].name = protocol.name
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.BOSS then
    self._teams.bossTeams.teamInfo[protocol.lineupId].name = protocol.name
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.ResourceDefendAndRecover then
    self._teams.defendRecoverResourceTeams.teamInfo[protocol.lineupId].name = protocol.name
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.ResourceAssassinAndDamage then
    self._teams.assassinDamageResourceTeams.teamInfo[protocol.lineupId].name = protocol.name
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.ResourceMagicAndImpair then
    self._teams.magicImpairResourceTeams.teamInfo[protocol.lineupId].name = protocol.name
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.UndecidedRoad then
    self._teams.undecidedRoadTeams.teamInfo[protocol.lineupId].name = protocol.name
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.Spring then
    self._teams.springTeams.teamInfo[protocol.lineupId].name = protocol.name
  end
  if self:GetTeamType(lineUpId) == self.TeamTypeEnum.SRChallenge then
    self._teams.srChallengeTeams.teamInfo[protocol.lineupId].name = protocol.name
  end
end

function DM_Team:OnSEnterDungeon(protocol)
  self._teams.curTeamId = protocol.lineupId
end

function DM_Team:OnSRefreshPower(data)
  for key, value in pairs(data) do
    if self._teams.teamInfo[key] then
      self._teams.teamInfo[key].power = value
    end
  end
end

function DM_Team:OnSChooseSupportRole(protocol)
  self:ClearSupportRole()
  local supportRoleList = NekoData.BehaviorManager.BM_Friends:GetSupportRoleList()
  if supportRoleList then
    local data = supportRoleList.rolesFromFriends[protocol.userId]
    if data then
      self._teams.SupportRoleInfo.role = Role.Create(data.id)
      self._teams.SupportRoleInfo.role:SetLevel(data.lv)
      self._teams.SupportRoleInfo.role:SetBreakLv(data.breakLv)
      self._teams.SupportRoleInfo.role:SetSupportSkill(data.contractSkill[1])
      self._teams.SupportRoleInfo.role:SetFashionId(data.skin)
      self._teams.SupportRoleInfo.user = NekoData.BehaviorManager.BM_Friends:GetFriend(protocol.userId)
    else
      for k, v in pairs(supportRoleList.rolesFromStrangers) do
        if protocol.userId == v.userInfo.baseUserData.userId then
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

function DM_Team:ClearSupportRole()
  if self._teams.SupportRoleInfo.role then
    self._teams.SupportRoleInfo.role = nil
  end
  if self._teams.SupportRoleInfo.user then
    self._teams.SupportRoleInfo.user = nil
  end
end

function DM_Team:GetCurrentRoleKeys()
  for k, v in pairs(self._teams.teamInfo) do
    if v.id == self._teams.curTeamId then
      return v.roles
    end
  end
  return {}
end

function DM_Team:OnSBattleStart(protocol)
  local lineId = protocol.battleInfo.lineId
  local battleType = protocol.battleInfo.battleType
  if battleType == CBattleStartProtocol.TOWER then
    self._towerTeam.curTeamId = lineId
  elseif battleType == CBattleStartProtocol.DUNGEON or battleType == CBattleStartProtocol.STARRY or battleType == CBattleStartProtocol.SUMMER or battleType == CBattleStartProtocol.LOVER or battleType == CBattleStartProtocol.ANNIVERSARY or battleType == CBattleStartProtocol.STARRY_MIRROR then
    self._teams.curTeamId = lineId
  elseif battleType == CBattleStartProtocol.BOSS_RUSH or battleType == CBattleStartProtocol.WEEK_BOSS then
    self._teams.bossTeams.curTeamId = lineId
  elseif battleType == CBattleStartProtocol.RESOURCE then
    if self:GetTeamType(lineId) == self.TeamTypeEnum.ResourceDefendAndRecover then
      self._teams.defendRecoverResourceTeams.curTeamId = lineId
    elseif self:GetTeamType(lineId) == self.TeamTypeEnum.ResourceAssassinAndDamage then
      self._teams.assassinDamageResourceTeams.curTeamId = lineId
    elseif self:GetTeamType(lineId) == self.TeamTypeEnum.ResourceMagicAndImpair then
      self._teams.magicImpairResourceTeams.curTeamId = lineId
    else
      self._teams.curTeamId = lineId
    end
  elseif battleType == CBattleStartProtocol.UNDECIDEDROAD then
    self._teams.undecidedRoadTeams.curTeamId = lineId
  elseif battleType == CBattleStartProtocol.CHRISTMAS then
    if self:GetTeamType(lineId) == self.TeamTypeEnum.UndecidedRoad then
      self._teams.undecidedRoadTeams.curTeamId = lineId
    else
      self._teams.curTeamId = lineId
    end
  elseif battleType == CBattleStartProtocol.SPRING_FESTIVAL then
    self._teams.springTeams.curTeamId = lineId
  elseif battleType == CBattleStartProtocol.SUMMER_ECHO then
    if self:GetTeamType(lineId) == self.TeamTypeEnum.SRChallenge then
      self._teams.srChallengeTeams.curTeamId = lineId
    else
      self._teams.curTeamId = lineId
    end
  elseif battleType == CBattleStartProtocol.FANTASY_CONFLICT then
    self._teams.SeasonPVPTeams.curTeamId = lineId
  end
end

return DM_Team
