local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterHpPercentSection = class("MonsterHpPercentSection", Task)

function MonsterHpPercentSection:Ctor(context, monsterid, hpleft, hpright)
  MonsterHpPercentSection.super.Ctor(self)
  self._context = context
  self._monsterid = monsterid
  self._entity = nil
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
  if hpleft == 100 then
    self._hpLeft = 1
  else
    self._hpLeft = fixedpoint(hpleft) / 100
  end
  if hpright == 100 then
    self._hpRight = 1
  else
    self._hpRight = fixedpoint(hpright) / 100
  end
end

function MonsterHpPercentSection:OnStart()
end

function MonsterHpPercentSection:OnUpdate(deltaTime)
  if self._entity then
    local HpComponent = BattleECS.Components.HpComponent
    local TypeComponent = BattleECS.Components.TypeComponent
    if self._monsterid == 0 then
      local hpComponent = self._entity:GetComponent(HpComponent)
      if hpComponent._currentHp >= hpComponent._maxHp * self._hpLeft and hpComponent._currentHp <= hpComponent._maxHp * self._hpRight then
        return TaskStatus.Success
      end
    else
      for _, v in ipairs(self._context._battleworld._rightPlayerList) do
        if v:GetComponent(TypeComponent)._roleID == self._monsterid then
          local hpComponent = v:GetComponent(HpComponent)
          if hpComponent._currentHp >= hpComponent._maxHp * self._hpLeft and hpComponent._currentHp <= hpComponent._maxHp * self._hpRight then
            return TaskStatus.Success
          end
        end
      end
      for _, v in ipairs(self._context._battleworld._leftPlayerList) do
        if v:GetComponent(TypeComponent)._roleID == self._monsterid then
          local hpComponent = v:GetComponent(HpComponent)
          if hpComponent._currentHp >= hpComponent._maxHp * self._hpLeft and hpComponent._currentHp <= hpComponent._maxHp * self._hpRight then
            return TaskStatus.Success
          end
        end
      end
    end
  end
  return TaskStatus.Failure
end

function MonsterHpPercentSection:OnEnd()
end

return MonsterHpPercentSection
