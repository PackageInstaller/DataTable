local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local TLog = require("Common/TlogUtil")
local SA = require("Logic/SpecialAttrLogic")
local DEFINE = require("Logic/Define")
local TS = require("Logic/Statistic")

function roundEnd(param, activeData)
  if FH.isGameOver(activeData) then
    activeData.roundStart = false
    return activeData
  end
  if activeData.gameStart == false or activeData.gameStart == nil then
    warning("GamePlay", "ERROR - round end run here?")
    return activeData
  end
  info("GamePlay", "lua - roundEnd")
  local id = param.playerId
  local fightData = activeData
  local loadList = fightData.loadList
  for i = 1, #loadList do
    if loadList[i].playerId == id then
      if loadList[i].round ~= fightData.roundIndex then
        loadList[i].round = fightData.roundIndex
        break
      end
      loadList[i].round = -1
      break
    end
  end
  local loadEnd = true
  if FH.isMultiPlayerMode(fightData) then
    for i = 1, #loadList do
      if loadList[i].round ~= fightData.roundIndex then
        loadEnd = false
        break
      end
    end
  end
  fightData.roundStart = loadEnd
  if loadEnd then
    fightData.roundIndex = fightData.roundIndex + 1
    fightData.roundState = 0
    local need_change = true
    if fightData.curSupportActor ~= 0 then
      need_change = false
    end
    if need_change then
      changeRoundOrTeam(fightData)
    else
      FH.refreshTeamEnergy(fightData.teamList)
      TS.recordHpList(fightData.teamList)
      TLog.CollectHp({
        action = "start or end",
        win = fightData.winTeam,
        allTeam = fightData.teamList
      })
      TLog.CollectEnergy({
        action = "end",
        win = fightData.winTeam,
        allTeam = fightData.teamList
      })
    end
    fightData.curSupportActor = 0
    local teamList = fightData.teamList
    for i = 1, #teamList do
      local teamInfo = teamList[i]
      FH.refreshDeadAndLockCard(teamInfo)
      teamInfo.statistic.gameRound = fightData.gameRound
    end
  end
  return fightData
end

function changeRoundOrTeam(fightData)
  local roundChange = false
  local last_actor = fightData.sequenceActor
  local result_actor = FH.getNextActiveActor(fightData, fightData.sequenceActor)
  local cur_actor = result_actor[1]
  local result_list = FH.getActiveList(cur_actor, fightData)
  fightData.sequenceActor = cur_actor
  fightData.activeActorList = result_list[1]
  fightData.activeTeam = result_list[2]
  fightData.activePlayerID = FH.getActivePlayerID(fightData)
  local real_round = 1
  if cur_actor ~= 0 then
    local remove_table = {}
    local base_list = fightData.sequenceList
    local index = -1
    for i = 1, #base_list do
      if base_list[i].uid == last_actor then
        index = i
        break
      end
    end
    if index ~= -1 then
      local find_end = false
      for i = index, #base_list do
        if base_list[i].uid == cur_actor then
          find_end = true
          break
        elseif base_list[i].dead then
          table.insert(remove_table, base_list[i].uid)
        end
      end
      if not find_end then
        for i = 1, #base_list do
          if base_list[i].uid == cur_actor then
            find_end = true
            break
          elseif base_list[i].dead then
            table.insert(remove_table, base_list[i].uid)
          end
        end
      end
    end
    for i = 1, #remove_table do
      info("GamePlay", "lua - skip dead actor ----------------------------- " .. remove_table[i])
      FH.removeActorBuff(fightData.teamList, PB.enum.BuffEndPoint.AttackBegin, 0, remove_table[i], fightData.gameRound)
      FH.removeActorBuff(fightData.teamList, PB.enum.BuffEndPoint.WeaponUserBegin, 0, remove_table[i], fightData.gameRound)
      FH.removeActorBuff(fightData.teamList, PB.enum.BuffEndPoint.AttackEnd, 0, remove_table[i], fightData.gameRound)
      FH.removeActorBuff(fightData.teamList, PB.enum.BuffEndPoint.WeaponUserEnd, 0, remove_table[i], fightData.gameRound)
    end
    real_round = real_round + #remove_table
  end
  if fightData.gameRound == 0 then
    roundChange = true
  else
    roundChange = result_actor[2]
  end
  if roundChange then
    fightData.gameRound = fightData.gameRound + 1
  end
  local teamList = fightData.teamList
  local activeTeam = fightData.activeTeam
  local gameround = fightData.gameRound
  local teamInfo1 = FH.getTeamInfo(teamList, 1)
  local teamInfo2 = FH.getTeamInfo(teamList, 2)
  if teamInfo1 ~= nil and teamInfo2 ~= nil then
    local defineParams = DEFINE.GetDefineParams(fightData.stageID)
    FH.addTeamEnergy(1, teamInfo1, defineParams.addMp * real_round, defineParams.maxMp, -1, 1)
    FH.addTeamEnergy(2, teamInfo1, defineParams.addSp * real_round, defineParams.maxSp, -1, 1)
    FH.addTeamEnergy(1, teamInfo2, defineParams.addMp * real_round, defineParams.maxMp, -1, 1)
    FH.addTeamEnergy(2, teamInfo2, defineParams.addSp * real_round, defineParams.maxSp, -1, 1)
    if roundChange then
      FH.addTeamEnergy(1, teamInfo1, defineParams.roundMp, defineParams.maxMp, -1, 1)
      FH.addTeamEnergy(2, teamInfo1, defineParams.roundSp, defineParams.maxSp, -1, 1)
      FH.addTeamEnergy(1, teamInfo2, defineParams.roundMp, defineParams.maxMp, -1, 1)
      FH.addTeamEnergy(2, teamInfo2, defineParams.roundSp, defineParams.maxSp, -1, 1)
      teamInfo1.weaponUseCount = defineParams.WeaponUseCountLimit
      teamInfo2.weaponUseCount = defineParams.WeaponUseCountLimit
    end
    local activeSeat = -1
    if activeTeam == 1 then
      local actor = FH.getActorByUid(teamInfo1, cur_actor)
      if actor then
        FH.addWeaponEnergy(teamInfo1, actor.baseSeat)
        if FH.isSelfEnergy(teamInfo1.dungeonType) then
          activeSeat = actor.baseSeat
        end
      end
      FH.addTeamEnergy(1, teamInfo1, FH.getRoundMpChange(teamInfo1, cur_actor), defineParams.maxMp, activeSeat, 1)
    end
    if activeTeam == 2 then
      local actor = FH.getActorByUid(teamInfo2, cur_actor)
      if actor then
        FH.addWeaponEnergy(teamInfo2, actor.baseSeat)
        if FH.isSelfEnergy(teamInfo2.dungeonType) then
          activeSeat = actor.baseSeat
        end
      end
      FH.addTeamEnergy(1, teamInfo2, FH.getRoundMpChange(teamInfo2, cur_actor), defineParams.maxMp, activeSeat, 1)
    end
  end
  local cardInfo = {
    num = 0,
    isLinkSkill = false,
    isBigSkill = false,
    isAssistSkill = false
  }
  local actionParam = {
    gameround,
    cardInfo,
    0,
    0,
    0,
    0,
    0,
    0,
    {},
    0,
    0,
    0,
    0,
    nil
  }
  if roundChange then
    local otherTeam = 1
    if activeTeam == 1 then
      otherTeam = 2
    end
    local targetList1 = FH.getTeamActors(teamList, activeTeam)
    local activeTeamInfo1 = FH.getTeamInfo(teamList, activeTeam)
    for i = 1, #targetList1 do
      local energyVal = FH.getCurEnergy(activeTeamInfo1, fightData.dungeonType, targetList1[i].uniqueID)
      actionParam[6] = energyVal[1]
      actionParam[7] = energyVal[2]
      SA.SpecialAttrLogic(targetList1[i], PB.enum.IdentityCategory.SelfTeam, {}, teamList, PB.enum.Timing.RoundNumberChangeFront, actionParam)
      SA.SpecialAttrLogic(targetList1[i], PB.enum.IdentityCategory.TargetTeam, {}, teamList, PB.enum.Timing.RoundNumberChangeFront, actionParam)
    end
    local targetList2 = FH.getTeamActors(teamList, otherTeam)
    local otherTeamInfo2 = FH.getTeamInfo(teamList, otherTeam)
    for i = 1, #targetList2 do
      local energyVal = FH.getCurEnergy(otherTeamInfo2, fightData.dungeonType, targetList2[i].uniqueID)
      actionParam[6] = energyVal[1]
      actionParam[7] = energyVal[2]
      SA.SpecialAttrLogic(targetList2[i], PB.enum.IdentityCategory.SelfTeam, {}, teamList, PB.enum.Timing.RoundNumberChangeFront, actionParam)
      SA.SpecialAttrLogic(targetList2[i], PB.enum.IdentityCategory.TargetTeam, {}, teamList, PB.enum.Timing.RoundNumberChangeFront, actionParam)
    end
  end
  FH.refreshHpChangeBuff(teamList, activeTeam, cur_actor, PB.enum.BuffFightType.HpChange)
  if roundChange then
    SA.SpecialRoundNumberChange(teamList, activeTeam, actionParam, fightData.dungeonType)
  end
  local targetList = FH.getTeamActors(teamList, activeTeam)
  local activeTeamInfo = FH.getTeamInfo(teamList, activeTeam)
  for i = 1, #targetList do
    if targetList[i].uniqueID == cur_actor then
      local energyVal = FH.getCurEnergy(activeTeamInfo, fightData.dungeonType, cur_actor)
      actionParam[6] = energyVal[1]
      actionParam[7] = energyVal[2]
      SA.SpecialAttrLogic(targetList[i], PB.enum.IdentityCategory.SelfTeam, {}, teamList, PB.enum.Timing.RoundTeamStart, actionParam)
    end
  end
  local triggerInfo = {}
  table.append(triggerInfo, FH.removeActorBuff(teamList, PB.enum.BuffEndPoint.TargetBegin, activeTeam, fightData.sequenceActor, gameround))
  table.append(triggerInfo, FH.removeActorBuff(teamList, PB.enum.BuffEndPoint.AttackBegin, 0, fightData.sequenceActor, gameround))
  table.append(triggerInfo, FH.removeActorBuff(teamList, PB.enum.BuffEndPoint.WeaponUserBegin, 0, fightData.sequenceActor, gameround))
  if roundChange and fightData.nextDungeonId ~= 0 then
    local missingUniqueId = {
      101,
      102,
      103,
      201,
      202,
      203
    }
    for i = #missingUniqueId, 1, -1 do
      local found = table.find(fightData.sequenceList, function(_, v)
        return v.uid == missingUniqueId[i]
      end)
      if found then
        table.remove(missingUniqueId, i)
      end
    end
    for i = 1, #missingUniqueId do
      table.append(triggerInfo, FH.removeActorBuff(fightData.teamList, PB.enum.BuffEndPoint.AttackBegin, 0, missingUniqueId[i], gameround))
      table.append(triggerInfo, FH.removeActorBuff(fightData.teamList, PB.enum.BuffEndPoint.WeaponUserBegin, 0, missingUniqueId[i], gameround))
      table.append(triggerInfo, FH.removeActorBuff(fightData.teamList, PB.enum.BuffEndPoint.AttackEnd, 0, missingUniqueId[i], gameround))
      table.append(triggerInfo, FH.removeActorBuff(fightData.teamList, PB.enum.BuffEndPoint.WeaponUserEnd, 0, missingUniqueId[i], gameround))
    end
  end
  SA.TriggerEachSpecialAttr(triggerInfo, teamList, actionParam)
  if teamInfo1 ~= nil and teamInfo2 ~= nil then
    local result1 = FH.checkGameOver(fightData, teamInfo1, teamInfo2, gameround)
    local result2 = FH.checkGameOver(fightData, teamInfo2, teamInfo1, gameround)
    if (result1 ~= 0 or result2 ~= 0) and fightData.nextDungeonId ~= 0 then
      actionParam[1] = actionParam[1] + 1
      SA.SpecialRoundNumberChange(teamList, activeTeam, actionParam, fightData.dungeonType)
    end
  end
  FH.refreshTeamEnergy(teamList)
  TS.recordHpList(teamList)
  TLog.CollectHp({
    action = "start or end",
    win = fightData.winTeam,
    allTeam = teamList
  })
  TLog.CollectEnergy({
    action = "end",
    win = fightData.winTeam,
    allTeam = teamList
  })
end

return roundEnd
