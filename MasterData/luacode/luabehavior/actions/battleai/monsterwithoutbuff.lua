local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterWithoutBuff = class("MonsterWithoutBuff", Task)

function MonsterWithoutBuff:Ctor(context, type, monsterid, buffid)
  MonsterWithoutBuff.super.Ctor(self)
  self._context = context
  self._entity = nil
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
  self._monsterType = type
  self._monsterID = monsterid
  self._buffid = buffid
  self._rightPlayerList = context._battleworld._rightPlayerList
  self._leftPlayerList = context._battleworld._leftPlayerList
  self._camp = self._entity:GetComponent(BattleECS.Components.TypeComponent)._camp
  self._dataUtility = BattleECS.Utility.DataUtility
end

function MonsterWithoutBuff:OnStart()
end

function MonsterWithoutBuff:OnUpdate(deltaTime)
  if self._entity then
    local BuffComponent = BattleECS.Components.BuffComponent
    local TypeComponent = BattleECS.Components.TypeComponent
    if self._monsterType == -1 then
      if self._monsterID == 0 then
        local buffComponent = self._entity:GetComponent(BuffComponent)
        if buffComponent then
          for _, v in ipairs(buffComponent._buffList) do
            if self._buffid == v.buffId then
              return TaskStatus.Failure
            end
          end
        end
      elseif self._camp == 2 then
        local index = 0
        local isHasIndex = 0
        for _, v in ipairs(self._rightPlayerList) do
          if v:GetComponent(TypeComponent)._roleID == self._monsterID then
            index = index + 1
            local buffComponent = v:GetComponent(BuffComponent)
            if buffComponent then
              for _, inV in ipairs(buffComponent._buffList) do
                if self._buffid == inV.buffId then
                  isHasIndex = isHasIndex + 1
                end
              end
            end
            return TaskStatus.Failure
          end
        end
      elseif self._camp == 1 then
        local index = 0
        local isHasIndex = 0
        for _, v in ipairs(self._leftPlayerList) do
          if v:GetComponent(TypeComponent)._roleID == self._monsterID then
            index = index + 1
            local buffComponent = v:GetComponent(BuffComponent)
            if buffComponent then
              for _, inV in ipairs(buffComponent._buffList) do
                if self._buffid == inV.buffId then
                  isHasIndex = isHasIndex + 1
                end
              end
            end
            return TaskStatus.Failure
          end
        end
      end
    elseif self._camp == 2 then
      local index = 0
      local isHasIndex = 0
      for _, v in ipairs(self._rightPlayerList) do
        if self._dataUtility.cMonsterCfgTable[v:GetComponent(TypeComponent)._roleID].MonsterType == self._monsterType then
          index = index + 1
          local buffComponent = v:GetComponent(BuffComponent)
          if buffComponent then
            for _, inV in ipairs(buffComponent._buffList) do
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
    elseif self._camp == 1 then
      local index = 0
      local isHasIndex = 0
      for _, v in ipairs(self._leftPlayerList) do
        if self._dataUtility.cMonsterCfgTable[v:GetComponent(TypeComponent)._roleID].MonsterType == self._monsterType then
          index = index + 1
          local buffComponent = v:GetComponent(BuffComponent)
          if buffComponent then
            for _, inV in ipairs(buffComponent._buffList) do
              if self._buffid == inV.buffId then
                isHasIndex = isHasIndex + 1
              end
            end
          end
        end
      end
      return TaskStatus.Failure
    end
  end
  return TaskStatus.Success
end

function MonsterWithoutBuff:OnEnd()
end

return MonsterWithoutBuff
