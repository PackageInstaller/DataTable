-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_team.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local Friend = require("logic.manager.experimental.types.friend")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local DM_Team = class("DM_Team")
DM_Team.TeamTypeEnum = {Normal = 1, Tower = 2, BrokenMirror = 3, OffLinePVP = 4, BOSS = 5, AutoExplore = 6, ResourceDefendAndRecover = 7, ResourceAssassinAndDamage = 8, ResourceMagicAndImpair = 9, UndecidedRoad = 10, Spring = 11, SRChallenge = 12}
DM_Team.GetTeamType = function(self, lineUpId)
  -- function num : 0_0
  if lineUpId > 0 and lineUpId < 1000 then
    return (self.TeamTypeEnum).Normal
  end
  if lineUpId > 1000 and lineUpId < 2000 then
    return (self.TeamTypeEnum).Tower
  end
  if lineUpId == 2000 then
    return (self.TeamTypeEnum).BrokenMirror
  end
  if lineUpId == 3000 then
    return (self.TeamTypeEnum).OffLinePVP
  end
  if lineUpId > 4000 and lineUpId < 5000 then
    return (self.TeamTypeEnum).BOSS
  end
  if lineUpId == 5001 then
    return (self.TeamTypeEnum).AutoExplore
  end
  if lineUpId == 6001 or lineUpId == 6002 then
    return (self.TeamTypeEnum).ResourceDefendAndRecover
  end
  if lineUpId == 6003 or lineUpId == 6004 then
    return (self.TeamTypeEnum).ResourceAssassinAndDamage
  end
  if lineUpId == 6005 or lineUpId == 6006 then
    return (self.TeamTypeEnum).ResourceMagicAndImpair
  end
  if lineUpId == 7000 or lineUpId == 7001 then
    return (self.TeamTypeEnum).UndecidedRoad
  end
  if lineUpId >= 8000 and lineUpId <= 8003 then
    return (self.TeamTypeEnum).Spring
  end
  if lineUpId >= 9000 and lineUpId <= 9001 then
    return (self.TeamTypeEnum).SRChallenge
  end
end

DM_Team.Ctor = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._teams = (NekoData.Data).teams
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).teamInfo = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).curTeamId = nil
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).SupportRoleInfo = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).filterCondition = nil
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).bossTeams = {
teamInfo = {}
, curTeamId = nil}
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).defendRecoverResourceTeams = {
teamInfo = {}
, curTeamId = nil}
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).assassinDamageResourceTeams = {
teamInfo = {}
, curTeamId = nil}
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).magicImpairResourceTeams = {
teamInfo = {}
, curTeamId = nil}
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).undecidedRoadTeams = {
teamInfo = {}
, curTeamId = nil}
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).springTeams = {
teamInfo = {}
, curTeamId = nil}
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).srChallengeTeams = {
teamInfo = {}
, curTeamId = nil}
  self._towerTeam = (NekoData.Data).towerteams
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._towerTeam).teamInfo = {}
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._towerTeam).curTeamId = nil
end

DM_Team.Clear = function(self)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._teams).teamInfo = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).curTeamId = nil
  for k,v in pairs((self._teams).SupportRoleInfo) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

    ((self._teams).SupportRoleInfo)[k] = nil
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._towerTeam).teamInfo = {}
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._towerTeam).curTeamId = nil
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).bossTeams).teamInfo = {}
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).bossTeams).curTeamId = nil
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).defendRecoverResourceTeams).teamInfo = {}
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).defendRecoverResourceTeams).curTeamId = nil
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).assassinDamageResourceTeams).teamInfo = {}
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).assassinDamageResourceTeams).curTeamId = nil
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).magicImpairResourceTeams).teamInfo = {}
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).magicImpairResourceTeams).curTeamId = nil
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).undecidedRoadTeams).teamInfo = {}
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).undecidedRoadTeams).curTeamId = nil
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).springTeams).teamInfo = {}
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).springTeams).curTeamId = nil
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).srChallengeTeams).teamInfo = {}
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._teams).srChallengeTeams).curTeamId = nil
  if (self._teams).filterCondition then
    for k,_ in pairs((self._teams).filterCondition) do
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R6 in 'UnsetPending'

      ((self._teams).filterCondition)[k] = nil
    end
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._teams).filterCondition = nil
  end
  -- DECOMPILER ERROR at PC87: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._teams).editCopyInfo = {}
end

DM_Team.OnSLineInfo = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, Role, Friend
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._teams).teamInfo = {}
  for index,team in ipairs(protocol.lineupList) do
    local info = {}
    info.id = team.id
    info.name = team.name
    info.skill = team.skill
    info.power = team.power or 0
    info.roles = {}
    for k,v in pairs(team.roles) do
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R13 in 'UnsetPending'

      (info.roles)[k] = v
    end
    local lineUpId = team.id
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R9 in 'UnsetPending'

    if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).Normal or self:GetTeamType(lineUpId) == (self.TeamTypeEnum).OffLinePVP or self:GetTeamType(lineUpId) == (self.TeamTypeEnum).AutoExplore then
      ((self._teams).teamInfo)[team.id] = info
    end
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R9 in 'UnsetPending'

    if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).Tower then
      ((self._towerTeam).teamInfo)[team.id] = info
    end
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R9 in 'UnsetPending'

    if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).BOSS then
      (((self._teams).bossTeams).teamInfo)[team.id] = info
    end
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R9 in 'UnsetPending'

    if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).ResourceDefendAndRecover then
      (((self._teams).defendRecoverResourceTeams).teamInfo)[team.id] = info
    end
    -- DECOMPILER ERROR at PC101: Confused about usage of register: R9 in 'UnsetPending'

    if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).ResourceAssassinAndDamage then
      (((self._teams).assassinDamageResourceTeams).teamInfo)[team.id] = info
    end
    -- DECOMPILER ERROR at PC113: Confused about usage of register: R9 in 'UnsetPending'

    if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).ResourceMagicAndImpair then
      (((self._teams).magicImpairResourceTeams).teamInfo)[team.id] = info
    end
    -- DECOMPILER ERROR at PC125: Confused about usage of register: R9 in 'UnsetPending'

    if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).UndecidedRoad then
      (((self._teams).undecidedRoadTeams).teamInfo)[team.id] = info
    end
    -- DECOMPILER ERROR at PC137: Confused about usage of register: R9 in 'UnsetPending'

    if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).Spring then
      (((self._teams).springTeams).teamInfo)[team.id] = info
    end
    -- DECOMPILER ERROR at PC149: Confused about usage of register: R9 in 'UnsetPending'

    if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).SRChallenge then
      (((self._teams).srChallengeTeams).teamInfo)[team.id] = info
    end
  end
  -- DECOMPILER ERROR at PC154: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._teams).curTeamId = protocol.commonLinupId
  -- DECOMPILER ERROR at PC157: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerTeam).curTeamId = protocol.towerLineupId
  -- DECOMPILER ERROR at PC161: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._teams).bossTeams).curTeamId = protocol.bossRushLineupId
  -- DECOMPILER ERROR at PC165: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._teams).defendRecoverResourceTeams).curTeamId = protocol.guardRestoreLineupId
  -- DECOMPILER ERROR at PC169: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._teams).assassinDamageResourceTeams).curTeamId = protocol.damageStabLineupId
  -- DECOMPILER ERROR at PC173: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._teams).magicImpairResourceTeams).curTeamId = protocol.magicImpairLineupId
  -- DECOMPILER ERROR at PC177: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._teams).undecidedRoadTeams).curTeamId = protocol.undecidedRoadLineupId
  -- DECOMPILER ERROR at PC181: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._teams).springTeams).curTeamId = protocol.springFestivalLineupId
  -- DECOMPILER ERROR at PC185: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._teams).srChallengeTeams).curTeamId = protocol.srChallengeLineupId
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.curTeamId %s", (self._teams).curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _towerTeam.curTeamId %s", (self._towerTeam).curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.bossTeam.curTeamId %s", ((self._teams).bossTeams).curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.defendRecoverResourceTeams.curTeamId %s", ((self._teams).defendRecoverResourceTeams).curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.assassinDamageResourceTeams.curTeamId %s", ((self._teams).assassinDamageResourceTeams).curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.magicImpairResourceTeams.curTeamId %s", ((self._teams).magicImpairResourceTeams).curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.undecidedRoadTeams.curTeamId %s", ((self._teams).magicImpairResourceTeams).curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.springTeams.curTeamId %s", ((self._teams).springTeams).curTeamId)
  LogInfoFormat("DM_Team", "OnSLineInfo _teams.srChallengeTeams.curTeamId %s", ((self._teams).srChallengeTeams).curTeamId)
  -- DECOMPILER ERROR at PC272: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.supportRole and (protocol.supportRole).role and ((protocol.supportRole).role).id ~= 0 and (protocol.supportRole).user then
    ((self._teams).SupportRoleInfo).role = (Role.Create)(((protocol.supportRole).role).id, (protocol.supportRole).role)
    -- DECOMPILER ERROR at PC277: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._teams).SupportRoleInfo).user = (Friend.Create)()
    ;
    (((self._teams).SupportRoleInfo).user):SetDataFromProtol((protocol.supportRole).user)
  end
end

DM_Team.OnSChangeRoles = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  local lineUpId = protocol.lineupId
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).Normal or self:GetTeamType(lineUpId) == (self.TeamTypeEnum).OffLinePVP or self:GetTeamType(lineUpId) == (self.TeamTypeEnum).AutoExplore then
    (((self._teams).teamInfo)[lineUpId]).power = protocol.power
    for k,v in pairs(protocol.roles) do
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

      ((((self._teams).teamInfo)[lineUpId]).roles)[k] = v
    end
  end
  do
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

    if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).Tower then
      (((self._towerTeam).teamInfo)[lineUpId]).power = protocol.power
      for k,v in pairs(protocol.roles) do
        -- DECOMPILER ERROR at PC58: Confused about usage of register: R8 in 'UnsetPending'

        ((((self._towerTeam).teamInfo)[lineUpId]).roles)[k] = v
      end
    end
    do
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R3 in 'UnsetPending'

      if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).BOSS then
        ((((self._teams).bossTeams).teamInfo)[lineUpId]).power = protocol.power
        for k,v in pairs(protocol.roles) do
          -- DECOMPILER ERROR at PC83: Confused about usage of register: R8 in 'UnsetPending'

          (((((self._teams).bossTeams).teamInfo)[lineUpId]).roles)[k] = v
        end
      end
      do
        -- DECOMPILER ERROR at PC98: Confused about usage of register: R3 in 'UnsetPending'

        if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).ResourceDefendAndRecover then
          ((((self._teams).defendRecoverResourceTeams).teamInfo)[lineUpId]).power = protocol.power
          for k,v in pairs(protocol.roles) do
            -- DECOMPILER ERROR at PC108: Confused about usage of register: R8 in 'UnsetPending'

            (((((self._teams).defendRecoverResourceTeams).teamInfo)[lineUpId]).roles)[k] = v
          end
        end
        do
          -- DECOMPILER ERROR at PC123: Confused about usage of register: R3 in 'UnsetPending'

          if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).ResourceAssassinAndDamage then
            ((((self._teams).assassinDamageResourceTeams).teamInfo)[lineUpId]).power = protocol.power
            for k,v in pairs(protocol.roles) do
              -- DECOMPILER ERROR at PC133: Confused about usage of register: R8 in 'UnsetPending'

              (((((self._teams).assassinDamageResourceTeams).teamInfo)[lineUpId]).roles)[k] = v
            end
          end
          do
            -- DECOMPILER ERROR at PC148: Confused about usage of register: R3 in 'UnsetPending'

            if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).ResourceMagicAndImpair then
              ((((self._teams).magicImpairResourceTeams).teamInfo)[lineUpId]).power = protocol.power
              for k,v in pairs(protocol.roles) do
                -- DECOMPILER ERROR at PC158: Confused about usage of register: R8 in 'UnsetPending'

                (((((self._teams).magicImpairResourceTeams).teamInfo)[lineUpId]).roles)[k] = v
              end
            end
            do
              -- DECOMPILER ERROR at PC173: Confused about usage of register: R3 in 'UnsetPending'

              if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).UndecidedRoad then
                ((((self._teams).undecidedRoadTeams).teamInfo)[lineUpId]).power = protocol.power
                for k,v in pairs(protocol.roles) do
                  -- DECOMPILER ERROR at PC183: Confused about usage of register: R8 in 'UnsetPending'

                  (((((self._teams).undecidedRoadTeams).teamInfo)[lineUpId]).roles)[k] = v
                end
              end
              do
                -- DECOMPILER ERROR at PC198: Confused about usage of register: R3 in 'UnsetPending'

                if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).Spring then
                  ((((self._teams).springTeams).teamInfo)[lineUpId]).power = protocol.power
                  for k,v in pairs(protocol.roles) do
                    -- DECOMPILER ERROR at PC208: Confused about usage of register: R8 in 'UnsetPending'

                    (((((self._teams).springTeams).teamInfo)[lineUpId]).roles)[k] = v
                  end
                end
                do
                  -- DECOMPILER ERROR at PC223: Confused about usage of register: R3 in 'UnsetPending'

                  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).SRChallenge then
                    ((((self._teams).srChallengeTeams).teamInfo)[lineUpId]).power = protocol.power
                    for k,v in pairs(protocol.roles) do
                      -- DECOMPILER ERROR at PC233: Confused about usage of register: R8 in 'UnsetPending'

                      (((((self._teams).srChallengeTeams).teamInfo)[lineUpId]).roles)[k] = v
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

DM_Team.OnSChangeLineUpName = function(self, protocol)
  -- function num : 0_5
  local lineUpId = protocol.lineupId
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).Normal then
    (((self._teams).teamInfo)[protocol.lineupId]).name = protocol.name
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).Tower then
    (((self._towerTeam).teamInfo)[protocol.lineupId]).name = protocol.name
  end
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).BOSS then
    ((((self._teams).bossTeams).teamInfo)[protocol.lineupId]).name = protocol.name
  end
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).ResourceDefendAndRecover then
    ((((self._teams).defendRecoverResourceTeams).teamInfo)[protocol.lineupId]).name = protocol.name
  end
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R3 in 'UnsetPending'

  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).ResourceAssassinAndDamage then
    ((((self._teams).assassinDamageResourceTeams).teamInfo)[protocol.lineupId]).name = protocol.name
  end
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R3 in 'UnsetPending'

  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).ResourceMagicAndImpair then
    ((((self._teams).magicImpairResourceTeams).teamInfo)[protocol.lineupId]).name = protocol.name
  end
  -- DECOMPILER ERROR at PC96: Confused about usage of register: R3 in 'UnsetPending'

  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).UndecidedRoad then
    ((((self._teams).undecidedRoadTeams).teamInfo)[protocol.lineupId]).name = protocol.name
  end
  -- DECOMPILER ERROR at PC110: Confused about usage of register: R3 in 'UnsetPending'

  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).Spring then
    ((((self._teams).springTeams).teamInfo)[protocol.lineupId]).name = protocol.name
  end
  -- DECOMPILER ERROR at PC124: Confused about usage of register: R3 in 'UnsetPending'

  if self:GetTeamType(lineUpId) == (self.TeamTypeEnum).SRChallenge then
    ((((self._teams).srChallengeTeams).teamInfo)[protocol.lineupId]).name = protocol.name
  end
end

DM_Team.OnSEnterDungeon = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._teams).curTeamId = protocol.lineupId
end

DM_Team.OnSRefreshPower = function(self, data)
  -- function num : 0_7 , upvalues : _ENV
  for key,value in pairs(data) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    if ((self._teams).teamInfo)[key] then
      (((self._teams).teamInfo)[key]).power = value
    end
  end
end

DM_Team.OnSChooseSupportRole = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV, Role, Friend
  self:ClearSupportRole()
  local supportRoleList = ((NekoData.BehaviorManager).BM_Friends):GetSupportRoleList()
  if supportRoleList then
    local data = (supportRoleList.rolesFromFriends)[protocol.userId]
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
      ((self._teams).SupportRoleInfo).user = ((NekoData.BehaviorManager).BM_Friends):GetFriend(protocol.userId)
    else
      for k,v in pairs(supportRoleList.rolesFromStrangers) do
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R9 in 'UnsetPending'

        if protocol.userId == ((v.userInfo).baseUserData).userId then
          ((self._teams).SupportRoleInfo).role = (Role.Create)((v.roleInfo).id)
          ;
          (((self._teams).SupportRoleInfo).role):SetLevel((v.roleInfo).lv)
          ;
          (((self._teams).SupportRoleInfo).role):SetBreakLv((v.roleInfo).breakLv)
          ;
          (((self._teams).SupportRoleInfo).role):SetSupportSkill(((v.roleInfo).contractSkill)[1])
          ;
          (((self._teams).SupportRoleInfo).role):SetFashionId((v.roleInfo).skin)
          -- DECOMPILER ERROR at PC105: Confused about usage of register: R9 in 'UnsetPending'

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

