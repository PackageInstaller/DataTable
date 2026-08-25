local System = require("System.System")
local BattleKeeperSkillData = System.NewClass("BattleKeeperSkillData")

function BattleKeeperSkillData.Create(config)
  local data = {
    uid = config.uid,
    tid = config.tid,
    camp = config.camp,
    isBlankMemory = config.isBlankMemory,
    randUnlockSourceId = config.randUnlockSourceId
  }
  return data
end

return BattleKeeperSkillData
