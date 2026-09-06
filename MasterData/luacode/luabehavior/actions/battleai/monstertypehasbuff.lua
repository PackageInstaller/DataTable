local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterTypeHasBuff = class("MonsterTypeHasBuff", Task)

function MonsterTypeHasBuff:Ctor(context, type, buffid)
  MonsterTypeHasBuff.super.Ctor(self)
  self._context = context
  self._entity = nil
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
  self._monsterType = type
  self._buffid = buffid
  self._rightPlayerList = context._battleworld._rightPlayerList
  self._leftPlayerList = context._battleworld._leftPlayerList
  self._camp = self._entity:GetComponent(BattleECS.Components.TypeComponent)._camp
  self._dataUtility = BattleECS.Utility.DataUtility
end

function MonsterTypeHasBuff:OnStart()
end

function MonsterTypeHasBuff:OnUpdate(deltaTime)
  if self._entity then
    local TypeComponent = BattleECS.Components.TypeComponent
    local BuffComponent = BattleECS.Components.BuffComponent
    if self._camp == 2 then
      for _, v in ipairs(self._rightPlayerList) do
        if self._dataUtility.cMonsterCfgTable[v:GetComponent(TypeComponent)._roleID].MonsterType == self._monsterType then
          local buffComponent = v:GetComponent(BuffComponent)
          if buffComponent then
            for _, inV in ipairs(buffComponent._buffList) do
              if self._buffid == inV.buffId then
                return TaskStatus.Success
              end
            end
          end
        end
      end
    elseif self._camp == 1 then
      for _, v in ipairs(self._leftPlayerList) do
        if self._dataUtility.cMonsterCfgTable[v:GetComponent(TypeComponent)._roleID].MonsterType == self._monsterType then
          local buffComponent = v:GetComponent(BuffComponent)
          if buffComponent then
            for _, inV in ipairs(buffComponent._buffList) do
              if self._buffid == inV.buffId then
                return TaskStatus.Success
              end
            end
          end
        end
      end
    end
  end
  return TaskStatus.Failure
end

function MonsterTypeHasBuff:OnEnd()
end

return MonsterTypeHasBuff
