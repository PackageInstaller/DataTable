local PB = require("Common/PbHelper")
local DEFINE = require("Logic/Define")
local TS = {}

local function getActorBaseAttr(actor, index)
  for m = 1, #actor.actorInfo.attrs do
    local attr = actor.actorInfo.attrs[m]
    if attr.type == index then
      return attr.value
    end
  end
  return 0
end

function TS.recordHpList(teamList)
  for i = 1, #teamList do
    local teamInfo = teamList[i]
    teamInfo.statistic.recordHpList = {}
    for j = 1, #teamInfo.playerList do
      local actorList = teamInfo.playerList[j].actorList
      for k = 1, #actorList do
        local roundActorInfo = actorList[k]
        if not DEFINE.IsWeapon(roundActorInfo) then
          local hp = 0
          if roundActorInfo.dynamicAttrs ~= nil and roundActorInfo.dynamicAttrs[PB.enum.AttrType.Hp] ~= nil then
            local baseTotalHp = getActorBaseAttr(roundActorInfo, PB.enum.AttrType.Hp)
            local percent = 1
            if baseTotalHp ~= 0 then
              percent = math.min(1, roundActorInfo.baseHp / baseTotalHp)
            end
            local result_val = roundActorInfo.dynamicAttrs[PB.enum.AttrType.Hp].value
            local pVal = result_val * percent
            if roundActorInfo.isAssist then
              hp = math.floor(pVal)
            else
              hp = math.ceil(pVal)
            end
            if 0 < result_val then
              hp = math.max(hp, 1)
            end
          end
          teamInfo.statistic.recordHpList[roundActorInfo.baseSeat] = hp
        end
      end
    end
  end
end

function TS.totalDamage(teamInfo, val)
  if val < 0 then
    teamInfo.statistic.totalDamage = teamInfo.statistic.totalDamage - val
  end
end

function TS.damageList(teamInfo, attack, damage)
  for j = 1, #teamInfo.playerList do
    local playerID = teamInfo.playerList[j].playerId
    local actorList = teamInfo.playerList[j].actorList
    for k = 1, #actorList do
      if actorList[k].uniqueID == attack.uniqueID then
        local addInfo
        if teamInfo.statistic.damageList ~= nil then
          for f = 1, #teamInfo.statistic.damageList do
            if teamInfo.statistic.damageList[f].playerId == playerID then
              addInfo = teamInfo.statistic.damageList[f]
              break
            end
          end
        end
        if addInfo == nil then
          addInfo = {playerId = playerID, damage = 0}
          table.insert(teamInfo.statistic.damageList, addInfo)
        end
        addInfo.damage = addInfo.damage + damage
        return
      end
    end
  end
end

function TS.SpecialTriggerList(teamInfo, specialIndex, id, gameRound, uniqueId, position, talentFlag)
  local teamStatistic = teamInfo.statistic
  table.insert(teamStatistic.specialTriggerList, {
    gameRound = gameRound,
    special = specialIndex,
    ownerId = id,
    uniqueId = uniqueId,
    weaponPosition = position,
    talentFlag = talentFlag
  })
end

return TS
