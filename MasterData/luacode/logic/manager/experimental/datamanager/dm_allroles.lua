-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_allroles.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local Role = require("logic.manager.experimental.types.role")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local DM_AllRoles = class("DM_AllRoles")
DM_AllRoles.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._allroles = (NekoData.Data).allroles
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._allroles).roles = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._allroles).capacity = 0
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._allroles).soulRefineRoleId = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._allroles).showRoleEvolutionRedPoint = false
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._allroles).hasNewRole = false
end

DM_AllRoles.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs((self._allroles).roles) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._allroles).roles)[k] = nil
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._allroles).capacity = 0
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._allroles).soulRefineRoleId = 0
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._allroles).showRoleEvolutionRedPoint = false
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._allroles).hasNewRole = false
end

DM_AllRoles.OnSRoleList = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, Role
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._allroles).capacity = protocol.capacity
  for index,roleInfo in ipairs(protocol.roles) do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

    ((self._allroles).roles)[roleInfo.id] = (Role.Create)(roleInfo.id, roleInfo)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

    if not (self._allroles).showRoleEvolutionRedPoint then
      (self._allroles).showRoleEvolutionRedPoint = (((self._allroles).roles)[roleInfo.id]):CanEvolutionByExclusiveItem()
    end
  end
end

DM_AllRoles.OnSRoleAdd = function(self, protocol)
  -- function num : 0_3 , upvalues : Role
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ((self._allroles).roles)[(protocol.role).id] = (Role.Create)((protocol.role).id, protocol.role)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._allroles).showRoleEvolutionRedPoint then
    (self._allroles).showRoleEvolutionRedPoint = (((self._allroles).roles)[(protocol.role).id]):CanEvolutionByExclusiveItem()
  end
end

DM_AllRoles.OnSRoleRemove = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.roleId and ((self._allroles).roles)[protocol.roleId] then
    ((self._allroles).roles)[protocol.roleId] = nil
  end
end

DM_AllRoles.OnSRoleLock = function(self, protocol)
  -- function num : 0_5
  if protocol.roleId and ((self._allroles).roles)[protocol.roleId] then
    (((self._allroles).roles)[protocol.roleId]):SetIsLock(protocol.lock)
  end
end

DM_AllRoles.OnSRoleUpdateLv = function(self, protocol)
  -- function num : 0_6
  if protocol.roleId and ((self._allroles).roles)[protocol.roleId] then
    local role = ((self._allroles).roles)[protocol.roleId]
    role:SetLevel(protocol.level)
    role:SetExp(protocol.exp)
  end
end

DM_AllRoles.OnSRoleUpdateBreakLv = function(self, protocol)
  -- function num : 0_7 , upvalues : CSkin, _ENV
  if protocol.roleId and ((self._allroles).roles)[protocol.roleId] then
    local role = ((self._allroles).roles)[protocol.roleId]
    role:SetBreakLv(protocol.breakLv)
    if protocol.gainSkin ~= 0 then
      local skinRecorder = CSkin:GetRecorder(protocol.gainSkin)
      if skinRecorder then
        role:SetSkinRedDot(skinRecorder, true)
      else
        LogErrorFormat("OnSRoleUpdateBreakLv", "recorder with id %s is not exist in cskin", protocol.gainSkin)
      end
    end
  end
end

DM_AllRoles.OnSRoleUpdateProperties = function(self, protocol)
  -- function num : 0_8
  if protocol.roleId and ((self._allroles).roles)[protocol.roleId] then
    (((self._allroles).roles)[protocol.roleId]):SetProperties(protocol.properties)
  end
end

DM_AllRoles.OnSChangeEquipment = function(self, protocol)
  -- function num : 0_9 , upvalues : _ENV, EquipTypeEnum
  for roleId,equipKey in pairs(protocol.roles) do
    if ((self._allroles).roles)[roleId] then
      local role = ((self._allroles).roles)[roleId]
      if (protocol.equipType)[equipKey] == EquipTypeEnum.WEAPON then
        role:SetWeapon(equipKey)
      end
      if (protocol.equipType)[equipKey] == EquipTypeEnum.JEWELRY then
        role:SetJewelry(equipKey)
      end
      if (protocol.equipType)[equipKey] == EquipTypeEnum.ARMOR then
        role:SetArmor(equipKey)
      end
    end
  end
end

