-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsteroutbattlenew.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterOutBattleNew = class("MonsterOutBattleNew", Task)
MonsterOutBattleNew.Ctor = function(self, context, typeid, monsterid)
  -- function num : 0_0 , upvalues : MonsterOutBattleNew, _ENV
  ((MonsterOutBattleNew.super).Ctor)(self)
  self._monsterType = typeid
  self._monsterid = monsterid
  self._rightPlayerList = (context._battleworld)._rightPlayerList
  self._rightPlayerSummonList = (context._battleworld)._rightPlayerSummonList
  self._dataUtility = (BattleECS.Utility).DataUtility
end

MonsterOutBattleNew.OnStart = function(self)
  -- function num : 0_1
end

MonsterOutBattleNew.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  local TypeComponent = (BattleECS.Components).TypeComponent
  if self._monsterType == -1 then
    for _,v in ipairs(self._rightPlayerList) do
      if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
        return TaskStatus.Failure
      end
    end
    for _,v in ipairs(self._rightPlayerSummonList) do
      if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
        return TaskStatus.Failure
      end
    end
  else
    do
      for _,v in ipairs(self._rightPlayerList) do
        if (((self._dataUtility).cMonsterCfgTable)[(v:GetComponent(TypeComponent))._roleID]).MonsterType == self._monsterType then
          return TaskStatus.Failure
        end
      end
      for _,v in ipairs(self._rightPlayerSummonList) do
        if (((self._dataUtility).cMonsterCfgTable)[(v:GetComponent(TypeComponent))._roleID]).MonsterType == self._monsterType then
          return TaskStatus.Failure
        end
      end
      do
        return TaskStatus.Success
      end
    end
  end
end

MonsterOutBattleNew.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterOutBattleNew

