-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsterinbattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterInBattle = class("MonsterInBattle", Task)
MonsterInBattle.Ctor = function(self, context, typeid, monsterid)
  -- function num : 0_0 , upvalues : MonsterInBattle, _ENV
  ((MonsterInBattle.super).Ctor)(self)
  self._monsterType = typeid
  self._monsterid = monsterid
  self._rightPlayerList = (context._battleworld)._rightPlayerList
  self._dataUtility = (BattleECS.Utility).DataUtility
end

MonsterInBattle.OnStart = function(self)
  -- function num : 0_1
end

MonsterInBattle.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  local TypeComponent = (BattleECS.Components).TypeComponent
  if self._monsterType == -1 then
    for _,v in ipairs(self._rightPlayerList) do
      if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
        return TaskStatus.Success
      end
    end
  else
    do
      for _,v in ipairs(self._rightPlayerList) do
        if (((self._dataUtility).cMonsterCfgTable)[(v:GetComponent(TypeComponent))._roleID]).MonsterType == self._monsterType then
          return TaskStatus.Success
        end
      end
      do
        return TaskStatus.Failure
      end
    end
  end
end

MonsterInBattle.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterInBattle

