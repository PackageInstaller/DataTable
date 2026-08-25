local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BattleZoneUtil = {}

function BattleZoneUtil.IsJapan()
  local ServerUtil = require("ServerUtil")
  return ServerUtil and ServerUtil.IsJapan()
end

function BattleZoneUtil.IsInternational()
  return not BattleZoneUtil.IsJapan()
end

function BattleZoneUtil.GetTentacleCrit(role)
  local outsideCrit = role:GetProperty(BP.outside_crit)
  if BattleZoneUtil.IsJapan() then
    return outsideCrit
  end
  local crit = 0
  local awakerList = role:GetAwakerList()
  for _, awaker in ipairs(awakerList) do
    local critPer = awaker:GetProperty(BP.crit_per)
    crit = crit + awaker:GetProperty(BP.crit) * (100 + critPer) / 100
  end
  local curTotalCrit = crit / #awakerList
  do return math.ceil end
  return math.ceil, curTotalCrit + outsideCrit - 5, ipairs(awakerList)
end

function BattleZoneUtil.GetTentacleCritDmg(role)
  local outsideCritDmg = role:GetProperty(BP.outside_crit_damage)
  if BattleZoneUtil.IsJapan() then
    return outsideCritDmg
  end
  local critDmg = 0
  local awakerList = role:GetAwakerList()
  for _, awaker in ipairs(awakerList) do
    critDmg = critDmg + awaker:GetProperty(BP.crit_damage)
  end
  local curTotalCritDmg = critDmg / #awakerList
  do return math.ceil end
  return math.ceil, curTotalCritDmg + outsideCritDmg - 50, ipairs(awakerList)
end

return BattleZoneUtil
