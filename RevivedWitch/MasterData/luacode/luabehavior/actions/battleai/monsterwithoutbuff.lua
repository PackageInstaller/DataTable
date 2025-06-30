-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsterwithoutbuff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterWithoutBuff = class("MonsterWithoutBuff", Task)
MonsterWithoutBuff.Ctor = function(self, context, type, monsterid, buffid)
  -- function num : 0_0 , upvalues : MonsterWithoutBuff, _ENV
  ((MonsterWithoutBuff.super).Ctor)(self)
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
    self._monsterID = monsterid
    self._buffid = buffid
    self._rightPlayerList = (context._battleworld)._rightPlayerList
    self._leftPlayerList = (context._battleworld)._leftPlayerList
    self._camp = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp
    self._dataUtility = (BattleECS.Utility).DataUtility
  end
end

MonsterWithoutBuff.OnStart = function(self)
  -- function num : 0_1
end

MonsterWithoutBuff.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._entity then
    local BuffComponent = (BattleECS.Components).BuffComponent
    local TypeComponent = (BattleECS.Components).TypeComponent
    if self._monsterType == -1 then
      if self._monsterID == 0 then
        local buffComponent = (self._entity):GetComponent(BuffComponent)
        if buffComponent then
          for _,v in ipairs(buffComponent._buffList) do
            if self._buffid == v.buffId then
              return TaskStatus.Failure
            end
          end
        end
      else
        do
          if self._camp == 2 then
            local index = 0
            local isHasIndex = 0
            for _,v in ipairs(self._rightPlayerList) do
              if (v:GetComponent(TypeComponent))._roleID == self._monsterID then
                index = index + 1
                local buffComponent = v:GetComponent(BuffComponent)
                if buffComponent then
                  for _,inV in ipairs(buffComponent._buffList) do
                    if self._buffid == inV.buffId then
                      isHasIndex = isHasIndex + 1
                    end
                  end
                end
                do
                  do
                    do return TaskStatus.Failure end
                    -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          else
            do
              if self._camp == 1 then
                local index = 0
                local isHasIndex = 0
                for _,v in ipairs(self._leftPlayerList) do
                  if (v:GetComponent(TypeComponent))._roleID == self._monsterID then
                    index = index + 1
                    local buffComponent = v:GetComponent(BuffComponent)
                    if buffComponent then
                      for _,inV in ipairs(buffComponent._buffList) do
                        if self._buffid == inV.buffId then
                          isHasIndex = isHasIndex + 1
                        end
                      end
                    end
                    do
                      do
                        do return TaskStatus.Failure end
                        -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out IF_STMT

                      end
                    end
                  end
                end
              end
              do
                if self._camp == 2 then
                  local index = 0
                  local isHasIndex = 0
                  for _,v in ipairs(self._rightPlayerList) do
                    if (((self._dataUtility).cMonsterCfgTable)[(v:GetComponent(TypeComponent))._roleID]).MonsterType == self._monsterType then
                      index = index + 1
                      local buffComponent = v:GetComponent(BuffComponent)
                      if buffComponent then
                        for _,inV in ipairs(buffComponent._buffList) do
                          if self._buffid == inV.buffId then
                            isHasIndex = isHasIndex + 1
                          end
                        end
                      end
                    end
                  end
                  if index == isHasIndex then
                    return TaskStatus.Failure
                  end
                else
                  do
                    if self._camp == 1 then
                      local index = 0
                      local isHasIndex = 0
                      for _,v in ipairs(self._leftPlayerList) do
                        if (((self._dataUtility).cMonsterCfgTable)[(v:GetComponent(TypeComponent))._roleID]).MonsterType == self._monsterType then
                          index = index + 1
                          local buffComponent = v:GetComponent(BuffComponent)
                          if buffComponent then
                            for _,inV in ipairs(buffComponent._buffList) do
                              if self._buffid == inV.buffId then
                                isHasIndex = isHasIndex + 1
                              end
                            end
                          end
                        end
                      end
                      return TaskStatus.Failure
                    end
                    do
                      return TaskStatus.Success
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

MonsterWithoutBuff.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterWithoutBuff

