local System = require("System.System")
local BattleCmdBaseExpression = require("Battle.DbgEngine.Cmd.Expression.BattleCmdBaseExpression")
local bc = require("Battle.BattleConst")
local BattleCmdStasticsExp, Super = System.NewClass("BattleCmdStasticsExp", BattleCmdBaseExpression)

function BattleCmdStasticsExp:ctor(cmdParser, type)
  Super.ctor(self)
  self.battleEngine = cmdParser.battleEngine
  self.statsMgr = self.battleEngine.statsMgr
  if self.battleEngine:IsPVP() then
    local player = self.battleEngine.roleMgr:GetPlayer(cmdParser:GetCasterCamp())
    self.statsMgr = player.battleStats
  end
  self.cmdServer = cmdParser.cmdServer
  self.type = type
  self:InitGetter(cmdParser.battleEngine.battleDT)
end

function BattleCmdStasticsExp:GetAttr(attrName)
  if self.type == "CurCmdStats" then
    if self.cmdServer == nil then
      return 0
    end
    local ret = self.cmdServer:GetStats(attrName) or 0
    return ret
  end
  do return self.statsMgr.GetStats, self.statsMgr, self.type end
  return self.statsMgr.GetStats, self.statsMgr, self.type, attrName
end

function BattleCmdStasticsExp:GetUsedCountOfCardByConfigId(cardConfigId)
  if self.type == "CurCmdStats" then
    if self.cmdServer == nil then
      return 0
    end
    local usedCardStats = self.cmdServer:GetStats(bc.StatsKey.UsedCardCount)
    if nil == usedCardStats then
      return 0
    end
    return usedCardStats[cardConfigId] or 0
  end
  do return self.statsMgr.GetUsedCountOfCardByConfigId, self.statsMgr, self.type end
  return self.statsMgr.GetUsedCountOfCardByConfigId, self.statsMgr, self.type, cardConfigId
end

return BattleCmdStasticsExp
