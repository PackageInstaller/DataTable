local System = require("ecs.system")
local BuffSystem = strictclass("BuffSystem", System)
local RelationType = {
  Self = 1,
  OneFriend = 2,
  OneEnemy = 4,
  Friends = 8,
  Enemies = 16
}
local PowerChangeType = {CostOrder = 1, CostChaos = 2}

function BuffSystem:Ctor(...)
  BuffSystem.super.Ctor(self, ...)
  self._utility = BattleECS.Utility.Utility
  self._buffUtility = BattleECS.Utility.BuffUtility
  self._dataUtility = BattleECS.Utility.DataUtility
  table.insert(self._requiredComponents, BattleECS.Components.BuffComponent)
end

function BuffSystem:Destroy()
  BuffSystem.super.Destroy(self)
end

function BuffSystem:Update()
  local BuffComponent = BattleECS.Components.BuffComponent
  local HpComponent = BattleECS.Components.HpComponent
  local TypeComponent = BattleECS.Components.TypeComponent
  for _, entity in ipairs(self._entitys) do
    local continualBuffList = entity:GetComponent(BuffComponent)._delayBuffList
    local deleteList = {}
    for k = #continualBuffList, 1, -1 do
      local v = continualBuffList[k]
      v.actualFrame = v.actualFrame + 1
      if v.actualFrame >= v.delayFrame then
        local targetEntity
        for i, e in ipairs(self._world._entitys) do
          if e._entityId == v.data.entity._entityId then
            targetEntity = e
            break
          end
        end
        if targetEntity then
          self._buffUtility.CreateBuffObject(v.data)
        end
        table.insert(deleteList, k)
      end
    end
    for _, k in ipairs(deleteList) do
      table.remove(continualBuffList, k)
    end
  end
  for _, entity in ipairs(self._world._leftPlayerList) do
    if not self._utility.IsRoleDead(entity) then
      local buffComponent = entity:GetComponent(BuffComponent)
      if buffComponent then
        for _, v in ipairs(buffComponent._buffList) do
          v.buffObj:SetBuffContinuedTime(v.buffObj:GetBuffContinuedTime() + 1, false, true)
          if v.buffObj:GetBuffContinuedTime() > v.buffObj:GetBuffTotalTime() then
            self._buffUtility.RemoveEntityBuff(entity, v.buffId)
          else
            local hpComponent = entity:GetComponent(HpComponent)
            if hpComponent then
              for _, value in ipairs(hpComponent._damageSheildNumberList) do
                if v.buffId == value.buffid and value.number <= 0 then
                  self._buffUtility.RemoveEntityBuff(entity, v.buffId)
                end
              end
            end
            self:CheckBuffLinkCondition(v.buffObj, entity, self._world._leftPlayerList, self._world._rightPlayerList)
          end
        end
      end
      for _, v in ipairs(self._world._battleBuffsList) do
        local record = self._dataUtility.cGlobalBuffConfigTable[v.buffId]
        if record and (record.target == TypeComponent.CampType.Left or record.target == TypeComponent.CampType.Both) and self._world._battleWorldStartFrames == record.time and 0 <= record.time and self._buffUtility.CanAddGlobalBuffBuff(entity, v.buffId, self._world) then
          if v.roleLimit and 0 < string.len(v.roleLimit) then
            local isFindeRoleId = false
            local roleids = string.split(v.roleLimit, ";")
            for _, roleid in ipairs(roleids) do
              if entity:GetComponent(TypeComponent)._roleID == tonumber(roleid) then
                isFindeRoleId = true
                break
              end
            end
            if isFindeRoleId then
              for i = 1, v.count do
                self._buffUtility.InsertEntityDifferentBuff({
                  entity = entity,
                  enermyentity = entity,
                  buffid = v.buffId,
                  buffparamter = record.buffattr,
                  skillid = 0,
                  battleworld = self._world
                })
              end
            end
          else
            for i = 1, v.count do
              self._buffUtility.InsertEntityDifferentBuff({
                entity = entity,
                enermyentity = entity,
                buffid = v.buffId,
                buffparamter = record.buffattr,
                skillid = 0,
                battleworld = self._world
              })
            end
          end
        end
      end
    end
  end
  for _, entity in ipairs(self._world._rightPlayerList) do
    if not self._utility.IsRoleDead(entity) then
      local buffComponent = entity:GetComponent(BuffComponent)
      if buffComponent then
        for _, v in ipairs(buffComponent._buffList) do
          v.buffObj:SetBuffContinuedTime(v.buffObj:GetBuffContinuedTime() + 1, false, true)
          if v.buffObj:GetBuffContinuedTime() > v.buffObj:GetBuffTotalTime() then
            self._buffUtility.RemoveEntityBuff(entity, v.buffId)
          else
            local hpComponent = entity:GetComponent(HpComponent)
            if hpComponent then
              for _, value in ipairs(hpComponent._damageSheildNumberList) do
                if v.buffId == value.buffid and value.number <= 0 then
                  self._buffUtility.RemoveEntityBuff(entity, v.buffId)
                end
              end
            end
            self:CheckBuffLinkCondition(v.buffObj, entity, self._world._rightPlayerList, self._world._leftPlayerList)
          end
        end
      end
      for _, v in ipairs(self._world._battleBuffsList) do
        local record = self._dataUtility.cGlobalBuffConfigTable[v.buffId]
        if record and (record.target == TypeComponent.CampType.Right or record.target == TypeComponent.CampType.Both) and self._world._battleWorldStartFrames == record.time and 0 <= record.time and self._buffUtility.CanAddGlobalBuffBuff(entity, v.buffId, self._world) then
          if v.roleLimit and 0 < string.len(v.roleLimit) then
            local isFindeRoleId = false
            local roleids = string.split(v.roleLimit, ";")
            for _, roleid in ipairs(roleids) do
              if entity:GetComponent(TypeComponent)._roleID == tonumber(roleid) then
                isFindeRoleId = true
                break
              end
            end
            if isFindeRoleId then
              for i = 1, v.count do
                self._buffUtility.InsertEntityDifferentBuff({
                  entity = entity,
                  enermyentity = entity,
                  buffid = v.buffId,
                  buffparamter = record.buffattr,
                  skillid = 0,
                  battleworld = self._world
                })
              end
            end
          else
            for i = 1, v.count do
              self._buffUtility.InsertEntityDifferentBuff({
                entity = entity,
                enermyentity = entity,
                buffid = v.buffId,
                buffparamter = record.buffattr,
                skillid = 0,
                battleworld = self._world
              })
            end
          end
        end
      end
    end
  end
  for _, entity in ipairs(self._world._leftPlayerPartnerList) do
    local buffComponent = entity:GetComponent(BuffComponent)
    if buffComponent then
      for _, v in ipairs(buffComponent._buffList) do
        v.buffObj:SetBuffContinuedTime(v.buffObj:GetBuffContinuedTime() + 1, false, true)
        if v.buffObj:GetBuffContinuedTime() > v.buffObj:GetBuffTotalTime() then
          self._buffUtility.RemoveEntityBuff(entity, v.buffId)
          self:CheckBuffLinkCondition(v.buffObj, entity, self._world._leftPlayerList, self._world._rightPlayerList)
        end
      end
    end
  end
  for _, entity in ipairs(self._world._leftPlayerSummonList) do
    local buffComponent = entity:GetComponent(BuffComponent)
    if buffComponent then
      for _, v in ipairs(buffComponent._buffList) do
        v.buffObj:SetBuffContinuedTime(v.buffObj:GetBuffContinuedTime() + 1, false, true)
        if v.buffObj:GetBuffContinuedTime() > v.buffObj:GetBuffTotalTime() then
          self._buffUtility.RemoveEntityBuff(entity, v.buffId)
          self:CheckBuffLinkCondition(v.buffObj, entity, self._world._leftPlayerList, self._world._rightPlayerList)
        end
      end
    end
  end
  for _, entity in ipairs(self._world._rightPlayerSummonList) do
    local buffComponent = entity:GetComponent(BuffComponent)
    if buffComponent then
      for _, v in ipairs(buffComponent._buffList) do
        v.buffObj:SetBuffContinuedTime(v.buffObj:GetBuffContinuedTime() + 1, false, true)
        if v.buffObj:GetBuffContinuedTime() > v.buffObj:GetBuffTotalTime() then
          self._buffUtility.RemoveEntityBuff(entity, v.buffId)
          self:CheckBuffLinkCondition(v.buffObj, entity, self._world._rightPlayerList, self._world._leftPlayerList)
        end
      end
    end
  end
  for _, entity in ipairs(self._entitys) do
    local buffComponent = entity:GetComponent(BuffComponent)
    if buffComponent then
      buffComponent._isPowerCost.Order = false
      buffComponent._isPowerCost.Chaos = false
      for _, className in ipairs(buffComponent._removeBuffClassNameList) do
        BattleECS.Utility.BuffUtility.RemoveBuffWithClassName(entity, className)
      end
      buffComponent._removeBuffClassNameList = {}
      if buffComponent._skillsectionendbuffSkillId ~= 0 then
        local clear = true
        for _, v in ipairs(buffComponent._skillsectionendbuffSkillEffect) do
          clear = clear and v.effect
        end
        if clear then
          BattleECS.Utility.BuffUtility.RemoveBuffWithClassName(entity, "skillsectionendbuff")
          buffComponent._skillsectionendbuffSkillId = 0
          buffComponent._skillsectionendbuffSkillEffect = {}
        end
      end
      local HpComponent = entity:GetComponent(BattleECS.Components.HpComponent)
      if HpComponent then
        HpComponent._buffDamgeSkillId = 0
      end
    end
  end
