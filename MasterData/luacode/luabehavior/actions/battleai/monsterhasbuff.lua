local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterHasBuff = class("MonsterHasBuff", Task)

function MonsterHasBuff:Ctor(context, monsterid, buffid)
  MonsterHasBuff.super.Ctor(self)
  self._monsterid = monsterid
  self._buffid = buffid
  self._rightPlayerList = context._battleworld._rightPlayerList
  self._leftPlayerList = context._battleworld._leftPlayerList
  self._entity = nil
  for i, e in ipairs(context._battleworld._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
  self._camp = self._entity:GetComponent(BattleECS.Components.TypeComponent)._camp
end

function MonsterHasBuff:OnStart()
end

function MonsterHasBuff:OnUpdate(deltaTime)
  if self._entity then
    local BuffComponent = BattleECS.Components.BuffComponent
    local TypeComponent = BattleECS.Components.TypeComponent
    if self._monsterid == 0 then
      local buffComponent = self._entity:GetComponent(BuffComponent)
      if buffComponent then
        for _, v in ipairs(buffComponent._buffList) do
          if self._buffid == v.buffId then
            return TaskStatus.Success
          end
        end
      end
    end
    if self._camp == 2 then
      for _, v in ipairs(self._rightPlayerList) do
        if v:GetComponent(TypeComponent)._roleID == self._monsterid then
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
        if v:GetComponent(TypeComponent)._roleID == self._monsterid then
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

function MonsterHasBuff:OnEnd()
end

return MonsterHasBuff
