-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsterhasbuff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterHasBuff = class("MonsterHasBuff", Task)
MonsterHasBuff.Ctor = function(self, context, monsterid, buffid)
  -- function num : 0_0 , upvalues : MonsterHasBuff, _ENV
  ((MonsterHasBuff.super).Ctor)(self)
  self._monsterid = monsterid
  self._buffid = buffid
  self._rightPlayerList = (context._battleworld)._rightPlayerList
  self._leftPlayerList = (context._battleworld)._leftPlayerList
  self._entity = nil
  for i,e in ipairs((context._battleworld)._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
  do
    self._camp = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp
  end
end

MonsterHasBuff.OnStart = function(self)
  -- function num : 0_1
end

MonsterHasBuff.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._entity then
    local BuffComponent = (BattleECS.Components).BuffComponent
    local TypeComponent = (BattleECS.Components).TypeComponent
    if self._monsterid == 0 then
      local buffComponent = (self._entity):GetComponent(BuffComponent)
      if buffComponent then
        for _,v in ipairs(buffComponent._buffList) do
          if self._buffid == v.buffId then
            return TaskStatus.Success
          end
        end
      end
    end
    do
      if self._camp == 2 then
        for _,v in ipairs(self._rightPlayerList) do
          if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
            local buffComponent = v:GetComponent(BuffComponent)
            if buffComponent then
              for _,inV in ipairs(buffComponent._buffList) do
                if self._buffid == inV.buffId then
                  return TaskStatus.Success
                end
              end
            end
          end
        end
      else
        do
          if self._camp == 1 then
            for _,v in ipairs(self._leftPlayerList) do
              if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
                local buffComponent = v:GetComponent(BuffComponent)
                if buffComponent then
                  for _,inV in ipairs(buffComponent._buffList) do
                    if self._buffid == inV.buffId then
                      return TaskStatus.Success
                    end
                  end
                end
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
end

MonsterHasBuff.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterHasBuff

