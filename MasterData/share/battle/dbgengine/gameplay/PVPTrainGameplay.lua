local System = require("System.System")
local PVPGameplay = require("Battle.DbgEngine.Gameplay.PVPGameplay")
local BattleConst = require("Battle.BattleConst")
local bc = BattleConst
local BP = bc.BattleProperty
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local PVPTrainGameplay, _ = System.NewClass("PVPTrainGameplay", PVPGameplay)

function PVPTrainGameplay:OnInitBattle()
  self:FillPlayerAwakerData()
  self:InitCamp(BattleConst.BattleCamp.Camp1)
  self:InitCamp(BattleConst.BattleCamp.Camp2)
  if self.battleInitData.draftRelicTid then
    self.battleEngine:DebugS("OnInitBattle draftRelicTid {tid}", self.battleInitData.draftRelicTid)
    self.battleEngine.relicMgr:AddRelic(nil, self.battleInitData.draftRelicTid, nil, BattleConst.BattleCamp.Camp1)
  end
  self:AfterInitRole()
  self:ExeCmdAfterInitCamp()
  local evData = {
    camp = bc.BattleCamp.Camp1
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.AfterSelectInitCard, evData)
end

function PVPTrainGameplay:FillPlayerAwakerData()
  local playerData = self.battleInitData[bc.BattleCamp.Camp1]
  local friendAwakerTid = self.battleEngine.battleDT.GetConstant("PVPTraning_Friendly")
  table.insert(playerData.roleData, self:GetCat(friendAwakerTid))
  table.insert(playerData.roleData, self:GetCat(friendAwakerTid))
  table.insert(playerData.roleData, self:GetCat(friendAwakerTid))
  local AIPlayerData = self.battleInitData[bc.BattleCamp.Camp2]
  local enemyAwakerTid = self.battleEngine.battleDT.GetConstant("PVPTraning_Enemy")
  table.insert(AIPlayerData.roleData, self:GetCat(enemyAwakerTid))
  table.insert(AIPlayerData.roleData, self:GetCat(enemyAwakerTid))
  table.insert(AIPlayerData.roleData, self:GetCat(enemyAwakerTid))
  table.insert(AIPlayerData.roleData, self:GetCat(enemyAwakerTid))
end

function PVPTrainGameplay:GetCat(tid)
  return {
    tid = tid,
    level = 1,
    properties = {
      [bc.BattleProperty.hp] = 100,
      [bc.BattleProperty.max_hp] = 100,
      [bc.BattleProperty.ulti_energy_max] = bc.UltiEnergyPerSkill
    },
    slotCards = {},
    breakLevel = 0,
    breakSkillLevel = 0,
    potencyLevel = 0
  }
end

function PVPTrainGameplay:ExeCmdAfterInitCamp()
  local battleEngine = self.battleEngine
  local playerList = battleEngine.roleMgr:GetPlayerList()
  local battleBeginCmd = self:GetExeCmdAfterInitCamp()
  if battleBeginCmd and next(battleBeginCmd) and playerList and next(playerList) then
    for _, player in ipairs(playerList) do
      for _, cmd in ipairs(battleBeginCmd) do
        local cmdCtorData = {}
        cmdCtorData.cmdId = cmd
        cmdCtorData.castRoleUid = player.uid
        local cmdServer = BattleCmdServer(self.battleEngine, cmdCtorData)
        local cardEffectConfig = {
          effectType = bc.BattleEffectType.BECreateSkillPhase,
          castRoleUid = player.uid,
          cmdServer = cmdServer
        }
        self.battleEngine.effectMgr:CreateEffect(cardEffectConfig)
      end
    end
  end
end

function PVPTrainGameplay:GetExeCmdAfterInitCamp()
  local battleEngine = self.battleEngine
  local battleBeginCmd = table.deepclone(battleEngine.battleDT.GetOriginalConstant("PVPTrainingGenesisDirective") or {})
  local battleBeginCmd2 = battleEngine.battleDT.GetOriginalConstant("PVPGenesisDirective") or {}
  for _, cmd in ipairs(battleBeginCmd2) do
    table.insert(battleBeginCmd, cmd)
  end
  return battleBeginCmd
end

function PVPTrainGameplay:StartTimeout()
  return
end

function PVPTrainGameplay:OnAfterBattleBegin()
  self.battleEngine.boutMgr:BeginBout()
end

function PVPTrainGameplay:InitCamp(camp)
  local DT = self.battleEngine.battleDT
  local roleMgr = self.battleEngine.roleMgr
  local playerData = self.battleInitData[camp]
  local player = {
    uid = self.battleEngine:GenUid(),
    lives = 1,
    camp = camp,
    properties = {
      [BP.max_energy] = 10,
      [BP.relic_num_limit] = 8
    },
    roleType = BattleConst.RoleType.Player,
    playerId = playerData.playerId,
    gender = playerData.gender,
    icon = playerData.icon,
    playerName = playerData.playerName,
    level = 1,
    respawnedNum = 0,
    isAI = playerData.isAI,
    schoolConfigId = playerData.schoolConfigId
  }
  roleMgr:SpawnPlayer(player)
  local cardDataList = {}
  self.battleEngine:InfoS("InitCamp {camp} PlayerData {roleData}", camp, table.tostring(playerData.roleData))
  for i, awaker in ipairs(playerData.roleData) do
    awaker.battleFieldPos = awaker.index or i
    local awakerCfg = DT.AwakerConfig[awaker.tid]
    awaker.slots = {}
    for _, skillID in ipairs(awakerCfg.PVPSkillList or {}) do
      table.insert(awaker.slots, {tid = skillID, level = 1})
    end
    awaker.uid = self.battleEngine:GenUid()
    awaker.lives = awaker.lives or 1
    awaker.camp = camp
    awaker.roleType = BattleConst.RoleType.Awaker
    awaker.level = awaker.level or 1
    awaker.schoolConfigId = awakerCfg.School
    roleMgr:SpawnAwaker(awaker)
  end
  for _, keeperSkill in ipairs(playerData.keeperSkillList or {}) do
    local itemCfg = DT.Item[keeperSkill.tid]
    local skillId = itemCfg and itemCfg.PVPSkill and itemCfg.PVPSkill[1]
    local skillCfg = skillId and DT.Skill[skillId]
    if skillCfg then
      local cardData = self:__GenerateCard(skillCfg, camp, {
        level = keeperSkill.level
      })
      table.insert(cardDataList, cardData)
    end
  end
  for _, weaponSkill in ipairs(playerData.weaponList or {}) do
    local itemCfg = DT.Item[weaponSkill.tid]
    local skillId = itemCfg and itemCfg.PVPSkill and itemCfg.PVPSkill[1]
    local skillCfg = skillId and DT.Skill[skillId]
    if skillCfg then
      local cardData = self:__GenerateCard(skillCfg, camp, {
        level = weaponSkill.level
      })
      table.insert(cardDataList, cardData)
    end
  end
  for _, playerCard in ipairs(playerData.cards or {}) do
    local data = DT.Skill[playerCard.tid]
    if data and not table.contains(data.Type, bc.SkillType.Ulti_Skill) then
      local cardData = self:__GenerateCard(data, camp, playerCard)
      table.insert(cardDataList, cardData)
    end
  end
  self.battleEngine.cardMgr:InitAllCards(cardDataList)
  if camp == bc.BattleCamp.Camp1 then
    local awakerList = self.battleEngine.roleMgr:GetPVPRoleList("AliveOnly", camp)
    for _, awaker in ipairs(awakerList or {}) do
      awaker:GainUltiEnergy(100, {})
    end
  end
end

return PVPTrainGameplay