DM_AllRoles.OnSChangePresetEquip = function(self, protocol)
  -- function num : 0_10 , upvalues : EquipTypeEnum
  if ((self._allroles).roles)[protocol.roleId] then
    local role = ((self._allroles).roles)[protocol.roleId]
    if not protocol.equipKey then
      role:SetPreSetWeapon(protocol.equipType ~= EquipTypeEnum.WEAPON or 0)
      if not protocol.equipKey then
        role:SetPreSetJewelry(protocol.equipType ~= EquipTypeEnum.JEWELRY or 0)
        if not protocol.equipKey then
          role:SetPreSetArmor(protocol.equipType ~= EquipTypeEnum.ARMOR or 0)
        end
      end
    end
  end
end

DM_AllRoles.OnSCancelPresetEquip = function(self, protocol)
  -- function num : 0_11 , upvalues : _ENV, EquipTypeEnum
  for _,v in ipairs(protocol.roleId) do
    if ((self._allroles).roles)[v] then
      local role = ((self._allroles).roles)[v]
      if not protocol.equipKey then
        role:SetPreSetWeapon(protocol.equipType ~= EquipTypeEnum.WEAPON or 0)
        if not protocol.equipKey then
          role:SetPreSetJewelry(protocol.equipType ~= EquipTypeEnum.JEWELRY or 0)
          if not protocol.equipKey then
            do
              role:SetPreSetArmor(protocol.equipType ~= EquipTypeEnum.ARMOR or 0)
              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

DM_AllRoles.OnSAddDeadRoles = function(self, protocol)
  -- function num : 0_12 , upvalues : _ENV
  for i,v in ipairs(protocol.deadRoles) do
    if v.roleId and ((self._allroles).roles)[v.roleId] then
      local role = ((self._allroles).roles)[v.roleId]
      role:SetHurtExtent(v.hurtExtent)
      role:SetRepairTime(v.repairTime)
      role:SetReviveTime(v.reviveTime)
    end
  end
end

DM_AllRoles.OnSRemoveRepairRoles = function(self, protocol)
  -- function num : 0_13 , upvalues : _ENV
  for i,v in ipairs(protocol.deadRoles) do
    if v.roleId and ((self._allroles).roles)[v.roleId] then
      local role = ((self._allroles).roles)[v.roleId]
      role:SetHurtExtent(v.hurtExtent)
      role:SetRepairTime(v.repairTime)
      role:SetReviveTime(v.reviveTime)
    end
  end
end

DM_AllRoles.OnRefreshRepairRole = function(self)
  -- function num : 0_14 , upvalues : _ENV
  for roleId,role in pairs((self._allroles).roles) do
    if role:GetHurtExtent() ~= 0 then
      local deltaTime = role:GetReviveTime() - (ServerGameTimer.GetServerTimeForecast)()
      if deltaTime <= 1000 then
        local CRemoveRepairRoles = (LuaNetManager.CreateProtocol)("protocol.login.cremoverepairroles")
        if CRemoveRepairRoles then
          CRemoveRepairRoles:Send()
        end
      end
    end
  end
end

DM_AllRoles.OnSEvolution = function(self, protocol)
  -- function num : 0_15
  if protocol.roleId and ((self._allroles).roles)[protocol.roleId] then
    local role = ((self._allroles).roles)[protocol.roleId]
    role:SetEvolution(protocol.evolution)
  end
end

DM_AllRoles.OnSRoleBaseProperties = function(self, protocol)
  -- function num : 0_16
  if protocol.roleId and ((self._allroles).roles)[protocol.roleId] then
    local role = ((self._allroles).roles)[protocol.roleId]
    role:SetCurLvBasePro(protocol.curLvBasePro)
    role:SetNextLvBasePro(protocol.nextLvBasePro)
    role:SetBreakLvRange(protocol.breakLvRange)
    role:SetBaseProAddPercent(protocol.addPercent)
  end
end

DM_AllRoles.OnSRefreshPower = function(self, data)
  -- function num : 0_17 , upvalues : _ENV
  for roleId,value in pairs(data) do
    local role = ((self._allroles).roles)[roleId]
    if role then
      role:SetRolePower(value)
    end
  end
end

DM_AllRoles.OnSRoleConverSkill = function(self, protocol)
  -- function num : 0_18
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._allroles).soulRefineRoleId = protocol.roleid
end

