local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleCmdTargetsExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdTargetsExp")
local BECopyTargetStates, Super = System.NewClass("BECopyTargetStates", BattleEffectServer)

function BECopyTargetStates:CopyState(target, stateList)
  for _, state in ipairs(stateList) do
    local effectType = bc.BattleEffectType.BEAddState
    local params = {
      state.stateId,
      state.data.layer
    }
    for _, param in ipairs(state.stateParams) do
      table.insert(params, param)
    end
    local effectConfig = {
      effectType = effectType,
      targets = {target},
      params = params,
      cmdServer = self.cmdServer,
      source = table.deepclone(state.source),
      noDirectCmd = true
    }
    self.battleEngine.effectMgr:CreateEffect(effectConfig)
  end
end

function BECopyTargetStates:DoEffect()
  Super.DoEffect(self)
  local copySource = self.params[1]
  if not (copySource and copySource.is) or not copySource:is(BattleCmdTargetsExp) then
    return false
  end
  local copyType = self.params[2] or 0
  local copySourceAwakerList = copySource:GetTargetList()
  for _, target in ipairs(self.targets) do
    if not target:IsRoleType(bc.RoleType.Awaker) then
      return false
    end
    for _, copySourceAwaker in ipairs(copySourceAwakerList) do
      local stateList = self.battleEngine.stateMgr:GetStateByOwnerUidAndCopyType(copySourceAwaker.uid, copyType)
      self:CopyState(target, stateList)
    end
  end
  return true
end

return BECopyTargetStates
