local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local BattleResult = class("BattleResult", Task)
local BattleEndType = BattleClientProtocolManager.GetBeanDef("data.battleendtype")
local ResultType = {Success = 1, Failed = 2}

function BattleResult:Ctor(context, param)
  BattleResult.super.Ctor(self)
  self._param = param
  self._context = context
end

function BattleResult:OnStart()
end

function BattleResult:OnUpdate()
  if self._param == ResultType.Success then
    self._context._battleworld:OnCBattleKill({
      type = BattleEndType.LeftWin
    })
  elseif self._param == ResultType.Failed then
    self._context._battleworld:OnCBattleKill({
      type = BattleEndType.RightWin
    })
  else
    LogErrorFormat("BattleResult", "TaskStatus.Failure : param % is wrong", self._param)
    return
  end
  return TaskStatus.Success
end

function BattleResult:OnEnd()
end

return BattleResult
