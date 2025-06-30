-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/camphasbuff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local CampHasBuff = class("CampHasBuff", Task)
local CampType = {Enemy = 1, Friend = 2}
CampHasBuff.Ctor = function(self, context, camp, buffid, num)
  -- function num : 0_0 , upvalues : CampHasBuff, _ENV
  ((CampHasBuff.super).Ctor)(self)
  self._needCamp = camp
  self._buffid = buffid
  self._num = num
  self._rightPlayerList = (context._battleworld)._rightPlayerList
  self._leftPlayerList = (context._battleworld)._leftPlayerList
  self._leftPlayerSummonList = (context._battleworld)._leftPlayerSummonList
  self._rightPlayerSummonList = (context._battleworld)._rightPlayerSummonList
  self._entity = nil
  for i,e in ipairs((context._battleworld)._entitys) do
    if e._entityId == context._entityId then
      self._entity = e
      break
    end
  end
  do
    self._selfCamp = ((self._entity):GetComponent((BattleECS.Components).TypeComponent))._camp
  end
end

CampHasBuff.OnStart = function(self)
  -- function num : 0_1
end

CampHasBuff.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, CampType, TaskStatus
  local count = 0
  if self._entity then
    local TypeComponent = (BattleECS.Components).TypeComponent
    local BuffComponent = (BattleECS.Components).BuffComponent
    local flag = ""
    if self._selfCamp == (TypeComponent.CampType).Left then
      if self._needCamp == CampType.Enemy then
        flag = "right"
      else
        if self._needCamp == CampType.Friend then
          flag = "left"
        end
      end
    else
      if self._selfCamp == (TypeComponent.CampType).Right then
        if self._needCamp == CampType.Enemy then
          flag = "left"
        else
          if self._needCamp == CampType.Friend then
            flag = "right"
          end
        end
      end
    end
    if flag == "right" then
      for _,entity in ipairs(self._rightPlayerList) do
        local buffComponent = entity:GetComponent(BuffComponent)
        if buffComponent then
          for _,v in ipairs(buffComponent._buffList) do
            if self._buffid == v.buffId then
              count = count + 1
            end
          end
        end
      end
      for _,entity in ipairs(self._rightPlayerSummonList) do
        local buffComponent = entity:GetComponent(BuffComponent)
        if buffComponent then
          for _,v in ipairs(buffComponent._buffList) do
            if self._buffid == v.buffId then
              count = count + 1
            end
          end
        end
      end
    else
      do
        if flag == "left" then
          for _,entity in ipairs(self._leftPlayerList) do
            local buffComponent = entity:GetComponent(BuffComponent)
            if buffComponent then
              for _,v in ipairs(buffComponent._buffList) do
                if self._buffid == v.buffId then
                  count = count + 1
                end
              end
            end
          end
          for _,entity in ipairs(self._leftPlayerSummonList) do
            local buffComponent = entity:GetComponent(BuffComponent)
            if buffComponent then
              for _,v in ipairs(buffComponent._buffList) do
                if self._buffid == v.buffId then
                  count = count + 1
                end
              end
            end
          end
        end
        do
          if count == self._num then
            return TaskStatus.Success
          end
          return TaskStatus.Failure
        end
      end
    end
  end
end

CampHasBuff.OnEnd = function(self)
  -- function num : 0_3
end

return CampHasBuff