end

function BuffSystem:CheckBuffLinkCondition(buffObj, entity, friendPlayerList, enemyPlayerList)
  local HpComponent = BattleECS.Components.HpComponent
  local SkillComponent = BattleECS.Components.SkillComponent
  local BuffComponent = BattleECS.Components.BuffComponent
  local TypeComponent = BattleECS.Components.TypeComponent
  if buffObj:IsHasLinkSkill() then
    local conditionList = buffObj:GetLinkSkillCondition()
    for _, condition in ipairs(conditionList) do
      if not condition.timebeforeFlag then
        condition.timebeforeFlag = condition.cfg.timebefore >= self._world._battleWorldStartFrames
      end
      if not condition.timeafterFlag then
        condition.timeafterFlag = condition.cfg.timeafter <= self._world._battleWorldStartFrames
      end
      if not condition.hppctfloorFlag or not condition.hppcttopFlag then
        local selfFlagFloor = true
        local friendFlagFloor = true
        local enemyFlagFloor = true
        local selfFlagTop = true
        local friendFlagTop = true
        local enemyFlagTop = true
        if condition.cfg.relation & RelationType.Self ~= 0 then
          local hpComponent = entity:GetComponent(HpComponent)
          if hpComponent and not self._utility.IsRoleDead(entity) then
            local perHp = hpComponent._currentHp / hpComponent._maxHp * 100
            if condition.cfg.hppctfloor and perHp < condition.cfg.hppctfloor then
              selfFlagFloor = false
            end
            if condition.cfg.hppcttop and perHp > condition.cfg.hppcttop then
              selfFlagTop = false
            end
          end
        end
        if condition.cfg.relation & RelationType.Friends ~= 0 then
          local friendCurHp = fixedpoint_zero
          local friendMaxHp = fixedpoint_zero
          for _, friendEntity in ipairs(friendPlayerList) do
            local friendHpComponent = friendEntity:GetComponent(HpComponent)
            if friendHpComponent and not self._utility.IsRoleDead(friendEntity) then
              friendCurHp = friendCurHp + friendHpComponent._currentHp
              friendMaxHp = friendMaxHp + friendHpComponent._maxHp
            end
          end
          if friendMaxHp ~= 0 then
            local perHp = friendCurHp / friendMaxHp * 100
            if condition.cfg.hppctfloor and perHp < condition.cfg.hppctfloor then
              friendFlagFloor = false
            end
            if condition.cfg.hppcttop and perHp > condition.cfg.hppcttop then
              friendFlagTop = false
            end
          end
        end
        if condition.cfg.relation & RelationType.OneFriend ~= 0 then
          friendFlagFloor = false
          friendFlagTop = false
          for _, friendEntity in ipairs(friendPlayerList) do
            local friendHpComponent = friendEntity:GetComponent(HpComponent)
            if friendHpComponent and not self._utility.IsRoleDead(friendEntity) then
              local friendCurHp = friendHpComponent._currentHp
              local friendMaxHp = friendHpComponent._maxHp
              if friendMaxHp ~= 0 then
                local perHp = friendCurHp / friendMaxHp * 100
                if condition.cfg.hppctfloor and perHp >= condition.cfg.hppctfloor then
                  friendFlagFloor = true
                end
                if condition.cfg.hppcttop and perHp <= condition.cfg.hppcttop then
                  friendFlagTop = true
                end
                if friendFlagFloor and friendFlagTop then
                  break
                end
                friendFlagFloor = false
                friendFlagTop = false
              end
            end
          end
        end
        if condition.cfg.relation & RelationType.Enemies ~= 0 then
          local enemyperHpList = {}
          for _, enemyEntity in ipairs(enemyPlayerList) do
            local enemyHpComponent = enemyEntity:GetComponent(HpComponent)
            if enemyHpComponent and not self._utility.IsRoleDead(enemyEntity) then
              local perHp = enemyHpComponent._currentHp / enemyHpComponent._maxHp * 100
              table.insert(enemyperHpList, perHp)
            end
          end
          for _, perHp in ipairs(enemyperHpList) do
            if condition.cfg.hppctfloor and perHp < condition.cfg.hppctfloor then
              enemyFlagFloor = false
              break
            end
          end
          for _, perHp in ipairs(enemyperHpList) do
            if condition.cfg.hppcttop and perHp > condition.cfg.hppcttop then
              enemyFlagTop = false
              break
            end
          end
        end
        if condition.cfg.relation & RelationType.OneEnemy ~= 0 then
          enemyFlagFloor = false
          enemyFlagTop = false
          for _, enemyEntity in ipairs(enemyPlayerList) do
            local enemyHpComponent = enemyEntity:GetComponent(HpComponent)
            if enemyHpComponent and not self._utility.IsRoleDead(enemyEntity) then
              local enemyCurHp = enemyHpComponent._currentHp
              local enemyMaxHp = enemyHpComponent._maxHp
              if enemyMaxHp ~= 0 then
                local perHp = enemyCurHp / enemyMaxHp * 100
                if condition.cfg.hppctfloor and perHp >= condition.cfg.hppctfloor then
                  enemyFlagFloor = true
                end
                if condition.cfg.hppcttop and perHp <= condition.cfg.hppcttop then
                  enemyFlagTop = true
                end
                if enemyFlagFloor and enemyFlagTop then
                  break
                end
                enemyFlagFloor = false
                enemyFlagTop = false
              end
            end
          end
        end
        condition.hppctfloorFlag = selfFlagFloor and friendFlagFloor and enemyFlagFloor
        condition.hppcttopFlag = selfFlagTop and friendFlagTop and enemyFlagTop
      end
      if not condition.castskillidFlag then
        if condition.cfg.relation & RelationType.Self ~= 0 then
          local skillComponent = entity:GetComponent(SkillComponent)
          if skillComponent._buffCastSkillId == condition.cfg.castskillid then
            condition.castskillidFlag = true
          end
        end
        if condition.cfg.relation & RelationType.Friends ~= 0 or condition.cfg.relation & RelationType.OneFriend ~= 0 then
          for _, friendEntity in ipairs(friendPlayerList) do
            local friendSkillComponent = friendEntity:GetComponent(SkillComponent)
            if friendSkillComponent and friendSkillComponent._buffCastSkillId == condition.cfg.castskillid then
              condition.castskillidFlag = true
              break
            end
          end
        end
        if condition.cfg.relation & RelationType.Enemies ~= 0 or condition.cfg.relation & RelationType.OneEnemy ~= 0 then
          for _, enemyEntity in ipairs(enemyPlayerList) do
            local enemySkillComponent = enemyEntity:GetComponent(SkillComponent)
            if enemySkillComponent and enemySkillComponent._buffCastSkillId == condition.cfg.castskillid then
              condition.castskillidFlag = true
              break
            end
          end
        end
      end
      if not condition.damageskillidFlag then
        if condition.cfg.relation & RelationType.Self ~= 0 then
          local hpComponent = entity:GetComponent(HpComponent)
          if hpComponent._buffDamgeSkillId == condition.cfg.damageskillid then
            condition.damageskillidFlag = true
          end
        end
        if condition.cfg.relation & RelationType.Friends ~= 0 or condition.cfg.relation & RelationType.OneFriend ~= 0 then
          for _, friendEntity in ipairs(friendPlayerList) do
            local friendHpComponent = friendEntity:GetComponent(HpComponent)
            if friendHpComponent and friendHpComponent._buffDamgeSkillId == condition.cfg.damageskillid then
              condition.damageskillidFlag = true
              break
            end
          end
        end
        if condition.cfg.relation & RelationType.Enemies ~= 0 or condition.cfg.relation & RelationType.OneEnemy ~= 0 then
          for _, enemyEntity in ipairs(enemyPlayerList) do
            local enemyHpComponent = enemyEntity:GetComponent(HpComponent)
            if enemyHpComponent and enemyHpComponent._buffDamgeSkillId == condition.cfg.damageskillid then
              condition.damageskillidFlag = true
              break
            end
          end
        end
      end
      if not condition.powerchangeFlag then
        if condition.cfg.relation & RelationType.Self ~= 0 then
          local buffComponent = entity:GetComponent(BuffComponent)
          if buffComponent then
            if condition.cfg.powerchange == PowerChangeType.CostOrder then
              condition.powerchangeFlag = buffComponent._isPowerCost.Order
            elseif condition.cfg.powerchange == PowerChangeType.CostChaos then
              condition.powerchangeFlag = buffComponent._isPowerCost.Chaos
            end
          end
        end
        if condition.cfg.relation & RelationType.Friends ~= 0 or condition.cfg.relation & RelationType.OneFriend ~= 0 then
          for _, friendEntity in ipairs(friendPlayerList) do
            local friendBuffComponent = friendEntity:GetComponent(BuffComponent)
            if friendBuffComponent then
              if condition.cfg.powerchange == PowerChangeType.CostOrder then
                condition.powerchangeFlag = friendBuffComponent._isPowerCost.Order
              elseif condition.cfg.powerchange == PowerChangeType.CostChaos then
                condition.powerchangeFlag = friendBuffComponent._isPowerCost.Chaos
              end
            end
            if condition.powerchangeFlag then
              break
            end
          end
        end
        if condition.cfg.relation & RelationType.Enemies ~= 0 or condition.cfg.relation & RelationType.OneEnemy ~= 0 then
          for _, enemyEntity in ipairs(enemyPlayerList) do
            local enemyBuffComponent = enemyEntity:GetComponent(BuffComponent)
            if enemyBuffComponent then
              if condition.cfg.powerchange == PowerChangeType.CostOrder then
                condition.powerchangeFlag = enemyBuffComponent._isPowerCost.Order
              elseif condition.cfg.powerchange == PowerChangeType.CostChaos then
                condition.powerchangeFlag = enemyBuffComponent._isPowerCost.Chaos
              end
            end
            if condition.powerchangeFlag then
              break
            end
          end
        end
      end
      if not condition.buffIdFlag then
        if condition.cfg.relation & RelationType.Self ~= 0 then
          local buffComponent = entity:GetComponent(BuffComponent)
          if buffComponent then
            for _, v in ipairs(buffComponent._buffList) do
              if (condition.cfg.buffstacks == 0 or v.buffObj:GetStackTimesCur() == condition.cfg.buffstacks) and v.buffObj:GetBuffID() == condition.cfg.buffid then
                condition.buffIdFlag = true
              end
            end
          end
        end
        if condition.cfg.relation & RelationType.Friends ~= 0 or condition.cfg.relation & RelationType.OneFriend ~= 0 then
          for _, friendEntity in ipairs(friendPlayerList) do
            local friendBuffComponent = friendEntity:GetComponent(BuffComponent)
            if friendBuffComponent then
              for _, v in ipairs(friendBuffComponent._buffList) do
                if (condition.cfg.buffstacks == 0 or v.buffObj:GetStackTimesCur() == condition.cfg.buffstacks) and v.buffObj:GetBuffID() == condition.cfg.buffid then
                  condition.buffIdFlag = true
                  break
                end
              end
            end
          end
        end
        if condition.cfg.relation & RelationType.Enemies ~= 0 or condition.cfg.relation & RelationType.OneEnemy ~= 0 then
          for _, enemyEntity in ipairs(enemyPlayerList) do
            local enemyBuffComponent = enemyEntity:GetComponent(BuffComponent)
            if enemyBuffComponent then
              for _, v in ipairs(enemyBuffComponent._buffList) do
                if (condition.cfg.buffstacks == 0 or v.buffObj:GetStackTimesCur() == condition.cfg.buffstacks) and v.buffObj:GetBuffID() == condition.cfg.buffid then
                  condition.buffIdFlag = true
                  break
                end
              end
            end
          end
        end
      end
      if not condition.attrIdFlag then
        if condition.cfg.relation & RelationType.Self ~= 0 then
          local buffComponent = entity:GetComponent(BuffComponent)
          if buffComponent then
            local attrValue = -1
            if condition.cfg.attrid == 650 then
              attrValue = buffComponent._attackTime
            end
            if condition.cfg.attrfloor and attrValue >= condition.cfg.attrfloor and attrValue <= condition.cfg.attrtop then
              condition.attrIdFlag = true
            end
          end
        end
        if condition.cfg.relation & RelationType.Friends ~= 0 or condition.cfg.relation & RelationType.OneFriend ~= 0 then
          for _, friendEntity in ipairs(friendPlayerList) do
            local friendBuffComponent = friendEntity:GetComponent(BuffComponent)
            if friendBuffComponent then
              local attrValue = -1
              if condition.cfg.attrid == 650 then
                attrValue = friendBuffComponent._attackTime
              end
              if condition.cfg.attrfloor and attrValue >= condition.cfg.attrfloor and attrValue <= condition.cfg.attrtop then
                condition.attrIdFlag = true
                break
              end
            end
          end
        end
        if condition.cfg.relation & RelationType.Enemies ~= 0 or condition.cfg.relation & RelationType.OneEnemy ~= 0 then
          for _, enemyEntity in ipairs(enemyPlayerList) do
            local enemyBuffComponent = enemyEntity:GetComponent(BuffComponent)
            if enemyBuffComponent then
              local attrValue = -1
              if condition.cfg.attrid == 650 then
                attrValue = enemyBuffComponent._attackTime
              end
              if condition.cfg.attrfloor and attrValue >= condition.cfg.attrfloor and attrValue <= condition.cfg.attrtop then
                condition.attrIdFlag = true
                break
              end
            end
          end
        end
      end
      if not condition.stationFlag then
        local StationType = {
          Front = 1,
          Middle = 2,
          Back = 3
        }
        if condition.cfg.relation & RelationType.Self ~= 0 then
          local typeComponent = entity:GetComponent(TypeComponent)
          if condition.cfg.station == StationType.Front then
            if typeComponent._rolePointNum == tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[50].attr) or typeComponent._rolePointNum == tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[53].attr) then
              condition.stationFlag = true
            end
          elseif condition.cfg.station == StationType.Middle then
            if typeComponent._rolePointNum == tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[51].attr) or typeComponent._rolePointNum == tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[54].attr) then
              condition.stationFlag = true
            end
          elseif condition.cfg.station == StationType.Back and (typeComponent._rolePointNum == tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[52].attr) or typeComponent._rolePointNum == tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[55].attr)) then
            condition.stationFlag = true
          end
        end
      end
    end
    if buffObj:IsTriggerCDOver() and buffObj:IfLinkSkillConditionFit() then
      local random = self._world._randomPcg(1, 100)
      local rate = buffObj:GetBUffTriggerRate()
      local effectTime = buffObj:GetLinkSkillEffectTime()
      local totalEffectTime = buffObj:GetLinkSkillEffectTotalTime()
      local triggerLinkSkillFlag = random <= rate
      if totalEffectTime and effectTime >= totalEffectTime then
        triggerLinkSkillFlag = false
      end
      if triggerLinkSkillFlag then
        buffObj:SetLinkSkillEffectTime(effectTime + 1)
        buffObj:ResetTriggerCDCountTime()
        self._utility.SetSkillComponnetPassiveSkillList(entity, buffObj:GetLinkSkillId(), entity)
      end
    end
  end
end

return BuffSystem
