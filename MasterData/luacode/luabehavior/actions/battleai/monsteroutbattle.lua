local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterOutBattle = class("MonsterOutBattle", Task)

function MonsterOutBattle:Ctor(context, typeid, monsterid)
  MonsterOutBattle.super.Ctor(self)
  self._monsterType = typeid
  self._monsterid = monsterid
  self._rightPlayerList = context._battleworld._rightPlayerList
  self._dataUtility = BattleECS.Utility.DataUtility
end

function MonsterOutBattle:OnStart()
end

function MonsterOutBattle:OnUpdate(deltaTime)
  local TypeComponent = BattleECS.Components.TypeComponent
  if self._monsterType == -1 then
    for _, v in ipairs(self._rightPlayerList) do
      if v:GetComponent(TypeComponent)._roleID == self._monsterid then
        return TaskStatus.Failure
      end
    end
  else
    for _, v in ipairs(self._rightPlayerList) do
      if self._dataUtility.cMonsterCfgTable[v:GetComponent(TypeComponent)._roleID].MonsterType == self._monsterType then
        return TaskStatus.Failure
      end
    end
  end
  return TaskStatus.Success
end

function MonsterOutBattle:OnEnd()
end

return MonsterOutBattle
