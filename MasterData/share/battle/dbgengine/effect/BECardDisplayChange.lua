local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BECardDisplayChange, Super = System.NewClass("BECardDisplayChange", BattleEffectServer)

function BECardDisplayChange:DoEffect()
  Super.DoEffect(self)
  local skillTid = self.params and self.params[1]
  if not skillTid or not self.battleEngine.battleDT.Skill[skillTid] then
    self.battleEngine:Warn("BECardDisplayChange 目标卡牌技能tid非法", tostring(skillTid))
    return false
  end
  local card = self:GetDisplayCard()
  if not card then
    self.battleEngine:Warn("BECardDisplayChange 找不到当前行动卡牌")
    return false
  end
  local sfxId = self.params[2]
  if 0 == sfxId then
    sfxId = nil
  end
  local srcHoldTimeMs = tonumber(self.params[3]) or 0
  local dstHoldTimeMs = tonumber(self.params[4]) or 0
  local condList, skillArgs, descArgs = self:__ResolveDisplayCondAndArgs(skillTid)
  self.battleEngine:LogBattleWithTab("卡牌表现替换：卡牌%s 切换为技能%s 特效%s 滞留%s/%s", card.uid, skillTid, tostring(sfxId), srcHoldTimeMs, dstHoldTimeMs)
  self.battleEngine.recordMgr:OnCardDisplayChange(card.uid, skillTid, sfxId, srcHoldTimeMs, dstHoldTimeMs, condList, skillArgs, descArgs)
  return true
end

function BECardDisplayChange:GetDisplayCard()
  local target = self.targets and self.targets[1]
  if target then
    return target:is(BattleCardServer) and target or nil
  end
  if self.cmdCfg and self.cmdCfg.Target then
    return nil
  end
  local cardUid = self.cmdServer and self.cmdServer.cardUid
  local card = cardUid and self.battleEngine:GetObj(cardUid)
  return card and card:is(BattleCardServer) and card or nil
end

function BECardDisplayChange:__ResolveDisplayCondAndArgs(skillTid)
  local cmdServer = self.cmdServer
  local skillCfg = self.battleEngine.battleDT.Skill[skillTid]
  if not (cmdServer and cmdServer.cmdCtorData) or not skillCfg then
    return nil, nil, nil
  end
  local ctorData = table.clone(cmdServer.cmdCtorData)
  ctorData.skillConfigId = skillTid
  ctorData.configPara = nil
  ctorData.createCardArgs = nil
  local displayCmdServer = BattleCmdServer(self.battleEngine, ctorData)
  local skillArgs, descArgs = displayCmdServer:GetSkillArgs()
  local condList = {}
  
  local function tryAddCondIndex(key, tempField)
    local list = skillCfg[tempField]
    if type(list) ~= "table" then
      return
    end
    local index = BattleUtilServer.GetTrueConditionIndexByCmd(displayCmdServer, list)
    if index then
      condList[key] = index
    end
  end
  
  tryAddCondIndex("tempBattleDesc", "tempBattleDesc")
  tryAddCondIndex("name", "tempName")
  tryAddCondIndex("icon", "tempIcon")
  if not next(condList) then
    condList = nil
  end
  return condList, skillArgs, descArgs
end

return BECardDisplayChange
