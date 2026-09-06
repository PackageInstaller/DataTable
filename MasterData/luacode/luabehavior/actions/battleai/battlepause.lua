local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local BattlePause = class("BattlePause", Task)

function BattlePause:Ctor(context, pauseType, param)
  BattlePause.super.Ctor(self)
  self._context = context
  self._pauseType = pauseType
  self._param = param
end

function BattlePause:OnStart()
end

function BattlePause:OnUpdate()
  local sendProtocol = true
  local BattlePauseType = BattleClientProtocolManager.GetBeanDef("data.battlepausetype")
  if self._pauseType == BattlePauseType.NpcChat then
    local chatId = tonumber(self._param)
    if not chatId or chatId == 0 then
      sendProtocol = false
    end
  end
  if sendProtocol then
    local protocol = BattleClientProtocolManager.CreateProtocol("action.sbattlepause")
    protocol.pauseType = self._pauseType
    protocol.param = self._param
    self._context._battleworld:InsertViewProtocolData(protocol)
  end
  return TaskStatus.Success
end

function BattlePause:OnEnd()
end

return BattlePause