DM_AllRoles.OnSUnlockTallent = function(self, protocol)
  -- function num : 0_19
  if protocol.roleId and ((self._allroles).roles)[protocol.roleId] then
    local role = ((self._allroles).roles)[protocol.roleId]
    role:SetTalentPage(protocol.talentPage)
    role:SetTalentRow(protocol.talentRow)
    role:SetTalentInRowList(protocol.talentInRow)
  end
end

DM_AllRoles.OnRefreshBuildingId = function(self, info)
  -- function num : 0_20 , upvalues : _ENV
  local role = ((self._allroles).roles)[info.roleKey]
  if role then
    LogInfoFormat("DM_AllRoles", "--- roleId = %s, buildingId = %s ---", info.roleKey, info.buildingId)
    role:SetBuildingId(info.buildingId)
  end
end

DM_AllRoles.OnSRefreshRole = function(self, protocol)
  -- function num : 0_21 , upvalues : _ENV
  for i,v in ipairs(protocol.list) do
    local role = ((self._allroles).roles)[v.id]
    if role then
      role:RefreshByRoleInfo(v)
      LogInfoFormat("DM_AllRoles", "--- roleId = %s, energy = %s ---", v.id, v.energy)
    end
  end
end

DM_AllRoles.CheckShowRoleEvolutionRed = function(self, protocol)
  -- function num : 0_22 , upvalues : _ENV
  if protocol and protocol.bagType ~= ((LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")).BAG and protocol.bagType ~= ((LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")).VALUABLEBAG then
    return 
  end
  local bShow = false
  for roleId,role in pairs((self._allroles).roles) do
    role:CheckCanEvolutionByExclusiveItem()
    if not bShow then
      bShow = role:CanEvolutionByExclusiveItem()
    end
  end
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

  if bShow ~= (self._allroles).showRoleEvolutionRedPoint then
    (self._allroles).showRoleEvolutionRedPoint = bShow
    return true
  end
end

DM_AllRoles.CheckNewRoleRed = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local bHasNew = false
  for id,role in pairs((self._allroles).roles) do
    if role:IsNew() and not bHasNew then
      bHasNew = true
    end
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  if (self._allroles).hasNewRole ~= bHasNew then
    (self._allroles).hasNewRole = bHasNew
    return true
  end
end

DM_AllRoles.RefreshRoleNewState = function(self, roleId, isNew)
  -- function num : 0_24 , upvalues : _ENV
  local role = ((self._allroles).roles)[roleId]
  role:SetNewState(isNew)
  local CEraseNewRoleRedDot = (LuaNetManager.CreateProtocol)("protocol.login.cerasenewrolereddot")
  CEraseNewRoleRedDot.roleId = roleId
  if CEraseNewRoleRedDot then
    CEraseNewRoleRedDot:Send()
  end
end

DM_AllRoles.OnSRefreshRoleGood = function(self, protocol)
  -- function num : 0_25
  local role = ((self._allroles).roles)[protocol.roleId]
  if role then
    role:SetRelationLevel(protocol.level)
    role:SetRelationProgress(protocol.progress)
  end
end

DM_AllRoles.OnSSweepreSult = function(self, protocol)
  -- function num : 0_26 , upvalues : _ENV
  for k,v in pairs(protocol.roleGoodLv) do
    local role = ((self._allroles).roles)[k]
    if role then
      role:SetRelationLevel(v)
    end
  end
  for k,v in pairs(protocol.roleGoodCurExp) do
    local role = ((self._allroles).roles)[k]
    if role then
      role:SetRelationProgress(v)
    end
  end
end

DM_AllRoles.OnSBattleEnd = function(self, protocol)
  -- function num : 0_27 , upvalues : _ENV
  for k,v in pairs(protocol.roleGoodLv) do
    local role = ((self._allroles).roles)[k]
    if role then
      role:SetRelationLevel(v)
    end
  end
  for k,v in pairs(protocol.roleGoodCurExp) do
    local role = ((self._allroles).roles)[k]
    if role then
      role:SetRelationProgress(v)
    end
  end
end

DM_AllRoles.OnSReceiveAward = function(self, protocol)
  -- function num : 0_28
  local role = ((self._allroles).roles)[protocol.roleId]
  if role then
    role:SetRelationReceiveMap(protocol.level)
  end
end

DM_AllRoles.OnSRefreshWitchSkills = function(self, protocol)
  -- function num : 0_29 , upvalues : _ENV
  local leader = nil
  for roleId,role in pairs((self._allroles).roles) do
    if role:GetIsLeader() then
      leader = role
      break
    end
  end
  do
    if leader then
      leader:RefreshLeaderSkills(protocol.changedSkills)
    end
  end
