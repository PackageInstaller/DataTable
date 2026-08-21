-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monstertypehasbuff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterTypeHasBuff = class("MonsterTypeHasBuff", Task)
MonsterTypeHasBuff.Ctor = function(self, context, type, buffid)
  -- function num : 0_0 , upvalues : MonsterTypeHasBuff, _ENV
  ((MonsterTypeHasBuff.super).Ctor)(self)
  self._context = context
  self._entity = nil
  for i,e in ipairs(((self._context)._battleworld)._entitys) do
    if e._entityId == (self._context)._entityId then
      self._entity = e
      break
    end
  end
  do
    self._monsterType = type
    self._buffid = buffid
    self._rightPlayerList = (context._battleworld)._rightPlayerList
    self._leftPlayerList = (context._battleworld)._leftPlayerList
    self._camp = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp
    self._dataUtility = (BattleECS.Utility).DataUtility
  end
end

MonsterTypeHasBuff.OnStart = function(self)
  -- function num : 0_1
end

MonsterTypeHasBuff.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._entity then
    local TypeComponent = (BattleECS.Components).TypeComponent
    local BuffComponent = (BattleECS.Components).BuffComponent
    if self._camp == 2 then
      for _,v in ipairs(self._rightPlayerList) do
        if (((self._dataUtility).cMonsterCfgTable)[(v:GetComponent(TypeComponent))._roleID]).MonsterType == self._monsterType then
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
            if (((self._dataUtility).cMonsterCfgTable)[(v:GetComponent(TypeComponent))._roleID]).MonsterType == self._monsterType then
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

MonsterTypeHasBuff.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterTypeHasBuff

