local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleLogMgrServer, Super = System.NewClass("BattleLogMgrServer", BattleEngineComponent)

function BattleLogMgrServer:ctor(battleEngine)
  Super.ctor(self, battleEngine)
end

function BattleLogMgrServer:AllStateBattleLog()
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local playerStates = "玩家状态:\n"
  local playerAttrs = "玩家属性:\n" .. player.property:GetBattleLog()
  local awakerStates = {}
  local awakerAttrs = {}
  local awakerList = player:GetAwakerList()
  for _, awaker in ipairs(awakerList) do
    awakerStates[awaker.uid] = ""
    awakerAttrs[awaker.uid] = awaker.property:GetBattleLog()
  end
  local monsterList = self.battleEngine.roleMgr:GetPosSortedRoleByCamp(bc.BattleCamp.Camp2)
  local monsterStates = {}
  local monsterAttrs = {}
  for _, monster in ipairs(monsterList) do
    monsterStates[monster.uid] = ""
    monsterAttrs[monster.uid] = monster.property:GetBattleLog()
  end
  local ownerStateList = self.battleEngine.stateMgr:GetStateList()
  for uid, stateList in pairs(ownerStateList) do
    for _, state in ipairs(stateList) do
      local str = string.format("\t[%s] %s 层\n", state.configData.CnID, state.data.layer)
      if uid == player.uid then
        playerStates = playerStates .. str
      elseif monsterStates[uid] then
        monsterStates[uid] = monsterStates[uid] .. str
      elseif awakerStates[uid] then
        awakerStates[uid] = awakerStates[uid] .. str
      end
    end
  end
  local otherAttrs = string.format("\n其他属性:\n\t贤石: %s\n\t压力值: %s", self.battleEngine:GetCurMoney(), self.battleEngine:GetStress())
  local ret = playerStates .. playerAttrs
  for _, awaker in ipairs(awakerList) do
    local awakerName = awaker.configData.CnID
    ret = ret .. awakerName .. "\n状态\n" .. awakerStates[awaker.uid] .. "属性\n" .. awakerAttrs[awaker.uid]
  end
  for _, monster in ipairs(monsterList) do
    local monsterName = monster:GetBattleLogName()
    ret = ret .. monsterName .. "\n状态\n" .. monsterStates[monster.uid] .. "属性\n" .. monsterAttrs[monster.uid]
  end
  self.battleEngine:LogBattle(ret .. otherAttrs)
end

function BattleLogMgrServer:PrintSnapShot()
  self.battleEngine:LogBattle("===============================战斗快照:===============================")
  self:AllStateBattleLog()
  self:AllCardBattleLog()
  self:AllStats()
  self.battleEngine:LogBattle("===============================战斗快照:===============================")
end

function BattleLogMgrServer:AllCardBattleLog()
  self.battleEngine:LogBattle("卡牌\n")
  local cardDataList = self.battleEngine.cardMgr:GetBattleLogCardData()
  for camp, cardData in pairs(cardDataList) do
    self.battleEngine:LogBattle("阵营 %s :", camp)
    self:LogCard(cardData)
  end
end

function BattleLogMgrServer:LogCard(cardData)
  local str = ""
  for name, cardDeck in pairs(cardData) do
    if #cardDeck <= 0 then
    else
      str = str .. string.format("\t%s卡牌列表:\n", name)
      for _, cardUid in ipairs(cardDeck) do
        local card = self.battleEngine:GetObj(cardUid)
        str = str .. string.format("\t\t%s [uid %s]\n", card.configData.CnID, card.uid)
        local ownerStateList = self.battleEngine.stateMgr:GetStateListByOwnerUid(card.uid)
        if ownerStateList and #ownerStateList > 0 then
          str = str .. string.format("\t\t状态:\n")
          for _, state in ipairs(ownerStateList) do
            str = str .. string.format("\t\t\t%s 层数: %s\n", state.configData.CnID, state.data.layer)
          end
        end
        str = str .. string.format("\t\t属性:\n")
        local propertiesStr = card.property:GetBattleLog(2)
        str = str .. string.format(propertiesStr)
      end
    end
  end
  self.battleEngine:LogBattle(str)
end

function BattleLogMgrServer:AllStats()
  if not self.battleEngine:IsPVE() then
    return
  end
  local statsMgr = self.battleEngine.statsMgr
  if not statsMgr then
    return
  end
  self.battleEngine:LogBattle("===== 战斗统计 =====")
  local battleCount = 1
  local boutCount = statsMgr:GetStats("GlobalStats", bc.StatsKey.BoutCount) or 0
  local curBoutCount = statsMgr:GetStats("BattleStats", bc.StatsKey.BoutCount) or 0
  self.battleEngine:LogBattle(string.format("统计时点：第 %d 场战斗，第 %d 回合。（已过共 %d 回合）", battleCount, curBoutCount, boutCount))
  self.battleEngine:LogBattle("")
  
  local function getRoleStatValue(statsData, statKey, roleTid)
    if not statsData or not statsData[statKey] then
      return 0
    end
    if type(statsData[statKey]) ~= "table" then
      return 0
    end
    return statsData[statKey][roleTid] or 0
  end
  
  local function getStatsCategory(roleTid, categoryName, statKey)
    local curBout = getRoleStatValue(statsMgr.curBoutStats, statKey, roleTid)
    local battle = getRoleStatValue(statsMgr.battleStats, statKey, roleTid)
    local global = getRoleStatValue(statsMgr.globalStats, statKey, roleTid)
    do return string.format, "\n\t\t本回合 %s：%d\n\t\t本战斗 %s：%d\n\t\t本探索 %s：%d", categoryName, curBout, categoryName, battle, categoryName end
    return string.format, "\n\t\t本回合 %s：%d\n\t\t本战斗 %s：%d\n\t\t本探索 %s：%d", categoryName, curBout, categoryName, battle, categoryName, global
  end
  
  local function getHistoryStats(roleTid)
    local lastBoutDamage = getRoleStatValue(statsMgr.lastBoutStats, bc.StatsKey.AwakerDoDamage, roleTid)
    local lastBoutBlock = getRoleStatValue(statsMgr.lastBoutStats, bc.StatsKey.AwakerDoBlock, roleTid)
    local lastBoutHeal = getRoleStatValue(statsMgr.lastBoutStats, bc.StatsKey.AwakerDoHeal, roleTid)
    if statsMgr.lastBattleStats then
      local lastBattleDamage = getRoleStatValue(statsMgr.lastBattleStats, bc.StatsKey.AwakerDoDamage, roleTid)
      local lastBattleBlock = getRoleStatValue(statsMgr.lastBattleStats, bc.StatsKey.AwakerDoBlock, roleTid)
      local lastBattleHeal = getRoleStatValue(statsMgr.lastBattleStats, bc.StatsKey.AwakerDoHeal, roleTid)
      do return string.format, "\t\t上回合 输出：%d\n\t\t上回合 护盾：%d\n\t\t上回合 治疗：%d\n\t\t上战斗 输出：%d\n\t\t上战斗 护盾：%d\n\t\t上战斗 治疗：%d", lastBoutDamage, lastBoutBlock, lastBoutHeal, lastBattleDamage, lastBattleBlock end
      return string.format, "\t\t上回合 输出：%d\n\t\t上回合 护盾：%d\n\t\t上回合 治疗：%d\n\t\t上战斗 输出：%d\n\t\t上战斗 护盾：%d\n\t\t上战斗 治疗：%d", lastBoutDamage, lastBoutBlock, lastBoutHeal, lastBattleDamage, lastBattleBlock, lastBattleHeal
    else
      do return string.format, "\t\t上回合 输出：%d\n\t\t上回合 护盾：%d\n\t\t上回合 治疗：%d", lastBoutDamage, lastBoutBlock end
      return string.format, "\t\t上回合 输出：%d\n\t\t上回合 护盾：%d\n\t\t上回合 治疗：%d", lastBoutDamage, lastBoutBlock, lastBoutHeal, lastBoutDamage, lastBoutBlock, lastBoutHeal, lastBattleDamage, lastBattleBlock, lastBattleHeal
    end
  end
  
  local function printRoleStatsDetail(roleTid, roleName)
    local damageStats = getStatsCategory(roleTid, "输出", bc.StatsKey.AwakerDoDamage)
    local blockStats = getStatsCategory(roleTid, "护盾", bc.StatsKey.AwakerDoBlock)
    local healStats = getStatsCategory(roleTid, "治疗", bc.StatsKey.AwakerDoHeal)
    local historyStats = getHistoryStats(roleTid)
    local fullStats = string.format([[
%s%s
			-----%s
			-----%s
			=====
%s
			=====]], roleName, damageStats, blockStats, healStats, historyStats)
    self.battleEngine:LogBattle(fullStats)
  end
  
  printRoleStatsDetail(0, "玩家")
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if player then
    local awakerList = player:GetAwakerList()
    for _, awaker in ipairs(awakerList) do
      local awakerName = awaker:GetBattleLogName()
      printRoleStatsDetail(awaker.tid, awakerName)
    end
  end
end

return BattleLogMgrServer
