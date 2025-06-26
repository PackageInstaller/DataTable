-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsterhppercentsection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterHpPercentSection = class("MonsterHpPercentSection", Task)
MonsterHpPercentSection.Ctor = function(self, context, monsterid, hpleft, hpright)
  -- function num : 0_0 , upvalues : MonsterHpPercentSection, _ENV
  ((MonsterHpPercentSection.super).Ctor)(self)
  self._context = context
  self._monsterid = monsterid
  self._entity = nil
  for i,e in ipairs(((self._context)._battleworld)._entitys) do
    if e._entityId == (self._context)._entityId then
      self._entity = e
      break
    end
  end
  do
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
end

MonsterHpPercentSection.OnStart = function(self)
  -- function num : 0_1
end

MonsterHpPercentSection.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._entity then
    local HpComponent = (BattleECS.Components).HpComponent
    local TypeComponent = (BattleECS.Components).TypeComponent
    if self._monsterid == 0 then
      local hpComponent = (self._entity):GetComponent(HpComponent)
      if hpComponent._maxHp * self._hpLeft <= hpComponent._currentHp and hpComponent._currentHp <= hpComponent._maxHp * self._hpRight then
        return TaskStatus.Success
      end
    else
      do
        for _,v in ipairs(((self._context)._battleworld)._rightPlayerList) do
          if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
            local hpComponent = v:GetComponent(HpComponent)
            if hpComponent._maxHp * self._hpLeft <= hpComponent._currentHp and hpComponent._currentHp <= hpComponent._maxHp * self._hpRight then
              return TaskStatus.Success
            end
          end
        end
        for _,v in ipairs(((self._context)._battleworld)._leftPlayerList) do
          if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
            local hpComponent = v:GetComponent(HpComponent)
            if hpComponent._maxHp * self._hpLeft <= hpComponent._currentHp and hpComponent._currentHp <= hpComponent._maxHp * self._hpRight then
              return TaskStatus.Success
            end
          end
        end
        do
          return TaskStatus.Failure
        end
      end
    end
  end
end

MonsterHpPercentSection.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterHpPercentSection

