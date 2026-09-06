local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local MonsterHpLinePercentSection = class("MonsterHpLinePercentSection", Task)

function MonsterHpLinePercentSection:Ctor(context, monsterid, hpleft, hpright)
  MonsterHpLinePercentSection.super.Ctor(self)
  self._context = context
  self._monsterid = monsterid
  self._entity = nil
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      self._entity = e
      break
    end
  end
  self._dataUtility = BattleECS.Utility.DataUtility
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

function MonsterHpLinePercentSection:OnStart()
end

function MonsterHpLinePercentSection:OnUpdate(deltaTime)
  if self._entity then
    local HpComponent = BattleECS.Components.HpComponent
    local TypeComponent = BattleECS.Components.TypeComponent
    if self._monsterid == 0 then
      local hpComponent = self._entity:GetComponent(HpComponent)
      if hpComponent then
        local lossHpNum = hpComponent._maxHp - hpComponent._currentHp
        local record = self._dataUtility.cMonsterCfgTable[self._entity:GetComponent(TypeComponent)._roleID]
        if record then
          for _, bossHpTable in ipairs(self._context._battleworld._bossHpStage) do
            local bossHpTableNum = bossHpTable.num
            if not fixedpoint.judgetype(bossHpTableNum) then
              bossHpTableNum = fixedpoint(bossHpTableNum)
            end
            if 0 < lossHpNum - bossHpTableNum then
              lossHpNum = lossHpNum - bossHpTableNum
            elseif bossHpTableNum - lossHpNum >= self._hpLeft * bossHpTableNum and bossHpTableNum - lossHpNum <= self._hpRight * bossHpTableNum then
              return TaskStatus.Success
            end
          end
        end
      end
    else
      for _, v in ipairs(self._context._battleworld._rightPlayerList) do
        if v:GetComponent(TypeComponent)._roleID == self._monsterid then
          local hpComponent = v:GetComponent(HpComponent)
          if hpComponent then
            local lossHpNum = hpComponent._maxHp - hpComponent._currentHp
            if self._dataUtility.cMonsterCfgTable[self._monsterid] then
              for _, bossHpTable in ipairs(self._context._battleworld._bossHpStage) do
                local bossHpTableNum = bossHpTable.num
                if not fixedpoint.judgetype(bossHpTableNum) then
                  bossHpTableNum = fixedpoint(bossHpTableNum)
                end
                if 0 < lossHpNum - bossHpTableNum then
                  lossHpNum = lossHpNum - bossHpTableNum
                elseif bossHpTableNum - lossHpNum >= self._hpLeft * bossHpTableNum and bossHpTableNum - lossHpNum <= self._hpRight * bossHpTableNum then
                  return TaskStatus.Success
                end
              end
            end
          end
        end
      end
      for _, v in ipairs(self._context._battleworld._leftPlayerList) do
        if v:GetComponent(TypeComponent)._roleID == self._monsterid then
          local hpComponent = v:GetComponent(HpComponent)
          if hpComponent then
            local lossHpNum = hpComponent._maxHp - hpComponent._currentHp
            if self._dataUtility.cMonsterCfgTable[self._monsterid] then
              for _, bossHpTable in ipairs(self._context._battleworld._bossHpStage) do
                local bossHpTableNum = bossHpTable.num
                if not fixedpoint.judgetype(bossHpTableNum) then
                  bossHpTableNum = fixedpoint(bossHpTableNum)
                end
                if 0 < lossHpNum - bossHpTableNum then
                  lossHpNum = lossHpNum - bossHpTableNum
                elseif bossHpTableNum - lossHpNum >= self._hpLeft * bossHpTableNum and bossHpTableNum - lossHpNum <= self._hpRight * bossHpTableNum then
                  return TaskStatus.Success
                end
              end
            end
          end
        end
      end
    end
  end
  return TaskStatus.Failure
end

function MonsterHpLinePercentSection:OnEnd()
end

return MonsterHpLinePercentSection
