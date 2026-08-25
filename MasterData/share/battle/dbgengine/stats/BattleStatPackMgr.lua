local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleActionStatsUtil = require("Battle.DbgEngine.Stats.BattleActionStatsUtil")
local BattleStatPackMgr = System.NewClass("BattleStatPackMgr")

function BattleStatPackMgr:ctor(battleEngine)
  self.battleEngine = battleEngine
  self.battleStatPackData = {}
end

function BattleStatPackMgr:Serialize()
  return {
    battleStatPackData = self.battleStatPackData
  }
end

function BattleStatPackMgr:OnRecover(snapshotData)
  self.battleStatPackData = snapshotData.battleStatPackData or {}
end

function BattleStatPackMgr:GetBattleStatPackCompressedString()
  local packData = self.battleStatPackData
  if not packData or not next(packData) then
    return ""
  end
  if not self.battleEngine:IsServerBattle() then
    return ""
  end
  local Lz4 = require("lz4")
  local MsgPackC = require("cmsgpack")
  local Crypto = require("crypto")
  local base64 = Crypto.base64
  local packed = MsgPackC.pack(packData)
  local msgpackByteCount = #packed
  local compressed = Lz4.compress(packed)
  local lz4ByteCount = #compressed
  local encodedStr = base64(compressed)
  local base64CharCount = #encodedStr
  local lz4OverMsgpack = msgpackByteCount > 0 and lz4ByteCount / msgpackByteCount or 0
  local finalOverMsgpack = msgpackByteCount > 0 and base64CharCount / msgpackByteCount or 0
  self.battleEngine:InfoS("GetBattleStatPackCompressedString: {msgpackBytes} {lz4Bytes} {base64Chars} {lz4OverMsgpack} {finalOverMsgpack} ", msgpackByteCount, lz4ByteCount, base64CharCount, lz4OverMsgpack, finalOverMsgpack)
  return encodedStr
end

function BattleStatPackMgr:AddBattleStatPackSkillStats(cmdServer, statKey, value)
  local skillConfigId = cmdServer.skillConfigId
  local roleUid = cmdServer.castRoleUid
  local sourceType = bc.RecordActionStats_Battle.SourceType.Skill
  if 1 == cmdServer.cmdParser:IsSuperUtlSkill() then
    sourceType = bc.RecordActionStats_Battle.SourceType.UtilSkill
  end
  self:__AccumulateBattleStatPackBucket(roleUid, sourceType, skillConfigId, statKey, value)
end

function BattleStatPackMgr:AddBattleStatPackStateStats(roleUid, cmdServer, statKey, value)
  local stateTid = cmdServer.stateId
  if not stateTid and cmdServer.stateUid then
    local stateObj = self.battleEngine:GetObj(cmdServer.stateUid)
    if stateObj then
      stateTid = stateObj.stateId or stateObj.tid
    end
  end
  local sourceType = bc.RecordActionStats_Battle.SourceType.State
  self:__AccumulateBattleStatPackBucket(roleUid, sourceType, stateTid, statKey, value)
end

function BattleStatPackMgr:__AccumulateBattleStatPackBucket(roleUid, sourceType, sourceEntryKey, statKey, value)
  if not (sourceEntryKey and value) or 0 == value then
    return
  end
  local awakerTid = BattleActionStatsUtil.GetStatsRoleId(self.battleEngine, roleUid)
  if not awakerTid then
    return
  end
  local mainType = bc.RecordActionStats_Battle.StatMainType.BattleValue
  local boutNumber = self.battleEngine.boutMgr:GetBoutNum() or 0
  boutNumber = math.max(boutNumber, 1)
  self.battleStatPackData[boutNumber] = self.battleStatPackData[boutNumber] or {}
  self.battleStatPackData[boutNumber][mainType] = self.battleStatPackData[boutNumber][mainType] or {}
  local boutData = self.battleStatPackData[boutNumber][mainType]
  boutData[awakerTid] = boutData[awakerTid] or {}
  boutData[awakerTid][sourceType] = boutData[awakerTid][sourceType] or {}
  local bucketStats = boutData[awakerTid][sourceType]
  bucketStats[sourceEntryKey] = bucketStats[sourceEntryKey] or {}
  bucketStats[sourceEntryKey][statKey] = (bucketStats[sourceEntryKey][statKey] or 0) + value
end

function BattleStatPackMgr:LogBattleStatPackHierarchy()
  local battleEngine = self.battleEngine
  if not battleEngine then
    return
  end
  local packData = self.battleStatPackData
  if not packData or not next(packData) then
    battleEngine:LogBattleWithTab("暂无聚合数据（非 PVE、尚未产生统计或本回合前无记录）")
    return
  end
  local mainType = bc.RecordActionStats_Battle.StatMainType.BattleValue
  local sourceSkill = bc.RecordActionStats_Battle.SourceType.Skill
  local sourceUtilSkill = bc.RecordActionStats_Battle.SourceType.UtilSkill
  local sourceState = bc.RecordActionStats_Battle.SourceType.State
  local damageKey = bc.StatsKey.AwakerDoDamage
  local healKey = bc.StatsKey.AwakerDoHeal
  local blockKey = bc.StatsKey.AwakerDoBlock
  
  local function readTriple(statMap)
    if not statMap then
      return 0, 0, 0
    end
    return statMap[damageKey] or 0, statMap[blockKey] or 0, statMap[healKey] or 0
  end
  
  local function resolveAwakerLabel(awakerTid)
    if 1 == awakerTid then
      local player = battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
      if player then
        do return player.GetBattleLogName end
        return player.GetBattleLogName, player, nil, nil
      end
      return "玩家"
    end
    local awaker = battleEngine.roleMgr:GetAwakerByTid(awakerTid, bc.BattleCamp.Camp1)
    if awaker then
      do return awaker.GetBattleLogName end
      return awaker.GetBattleLogName, awaker, bc.BattleCamp.Camp1, nil
    end
    local cfg = battleEngine.battleDT.AwakerConfig and battleEngine.battleDT.AwakerConfig[awakerTid]
    if cfg and cfg.CnID then
      do return tostring end
      return tostring, cfg.CnID, nil
    end
    return "唤醒体tid=" .. tostring(awakerTid)
  end
  
  local function resolveSkillLabel(skillConfigId)
    local skillCfg = battleEngine.battleDT.Skill and battleEngine.battleDT.Skill[skillConfigId]
    if skillCfg then
      local name = BattleActionStatsUtil.GetConfigPlainName(battleEngine, skillCfg.Name)
      local str = string.format("%s(%s)", skillCfg.CnID, name)
      return str
    end
    return "技能无配置 " .. tostring(skillConfigId)
  end
  
  local function resolveStateLabel(stateTid)
    local stateCfg = battleEngine.battleDT.State and battleEngine.battleDT.State[stateTid]
    if stateCfg then
      local name = BattleActionStatsUtil.GetConfigPlainName(battleEngine, stateCfg.Name)
      local str = string.format("%s(%s)", stateCfg.CnID, name)
      return str
    end
    return "状态无配置 " .. tostring(stateTid)
  end
  
  local boutMgr = battleEngine.boutMgr
  if not boutMgr or not boutMgr.GetBoutNum then
    battleEngine:LogBattleWithTab("GM统计: boutMgr 不可用，无法按回合打印")
    return
  end
  local currentBoutNumber = boutMgr:GetBoutNum()
  if type(currentBoutNumber) ~= "number" or currentBoutNumber < 0 then
    battleEngine:LogBattleWithTab("GM统计: 当前回合号无效，无法按回合打印")
    return
  end
  battleEngine:LogBattleWithTab("========== 按回合汇总（伤害/护盾/治疗）==========")
  for boutNumber = 1, currentBoutNumber do
    local boutRoot = packData[boutNumber]
    local boutData = boutRoot and boutRoot[mainType]
    if boutData and next(boutData) then
      battleEngine:LogBattleWithTab("第 " .. tostring(boutNumber) .. " 回合：")
      local awakerTidList = {}
      for awakerTid in pairs(boutData) do
        table.insert(awakerTidList, awakerTid)
      end
      table.sort(awakerTidList)
      for _, awakerTid in ipairs(awakerTidList) do
        local perAwaker = boutData[awakerTid]
        local totalDamage = 0
        local totalBlock = 0
        local totalHeal = 0
        
        local function accumulateSourceMap(sourceMap)
          if not sourceMap then
            return
          end
          for _, statMap in pairs(sourceMap) do
            local damageVal, blockVal, healVal = readTriple(statMap)
            totalDamage = totalDamage + damageVal
            totalBlock = totalBlock + blockVal
            totalHeal = totalHeal + healVal
          end
        end
        
        accumulateSourceMap(perAwaker[sourceSkill])
        accumulateSourceMap(perAwaker[sourceUtilSkill])
        accumulateSourceMap(perAwaker[sourceState])
        local awakerLabel = resolveAwakerLabel(awakerTid)
        battleEngine:LogBattleWithTab("\t" .. awakerLabel .. " 伤害" .. tostring(totalDamage) .. " 护盾" .. tostring(totalBlock) .. " 治疗" .. tostring(totalHeal))
        
        local function logSkillMap(skillMap, linePrefix)
          if not skillMap or not next(skillMap) then
            return
          end
          local skillIdList = {}
          for skillConfigId in pairs(skillMap) do
            table.insert(skillIdList, skillConfigId)
          end
          table.sort(skillIdList)
          for _, skillConfigId in ipairs(skillIdList) do
            local damageVal, blockVal, healVal = readTriple(skillMap[skillConfigId])
            if 0 ~= damageVal or 0 ~= blockVal or 0 ~= healVal then
              battleEngine:LogBattleWithTab("\t\t" .. linePrefix .. " " .. resolveSkillLabel(skillConfigId) .. " 伤害" .. tostring(damageVal) .. " 护盾" .. tostring(blockVal) .. " 治疗" .. tostring(healVal))
            end
          end
        end
        
        logSkillMap(perAwaker[sourceSkill], "技能")
        logSkillMap(perAwaker[sourceUtilSkill], "超限狂气爆发")
        local stateMap = perAwaker[sourceState]
        if stateMap and next(stateMap) then
          local stateTidList = {}
          for stateTid in pairs(stateMap) do
            table.insert(stateTidList, stateTid)
          end
          table.sort(stateTidList)
          for _, stateTid in ipairs(stateTidList) do
            local damageVal, blockVal, healVal = readTriple(stateMap[stateTid])
            if 0 ~= damageVal or 0 ~= blockVal or 0 ~= healVal then
              battleEngine:LogBattleWithTab("\t\t状态 " .. resolveStateLabel(stateTid) .. " 伤害" .. tostring(damageVal) .. " 护盾" .. tostring(blockVal) .. " 治疗" .. tostring(healVal))
            end
          end
        end
      end
    end
  end
  battleEngine:LogBattleWithTab("========== 汇总结束 ==========")
end

return BattleStatPackMgr
