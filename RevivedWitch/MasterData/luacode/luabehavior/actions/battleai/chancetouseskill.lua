-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/chancetouseskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local ChancetoUseSkill = class("ChancetoUseSkill", Task)
ChancetoUseSkill.Ctor = function(self, context, rate, skillid)
  -- function num : 0_0 , upvalues : ChancetoUseSkill, _ENV
  ((ChancetoUseSkill.super).Ctor)(self)
  self._context = context
  self._skillid = skillid
  self._rate = rate
  local entity = nil
  for i,e in ipairs(((self._context)._battleworld)._entitys) do
    if e._entityId == (self._context)._entityId then
      entity = e
      break
    end
  end
  do
    if entity then
      self._skillComponnet = entity:GetComponent((BattleECS.Components).SkillComponent)
    end
  end
end

ChancetoUseSkill.OnStart = function(self)
  -- function num : 0_1
end

ChancetoUseSkill.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._skillComponnet then
    local skillTable = nil
    for _,v in ipairs((self._skillComponnet)._skillList) do
      if self._skillid == v.skillId then
        skillTable = v
        break
      end
    end
    do
      do
        if skillTable then
          local randomNum = (((self._context)._battleworld)._randomPcg)(1, 100)
          if randomNum <= self._rate then
            return TaskStatus.Success
          else
            skillTable.currentTime = 0
          end
        end
        return TaskStatus.Failure
      end
    end
  end
end

ChancetoUseSkill.OnEnd = function(self)
  -- function num : 0_3
end

return ChancetoUseSkill

