local TLog = {}
local WU, DB = require("Common/WindowUtil")()
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local CO = require("Common/Coroutine")
local m_configDataManager = S:Get("ConfigDataManager")
local mClickData = {}
local mDamageData = {}
local mEnemyData = {}
local mActorInfo = {}
local mBaseData = {}
local mEnergyMp = {}
local mEnergySp = {}
local mSkillHit = {}
local mActorGroup = {}
local mIsRecordingSkillHit = false
local mTempSkillHitRecord = {}
local mHpInfo = {}
local mBuffInfo = {}
local mBalanceData = {}
local mBeginTime
local mLastRound = 0

local function selfAdd(table, key, addValue)
  table = table or {}
  if table[key] then
    table[key] = table[key] + addValue
  else
    table[key] = addValue
  end
end

local function assign(table, key, newValue, condition)
  table = table or {}
  if table[key] then
    if not condition then
      table[key] = newValue
    elseif condition(table[key], newValue) then
      table[key] = newValue
    end
  else
    table[key] = newValue
  end
end

local function tohex(str)
  if str then
    return (str:gsub(".", function(c)
      return string.format("%02X", string.byte(c))
    end))
  else
    return ""
  end
end

local function GetSkillAttackArea(skill)
  if skill.kindIcon and skill.kindIcon ~= nil and skill.kindIcon ~= "" then
    local kindIcon = skill.kindIcon
    if string.find(kindIcon, "_front_") then
      return 1
    elseif string.find(kindIcon, "_middle") then
      return 2
    elseif string.find(kindIcon, "_back") then
      return 3
    elseif string.find(kindIcon, "_all") then
      return 4
    elseif string.find(kindIcon, "front_heal") then
      return 5
    elseif string.find(kindIcon, "self_all") then
      return 6
    end
  end
  return 0
end

local function GetActorLink(actorA, actorB)
  if actorA.id == actorB.id then
    return nil
  end
  local rows = PB.all("ActorLink")
  local linkTable = {}
  for i = 1, #rows do
    for li = 1, #rows[i].link do
      if rows[i].link[li].actorID == actorA.id then
        table.insert(linkTable, rows[i])
      end
    end
  end
  for i = 1, #linkTable do
    for li = 1, #linkTable[i].link do
      if linkTable[i].link[li].actorID == actorB.id then
        return linkTable[i]
      end
    end
  end
  return nil
end

local function firstToUpper(str)
  local input = tostring(str)
  return (input:gsub("^%l", string.upper))
end

local function PostProcessTable(data)
  local res = {}
  for k, v in pairs(data) do
    if k == "playerid" or k == "skillid" or k == "id" then
      res[k] = v
    elseif k == "order" then
      res[k] = v
      res[firstToUpper(k)] = v
    else
      res[firstToUpper(k)] = v
    end
  end
  return res
end

function TLog.CollectTeamInfo(actorInfo)
  if actorInfo.actors == nil then
    return
  end
  for i = 1, #actorInfo.actors do
    local info = actorInfo.actors[i]
    local actor = {}
    actor.type = info.id
    if info.id and info.id ~= 0 then
      local index = i % 3
      if index == 0 then
        index = 3
      end
      actor.prefix = "Main"
      local isMain = i <= 3
      if isMain then
        actor.prefix = "Main"
      else
        actor.prefix = "Sup"
      end
      actor.subfix = tostring(index)
      actor.level = info.level
      actor.star = info.star
      actor.qua = info.quality
      if info.talentInfo ~= nil then
        actor.tFPoint = AU.ActorTalentScore(info)
      end
      for index_attr = 1, #info.attrs do
        local attr = info.attrs[index_attr]
        if attr.type == PB.enum.AttrType.Attack then
          actor.atk = attr.value
        elseif attr.type == PB.enum.AttrType.Penetration then
          actor.dP = attr.value
        elseif attr.type == PB.enum.AttrType.CriticalHitRate then
          actor.crit = math.floor(attr.value / 100)
        elseif attr.type == PB.enum.AttrType.CriticalHitDamageRate then
          actor.critD = math.floor(attr.value / 100)
        elseif attr.type == PB.enum.AttrType.Hp then
          actor.hP = attr.value
        elseif attr.type == PB.enum.AttrType.PhysicalDefense then
          actor.def = attr.value
        elseif attr.type == PB.enum.AttrType.MagicalDefense then
          actor.mDef = attr.value
        elseif attr.type == PB.enum.AttrType.Speed then
          actor.speed = attr.value
        end
      end
      if isMain then
        local skillA = PB.get("ActorCombo", info.id, 1, 0)
        if skillA then
          actor.skillAID = table.join(skillA.skillList, ",")
          actor.SkillATagType = GetSkillAttackArea(skillA)
        end
        local skillB = PB.get("ActorCombo", info.id, 2, 0)
        if skillB then
          actor.skillBID = table.join(skillB.skillList, ",")
          actor.SkillBTagType = GetSkillAttackArea(skillB)
        end
        local skillC = PB.get("ActorCombo", info.id, 0, 1)
        if skillC then
          actor.skillCID = table.join(skillC.skillList, ",")
          actor.SkillCTagType = GetSkillAttackArea(skillC)
        end
      else
        local skillD = PB.get("ActorCombo", info.id, 1, 0)
        if skillD then
          actor.skillDID = table.join(skillD.skillList, ",")
          actor.SkillDTagType = GetSkillAttackArea(skillD)
        end
        local mainActor = actorInfo.actors[i - 3]
        local lk = GetActorLink(mainActor, info)
        if lk then
          actor.cPID = lk.linkID
          local skillE = ""
          for l = 1, #lk.link do
            if l == 1 then
              skillE = skillE .. lk.link[l].skillID
            else
              skillE = skillE .. "," .. lk.link[l].skillID
            end
          end
          actor.skillEID = skillE
          actor.SkillETagType = GetSkillAttackArea(skillE)
        end
      end
    end
    table.insert(mActorInfo, actor)
  end
end

function TLog.ResetData()
  info("TLog", "TLog.ResetData")
  mClickData = {}
  mDamageData = {}
  mEnemyData = {}
  mActorInfo = {}
  mBaseData = {}
  mEnergyMp = {}
  mEnergySp = {}
  mBalanceData = {}
  mSkillHit = {}
  mActorGroup = {}
  mHpInfo = {}
  mBuffInfo = {}
  mLastRound = 0
end

local function GetSkillString(skillInfo)
  if skillInfo.isLinkSkill then
    return "SkillE"
  elseif skillInfo.isAssistSkill then
    return "SkillD"
  elseif skillInfo.isBigSkill then
    return "SkillC"
  end
  if skillInfo.num == 1 then
    return "SkillA"
  elseif skillInfo.num == 2 then
    return "SkillB"
  end
  return ""
end

local function RecordingSkillDamage(param)
  if param.action == "start" and param.team then
    mIsRecordingSkillHit = true
    mTempSkillHitRecord = {}
    local pos = param.seat
    if param.seat >= 4 then
      pos = param.seat - 3
    end
    if param.team == 1 then
      mTempSkillHitRecord.playerid = "Player" .. pos
    elseif param.team == 2 then
      mTempSkillHitRecord.playerid = "Enemy" .. pos
    else
      return
    end
    mTempSkillHitRecord.skillid = GetSkillString(param.allinfo[2])
    if mSkillHit[mTempSkillHitRecord.playerid] == nil then
      mSkillHit[mTempSkillHitRecord.playerid] = {}
    end
    if mSkillHit[mTempSkillHitRecord.playerid][mTempSkillHitRecord.skillid] == nil then
      mSkillHit[mTempSkillHitRecord.playerid][mTempSkillHitRecord.skillid] = {}
    end
    local obj = mSkillHit[mTempSkillHitRecord.playerid][mTempSkillHitRecord.skillid]
    obj.playerid = mTempSkillHitRecord.playerid
    obj.skillid = mTempSkillHitRecord.skillid
    assign(obj, "tag", param.enemyNum, function(old, new)
      return old < new
    end)
  elseif param.action == "doing" and mIsRecordingSkillHit then
    local obj = mSkillHit[mTempSkillHitRecord.playerid][mTempSkillHitRecord.skillid]
    local hurt = param.hurtVal
    if hurt < 0 then
      local damageValue = math.abs(hurt)
      selfAdd(obj, "total", damageValue)
      selfAdd(obj, "hitsTotal", param.hitNum)
      assign(obj, "max", damageValue, function(old, new)
        return old < new
      end)
      assign(obj, "min", damageValue, function(old, new)
        return new < old and 0 < new
      end)
    end
    if param.isCritical then
      selfAdd(obj, "critTotal", 1)
    end
  elseif param.action == "end" then
    if mIsRecordingSkillHit then
      local obj = mSkillHit[mTempSkillHitRecord.playerid][mTempSkillHitRecord.skillid]
      selfAdd(obj, "count", 1)
    end
    mIsRecordingSkillHit = false
    mTempSkillHitRecord = {}
    selfAdd(mBalanceData, "roundCount2", 1)
  end
end

local function RecordingHpInfo(param)
  local teamstring = ""
  if param.action == "change" and param.actorData then
    local team = param.actorData.team
    local seat = param.actorData.baseSeat
    teamstring = tostring(team) .. "|" .. tostring(seat)
    if 3 < seat then
      return
    end
    local playerId = ""
    if team == 1 then
      playerId = "Player" .. seat
    elseif team == 2 then
      playerId = "Enemy" .. seat
    else
      info("TLog", "unexpected return in RecordingHpInfo change")
      return
    end
    if mHpInfo[playerId] == nil then
      mHpInfo[playerId] = {}
    end
    local obj = mHpInfo[playerId]
    obj.playerId = playerId
    local change = param.changeVal
    if obj.initHP == nil then
      obj.initHP = param.maxVal
      obj.position = seat
    end
    local absChange = math.abs(change)
    if 0 < change then
      selfAdd(obj, "healHPCount", 1)
      assign(obj, "healHPMax", absChange, function(old, new)
        return old < new
      end)
      assign(obj, "healHPMin", absChange, function(old, new)
        return new < old and 0 < new
      end)
      selfAdd(obj, "healHPTotal", absChange)
    elseif change < 0 then
      selfAdd(obj, "damageHPCount", 1)
      assign(obj, "damageHPMax", absChange, function(old, new)
        return old < new
      end)
      assign(obj, "damageHPMin", absChange, function(old, new)
        return new < old and 0 < new
      end)
      selfAdd(obj, "damageHPTotal", absChange)
    end
  elseif param.action == "start or end" and param.win and param.win ~= 0 then
    local teamList = param.allTeam
    for teamIndex = 1, #teamList do
      local hpList = teamList[teamIndex].statistic.recordHpList
      local playerId = ""
      if teamIndex == 1 then
        playerId = "Player"
      elseif teamIndex == 2 then
        playerId = "Enemy"
      else
        info("TLog", "unexpected return in RecordingHpInfo start or end")
      end
      for pos = 1, 3 do
        local id = playerId .. pos
        if mHpInfo[id] == nil then
          mHpInfo[id] = {}
        end
        mHpInfo[id].endHP = hpList[pos]
        if mHpInfo[id].initHP and mHpInfo[id].initHP ~= 0 and 0 >= mHpInfo[id].endHP then
          mHpInfo[id].deadCount = 1
        end
      end
    end
  end
end

local function RecordingEnergy(param)
  local FH = require("Logic/HelpLogic")
  if param.action == "change" then
    if param.teamInfo.team ~= 1 then
      return
    end
    local value = math.abs(param.val)
    local keyCost = ""
    local keySource = ""
    if param.val > 0 then
      keyCost = "add"
    elseif param.val < 0 then
      keyCost = "cost"
    else
      return
    end
    if param.kind == 1 then
      local mp = FH.getTeamEnergy(1, param.teamInfo, -1)
      if mp >= param.maxVal then
        return
      end
      if param.source == 1 then
        keySource = "1"
      else
        keySource = "2"
      end
      local key = keyCost .. "MPCount" .. keySource
      selfAdd(mEnergyMp, key, value)
    elseif param.kind == 2 then
      local sp = FH.getTeamEnergy(2, param.teamInfo, -1)
      if sp >= param.maxVal then
        return
      end
      if param.source == 2 then
        keySource = "1"
      else
        keySource = "2"
      end
      local key = keyCost .. "SPCount" .. keySource
      selfAdd(mEnergySp, key, value)
    end
  elseif param.action == "init" then
    local teamInfo = FH.getTeamInfo(param.allTeam, 1)
    local mp = FH.getTeamEnergy(1, teamInfo, -1)
    local sp = FH.getTeamEnergy(1, teamInfo, -1)
    mEnergyMp.InitMP = mp
    mEnergySp.InitSP = sp
  elseif param.action == "end" and param.win ~= 0 then
    local teamInfo = FH.getTeamInfo(param.allTeam, 1)
    local mp = FH.getTeamEnergy(1, teamInfo, -1)
    local sp = FH.getTeamEnergy(1, teamInfo, -1)
    mEnergyMp.EndMP = mp
    mEnergySp.EndSP = sp
  end
end

function TLog.CollectButtonClick(name)
  selfAdd(mClickData, name, 1)
end

function TLog.CollectSkillDamage(param)
  RecordingSkillDamage(param)
end

function TLog.CollectHp(param)
  RecordingHpInfo(param)
end

function TLog.CollectEnergy(param)
  RecordingEnergy(param)
end

local function GetTencentBuffId(buffData)
  local type = buffData.type
  if type == PB.enum.BuffFightType.Attr then
    local attr = buffData.paramInt[1]
    if attr == PB.enum.AttrType.PhysicalDefense then
      return "1"
    elseif attr == PB.enum.AttrType.MagicalDefense then
      return "2"
    elseif attr == PB.enum.AttrType.Attack then
      return "3"
    end
  elseif type == PB.enum.BuffFightType.AbHurt then
    local finalDamage = buffData.paramInt[1]
    if finalDamage == 1 then
      return "4"
    elseif finalDamage == 2 then
      return "6"
    end
  elseif type == PB.enum.BuffFightType.Shield then
    return "5"
  elseif type == PB.enum.BuffFightType.Rebound then
    return "7"
  elseif type == PB.enum.BuffFightType.KeepAlive then
    return "8"
  elseif type == PB.enum.BuffFightType.Remove then
    local param1 = buffData.paramInt[1]
    local param2 = buffData.paramInt[2]
    if param1 == 1 and param2 == 1 then
      return "13"
    end
    if param1 == 1 and param2 == 2 then
      return "9"
    end
  elseif type == PB.enum.BuffFightType.MpOnceChange then
    return "10"
  elseif type == PB.enum.BuffFightType.HpChange then
    local param1 = buffData.paramInt[1]
    local param2 = buffData.paramInt[2]
    if (param1 == 3 or param1 == 4) and 0 < param2 then
      return "11"
    end
  elseif type == PB.enum.BuffFightType.LockCard then
    return "12"
  elseif type == PB.enum.BuffFightType.ActionFeedBack then
    return "14"
  elseif type == PB.enum.BuffFightType.CostChange then
    return "15"
  elseif type == PB.enum.BuffFightType.HpAddChange then
    local param1 = buffData.paramInt[1]
    if param1 < 0 then
      return "16"
    end
  end
  return "0"
end

function TLog.CollectBuff(param)
  local buffKey = param.buffInfo.buffKey
  local buffData = PB.get("BuffData", buffKey.id, buffKey.owner)
  local type = buffData.type
  local tencentId = GetTencentBuffId(buffData)
  if tencentId == "0" then
    return
  end
  if mBuffInfo[tencentId] == nil then
    mBuffInfo[tencentId] = {}
    mBuffInfo[tencentId].type = type
    mBuffInfo[tencentId].tencentId = tencentId
  end
  mLastRound = param.round
  local gameRound = param.round
  local infoTable = mBuffInfo[tencentId]
  if param.action == "add" then
    selfAdd(infoTable, "count", 1)
    local effectValue = 0
    if tencentId == "5" or tencentId == "11" then
      effectValue = math.floor(math.abs(param.buffInfo.val))
    else
      effectValue = math.floor(math.abs(param.buffInfo.val / 100))
    end
    assign(infoTable, "effectMin", effectValue, function(old, new)
      return old < new
    end)
    assign(infoTable, "effectMax", effectValue, function(old, new)
      return new < old and 0 < new
    end)
    if infoTable.usageList == nil then
      infoTable.usageList = {}
    end
    local usagePlace = infoTable.usageList[param.buffInfo.ownerUid]
    if usagePlace == nil then
      infoTable.usageList[param.buffInfo.ownerUid] = {}
      usagePlace = infoTable.usageList[param.buffInfo.ownerUid]
    end
    local usageItem = {}
    usageItem.startRound = gameRound
    usageItem.isFinished = false
    usagePlace[gameRound] = usageItem
  elseif param.action == "del" then
    local endRound = gameRound
    local usagePlace = infoTable.usageList[param.buffInfo.ownerUid]
    for k, usageItem in pairs(usagePlace) do
      if not usageItem.isFinished then
        usageItem.endRound = gameRound
        usageItem.isFinished = true
      end
    end
  end
end

function TLog.CollectDamage(team, value, isCritical)
  if team ~= 2 or value <= 0 then
    return
  end
  selfAdd(mDamageData, "playerDpsTotal", value)
  assign(mDamageData, "playerDamageMax", value, function(old, new)
    return old < new
  end)
  assign(mDamageData, "playerDamageMin", value, function(old, new)
    return new < old and 0 < new
  end)
  selfAdd(mDamageData, "playerDpsCount", 1)
  if isCritical then
    selfAdd(mDamageData, "playerCritCount", 1)
  end
end

local function UpdateBaseData()
  mBaseData.battleID = tostring(DB:GetData("Dungeon/DungeonUid"))
  mBaseData.clientVersion = m_configDataManager.FullVersion()
  if DB:GetData("FightDungeonType") then
    mBaseData.dungeonType = tostring(DB:GetData("FightDungeonType"))
  end
  mBaseData.clientStartTime = CS.System.DateTime.Now:ToString("yyyy-MM-dd HH:mm:ss")
  mBaseData.clientEndTime = CS.System.DateTime.Now:ToString("yyyy-MM-dd HH:mm:ss")
end

function TLog.CollectEndInfo(fightLuaTable)
  UpdateBaseData()
  local dead = fightLuaTable.teamList[2].statistic.deadInfo
  if dead then
    for i = 1, #dead do
      local item = dead[i]
      if mEnemyData[item.seat] == nil then
        mEnemyData[item.seat] = {}
      end
      mEnemyData[item.seat].deadTime = 1
    end
  end
  local actorInfo = DB:GetData("FightActorInfo")
  if actorInfo then
    for i = 1, #actorInfo do
      local cur = actorInfo[i]
      TLog.CollectTeamInfo(cur)
    end
  else
    info("TLog", "CollectEndInfo actorInfo not found")
  end
  mBalanceData.roundCount1 = fightLuaTable.gameRound
  local selfTeam = DB:GetData("FightSelfTeam")
  if fightLuaTable.winTeam == selfTeam then
    mBalanceData.roundEndType = 0
  else
    mBalanceData.roundEndType = 1
  end
end

function TLog.CollectEnemyBaseInfo(index, process)
  if index < 6 or 11 < index then
    return
  end
  local actorKey = "mainID"
  if 9 <= index then
    actorKey = "supID"
  end
  local pos = (index - 5) % 3
  if pos == 0 then
    pos = 3
  end
  if not mEnemyData[pos] then
    mEnemyData[pos] = {}
  end
  mEnemyData[pos][actorKey] = process:GetActorID()
end

function TLog.CollectEnemySkillUsage(fightData, activeTeamInfo)
  local data = {
    useCard = fightData.useCard,
    useSCard = fightData.useSCard,
    linkID = fightData.linkID,
    team = fightData.team,
    actorID = fightData.actorID
  }
  if data.team ~= 2 then
    return
  end
  if data.useCard == 0 and data.useSCard == 0 and data.linkID == 0 and data.actorID == 0 then
    return
  end
  local key = "skillACount"
  local FH = require("Logic/HelpLogic")
  if data.linkID ~= 0 then
    data.actorID = fightData.cardList[1].actorRuntimeID
  end
  local attackActor = FH.getActorByUid(activeTeamInfo, data.actorID)
  if attackActor then
    if data.linkID ~= 0 then
      key = "SkillECount"
    elseif attackActor.isAssist then
      key = "SkillDCount"
    elseif data.useSCard == 1 then
      key = "SkillCCount"
    elseif data.useCard == 1 then
      key = "SkillBCount"
    end
    local pos = attackActor.baseSeat
    if 3 < pos then
      pos = pos - 3
    end
    selfAdd(mEnemyData[pos], key, 1)
    selfAdd(mEnemyData[pos], "liveTime", 1)
  end
end

local function UploadData(type, originalData)
  local baseInfo = DB:GetData("fci/baseinfo/")
  if baseInfo == nil then
    info("TLog", "Disable upload data")
    return
  end
  local processed = {}
  for k, v in pairs(originalData) do
    processed[k] = PostProcessTable(v)
  end
  local innerList = {
    "skillHitInfo",
    "actorGroup",
    "actorHpInfo",
    "enemyInfo",
    "actorInfo",
    "buffInfo"
  }
  for index, item in pairs(innerList) do
    if originalData[item] then
      for k, v in pairs(originalData[item]) do
        processed[item][k] = PostProcessTable(v)
      end
    end
  end
  local param
  if type == PB.enum.SecLogType.SecRoundStartFlow then
    param = {roundStart = processed}
  elseif type == PB.enum.SecLogType.SecRoundEndFlow then
    param = {roundEnd = processed}
  elseif type == PB.enum.SecLogType.SecRoundEndCount then
    param = {roundEndCount = processed}
  end
  if param == nil then
    warning("TLog unhandled type")
    return
  end
  param.logType = type
  CO.coroutine_call(function()
    local fixed = ProtobufT("ApiAQLog", param)
    DB:GameRequest("fci/aq/log/"):SyncInput(false):ResetGameWhenFailed(false):Post(fixed)
  end)()
end

local function AddToTotal(table, sumKey, addKey)
  if table[addKey] then
    table[sumKey] = table[sumKey] + table[addKey]
  end
end

local function CalculateEnergy()
  mEnergyMp.addMPTotal = 0
  AddToTotal(mEnergyMp, "addMPTotal", "addMPCount1")
  AddToTotal(mEnergyMp, "addMPTotal", "addMPCount2")
  mEnergyMp.costMPTotal = 0
  AddToTotal(mEnergyMp, "costMPTotal", "costMPCount1")
  AddToTotal(mEnergyMp, "costMPTotal", "costMPCount2")
  mEnergySp.addSPTotal = 0
  AddToTotal(mEnergySp, "addSPTotal", "addSPCount1")
  AddToTotal(mEnergySp, "addSPTotal", "addSPCount2")
  mEnergySp.costSPTotal = 0
  AddToTotal(mEnergySp, "costSPTotal", "costSPCount1")
  AddToTotal(mEnergySp, "costSPTotal", "costSPCount2")
end

local function CalculateEnemyAttackInfo()
  for i = 1, 3 do
    local key = "Enemy" .. i
    if mSkillHit[key] then
      local atkMin
      local atkMax = 0
      local atkTotal = 0
      for k, v in pairs(mSkillHit[key]) do
        if atkMin == nil and v.min then
          atkMin = v.min
        elseif v.min and atkMin > v.min and 0 < v.min then
          atkMin = v.min
        end
        if v.max and atkMax < v.max then
          atkMax = v.max
        end
        if v.total then
          atkTotal = atkTotal + v.total
        end
      end
      if mEnemyData[i] == nil then
        mEnemyData[i] = {}
      end
      mEnemyData[i].attackMin = atkMin
      mEnemyData[i].attackMax = atkMax
      mEnemyData[i].attackTotal = atkTotal
    end
  end
end

