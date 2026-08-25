local System = require("System.System")
local GameplayBase = require("Battle.DbgEngine.GameplayBase")
local BattleConst = require("Battle.BattleConst")
local BattleBoutMgrServer = require("Battle.DbgEngine.Bout.BattleBoutMgrServer")
local BattleCardMgrServer = require("Battle.DbgEngine.Card.BattleCardMgrServer")
local BattleAIMgrServer = require("Battle.DbgEngine.AI.BattleAIMgrServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local PVEGameplay, Super = System.NewClass("PVEGameplay", GameplayBase)

function PVEGameplay:OnInit()
  local battleEngine = self.battleEngine
  battleEngine.boutMgr = battleEngine:AddBattleComponent(BattleBoutMgrServer)
  battleEngine.cardMgr = battleEngine:AddBattleComponent(BattleCardMgrServer)
  battleEngine.aiMgr = battleEngine:AddBattleComponent(BattleAIMgrServer)
end

function PVEGameplay:StartBattle(playerId)
  local battleEngine = self.battleEngine
  battleEngine:Info("StartBattle {playerId}", playerId)
  if battleEngine:IsInit() then
    battleEngine:ReconnectBattle()
  else
    battleEngine:__StartBattle()
  end
end

function PVEGameplay:OnInitBattle()
  local battleEngine = self.battleEngine
  self:SpawnCampRoles(self.battleInitData.roleData)
  self:SpawnCamp2Roles()
  self:AfterInitRole()
  battleEngine:InitSchoolState(self.battleInitData.isMock)
  self:InitAllCards()
  self:InitStateFromSvrData(self.battleInitData.stateList)
  battleEngine:InitPassiveState()
  battleEngine.cardMgr:BattleBeginShuffleCard()
end

function PVEGameplay:AfterInitRole()
  for _, role in ipairs(self.battleEngine.roleMgr:GetRoleList()) do
    role:AfterInit()
  end
end

function PVEGameplay:SpawnCampRoles(roleData)
  local keeperSkillItem = self.battleInitData.keeperSkill
  local itemCfg = self.battleEngine.battleDT.Item[keeperSkillItem]
  local keeperSkillId = itemCfg and tonumber(itemCfg.SpParam[1])
  local role = {
    uid = self.battleEngine:GenUid(),
    lives = self.battleInitData.lives,
    camp = bc.BattleCamp.Camp1,
    battleFieldPos = 1,
    roleType = bc.RoleType.Player,
    properties = self.battleInitData.copyProperties or {},
    level = self.battleInitData.playerLevel,
    skillId = keeperSkillId,
    skillLevel = 1,
    schoolMap = self.battleInitData.schoolMap,
    gender = self.battleInitData.gender,
    playerName = self.battleInitData.playerName,
    unlockedKeeperSkillItems = self.battleInitData.unlockedKeeperSkillItems,
    selectedKeeperSkill = self.battleInitData.selectedKeeperSkill,
    randUnlockKeeperSkillUsed = self.battleInitData.randUnlockKeeperSkillUsed,
    keeperSkillIdMap = self.battleInitData.keeperSkillIdMap
  }
  self.battleEngine.roleMgr:SpawnPlayer(role)
  local awakerCount = #roleData
  for i, awaker in ipairs(roleData) do
    if awakerCount <= 2 then
      awaker.battleFieldPos = 4 - awakerCount + i - 1
    else
      awaker.battleFieldPos = awaker.index or i
    end
    awaker.properties = awaker.attrs
    awaker.camp = bc.BattleCamp.Camp1
    self:LoadAwakerConfigProperties(awaker)
    self.battleEngine.roleMgr:SpawnAwaker(awaker)
  end
end

function PVEGameplay:SpawnCamp2Roles()
  self.battleEngine.monsterSpawnerMgr:Spawn(nil, self.battleInitData.coverMonsters)
end

function PVEGameplay:InitAllCards()
  local cardDataList = {}
  local cards = self.battleInitData.cards
  for _, card in ipairs(cards) do
    local cardData = table.clone(card)
    cardData.uid = card.uid
    cardData.tid = card.tid
    cardData.deck = cardData.deck or bc.CardDeck.DrawDeck
    cardData.level = card.level
    cardData.camp = bc.BattleCamp.Camp1
    table.insert(cardDataList, cardData)
  end
  self.battleEngine.cardMgr:InitAllCards(cardDataList)
  if self.battleInitData.dimensionCards then
    self.battleEngine.cardMgr:InitDimensionCards(self.battleInitData.dimensionCards)
  end
end

function PVEGameplay:OnBattleBegin()
  local battleEngine = self.battleEngine
  battleEngine.roleMgr:OnBattleBegin()
  battleEngine.recordMgr:OnBattleBegin()
end

function PVEGameplay:OnAfterBattleBegin()
  local battleEngine = self.battleEngine
  battleEngine.boutMgr:BeginBout()
end

function PVEGameplay:OnBattleFinish(winCamp, battleFinishData)
  local battleEngine = self.battleEngine
  battleEngine:WorldRpc("Battle", "OnBattleFinish", winCamp, battleFinishData)
end

function PVEGameplay:GetAwakerUpgradeConfig(level, quality)
  if not level then
    return
  end
  local DT = self.battleEngine.battleDT
  local extraLevel = 0
  if quality then
    extraLevel = DT.GetConstant("AwakerUpgradeLevel_" .. quality)
  end
  level = level + extraLevel
  return DT.AwakerUpgrade[level]
end

function PVEGameplay:CalcInitProperty(awakerConfig, propertyName, level)
  local baseValue
  if awakerConfig and awakerConfig[propertyName] then
    baseValue = math.ceil(awakerConfig[propertyName])
  else
    return
  end
  local fieldName
  if "atk" == propertyName then
    fieldName = "AtkGrowthOfBaseAtk"
  elseif "def" == propertyName then
    fieldName = "DefGrowthOfBaseDef"
  elseif "physique" == propertyName then
    fieldName = "PhysiqueGrowthOfBasePhysique"
  else
    return baseValue
  end
  local upgradeCfg = self:GetAwakerUpgradeConfig(level, awakerConfig.Quality)
  if upgradeCfg and upgradeCfg[fieldName] then
    local formula = upgradeCfg[fieldName]
    local mt = {
      __index = function(_, key)
        if _G[key] then
          return _G[key]
        end
        return awakerConfig[key]
      end
    }
    local fenv = {}
    setmetatable(fenv, mt)
    local cmdFunc = self.battleEngine:GetCmdFunc(formula, fenv)
    local _, v = xpcall(cmdFunc, function(error)
      local err = string.format("获取唤醒体 %s 等级 %s 属性 %s 失败，公式 %s", awakerConfig.ID, level, propertyName, formula)
      print(err, error)
    end)
    return v or baseValue
  end
  return baseValue
end

function PVEGameplay:LoadAwakerConfigProperties(roleData)
  local DT = self.battleEngine.battleDT
  local awakerConfig = DT.AwakerConfig[roleData.tid]
  for k, v in pairs(awakerConfig) do
    if roleData.properties[k] then
    else
      local apiCfg = DT.BattleApi[k]
      if apiCfg and (apiCfg.ApiType == bc.ApiType.ATTR or apiCfg.ApiType == bc.ApiType.AWAKER_ATTR) then
        local configNum = self:CalcInitProperty(awakerConfig, k, roleData.level)
        roleData.properties[k] = configNum
      end
    end
  end
  if not roleData.properties.hp then
    roleData.properties.hp = math.ceil(roleData.properties.physique * (1 + roleData.properties.physique_per / 100))
    roleData.properties.max_hp = roleData.properties.hp
  end
end

function PVEGameplay:InitStateFromSvrData(stateList)
  if not stateList then
    return
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  for _, v in pairs(stateList) do
    local ownerData = v.ownerData
    local stateCfg = self.battleEngine.battleDT.State[v.stateId]
    if not stateCfg then
      self.battleEngine:Warn("InitStateFromSvrData failed no state", v.stateId)
    else
      for propertyName, _ in pairs(stateCfg.ExistProperty or {}) do
        if propertyName == BP.max_hp then
          goto lbl_183
        end
      end
      if ownerData.targetType == "PlayerRole" then
        v.castRoleUid = player.uid
        self.battleEngine.stateMgr:CreateState(player, v)
      elseif ownerData.targetType == "Card" then
        local card = self.battleEngine:GetObj(ownerData.uid)
        if not card then
          self.battleEngine:Warn("InitStateFromSvrData failed no card", ownerData.uid, v.stateId)
        else
          v.castRoleUid = card.owner and card.owner.uid or player.uid
          self.battleEngine.stateMgr:CreateState(card, v)
        end
      elseif ownerData.targetType == "TargetCmdOwner" then
        self.battleEngine:Warn("InitStateFromSvrData targetTyper TargetCmdOwner", v.tid)
        local awaker = self.battleEngine:GetObj(ownerData.uid)
        if not awaker then
          self.battleEngine:Warn("InitStateFromSvrData failed no awaker", ownerData.uid, v.stateId)
        else
          v.castRoleUid = ownerData.uid
          local createArgs = table.deepclone(v)
          self.battleEngine.stateMgr:CreateState(awaker, createArgs)
        end
      elseif ownerData.targetType == "CmdCaster" then
        self.battleEngine:Warn("InitStateFromSvrData targetTyper CmdCaster", v.tid)
        local casterUid = v.casterUid
        local caster = self.battleEngine:GetObj(casterUid)
        if not caster then
          self.battleEngine:Warn("InitStateFromSvrData failed no caster", casterUid)
        else
          v.casterRoleUid = caster.uid
          local createArgs = table.deepclone(v)
          self.battleEngine.stateMgr:CreateState(caster, createArgs)
        end
      elseif ownerData.targetType == "Awaker" then
        v.castRoleUid = ownerData.uid
        do
          local awaker = self.battleEngine:GetObj(ownerData.uid)
          if not awaker then
            self.battleEngine:Warn("InitStateFromSvrData failed no awaker", ownerData.uid, v.stateId)
          else
            local createArgs = table.deepclone(v)
            self.battleEngine.stateMgr:CreateState(awaker, createArgs)
          end
        end
      end
    end
    ::lbl_183::
  end
end

function PVEGameplay:GetInitData()
  return self.battleInitData
end

return PVEGameplay
