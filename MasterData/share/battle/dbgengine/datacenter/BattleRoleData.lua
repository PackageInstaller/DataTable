local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleRoleData = System.NewClass("BattleRoleData")

function BattleRoleData.Create(roleData)
  local data = {
    fsmState = bc.AwakerFsmState.Idle,
    lives = roleData.lives or 1,
    respawnedNum = 0,
    playerId = roleData.playerId,
    gender = roleData.gender,
    curSkin = roleData.curSkin,
    icon = roleData.icon,
    playerName = roleData.playerName,
    boutSkillTimes = 0,
    slots = roleData.slots,
    roleType = roleData.roleType,
    schoolConfigId = roleData.schoolConfigId,
    battleFieldPos = roleData.battleFieldPos,
    talents = roleData.talents,
    potencyLevel = roleData.potencyLevel or 0,
    breakLevel = roleData.breakLevel or 0,
    breakSkillLevel = roleData.breakSkillLevel or 0,
    skillId = roleData.skillId,
    skillLevel = roleData.skillLevel,
    unlockedKeeperSkillItems = roleData.unlockedKeeperSkillItems,
    selectedKeeperSkill = roleData.selectedKeeperSkill,
    randUnlockKeeperSkillUsed = roleData.randUnlockKeeperSkillUsed,
    keeperSkillIdMap = roleData.keeperSkillIdMap or {},
    oceanModel = nil,
    boutTentacleSwitched = false,
    animIdx = 0,
    hpNum = roleData.hpNum or 0,
    maxHpNum = roleData.maxHpNum or 0,
    boutBloodRecoverTimes = 0,
    chaosType2SkillTimes = 0,
    chaosType2Skill2Times = 0,
    motion = roleData.motion or {},
    likeLevel = roleData.likeLevel,
    doubleUltiEnergy = roleData.doubleUltiEnergy or false,
    tags = roleData.tags or {}
  }
  return data
end

return BattleRoleData