local function CalculateBuffSummary()
  local gameRound = mLastRound
  for index, v in pairs(mBuffInfo) do
    if v then
      if v.tencentId == "9" or v.tencentId == "13" or v.tencentId == "10" or v.tencentId == "15" then
        v.effectCount = v.count
      end
      local totalTime = 0
      local min
      local max = 0
      if v.usageList then
        for k, eachActor in pairs(v.usageList) do
          local tempMap = {}
          for _, usageItem in pairs(eachActor) do
            if not usageItem.isFinished then
              usageItem.endRound = gameRound
              usageItem.isFinished = true
            end
            local activeTurn = usageItem.endRound - usageItem.startRound
            if tempMap[usageItem.startRound] == nil then
              tempMap[usageItem.startRound] = activeTurn
            end
            if min then
              if min > activeTurn then
                min = activeTurn
              end
            else
              min = activeTurn
            end
            if max < activeTurn then
              max = activeTurn
            end
          end
          local maxActiveTurn = 0
          for tk, tv in pairs(tempMap) do
            if tv > maxActiveTurn then
              maxActiveTurn = tv
            end
          end
          totalTime = totalTime + maxActiveTurn
        end
      end
      v.timeMin = min
      v.timeMax = max
      v.timeTotal = totalTime
      local usageCount = 0
      if v.usageList then
        for k, eachActor in pairs(v.usageList) do
          local tempMap = {}
          for _, usageItem in pairs(eachActor) do
            if tempMap[usageItem.startRound] == nil then
              tempMap[usageItem.startRound] = 1
              usageCount = usageCount + 1
            end
          end
        end
      end
      v.use = usageCount
    end
  end
end

local function FormatSkillHit()
  local result = _ENV["!"]({})
  for _, packed in pairs(mSkillHit) do
    for key, item in pairs(packed) do
      table.insert(result, item)
    end
  end
  return result
end

local function CalculateEnemyDamageSummary()
  for i = 1, 3 do
    local key = "Enemy" .. i
    local info = mHpInfo[key]
    if info then
      if mEnemyData[i] == nil then
        mEnemyData[i] = {}
      end
      mEnemyData[i].damageMin = info.damageHPMin
      mEnemyData[i].damageMax = info.damageHPMax
      mEnemyData[i].damageTotal = info.damageHPTotal
      mEnemyData[i].healHPTotal = info.healHPTotal
    end
  end
end

function TLog.Report()
  CalculateEnergy()
  CalculateEnemyAttackInfo()
  CalculateEnemyDamageSummary()
  local hpArray = _ENV["!"](mHpInfo):toarray()
  local skillHitList = FormatSkillHit()
  local secRoundEndFlow = {
    base = mBaseData,
    manualData = mClickData,
    globalDamageData = mDamageData,
    enemyInfo = mEnemyData,
    actorInfo = mActorInfo,
    mpData = mEnergyMp,
    spData = mEnergySp,
    actorGroup = mActorGroup,
    actorHpInfo = hpArray,
    skillHitInfo = skillHitList,
    balance = mBalanceData
  }
  UploadData(PB.enum.SecLogType.SecRoundEndFlow, secRoundEndFlow)
  CalculateBuffSummary()
  local buffArray = _ENV["!"](mBuffInfo):toarray()
  local secRoundEndCount = {base = mBaseData, buffInfo = buffArray}
  UploadData(PB.enum.SecLogType.SecRoundEndCount, secRoundEndCount)
end

function TLog.CollectOrder(sequenceList)
  for i = 1, #sequenceList do
    local item = sequenceList[i]
    local uid = item.uid
    local team = math.floor(uid / 100)
    local pos = uid % 100
    if team == 1 then
      if mActorGroup[pos] == nil then
        mActorGroup[pos] = {}
      end
      mActorGroup[pos].id = "Player" .. pos
      assign(mActorGroup[pos], "order", i)
    elseif team == 2 then
      if mEnemyData[pos] == nil then
        mEnemyData[pos] = {}
      end
      assign(mEnemyData[pos], "order", i)
    end
  end
end

function TLog.CollectHpList(actorTable)
  for i = 1, #actorTable do
    local actor = actorTable[i]
    if actor.team ~= nil and actor.team == 2 and actor.seat ~= nil and actor.seat < 4 then
      local hp = actor.dynamicAttrs[PB.enum.AttrType.Hp].value
      if mEnemyData == nil then
        mEnemyData = {}
      end
      if mEnemyData[actor.seat] == nil then
        mEnemyData[actor.seat] = {}
      end
      assign(mEnemyData[actor.seat], "hP", hp)
    end
  end
end

