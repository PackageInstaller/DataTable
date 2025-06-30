-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsterhpsection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterHpSection = class("MonsterHpSection", Task)
MonsterHpSection.Ctor = function(self, context, monsterid, hpleft, hpright)
  -- function num : 0_0 , upvalues : MonsterHpSection, _ENV
  ((MonsterHpSection.super).Ctor)(self)
  self._context = context
  self._monsterid = monsterid
  self._hpLeft = hpleft
  self._hpRight = hpright
  self._entity = nil
  for i,e in ipairs(((self._context)._battleworld)._entitys) do
    if e._entityId == (self._context)._entityId then
      self._entity = e
      break
    end
  end
end

MonsterHpSection.OnStart = function(self)
  -- function num : 0_1
end

MonsterHpSection.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._entity then
    local HpComponent = (BattleECS.Components).HpComponent
    local TypeComponent = (BattleECS.Components).TypeComponent
    if self._monsterid == 0 then
      local hpComponent = (self._entity):GetComponent(HpComponent)
      if self._hpLeft <= hpComponent._currentHp and hpComponent._currentHp <= self._hpRight then
        return TaskStatus.Success
      end
    else
      do
        for _,v in ipairs(((self._context)._battleworld)._rightPlayerList) do
          if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
            local hpComponent = v:GetComponent(HpComponent)
            if self._hpLeft <= hpComponent._currentHp and hpComponent._currentHp <= self._hpRight then
              return TaskStatus.Success
            end
          end
        end
        for _,v in ipairs(((self._context)._battleworld)._leftPlayerList) do
          if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
            local hpComponent = v:GetComponent(HpComponent)
            if self._hpLeft <= hpComponent._currentHp and hpComponent._currentHp <= self._hpRight then
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

MonsterHpSection.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterHpSection

