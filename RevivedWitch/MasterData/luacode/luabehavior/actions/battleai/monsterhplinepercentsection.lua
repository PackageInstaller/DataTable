-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/monsterhplinepercentsection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterHpLinePercentSection = class("MonsterHpLinePercentSection", Task)
MonsterHpLinePercentSection.Ctor = function(self, context, monsterid, hpleft, hpright)
  -- function num : 0_0 , upvalues : MonsterHpLinePercentSection, _ENV
  ((MonsterHpLinePercentSection.super).Ctor)(self)
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
    self._dataUtility = (BattleECS.Utility).DataUtility
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

MonsterHpLinePercentSection.OnStart = function(self)
  -- function num : 0_1
end

MonsterHpLinePercentSection.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._entity then
    local HpComponent = (BattleECS.Components).HpComponent
    local TypeComponent = (BattleECS.Components).TypeComponent
    if self._monsterid == 0 then
      local hpComponent = (self._entity):GetComponent(HpComponent)
      if hpComponent then
        local lossHpNum = hpComponent._maxHp - hpComponent._currentHp
        local record = ((self._dataUtility).cMonsterCfgTable)[((self._entity):GetComponent(TypeComponent))._roleID]
        if record then
          for _,bossHpTable in ipairs(((self._context)._battleworld)._bossHpStage) do
            local bossHpTableNum = bossHpTable.num
            if not (fixedpoint.judgetype)(bossHpTableNum) then
              bossHpTableNum = fixedpoint(bossHpTableNum)
            end
            if lossHpNum - bossHpTableNum > 0 then
              lossHpNum = lossHpNum - bossHpTableNum
            else
              if self._hpLeft * bossHpTableNum <= bossHpTableNum - (lossHpNum) and bossHpTableNum - (lossHpNum) <= self._hpRight * bossHpTableNum then
                return TaskStatus.Success
              end
            end
          end
        end
      end
    else
      do
        for _,v in ipairs(((self._context)._battleworld)._rightPlayerList) do
          if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
            local hpComponent = v:GetComponent(HpComponent)
            if hpComponent then
              local lossHpNum = hpComponent._maxHp - hpComponent._currentHp
              if ((self._dataUtility).cMonsterCfgTable)[self._monsterid] then
                for _,bossHpTable in ipairs(((self._context)._battleworld)._bossHpStage) do
                  local bossHpTableNum = bossHpTable.num
                  if not (fixedpoint.judgetype)(bossHpTableNum) then
                    bossHpTableNum = fixedpoint(bossHpTableNum)
                  end
                  if lossHpNum - bossHpTableNum > 0 then
                    lossHpNum = lossHpNum - bossHpTableNum
                  else
                    if self._hpLeft * bossHpTableNum <= bossHpTableNum - (lossHpNum) and bossHpTableNum - (lossHpNum) <= self._hpRight * bossHpTableNum then
                      return TaskStatus.Success
                    end
                  end
                end
              end
            end
          end
        end
        for _,v in ipairs(((self._context)._battleworld)._leftPlayerList) do
          if (v:GetComponent(TypeComponent))._roleID == self._monsterid then
            local hpComponent = v:GetComponent(HpComponent)
            if hpComponent then
              local lossHpNum = hpComponent._maxHp - hpComponent._currentHp
              if ((self._dataUtility).cMonsterCfgTable)[self._monsterid] then
                for _,bossHpTable in ipairs(((self._context)._battleworld)._bossHpStage) do
                  local bossHpTableNum = bossHpTable.num
                  if not (fixedpoint.judgetype)(bossHpTableNum) then
                    bossHpTableNum = fixedpoint(bossHpTableNum)
                  end
                  if lossHpNum - bossHpTableNum > 0 then
                    lossHpNum = lossHpNum - bossHpTableNum
                  else
                    if self._hpLeft * bossHpTableNum <= bossHpTableNum - (lossHpNum) and bossHpTableNum - (lossHpNum) <= self._hpRight * bossHpTableNum then
                      return TaskStatus.Success
                    end
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

MonsterHpLinePercentSection.OnEnd = function(self)
  -- function num : 0_3
end

return MonsterHpLinePercentSection

