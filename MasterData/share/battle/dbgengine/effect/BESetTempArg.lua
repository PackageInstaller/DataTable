local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BESetTempArg, Super = System.NewClass("BESetTempArg", BattleEffectServer)

function BESetTempArg:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BESetTempArg:Dispose()
  Super.Dispose(self)
end

function BESetTempArg:DoEffect()
  Super.DoEffect(self)
  local argIndex = self.params[1]
  if not argIndex or type(argIndex) ~= "number" then
    return false
  end
  argIndex = math.ceil(argIndex)
  local argValue = math.ceil(self.params[2])
  if not argValue then
    return false
  end
  local argKey = "TempArg" .. argIndex
  self.cmdServer:SetMemberValue(argKey, argValue)
  local apiCfg = self.battleEngine.battleDT.BattleApi[argKey]
  self.battleEngine:LogBattleWithTab("\t 【%s】 创建成功，值为 %s", apiCfg.CnID, argValue)
  self.battleEngine.recordMgr:OnSetTempArg(argKey, argValue)
  return true
end

return BESetTempArg