function TLog.CollectBeginInfo()
  local baseInfo = DB:GetData("fci/baseinfo/")
  if baseInfo == nil then
    return
  end
  UpdateBaseData()
  mBeginTime = CS.System.DateTime.UtcNow
  local actorInfo = DB:GetData("FightActorInfo")
  local uids = {}
  if actorInfo then
    for i = 1, #actorInfo do
      local cur = actorInfo[i]
      for j = 1, #cur.actors do
        local item = cur.actors[j]
        if item.id == 0 then
          uids[j] = 0
        else
          uids[j] = item.uid
        end
      end
    end
  else
    info("TLog", "CollectBeginInfo actorInfo not found")
  end
  local secRoundStartFlow = {base = mBaseData, actorUids = uids}
  UploadData(PB.enum.SecLogType.SecRoundStartFlow, secRoundStartFlow)
end

function TLog.CollectBalanceData()
  local baseInfo = DB:GetData("fci/baseinfo/")
  if baseInfo == nil then
    info("TLog", "Disable CollectBalanceData")
    return
  end
  if mBeginTime then
    local delta = CS.System.DateTime.UtcNow - mBeginTime
    mBalanceData.roundTimeUse = math.floor(delta.TotalSeconds * 1000)
  end
  mBalanceData.userMoney1 = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResPlayerGold] .. "_0")
  local allMaiko = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResPlayerMoney] .. "_0")
  local payMaiko = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResPlayerPayMoney] .. "_0")
  mBalanceData.userMoney2 = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResPlayerPayMoney] .. "_0")
  mBalanceData.userMoney3 = allMaiko - payMaiko
  mBalanceData.userMoney4 = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResPlayerPower] .. "_0")
  mBalanceData.userMoney5 = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResTowerScore] .. "_0")
  mBalanceData.userMoney6 = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResGuildScore] .. "_0")
  mBalanceData.userMoney7 = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResPlayerRelationPoint] .. "_0")
  mBalanceData.userMoney8 = DB:GetData("fci/item/90001").count
  local balanceResult = DB:GetData("DungeonBalance/result")
  local equipTypeList = {}
  local equipUuidList = {}
  local itemTypeList = {}
  if balanceResult and balanceResult.resChange then
    for i = 1, #balanceResult.resChange do
      local item = balanceResult.resChange[i]
      if item.baseRes then
        if item.baseRes.type == PB.enum.ResourceType.ResPlayerGold then
          mBalanceData.roundmoney1 = item.baseRes.countDelta
        elseif item.baseRes.type == PB.enum.ResourceType.ResPlayerMoney then
          mBalanceData.roundmoney2 = item.baseRes.countDelta
        elseif item.baseRes.type == PB.enum.ResourceType.ResPlayerExp then
          mBalanceData.roundExp = item.baseRes.countDelta
        else
          if item.baseRes.type == PB.enum.ResourceType.ResItem then
            table.insert(itemTypeList, item.baseRes.id)
          else
          end
        end
      else
        if item.equip then
          local equip = item.equip
          table.insert(equipTypeList, equip.id)
          table.insert(equipUuidList, equip.uid)
        else
        end
      end
    end
  end
  mBalanceData.dropItemType1 = table.join(equipTypeList, ",")
  mBalanceData.dropItemUuid1 = table.join(equipUuidList, ",")
  mBalanceData.dropItemType2 = table.join(itemTypeList, ",")
  local towerSummary = DB:GetData("fci/tower/summary/")
  if towerSummary then
    mBalanceData.endLessFloor = towerSummary.towerFloorRecord
  end
  if balanceResult and balanceResult.targetsDone then
    local starCount = #balanceResult.targetsDone
    mBalanceData.roundRate = starCount
  end
end

function TLog.RecordLeaveDungeon(reason)
  if reason == 1 then
    mBalanceData.roundEndType = 0
  elseif reason == 2 then
    mBalanceData.roundEndType = 1
  elseif reason == 3 then
    mBalanceData.roundEndType = 2
    TLog.Report()
  end
end

function TLog.NotifyKeepAlive()
  if mBuffInfo["8"] == nil then
    mBuffInfo["8"] = {}
    mBuffInfo["8"].tencentId = 8
  end
  selfAdd(mBuffInfo["8"], "effectCount", 1)
end

return TLog
