-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/battleresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local BattleResult = class("BattleResult", Task)
local BattleEndType = (BattleClientProtocolManager.GetBeanDef)("data.battleendtype")
local ResultType = {Success = 1, Failed = 2}
BattleResult.Ctor = function(self, context, param)
  -- function num : 0_0 , upvalues : BattleResult
  ((BattleResult.super).Ctor)(self)
  self._param = param
  self._context = context
end

BattleResult.OnStart = function(self)
  -- function num : 0_1
end

BattleResult.OnUpdate = function(self)
  -- function num : 0_2 , upvalues : ResultType, BattleEndType, _ENV, TaskStatus
  if self._param == ResultType.Success then
    ((self._context)._battleworld):OnCBattleKill({type = BattleEndType.LeftWin})
  else
    if self._param == ResultType.Failed then
      ((self._context)._battleworld):OnCBattleKill({type = BattleEndType.RightWin})
    else
      LogErrorFormat("BattleResult", "TaskStatus.Failure : param % is wrong", self._param)
      return 
    end
  end
  return TaskStatus.Success
end

BattleResult.OnEnd = function(self)
  -- function num : 0_3
end

return BattleResult