end

DM_AllRoles.OnSUnlockWitchSkill = function(self, protocol)
  -- function num : 0_30 , upvalues : _ENV
  local leader = nil
  for roleId,role in pairs((self._allroles).roles) do
    if role:GetIsLeader() then
      leader = role
      break
    end
  end
  do
    if leader then
      leader:AddLeaderSkill(protocol)
    end
  end
end

DM_AllRoles.OnSShowSpecialWeapon = function(self, protocol)
  -- function num : 0_31 , upvalues : _ENV
  for i,v in ipairs(protocol.roles) do
    local role = ((self._allroles).roles)[v]
    if role then
      role:SetUniqueEquipLevel(0)
    end
  end
end

DM_AllRoles.OnSGetSpecialWeaponInfo = function(self, protocol)
  -- function num : 0_32
  local role = ((self._allroles).roles)[protocol.roleId]
  if role then
    role:SetUniqueEquipAttrs(protocol)
    role:SetUniqueEquipSkillOpen(protocol.skillOpen)
  end
end

DM_AllRoles.OnSSpecialWeaponlvUp = function(self, protocol)
  -- function num : 0_33 , upvalues : _ENV
  local role = ((self._allroles).roles)[protocol.roleId]
  if role then
    do
      if not role:IsUnlockUniqueEquip() then
        local SSpecialWeaponSkillSwitch = require("protocols.def.protocol.item.sspecialweaponskillswitch")
        role:SetUniqueEquipSkillOpen(SSpecialWeaponSkillSwitch.OPEN)
      end
      role:SetUniqueEquipAttrs(protocol)
    end
  end
end

DM_AllRoles.OnSSpecialWeaponSkillSwitch = function(self, protocol)
  -- function num : 0_34
  local role = ((self._allroles).roles)[protocol.roleId]
  if role then
    role:SetUniqueEquipSkillOpen(protocol.skillOpen)
  end
end

DM_AllRoles.OnSChangeSkin = function(self, protocol)
  -- function num : 0_35 , upvalues : _ENV
  local role = nil
  local roleId = protocol.roleId
  for k,v in pairs((self._allroles).roles) do
    if v:GetId() == roleId then
      role = v
      break
    end
  end
  do
    if role then
      role:SetFashionId(protocol.skin2Change)
    end
  end
end

DM_AllRoles.OnSGetRoleSkin = function(self, protocol)
  -- function num : 0_36 , upvalues : _ENV
  local role = nil
  local roleId = protocol.roleId
  for k,v in pairs((self._allroles).roles) do
    if v:GetId() == roleId then
      role = v
      break
    end
  end
  do
    if role then
      role:UpdateFashion(protocol.skins)
    end
  end
end

DM_AllRoles.SetSkinRedDotById = function(self, skinId)
  -- function num : 0_37 , upvalues : CSkin, _ENV
  local skinRecorder = CSkin:GetRecorder(skinId)
  if skinRecorder then
    local role = ((self._allroles).roles)[skinRecorder.roleid]
    if role then
      role:SetSkinRedDot(skinRecorder, true)
    end
  else
    do
      LogErrorFormat("OnSSkinRedPoints", "recorder with id %s is not exist in cskin", skinId)
    end
  end
end

DM_AllRoles.OnSSkinRedPoints = function(self, protocol)
  -- function num : 0_38 , upvalues : _ENV
  for i,v in ipairs(protocol.looked) do
    self:SetSkinRedDotById(v)
  end
end

DM_AllRoles.OnSReceiveRoleSkin = function(self, protocol)
  -- function num : 0_39
  self:SetSkinRedDotById((protocol.skins).skinID)
end

DM_AllRoles.SetSkinRedDotChecked = function(self, skinRecorder)
  -- function num : 0_40
  local role = ((self._allroles).roles)[skinRecorder.roleid]
  if role then
    role:SetSkinRedDot(skinRecorder)
  end
end

DM_AllRoles.OnSProfessionRune = function(self, protocol)
  -- function num : 0_41
  if protocol.roleId and ((self._allroles).roles)[protocol.roleId] then
    local role = ((self._allroles).roles)[protocol.roleId]
    role:SetRuneLevel(protocol.professionRune)
  end
end

return DM_AllRoles

