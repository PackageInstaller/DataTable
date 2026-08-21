local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local DEFINE = require("Logic/Define")
local TLog = require("Common/TlogUtil")
local CombatDataRecorder = require("Logic/CombatDataRecorder")
local HP_INDEX = PB.enum.AttrType.Hp
local ATTR_MAX = PB.enum.AttrType.Max

function initGame(initGameInput, activeData)
  if activeData.init then
    return activeData
  end
  if FH.isGameOver(activeData) then
    info("GamePlay", "game is over, can not process logic")
    return activeData
  end
  activeData.init = true
  info("GamePlay", "lua - initGame stageID = " .. initGameInput.stageID)
  PB.all("ActionDamage")
  PB.all("DamageIndex")
  PB.all("DamageIndexMonster")
  PB.all("SkillHit")
  PB.all("SkillHitIndex")
  PB.all("BuffData")
  PB.all("BuffIndex")
  PB.all("SpecialAttrInfo")
  PB.all("SpecialLevelUpIndex")
  PB.all("ActionBuff")
  PB.all("ActorLink")
  PB.all("ActorCombo")
  PB.all("ActorConfig")
  PB.all("DungeonModeIndex")
  local fightData = activeData
  local dungeonType = initGameInput.dungeonType
  local teamList = initGameInput.teamList
  local stageID = initGameInput.stageID
  local support = initGameInput.supportMode
  local dungeonInfo = PB.get("DungeonMonster", stageID)
  if dungeonInfo == nil then
    warning("GamePlay", "lua - init game no stage info " .. stageID)
    return fightData
  end
  local seed = initGameInput.randomSeed
  if seed == 0 then
    seed = os.time()
  end
  fightData.initSeed = seed
  FH.setGlobalSeed(seed, seed + 1000, seed + 2000)
  fightData.dungeonType = dungeonType
  fightData.stageID = stageID
  fightData.supportMode = support
  fightData.curSupportActor = 0
  fightData.teamList = teamList
  fightData.playerCount = initGameInput.playerCount
  fightData.nextDungeonId = dungeonInfo.nextDungeonId
  fightData.gameRound = initGameInput.gameRound
  if fightData.nextDungeonId == 0 then
    TLog.ResetData()
  end
  local initParamList = getRecordParam(initGameInput.initList)
  local initHpList = initParamList[1]
  buildActorFromData(teamList, {
    hpList = initHpList,
    buffList = initParamList.buffList
  }, dungeonType)
  buildActorFromTable(teamList, initHpList, dungeonType, stageID, dungeonInfo)
  initDynamicAttrs(teamList)
  InitWeaponDynamicTalent(teamList, initParamList.energyWPList)
  initAffix(teamList, dungeonType, stageID, dungeonInfo, initGameInput.initList)
  local buffAffix = initGameInput.fightBuffs
  for b = 1, #buffAffix do
    local fightBuff = PB.get("FightBuff", buffAffix[b])
    if fightBuff ~= nil then
      AppendDungeonAffix(teamList, fightBuff)
    else
      warning("GamePlay", "error fight buff id = " .. buffAffix[b])
    end
  end
  fightData.loadList = getLoadList(teamList)
  initFightLink(teamList)
  fightData.sequenceList = initFightSequence(dungeonInfo.firstTeam, initGameInput.debugMode, dungeonType, teamList, initGameInput.testActor)
  fightData.activeActorList = {}
  fightData.guideType = initGameInput.guideType
  initPreHpList(teamList, initHpList)
  local initCardInput = {
    mpList = initParamList.mpList,
    spList = initParamList.spList,
    allCardUseCount = initParamList.allCardUseCount
  }
  initCard(teamList, dungeonType, stageID, initCardInput)
  initPreSAndLinkCard(teamList)
  initWinCondition(teamList, dungeonType, stageID)
  FH.fixGameSeat(teamList)
  TLog.CollectOrder(fightData.sequenceList)
  CombatDataRecorder.reset()
  info("GamePlay", "lua - playerList Count = " .. #fightData.loadList)
  return fightData
end

function getRecordParam(initList)
  local result = {}
  local mpList = {}
  local spList = {}
  local buffList = {}
  local allCardUseCount = {}
  local energyWPList = {}
  for team = 1, 2 do
    local mp = -1
    local sp = -1
    local oneHpList = {}
    local oneData = initList[team] or {}
    for seat = 1, DEFINE.ACTOR_NUM do
      local hp = 0
      local monsterID = 0
      if oneData.hpList ~= nil then
        hp = oneData.hpList[seat] or 0
      end
      if oneData.monsterList ~= nil then
        monsterID = oneData.monsterList[seat] or 0
      end
      table.insert(oneHpList, {hp, monsterID})
    end
    table.insert(result, oneHpList)
    if oneData ~= nil then
      if oneData.recordMp ~= nil then
        mp = oneData.recordMp
      end
      if oneData.recordSp ~= nil then
        sp = oneData.recordSp
      end
    end
    table.insert(mpList, mp)
    table.insert(spList, sp)
    table.insert(buffList, oneData.recordBuffs or {})
    table.insert(allCardUseCount, oneData.allCardUseCount or {})
    table.insert(energyWPList, oneData.energyWPList or {})
  end
  return {
    result,
    mpList = mpList,
    spList = spList,
    buffList = buffList,
    allCardUseCount = allCardUseCount,
    energyWPList = energyWPList
  }
end

function initFightSequence(firstTeam, debugMode, dungeonType, teamList, testActor)
  if dungeonType == PB.enum.DungeonType.None then
    firstTeam = debugMode
  end
  local sort_list = {}
  for i = 1, #teamList do
    local list = teamList[i].playerList
    local team = teamList[i].team
    for j = 1, #list do
      local actorList = list[j].actorList
      for p = 1, #actorList do
        local actor = actorList[p]
        local actorID = actor.actorInfo.id
        if actorID ~= nil and actorID ~= 0 then
          if not actor.isAssist then
            local random_speed = actor.dynamicAttrs[PB.enum.AttrType.Speed].value
            if firstTeam ~= 0 then
              if firstTeam == team then
                random_speed = 20000 - actor.uniqueID
              else
                random_speed = 10000 - actor.uniqueID
              end
            end
            local insert_pos = #sort_list + 1
            for s = 1, #sort_list do
              if random_speed > sort_list[s].speed then
                insert_pos = s
                break
              elseif random_speed == sort_list[s].speed then
                if FH.getRandom(1, 2) == 1 then
                  insert_pos = s + 1
                  break
                end
                insert_pos = s + 1
                break
              end
            end
            table.insert(sort_list, insert_pos, {sort_actor = actor, speed = random_speed})
          else
            for s = 1, #sort_list do
              if sort_list[s].sort_actor.team == actor.team and sort_list[s].sort_actor.baseSeat + 3 == actor.baseSeat then
                sort_list[s].link_actor = actor
                break
              end
            end
          end
        end
      end
    end
  end
  local sequence_list = {}
  for i = 1, #sort_list do
    local actor = sort_list[i].sort_actor
    local enable_insert = true
    if testActor ~= nil and testActor ~= 0 then
      local link_actor = sort_list[i].link_actor
      if actor.actorInfo.id == testActor or actor.actorInfo.uniqueWeaponId == testActor then
        enable_insert = true
      elseif link_actor ~= nil and link_actor.actorInfo.id == testActor then
        enable_insert = true
      else
        enable_insert = false
      end
    end
    if enable_insert then
      actor.sequence = i
      table.insert(sequence_list, {
        uid = actor.uniqueID,
        dead = false
      })
    end
  end
  return sequence_list
end

function initFightLink(teamList)
  for i = 1, #teamList do
    local list = teamList[i].playerList
    local team = teamList[i].team
    local link_list = {}
    for j = 1, #list do
      local actorList = list[j].actorList
      for p = 1, #actorList do
        local actor = actorList[p]
        local actorID = actor.actorInfo.id
        if actorID ~= nil and actorID ~= 0 then
          if not actor.isAssist then
            link_list[actor.baseSeat] = {main = actor}
          elseif link_list[actor.baseSeat - 3] ~= nil then
            link_list[actor.baseSeat - 3].assist = actor
          elseif link_list[actor.baseSeat - 6] ~= nil then
            link_list[actor.baseSeat - 6].support = actor
          end
        end
      end
    end
    teamList[i].activeList = {}
    teamList[i].linkInfoList = {}
    for k, v in pairs(link_list) do
      local actor_main = v.main
      local actor_assist = v.assist
      local actor_support = v.support
      local id_table = {
        actor_main.actorInfo.id
      }
      local uid_table = {
        actor_main.uniqueID
      }
      local star_val = actor_main.actorInfo.star
      if star_val == nil or star_val == 0 then
        star_val = 1
      end
      local link = 0
      if actor_assist ~= nil then
        local star_val2 = actor_assist.actorInfo.star
        if star_val2 == nil or star_val2 == 0 then
          star_val2 = 1
        end
        star_val = star_val + star_val2
        table.insert(id_table, actor_assist.actorInfo.id)
        table.insert(uid_table, actor_assist.uniqueID)
        link = getLinkID(id_table)
        for m = 1, ATTR_MAX - 1 do
          local attr_base = getBaseAttr(actor_main, m)
          local attr_link = getBaseAttr(actor_assist, m)
          if attr_link ~= nil then
            if attr_base ~= nil then
              attr_base.value = attr_base.value + attr_link.value
            else
              attr_base = {
                type = m,
                value = attr_link.value
              }
              table.insert(actor_main.actorInfo.attrs, attr_base)
            end
          end
          local newAttr = actor_main.dynamicAttrs[m]
          if attr_base ~= nil then
            newAttr.value = attr_base.value
          end
        end
        actor_assist.dynamicAttrs = actor_main.dynamicAttrs
        actor_assist.actorInfo.attrs = actor_main.actorInfo.attrs
        actor_assist.buffList = actor_main.buffList
      end
      if actor_support ~= nil then
        actor_support.dynamicAttrs = actor_main.dynamicAttrs
        actor_support.actorInfo.attrs = actor_main.actorInfo.attrs
        actor_support.buffList = actor_main.buffList
      end
      local new_link = {
        linkID = link,
        ownerSeat = actor_main.baseSeat,
        actorList = id_table,
        uidList = uid_table,
        totalStar = math.max(2, star_val) - 1,
        mpVal = 0,
        spVal = 0
      }
      table.insert(teamList[i].linkInfoList, new_link)
      if 0 < link then
        addActorLinkSpecial(actor_main, link, new_link.totalStar)
        addActorLinkSpecial(actor_assist, link, new_link.totalStar)
      end
    end
  end
end

function getBaseAttr(actor, index)
  for m = 1, #actor.actorInfo.attrs do
    local attr = actor.actorInfo.attrs[m]
    if attr.type == index then
      return attr
    end
  end
  return nil
end

function getLinkID(actorIDList)
  local data = PB.all("ActorLink")
  for i = 1, #data do
    local info = data[i]
    local infoCount = #info.link
    if infoCount == #actorIDList then
      local total = infoCount
      for j = 1, infoCount do
        for k = 1, #actorIDList do
          if info.link[j].actorID == actorIDList[k] then
            total = total - 1
            break
          end
        end
      end
      if total == 0 then
        return info.linkID
      end
    end
  end
  return 0
end

function initPreSAndLinkCard(teamList)
  for i = 1, #teamList do
    local list = teamList[i].playerList
    local team = teamList[i].team
    local link_list = teamList[i].linkInfoList
    for l = 1, #link_list do
      if link_list[l].linkID > 0 then
        local link_tag = DEFINE.GenRoundCardInfoIndex(team, link_list[l].ownerSeat, 2, 0)
        table.insert(teamList[i].preCardQueue, link_tag)
      end
    end
    for j = 1, #list do
      local actorList = list[j].actorList
      for p = 1, #actorList do
        local actor = actorList[p]
        local actorID = actor.actorInfo.id
        if actorID ~= nil and actorID ~= 0 then
          local s_tag = DEFINE.GenRoundCardInfoIndex(team, actor.seat, 1, 0)
          local sCount = FH.getActorSCardCount(actor)
          for s = 1, sCount do
            table.insert(teamList[i].preCardQueue, s_tag)
          end
          local normal_tag = DEFINE.GenRoundCardInfoIndex(team, actor.seat, 0, 0)
          local count = FH.getComboNum(actorID, false)
          for c = 1, count do
            table.insert(teamList[i].preCardQueue, normal_tag)
          end
        end
      end
    end
  end
end

function buildActorFromData(teamList, initInfo, dungeonType)
  local developMode = dungeonType == PB.enum.DungeonType.None
  local initHpList = initInfo.hpList
  local initBuffList = initInfo.buffList
  local check_actor = DEFINE.ACTOR_NUM
  for k = 1, #teamList do
    local list = teamList[k].playerList
    local actorCount = 0
    for j = 1, #list do
      actorCount = actorCount + #list[j].actorList
    end
    if actorCount ~= check_actor then
      if actorCount ~= 0 then
        warning("GamePlay", "ERROR ACTOR COUNT = " .. actorCount)
      end
      for l = 1, #list do
        list[l].actorList = {}
      end
    end
  end
  for k = 1, #teamList do
    local team = teamList[k].team
    local list = teamList[k].playerList
    for j = 1, #list do
      local roundPlayerInfo = list[j]
      local player_id = roundPlayerInfo.playerId
      local mainWeapons = {}
      for a = 1, #roundPlayerInfo.actorList do
        local newActor = roundPlayerInfo.actorList[a]
        local seat = newActor.seat
        if seat == nil or seat < 1 or newActor.actorInfo == nil then
          warning("GamePlay", "error actor")
          newActor.actorInfo = {}
          newActor.actorInfo.id = 0
        elseif initHpList[team][seat][1] < 0 then
          newActor.actorInfo.id = 0
        end
        local id = newActor.actorInfo.id
        local weapon = setActorDataImpl(newActor, id, seat, team)
        if developMode or string.find(player_id, "TestPlayer") ~= nil then
          weapon = setActorTableImpl(newActor, id, 999)
        end
        if seat and 1 <= seat then
          local teamBuffList = initBuffList[team] or {}
          local actorBuffs = teamBuffList[seat] or {}
          for bi = 1, #actorBuffs do
            local buff = actorBuffs[bi]
            newActor.buffList = newActor.buffList or {}
            table.insert(newActor.buffList, buff)
          end
        end
        if weapon and 0 < weapon.actorInfo.id then
          table.insert(mainWeapons, weapon)
        end
      end
      table.append(roundPlayerInfo.actorList, mainWeapons)
    end
  end
end

function buildActorFromTable(teamList, initHpList, dungeonType, stageID, dungeonInfo)
  local playerID = "fci_none_" .. dungeonType
  if FH.isDungeonSelfMonster(dungeonType) then
    for i = 1, #teamList do
      local teamInfo = teamList[i]
      for j = 1, #teamInfo.playerList do
        playerID = teamInfo.playerList[j].playerId
        break
      end
    end
    table.remove(teamList, 1)
    local storyInfo = PB.get("StoryDungeon", stageID)
    if storyInfo == nil then
      warning("GamePlay", "story mode not have monster, stageID = " .. stageID)
      storyInfo = dungeonInfo
    end
    createDungeonActor(playerID, DEFINE.TEAM1, false, storyInfo, teamList, initHpList, dungeonType)
  end
  if FH.isDungeonPVE(dungeonType) and #teamList < 2 then
    createDungeonActor("fci_ai_monster_" .. dungeonType, DEFINE.TEAM2, true, dungeonInfo, teamList, initHpList, dungeonType)
  end
  if FH.getTeamInfo(teamList, 1) == nil then
    warning("GamePlay", "not have team 1, fixed")
    createDungeonActor(playerID .. "_fixed1", DEFINE.TEAM1, false, nil, teamList, initHpList, dungeonType)
  end
  if FH.getTeamInfo(teamList, 2) == nil then
    warning("GamePlay", "not have team 2, fixed")
    createDungeonActor(playerID .. "_fixed2", DEFINE.TEAM2, false, nil, teamList, initHpList, dungeonType)
  end
end

function createDungeonActor(playerID, team, ai, dungeonMonster, teamList, initHpList, dungeonType)
  local new_team = {}
  new_team.team = team
  local new_player = {}
  new_player.playerId = playerID
  new_player.actorList = {}
  local mainWeapons = {}
  for seat = 1, DEFINE.ACTOR_NUM do
    local newActor = {}
    local weapon
    newActor.actorInfo = {}
    if dungeonMonster and dungeonMonster.dungeonId == 3101 then
      if seat == 1 then
        newActor.actorInfo.uniqueWeaponId = 3006
        newActor.actorInfo.uniqueWeaponPhase = 1
      elseif seat == 2 then
        newActor.actorInfo.uniqueWeaponId = 3005
        newActor.actorInfo.uniqueWeaponPhase = 1
      end
    end
    if dungeonMonster ~= nil and initHpList[team][seat][1] >= 0 then
      local monster_id = dungeonMonster.monsterId[seat]
      if initHpList[team][seat][2] ~= nil and initHpList[team][seat][2] > 0 then
        monster_id = initHpList[team][seat][2]
      end
      weapon = setActorDataImpl(newActor, monster_id, seat, team)
      weapon = setActorTableImpl(newActor, monster_id, dungeonMonster.level[seat], dungeonMonster.levelUpIndex[seat], dungeonType)
    else
      newActor.actorInfo.id = 0
      newActor.baseSeat = seat
    end
    table.insert(new_player.actorList, newActor)
    table.insert(mainWeapons, weapon)
  end
  table.append(new_player.actorList, mainWeapons)
  new_team.playerList = {}
  table.insert(new_team.playerList, new_player)
  table.insert(teamList, new_team)
end

function setActorDataImpl(roundActorInfo, targetId, seat, team)
  local closeID = 0
  local actorConfig = PB.get("ActorConfig", targetId)
  if actorConfig then
    closeID = actorConfig.close
  end
  local buffIndex = 0
  local specialIndex = 0
  local actorID = targetId
  local monsterInfo = PB.get("MonsterInfo", targetId)
  if monsterInfo ~= nil then
    actorID = monsterInfo.actorID
    closeID = monsterInfo.closeID
    buffIndex = monsterInfo.buffIndex
    specialIndex = monsterInfo.specialIndex
  end
  local actorInfo = roundActorInfo.actorInfo
  if actorInfo.uid ~= nil and actorInfo.uid ~= 0 and actorInfo.actorSkin ~= nil and actorInfo.actorSkin ~= 0 then
    closeID = FH.getActorClose(actorID, actorInfo.actorSkin)
  end
  roundActorInfo.closeID = closeID
  roundActorInfo.buffIndex = buffIndex
  roundActorInfo.specialIndex = specialIndex
  roundActorInfo.seat = seat
  roundActorInfo.baseSeat = seat
  roundActorInfo.team = team
  roundActorInfo.uniqueID = DEFINE.GenRoundActorInfoUniqueId(team, seat)
  roundActorInfo.lastUseCard = 0
  local assist = false
  if seat > DEFINE.HALF_ACTOR_NUM then
    assist = true
  end
  roundActorInfo.isAssist = assist
  roundActorInfo.lock = false
  roundActorInfo.hpChangeList = {}
  roundActorInfo.hpOnceChange = {}
  roundActorInfo.energyWp = 0
  roundActorInfo.buffAction = {type = 0, refCount = 0}
  roundActorInfo.dynamicTalent = {}
  local talentList = FH.GenDynamicTalentList(actorInfo.talentInfo, {
    nameSpecial = "talentId",
    nameLv = "talentValue",
    talentFlag = DEFINE.TalentFlagDEF.Actor
  })
  table.append(roundActorInfo.dynamicTalent, talentList)
  local specialList = FH.GenDynamicTalentList(actorInfo.specialAttrIds, {
    talentFlag = DEFINE.TalentFlagDEF.Actor
  })
  table.append(roundActorInfo.dynamicTalent, specialList)
  actorInfo.bodyEquips = {}
  actorInfo.equipAttrs = {}
  actorInfo.specialAttrIds = {}
  actorInfo.talentInfo = {}
  actorInfo.groupTag = {}
  actorInfo.talentResetInfo = {}
  return CreateWeaponInfo(roundActorInfo)
end

function CreateWeaponInfo(roundActorInfo)
  local weapon
  if not roundActorInfo.isAssist and roundActorInfo.actorInfo.uniqueWeaponId and roundActorInfo.actorInfo.uniqueWeaponId > 0 then
    weapon = {}
    table.copy(roundActorInfo, weapon, true)
    weapon.actorInfo.id = weapon.actorInfo.uniqueWeaponId
    local seat = weapon.baseSeat + DEFINE.ACTOR_NUM
    weapon.seat = seat
    weapon.baseSeat = seat
    weapon.uniqueID = DEFINE.GenRoundActorInfoUniqueId(weapon.team, seat)
    weapon.isAssist = true
    weapon.dynamicTalent = {}
  end
  return weapon
end

function setActorTableImpl(roundActorInfo, monsterID, level, upIndex, dungeonType)
  local monsterInfo = PB.get("MonsterInfo", monsterID)
  local actorID = monsterID
  local talent_level = level
  if monsterInfo ~= nil then
    actorID = monsterInfo.actorID
    talent_level = 60
  end
  local actorConfig = PB.get("ActorConfig", actorID)
  if actorConfig == nil then
    if monsterID ~= nil and monsterID ~= 0 and monsterInfo == nil then
      warning("GamePlay", "not find monsterID = " .. monsterID)
    end
    actorID = 0
    monsterID = 0
  end
  local actorInfo = roundActorInfo.actorInfo
  actorInfo.uid = 0
  actorInfo.id = actorID
  actorInfo.star = 1
  actorInfo.level = talent_level
  if monsterID ~= 0 then
    actorInfo.attrs = {}
    for i = 1, ATTR_MAX - 1 do
      local newAttr = {}
      newAttr.type = i
      newAttr.value = 0
      table.insert(actorInfo.attrs, newAttr)
    end
    local attrsInfo, indexInfo
    if monsterInfo ~= nil then
      local index = monsterInfo.levelUpIndex
      if upIndex ~= nil and upIndex ~= 0 then
        index = upIndex
      end
      indexInfo = PB.get("MonsterLevelUpIndex", index)
      if indexInfo == nil then
        warning("GamePlay", "not find level up index = " .. index .. " monsterID = " .. monsterID)
      end
      local baseInfo = PB.get("MonsterLevelUpBase", level)
      if baseInfo ~= nil then
        attrsInfo = baseInfo.attrs
      end
      local monsterSpeList = FH.GenDynamicTalentList(monsterInfo.special, {
        nameSpecial = "talentId",
        nameLv = "talentValue",
        talentFlag = DEFINE.TalentFlagDEF.Actor,
        index = 0
      })
      table.append(roundActorInfo.dynamicTalent, monsterSpeList)
      local testTeam = false
      if roundActorInfo.team == 1 and not FH.isDungeonSelfMonster(dungeonType) then
        testTeam = true
      end
      local actor_base_info = PB.get("ActorInfo", monsterInfo.actorID, 1)
      local kind = PB.get("ActorConfig", monsterInfo.actorID).kind
      if actor_base_info ~= nil then
        for k = 1, #actor_base_info.attrs do
          if actor_base_info.attrs[k].type == PB.enum.AttrType.Speed then
            local speed_rate = 2
            if testTeam then
              speed_rate = 1
            elseif kind ~= 1 then
              speed_rate = 0
            end
            actorInfo.attrs[PB.enum.AttrType.Speed].value = actor_base_info.attrs[k].value * speed_rate
            break
          end
        end
      end
    else
      local actor_base_info = PB.get("ActorInfo", monsterID, 1)
      if actor_base_info ~= nil then
        attrsInfo = actor_base_info.attrs
      end
    end
    if attrsInfo ~= nil then
      for i = 1, #attrsInfo do
        local attrs = attrsInfo[i]
        local rate = 1
        if indexInfo ~= nil then
          for j = 1, #indexInfo.attrs do
            if indexInfo.attrs[j].type == attrs.type then
              rate = indexInfo.attrs[j].value / 10000
              break
            end
          end
        end
        local attr = actorInfo.attrs[attrs.type]
        if attr then
          attr.value = math.floor(attrs.value * rate)
        else
          error("GamePlay", "cannot find actionInfo.Attrs by attr.type: " .. attrs.type)
        end
      end
    else
      warning("GamePlay", "not find any attts at monsterID = " .. monsterID .. " level = " .. level)
    end
  end
  actorInfo.skills = {}
  if actorID ~= 0 and not DEFINE.IsWeapon(roundActorInfo) then
    local data = PB.all("ActorSkill")
    for i = 1, #data do
      local skill_info = data[i]
      if skill_info.actorId == actorID and not skill_info.isPassive then
        table.insert(actorInfo.skills, {
          id = skill_info.skillId,
          level = 1
        })
      end
    end
  end
  return CreateWeaponInfo(roundActorInfo)
end

function addActorLinkSpecial(actor, linkID, starVal)
  if actor == nil then
    return
  end
  local linkInfo = PB.get("ActorLink", linkID)
  if linkInfo == nil then
    return
  end
  local skillID = 0
  for i = 1, #linkInfo.link do
    if linkInfo.link[i].actorID == actor.actorInfo.id then
      skillID = linkInfo.link[i].skillID
      break
    end
  end
  if skillID == 0 then
    return
  end
  local find = false
  for j = 1, #actor.actorInfo.skills do
    if actor.actorInfo.skills[j].id == skillID then
      actor.actorInfo.skills[j].level = starVal
      find = true
      break
    end
  end
  if not find then
    table.insert(actor.actorInfo.skills, {id = skillID, level = starVal})
  end
  local source = {}
  for l = 1, #linkInfo.link do
    table.insert(source, linkInfo.link[l].skillID)
  end
  local skill_info = PB.get("ActorSkill", skillID)
  if skill_info ~= nil and not skill_info.isPassive and skill_info.isLink then
    local special = skill_info.specialIndex[actor.specialIndex + 1]
    if special ~= nil and special ~= 0 then
      local talent_info = {
        talentId = special,
        talentValue = starVal,
        talentFlag = DEFINE.TalentFlagDEF.Link,
        talentIndex = 0,
        talentSource = source
      }
      table.insert(actor.dynamicTalent, talent_info)
    end
  end
end

function initAffix(teamList, dungeonType, stageID, dungeonMonster, initList)
  if dungeonType == PB.enum.DungeonType.None then
    return
  end
  for a = 1, #dungeonMonster.team1Affix do
    local affix_info = PB.get("AffixInfo", dungeonMonster.team1Affix[a])
    local team1List = FH.getTeamActorsByKind(teamList, 1, affix_info.kind, true)
    for b = 1, #team1List do
      local new_talent = {
        talentId = affix_info.index,
        talentValue = affix_info.level,
        talentFlag = DEFINE.TalentFlagDEF.IgnoreShowId,
        talentIndex = 0
      }
      table.insert(team1List[b].dynamicTalent, new_talent)
    end
  end
  for a = 1, #dungeonMonster.team2Affix do
    local affix_info = PB.get("AffixInfo", dungeonMonster.team2Affix[a])
    local team2List = FH.getTeamActorsByKind(teamList, 2, affix_info.kind, true)
    for b = 1, #team2List do
      local new_talent = {
        talentId = affix_info.index,
        talentValue = affix_info.level,
        talentFlag = DEFINE.TalentFlagDEF.IgnoreShowId,
        talentIndex = 0
      }
      table.insert(team2List[b].dynamicTalent, new_talent)
    end
  end
  local actorTable = FH.getAllActors(teamList, false)
  for team = 1, #initList do
    local roundTeamInitData = initList[team]
    if roundTeamInitData then
      for baseSeat = 1, 3 do
        local affixList = roundTeamInitData["baseSeat" .. baseSeat .. "AffixList"] or {}
        if 0 < #affixList then
          for _, id in ipairs(affixList) do
            AppendAffixInfo(actorTable, team, baseSeat, id)
          end
        end
      end
    end
  end
  local dungeonAffix = PB.get("DungeonAffix", stageID)
  AppendDungeonAffix(teamList, dungeonAffix)
end

function AppendAffixInfo(actorTable, team, baseSeat, id)
  if id and 0 < id then
    local affixInfo = PB.get("AffixInfo", id)
    local result = {}
    for k = 1, #actorTable do
      local actor = actorTable[k]
      if actor.team == team then
        if actor.baseSeat == baseSeat then
          if affixInfo.kind == 1 or affixInfo.kind == 3 then
            table.insert(result, actor)
          end
        elseif actor.baseSeat - 3 == baseSeat and (affixInfo.kind == 2 or affixInfo.kind == 3) then
          table.insert(result, actor)
        end
      end
    end
    for b = 1, #result do
      local newTalent = {
        talentId = affixInfo.index,
        talentValue = affixInfo.level,
        talentFlag = DEFINE.TalentFlagDEF.IgnoreShowId,
        talentIndex = 0
      }
      table.insert(result[b].dynamicTalent, newTalent)
    end
  end
end

function AppendDungeonAffix(teamList, dungeonAffix)
  if dungeonAffix == nil then
    return
  end
  if #dungeonAffix.team1 == 3 and #dungeonAffix.team2 == 3 then
    local actorTable = FH.getAllActors(teamList, true)
    for a = 1, #dungeonAffix.team1 do
      for b = 1, #dungeonAffix.team1[a].affixList do
        local id = dungeonAffix.team1[a].affixList[b]
        AppendAffixInfo(actorTable, 1, a, id)
      end
    end
    for a = 1, #dungeonAffix.team2 do
      for b = 1, #dungeonAffix.team2[a].affixList do
        local id = dungeonAffix.team2[a].affixList[b]
        AppendAffixInfo(actorTable, 2, a, id)
      end
    end
  else
    warning("GamePlay", "ERROR DungeonAffix  ")
  end
end

function initDynamicAttrs(teamList)
  local function GetSource(actorId, skillId)
    local source
    
    local rows = PB.all("ActorCombo")
    for r = 1, #rows do
      if rows[r].actorId == actorId and rows[r].skillList[1] == skillId then
        source = rows[r].skillList
        break
      end
    end
    return source
  end
  
  local actorTable = FH.getAllActors(teamList, false)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    local actorInfo = actor.actorInfo
    actor.dynamicAttrs = {}
    actor.buffList = actor.buffList or {}
    for n = 1, ATTR_MAX - 1 do
      table.insert(actor.dynamicAttrs, {type = n, value = 0})
    end
    if not DEFINE.IsWeapon(actor) then
      local hp_attr
      for f = 1, #actorInfo.attrs do
        local attr = actorInfo.attrs[f]
        if attr.type == HP_INDEX then
          hp_attr = attr
          break
        end
      end
      local hp_error = false
      if hp_attr == nil then
        hp_error = true
        hp_attr = {
          type = HP_INDEX,
          value = DEFINE.FIX_HP
        }
        table.insert(actorInfo.attrs, hp_attr)
      elseif hp_attr.value == 0 then
        hp_attr.value = DEFINE.FIX_HP
        hp_error = true
      end
      if hp_error and not actor.isAssist then
        warning("GamePlay", "ERROR NO HP  " .. actorInfo.id)
      end
      actor.baseHp = hp_attr.value
      for m = 1, #actorInfo.attrs do
        local attr = actorInfo.attrs[m]
        local newAttr = actor.dynamicAttrs[attr.type]
        if newAttr ~= nil then
          newAttr.value = attr.value
        else
          error("GamePlay", "cannot find dynamicAttr by attr.type: " .. attr.type)
        end
      end
      for i = 1, #actorInfo.skills do
        local id = actorInfo.skills[i].id
        local level = actorInfo.skills[i].level
        local skill_info = PB.get("ActorSkill", id)
        if skill_info ~= nil then
          local special = skill_info.specialIndex[actor.specialIndex + 1]
          if special ~= nil and special ~= 0 and not skill_info.isLink then
            local talent_info = {
              talentId = special,
              talentValue = level,
              talentFlag = DEFINE.TalentFlagDEF.Common,
              talentIndex = 0
            }
            if skill_info.specialSelf == 1 and skill_info.displayIndex ~= nil and 0 < skill_info.displayIndex then
              talent_info.talentSource = GetSource(actorInfo.actorId, id)
            end
            table.insert(actor.dynamicTalent, talent_info)
          end
        else
          warning("GamePlay", "error skill id = " .. id)
        end
      end
    end
  end
end

function initPreHpList(teamList, initHpList)
  local actorTable = FH.getAllActors(teamList, false)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    if actor.team ~= nil and actor.team ~= 0 and actor.seat ~= nil and actor.seat ~= 0 then
      local teamHpList = initHpList[actor.team] or {}
      if teamHpList[actor.seat] then
        local initHp = teamHpList[actor.seat][1]
        if 0 < initHp and not actor.isAssist then
          local fixHp = initHp
          local linkHp = teamHpList[actor.seat + 3][1]
          if 0 < linkHp then
            fixHp = fixHp + linkHp
          end
          actor.dynamicAttrs[HP_INDEX].value = math.min(fixHp, FH.getActorBaseAttr(actor, HP_INDEX))
        end
      end
    end
  end
  TLog.CollectHpList(actorTable)
end

function getLoadList(teamList)
  local loadList = {}
  for i = 1, #teamList do
    local list = teamList[i].playerList
    for j = 1, #list do
      local loadInfo = {}
      loadInfo.playerId = list[j].playerId
      loadInfo.progress = 0
      loadInfo.round = -1
      table.insert(loadList, loadInfo)
    end
  end
  return loadList
end

function initCard(teamList, dungeonType, stageID, initInput)
  local defineParams = DEFINE.GetDefineParams(stageID)
  for i = 1, #teamList do
    teamList[i].statistic = {
      assistCount = 0,
      aliveCount = 0,
      initCount = 0,
      gameRound = 1,
      totalDamage = 0,
      deadInfo = {},
      linkIdList = {},
      bigSkillList = {},
      cardNumList = {},
      buffKindList = {},
      recordHpList = {},
      inputList = {},
      damageList = {},
      specialTriggerList = {}
    }
    teamList[i].allCardList = {}
    teamList[i].cardsInHand = {}
    teamList[i].cardsInStack = {}
    teamList[i].preCardQueue = {}
    teamList[i].winParam = {}
    teamList[i].stageParam = stageID
    teamList[i].dungeonType = dungeonType
    local initSp = defineParams.initSp
    local initMp = defineParams.initMp
    if 0 <= initInput.spList[i] then
      initSp = initInput.spList[i]
    end
    if 0 <= initInput.mpList[i] then
      initMp = initInput.mpList[i]
    end
    FH.setTeamEnergy(1, teamList[i], math.min(initMp, defineParams.maxMp), -1)
    FH.setTeamEnergy(2, teamList[i], math.min(initSp, defineParams.maxSp), -1)
    teamList[i].weaponUseCount = defineParams.WeaponUseCountLimit
    teamList[i].cardShowDelay = 0
    teamList[i].cardCountDown = 0
    teamList[i].cardCurIndex = 0
    teamList[i].cardState = 0
    teamList[i].useResult = 0
    teamList[i].hitKeyList = {}
    teamList[i].hitResultList = {}
    teamList[i].buffKeyList = {}
    teamList[i].buffResultList = {}
    teamList[i].useCardList = {}
    teamList[i].useActionList = {}
    teamList[i].useLinkID = 0
    teamList[i].useCard = 0
    teamList[i].useSCard = 0
    teamList[i].useActorList = {}
    teamList[i].useSupportActor = 0
    local list = teamList[i].playerList
    local team = teamList[i].team
    local link_list = teamList[i].linkInfoList
    local useCountRecord = initInput.allCardUseCount[team] or {}
    for j = 1, #list do
      local actorList = list[j].actorList
      for p = 1, #actorList do
        local roundActorInfo = actorList[p]
        local targetId = roundActorInfo.actorInfo.id
        if targetId ~= nil and targetId ~= 0 then
          local cardCount = 0
          local linkCardCount = 0
          local linkCardID = 0
          local weaponCount = 0
          local sCardCount = 0
          local assist = roundActorInfo.isAssist
          local isWeapon = DEFINE.IsWeapon(roundActorInfo)
          if assist then
            if isWeapon then
              weaponCount = 1
            else
              cardCount = DEFINE.CARD_NUM_ASSIST
              teamList[i].statistic.assistCount = teamList[i].statistic.assistCount + 1
            end
          else
            cardCount = DEFINE.CARD_NUM_MAIN
            sCardCount = FH.getActorSCardCount(roundActorInfo)
            teamList[i].statistic.aliveCount = teamList[i].statistic.aliveCount + 1
            teamList[i].statistic.initCount = teamList[i].statistic.initCount + 1
          end
          if not isWeapon then
            cardCount = FH.getComboNum(targetId, false)
            for l = 1, #link_list do
              if link_list[l].ownerSeat == roundActorInfo.baseSeat then
                linkCardID = link_list[l].linkID
                if 0 < linkCardID then
                  linkCardCount = 1
                end
                break
              end
            end
          end
          local allCardCount = cardCount + sCardCount + linkCardCount + weaponCount
          local n_skill_index = 0
          local s_skill_index = 0
          for k = 1, allCardCount do
            local newCard = {}
            newCard.sCard = false
            newCard.linkID = 0
            local skill_index = 0
            local s_flag = DEFINE.CardFlag.Normal
            local use_count = 99999
            local weaponPhase = 0
            local fireCount = 0
            local weaponPhase = 0
            local recordKey = ""
            if 0 < sCardCount then
              sCardCount = sCardCount - 1
              s_skill_index = s_skill_index + 1
              newCard.sCard = true
              s_flag = DEFINE.CardFlag.S
              fireCount = PB.get("ActorCombo", targetId, 0, s_skill_index).fireCount
              recordKey = tostring("s_" .. targetId .. s_skill_index)
              skill_index = s_skill_index
            elseif 0 < linkCardCount then
              linkCardCount = linkCardCount - 1
              newCard.linkID = linkCardID
              s_flag = DEFINE.CardFlag.Link
              fireCount = PB.get("ActorLink", linkCardID).fireCount
              recordKey = tostring("l_" .. linkCardID)
            elseif 0 < cardCount then
              cardCount = cardCount - 1
              n_skill_index = n_skill_index + 1
              fireCount = PB.get("ActorCombo", targetId, n_skill_index, 0).fireCount
              recordKey = tostring("n_" .. targetId .. n_skill_index)
              skill_index = n_skill_index
            elseif 0 < weaponCount then
              weaponCount = weaponCount - 1
              local actorInfo = roundActorInfo.actorInfo
              weaponPhase = actorInfo.uniqueWeaponPhase or 1
              local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", actorInfo.uniqueWeaponId, weaponPhase) or {}
              fireCount = uniqueWeaponSkill.fireCount or 0
              weaponPhase = actorInfo.uniqueWeaponPhase or 1
              fireCount = PB.get("UniqueWeaponSkill", targetId, weaponPhase).fireCount
              recordKey = tostring("w_" .. targetId .. weaponPhase)
              s_flag = DEFINE.CardFlag.Weapon
            end
            if defineParams.infiniteSkill ~= 1 and 0 < fireCount then
              use_count = useCountRecord[recordKey] or fireCount
            end
            if FH.isInfiniteCard(dungeonType, team) then
              use_count = 99999
            end
            newCard.index = DEFINE.GenRoundCardInfoIndex(team, roundActorInfo.seat, s_flag, k)
            newCard.actorRuntimeID = roundActorInfo.uniqueID
            newCard.actorID = targetId
            newCard.weaponPhase = weaponPhase
            newCard.assist = assist
            newCard.dead = false
            newCard.lock = false
            newCard.useCount = use_count
            newCard.skillIndex = skill_index
            table.insert(teamList[i].allCardList, newCard)
            table.insert(teamList[i].cardsInStack, newCard)
          end
        end
      end
    end
  end
  TLog.CollectEnergy({action = "init", allTeam = teamList})
end

function initWinCondition(teamList, dungeonType, stageID)
  if FH.isDungeonPVE(dungeonType) then
    local selfTeamInfo = FH.getTeamInfo(teamList, 1)
    local dungeonMonster = PB.get("DungeonMonster", stageID)
    local result = {}
    if dungeonMonster and #dungeonMonster.winParam > 0 then
      local paramTypeStr = dungeonMonster.winParam[1]
      if string.trim(paramTypeStr) == "" then
        table.insert(result, 1)
      else
        local paramTypes = string.split(paramTypeStr, "_")
        local params2 = string.split(dungeonMonster.winParam[2] or "", "_")
        local params3 = string.split(dungeonMonster.winParam[3] or "", "_")
        for pi = 1, #paramTypes do
          local paramType = math.floor(tonumber(paramTypes[pi]))
          table.insert(result, paramType)
          table.insert(result, math.floor(tonumber(params2[pi] or 0)))
          table.insert(result, math.floor(tonumber(params3[pi] or 0)))
        end
      end
    end
    table.append(selfTeamInfo.winParam, result)
  end
end

function InitWeaponDynamicTalent(teamList, initEnergyWPList)
  for i = 1, #teamList do
    local weapons = FH.getTeamWeapons(teamList, teamList[i].team)
    local subWeapons = FH.getTeamSubWeapons(teamList, teamList[i].team)
    table.append(weapons, subWeapons)
    local teamEnergyWP = initEnergyWPList[teamList[i].team] or {}
    local teamInfo = teamList[i]
    for wi = 1, #weapons do
      local weaponInfo = weapons[wi]
      local weaponDetail = weaponInfo.actorInfo
      local mainActor = FH.getMainActor(teamList, weaponInfo, true)
      if mainActor and not mainActor.isAssist then
        local subActor = FH.getActorByUid(teamInfo, mainActor.uniqueID + DEFINE.HALF_ACTOR_NUM)
        local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponDetail.uniqueWeaponId, weaponDetail.uniqueWeaponPhase or 1)
        if uniqueWeaponSkill then
          local specials = uniqueWeaponSkill.specials
          for si = 1, #specials do
            local special = specials[si]
            special.talentLv = weaponDetail.uniqueWeaponPhase or 1
            local appendSpecial = FH.GenDynamicTalentList({special}, {
              nameSpecial = "index",
              nameLv = "talentLv",
              talentFlag = DEFINE.GenWeaponTalentFlag(weaponDetail.uniqueWeaponId, fif(DEFINE.IsWeapon(weaponInfo), PB.enum.ActorType.Main, PB.enum.ActorType.Sub), weaponDetail.uniqueWeaponPhase or 1)
            })
            if special.kind == PB.enum.KindForAppendSpecialAttrInfo.Main or special.kind == PB.enum.KindForAppendSpecialAttrInfo.Main1 then
              table.append(mainActor.dynamicTalent, appendSpecial)
            elseif special.kind == PB.enum.KindForAppendSpecialAttrInfo.Sub then
              table.append(subActor.dynamicTalent, appendSpecial)
            elseif special.kind == PB.enum.KindForAppendSpecialAttrInfo.MainAndSub or special.kind == PB.enum.KindForAppendSpecialAttrInfo.MainAndSub1 then
              table.append(mainActor.dynamicTalent, appendSpecial)
              table.append(subActor.dynamicTalent, appendSpecial)
            elseif special.kind == PB.enum.KindForAppendSpecialAttrInfo.Weapon then
              appendSpecial.talentFlag = DEFINE.TalentFlagDEF.Weapon
              table.append(weaponInfo.dynamicTalent, appendSpecial)
            else
              warning("GamePlay", "getTeamActorsByKind parameter kind " .. tostring(special.kind) .. " is illegal ")
            end
          end
          weaponInfo.energyWP = teamEnergyWP[weaponInfo.baseSeat] or uniqueWeaponSkill.initWP
        else
          warning("GamePlay", "missing UniqueWeaponSkill.xlsx id " .. tostring(actorInfo.id) .. " uniqueWeaponPhase " .. tostring(actorInfo.uniqueWeaponPhase))
        end
      end
    end
  end
end

return initGame