DM_Team.ClearSupportRole = function(self)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if ((self._teams).SupportRoleInfo).role then
    ((self._teams).SupportRoleInfo).role = nil
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  if ((self._teams).SupportRoleInfo).user then
    ((self._teams).SupportRoleInfo).user = nil
  end
end

DM_Team.GetCurrentRoleKeys = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in pairs((self._teams).teamInfo) do
    if v.id == (self._teams).curTeamId then
      return v.roles
    end
  end
  return {}
end

DM_Team.OnSBattleStart = function(self, protocol)
  -- function num : 0_11 , upvalues : CBattleStartProtocol
  local lineId = (protocol.battleInfo).lineId
  local battleType = (protocol.battleInfo).battleType
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if battleType == CBattleStartProtocol.TOWER then
    (self._towerTeam).curTeamId = lineId
  else
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

    if battleType == CBattleStartProtocol.DUNGEON or battleType == CBattleStartProtocol.STARRY or battleType == CBattleStartProtocol.SUMMER or battleType == CBattleStartProtocol.LOVER or battleType == CBattleStartProtocol.ANNIVERSARY or battleType == CBattleStartProtocol.STARRY_MIRROR then
      (self._teams).curTeamId = lineId
    else
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

      if battleType == CBattleStartProtocol.BOSS_RUSH or battleType == CBattleStartProtocol.WEEK_BOSS then
        ((self._teams).bossTeams).curTeamId = lineId
      else
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

        if battleType == CBattleStartProtocol.RESOURCE then
          if self:GetTeamType(lineId) == (self.TeamTypeEnum).ResourceDefendAndRecover then
            ((self._teams).defendRecoverResourceTeams).curTeamId = lineId
          else
            -- DECOMPILER ERROR at PC64: Confused about usage of register: R4 in 'UnsetPending'

            if self:GetTeamType(lineId) == (self.TeamTypeEnum).ResourceAssassinAndDamage then
              ((self._teams).assassinDamageResourceTeams).curTeamId = lineId
            else
              -- DECOMPILER ERROR at PC75: Confused about usage of register: R4 in 'UnsetPending'

              if self:GetTeamType(lineId) == (self.TeamTypeEnum).ResourceMagicAndImpair then
                ((self._teams).magicImpairResourceTeams).curTeamId = lineId
              else
                -- DECOMPILER ERROR at PC78: Confused about usage of register: R4 in 'UnsetPending'

                ;
                (self._teams).curTeamId = lineId
              end
            end
          end
        else
          -- DECOMPILER ERROR at PC85: Confused about usage of register: R4 in 'UnsetPending'

          if battleType == CBattleStartProtocol.UNDECIDEDROAD then
            ((self._teams).undecidedRoadTeams).curTeamId = lineId
          else
            -- DECOMPILER ERROR at PC99: Confused about usage of register: R4 in 'UnsetPending'

            if battleType == CBattleStartProtocol.CHRISTMAS then
              if self:GetTeamType(lineId) == (self.TeamTypeEnum).UndecidedRoad then
                ((self._teams).undecidedRoadTeams).curTeamId = lineId
              else
                -- DECOMPILER ERROR at PC102: Confused about usage of register: R4 in 'UnsetPending'

                ;
                (self._teams).curTeamId = lineId
              end
            else
              -- DECOMPILER ERROR at PC109: Confused about usage of register: R4 in 'UnsetPending'

              if battleType == CBattleStartProtocol.SPRING_FESTIVAL then
                ((self._teams).springTeams).curTeamId = lineId
              else
                -- DECOMPILER ERROR at PC123: Confused about usage of register: R4 in 'UnsetPending'

                if battleType == CBattleStartProtocol.SUMMER_ECHO then
                  if self:GetTeamType(lineId) == (self.TeamTypeEnum).SRChallenge then
                    ((self._teams).srChallengeTeams).curTeamId = lineId
                  else
                    -- DECOMPILER ERROR at PC126: Confused about usage of register: R4 in 'UnsetPending'

                    ;
                    (self._teams).curTeamId = lineId
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

return DM_Team

