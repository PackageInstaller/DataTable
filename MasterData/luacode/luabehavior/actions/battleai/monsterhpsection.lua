local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterHpSection = class("MonsterHpSection", Task)

function MonsterHpSection:Ctor(context, monsterid, hpleft, hpright)
  MonsterHpSection.super.Ctor(self)
  self._context = context
  self._monsterid = monsterid
  self._hpLeft = hpleft
  self._hpRight = hpright
  self._entity = nil
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
end

function MonsterHpSection:OnStart()
end

function MonsterHpSection:OnUpdate(deltaTime)
  if self._entity then
    local HpComponent = BattleECS.Components.HpComponent
    local TypeComponent = BattleECS.Components.TypeComponent
    if self._monsterid == 0 then
      local hpComponent = self._entity:GetComponent(HpComponent)
      if hpComponent._currentHp >= self._hpLeft and hpComponent._currentHp <= self._hpRight then
        return TaskStatus.Success
      end
    else
      for _, v in ipairs(self._context._battleworld._rightPlayerList) do
        if v:GetComponent(TypeComponent)._roleID == self._monsterid then
          local hpComponent = v:GetComponent(HpComponent)
          if hpComponent._currentHp >= self._hpLeft and hpComponent._currentHp <= self._hpRight then
            return TaskStatus.Success
          end
        end
      end
      for _, v in ipairs(self._context._battleworld._leftPlayerList) do
        if v:GetComponent(TypeComponent)._roleID == self._monsterid then
          local hpComponent = v:GetComponent(HpComponent)
          if hpComponent._currentHp >= self._hpLeft and hpComponent._currentHp <= self._hpRight then
            return TaskStatus.Success
          end
        end
      end
    end
  end
  return TaskStatus.Failure
end

function MonsterHpSection:OnEnd()
end

return MonsterHpSection
