local System = require("System.System")
local BattleCardData = System.NewClass("BattleCardData")

function BattleCardData.Create(config)
  local data = {
    tid = config.tid,
    srcConfigId = config.tid,
    used = false,
    isDeleted = false,
    runes = config.runes or {},
    savedStateData = nil,
    savedOriginData = nil,
    damageTargets = {},
    composeCardUids = config.composeCardUids,
    randomseed = config.randomseed,
    fromCardUid = config.fromCardUid
  }
  if 0 ~= config.performSkillId then
    data.performSkillId = config.performSkillId
  end
  return data
end

return BattleCardData
