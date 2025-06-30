-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/battlepause.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local BattlePause = class("BattlePause", Task)
BattlePause.Ctor = function(self, context, pauseType, param)
  -- function num : 0_0 , upvalues : BattlePause
  ((BattlePause.super).Ctor)(self)
  self._context = context
  self._pauseType = pauseType
  self._param = param
end

BattlePause.OnStart = function(self)
  -- function num : 0_1
end

BattlePause.OnUpdate = function(self)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  local sendProtocol = true
  local BattlePauseType = (BattleClientProtocolManager.GetBeanDef)("data.battlepausetype")
  do
    if self._pauseType == BattlePauseType.NpcChat then
      local chatId = tonumber(self._param)
      if not chatId or chatId == 0 then
        sendProtocol = false
      end
    end
    do
      if sendProtocol then
        local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sbattlepause")
        protocol.pauseType = self._pauseType
        protocol.param = self._param
        ;
        ((self._context)._battleworld):InsertViewProtocolData(protocol)
      end
      return TaskStatus.Success
    end
  end
end

BattlePause.OnEnd = function(self)
  -- function num : 0_3
end

return BattlePause

