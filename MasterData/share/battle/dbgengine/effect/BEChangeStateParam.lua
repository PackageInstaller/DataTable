local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEChangeStateParam, Super = System.NewClass("BEChangeStateParam", BattleEffectServer)

function BEChangeStateParam:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local stateId = self.params[1]
  local stateArgIndex = self.params[2] or 1
  local newValueExpr = self.params[3]
  if not (targets and stateId) or not newValueExpr then
    self.battleEngine.logger:WarningS("BEChangeStateParam: 参数不完整 {stateId} {stateArgIndex} {newValueExpr}", stateId, stateArgIndex, newValueExpr)
    return false
  end
  if stateArgIndex < 1 then
    self.battleEngine.logger:WarningS("BEChangeStateParam: stateArgIndex 必须 >= 1 {stateArgIndex}", stateArgIndex)
    return false
  end
  local newValue = self.cmdServer:GetValueByCmd(newValueExpr)
  if nil == newValue then
    self.battleEngine.logger:WarningS("BEChangeStateParam: 无法解析新值表达式 {newValueExpr}", newValueExpr)
    return false
  end
  local successCount = 0
  for _, target in ipairs(targets) do
    local state = self.battleEngine.stateMgr:GetState(target, stateId)
    if state then
      while stateArgIndex > #state.stateParams do
        table.insert(state.stateParams, 0)
      end
      local oldValue = state.stateParams[stateArgIndex] or 0
      state.stateParams[stateArgIndex] = newValue
      self.battleEngine:LogBattleWithTab("改变状态参数: %s 的状态 %s [%s] StateArg%d: %s -> %s", target:GetBattleLogName(), state.configData.CnID, state.uid, stateArgIndex, oldValue, newValue)
      state:UpdateStateArgs()
      successCount = successCount + 1
    else
      self.battleEngine.logger:InfoS("BEChangeStateParam: 目标 {targetName} 上未找到状态 {stateId}", target:GetBattleLogName(), stateId)
    end
  end
  if successCount > 0 then
    self.battleEngine.stateMgr:UpdateStateArgs()
  end
  return successCount > 0
end

return BEChangeStateParam
