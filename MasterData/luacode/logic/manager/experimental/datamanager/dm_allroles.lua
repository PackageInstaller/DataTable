local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local Role = require("logic.manager.experimental.types.role")
local CSkin = BeanManager.GetTableByName("role.cskin")
local DM_AllRoles = class("DM_AllRoles")

function DM_AllRoles:Ctor()
  self._allroles = NekoData.Data.allroles
  self._allroles.roles = {}
  self._allroles.capacity = 0
  self._allroles.soulRefineRoleId = 0
  self._allroles.showRoleEvolutionRedPoint = false
  self._allroles.hasNewRole = false
end

function DM_AllRoles:Clear()
  for k, v in pairs(self._allroles.roles) do
    self._allroles.roles[k] = nil
  end
  self._allroles.capacity = 0
  self._allroles.soulRefineRoleId = 0
  self._allroles.showRoleEvolutionRedPoint = false
  self._allroles.hasNewRole = false
end

function DM_AllRoles:OnSRoleList(protocol)
  self._allroles.capacity = protocol.capacity
  for index, roleInfo in ipairs(protocol.roles) do
    self._allroles.roles[roleInfo.id] = Role.Create(roleInfo.id, roleInfo)
    if not self._allroles.showRoleEvolutionRedPoint then
      self._allroles.showRoleEvolutionRedPoint = self._allroles.roles[roleInfo.id]:CanEvolutionByExclusiveItem()
    end
  end
end

function DM_AllRoles:OnSRoleAdd(protocol)
  self._allroles.roles[protocol.role.id] = Role.Create(protocol.role.id, protocol.role)
  if not self._allroles.showRoleEvolutionRedPoint then
    self._allroles.showRoleEvolutionRedPoint = self._allroles.roles[protocol.role.id]:CanEvolutionByExclusiveItem()
  end
end

function DM_AllRoles:OnSRoleRemove(protocol)
  if protocol.roleId and self._allroles.roles[protocol.roleId] then
    self._allroles.roles[protocol.roleId] = nil
  end
end

function DM_AllRoles:OnSRoleLock(protocol)
  if protocol.roleId and self._allroles.roles[protocol.roleId] then
    self._allroles.roles[protocol.roleId]:SetIsLock(protocol.lock)
  end
end

function DM_AllRoles:OnSRoleUpdateLv(protocol)
  if protocol.roleId and self._allroles.roles[protocol.roleId] then
    local role = self._allroles.roles[protocol.roleId]
    role:SetLevel(protocol.level)
    role:SetExp(protocol.exp)
  end
end

function DM_AllRoles:OnSRoleUpdateBreakLv(protocol)
  if protocol.roleId and self._allroles.roles[protocol.roleId] then
    local role = self._allroles.roles[protocol.roleId]
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

function DM_AllRoles:OnSRoleUpdateProperties(protocol)
  if protocol.roleId and self._allroles.roles[protocol.roleId] then
    self._allroles.roles[protocol.roleId]:SetProperties(protocol.properties)
  end
end

function DM_AllRoles:OnSChangeEquipment(protocol)
  for roleId, equipKey in pairs(protocol.roles) do
    if self._allroles.roles[roleId] then
      local role = self._allroles.roles[roleId]
      if protocol.equipType[equipKey] == EquipTypeEnum.WEAPON then
        role:SetWeapon(equipKey)
      end
      if protocol.equipType[equipKey] == EquipTypeEnum.JEWELRY then
        role:SetJewelry(equipKey)
      end
      if protocol.equipType[equipKey] == EquipTypeEnum.ARMOR then
        role:SetArmor(equipKey)
      end
    end
  end
end

function DM_AllRoles:OnSChangePresetEquip(protocol)
  if self._allroles.roles[protocol.roleId] then
    local role = self._allroles.roles[protocol.roleId]
    if protocol.equipType == EquipTypeEnum.WEAPON then
      role:SetPreSetWeapon(protocol.equipKey or 0)
    end
    if protocol.equipType == EquipTypeEnum.JEWELRY then
      role:SetPreSetJewelry(protocol.equipKey or 0)
    end
    if protocol.equipType == EquipTypeEnum.ARMOR then
      role:SetPreSetArmor(protocol.equipKey or 0)
    end
  end
end

function DM_AllRoles:OnSCancelPresetEquip(protocol)
  for _, v in ipairs(protocol.roleId) do
    if self._allroles.roles[v] then
      local role = self._allroles.roles[v]
      if protocol.equipType == EquipTypeEnum.WEAPON then
        role:SetPreSetWeapon(protocol.equipKey or 0)
      end
      if protocol.equipType == EquipTypeEnum.JEWELRY then
        role:SetPreSetJewelry(protocol.equipKey or 0)
      end
      if protocol.equipType == EquipTypeEnum.ARMOR then
        role:SetPreSetArmor(protocol.equipKey or 0)
      end
    end
  end
end

function DM_AllRoles:OnSAddDeadRoles(protocol)
  for i, v in ipairs(protocol.deadRoles) do
    if v.roleId and self._allroles.roles[v.roleId] then
      local role = self._allroles.roles[v.roleId]
      role:SetHurtExtent(v.hurtExtent)
      role:SetRepairTime(v.repairTime)
      role:SetReviveTime(v.reviveTime)
    end
  end
end

function DM_AllRoles:OnSRemoveRepairRoles(protocol)
  for i, v in ipairs(protocol.deadRoles) do
    if v.roleId and self._allroles.roles[v.roleId] then
      local role = self._allroles.roles[v.roleId]
      role:SetHurtExtent(v.hurtExtent)
      role:SetRepairTime(v.repairTime)
      role:SetReviveTime(v.reviveTime)
    end
  end
end

function DM_AllRoles:OnRefreshRepairRole()
  for roleId, role in pairs(self._allroles.roles) do
    if role:GetHurtExtent() ~= 0 then
      local deltaTime = role:GetReviveTime() - ServerGameTimer.GetServerTimeForecast()
      if deltaTime <= 1000 then
        local CRemoveRepairRoles = LuaNetManager.CreateProtocol("protocol.login.cremoverepairroles")
        if CRemoveRepairRoles then
          CRemoveRepairRoles:Send()
        end
      end
    end
  end
end

function DM_AllRoles:OnSEvolution(protocol)
  if protocol.roleId and self._allroles.roles[protocol.roleId] then
    local role = self._allroles.roles[protocol.roleId]
    role:SetEvolution(protocol.evolution)
  end
end

function DM_AllRoles:OnSRoleBaseProperties(protocol)
  if protocol.roleId and self._allroles.roles[protocol.roleId] then
    local role = self._allroles.roles[protocol.roleId]
    role:SetCurLvBasePro(protocol.curLvBasePro)
    role:SetNextLvBasePro(protocol.nextLvBasePro)
    role:SetBreakLvRange(protocol.breakLvRange)
    role:SetBaseProAddPercent(protocol.addPercent)
  end
end

function DM_AllRoles:OnSRefreshPower(data)
  for roleId, value in pairs(data) do
    local role = self._allroles.roles[roleId]
    if role then
      role:SetRolePower(value)
    end
  end
end

function DM_AllRoles:OnSRoleConverSkill(protocol)
  self._allroles.soulRefineRoleId = protocol.roleid
end

function DM_AllRoles:OnSUnlockTallent(protocol)
  if protocol.roleId and self._allroles.roles[protocol.roleId] then
    local role = self._allroles.roles[protocol.roleId]
    role:SetTalentPage(protocol.talentPage)
    role:SetTalentRow(protocol.talentRow)
    role:SetTalentInRowList(protocol.talentInRow)
  end
end

function DM_AllRoles:OnRefreshBuildingId(info)
  local role = self._allroles.roles[info.roleKey]
  if role then
    LogInfoFormat("DM_AllRoles", "--- roleId = %s, buildingId = %s ---", info.roleKey, info.buildingId)
    role:SetBuildingId(info.buildingId)
  end
end

function DM_AllRoles:OnSRefreshRole(protocol)
  for i, v in ipairs(protocol.list) do
    local role = self._allroles.roles[v.id]
    if role then
      role:RefreshByRoleInfo(v)
      LogInfoFormat("DM_AllRoles", "--- roleId = %s, energy = %s ---", v.id, v.energy)
    end
  end
end

function DM_AllRoles:CheckShowRoleEvolutionRed(protocol)
  if protocol and protocol.bagType ~= LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes").BAG and protocol.bagType ~= LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes").VALUABLEBAG then
    return
  end
  local bShow = false
  for roleId, role in pairs(self._allroles.roles) do
    role:CheckCanEvolutionByExclusiveItem()
    bShow = bShow or role:CanEvolutionByExclusiveItem()
  end
  if bShow ~= self._allroles.showRoleEvolutionRedPoint then
    self._allroles.showRoleEvolutionRedPoint = bShow
    return true
  end
end

function DM_AllRoles:CheckNewRoleRed()
  local bHasNew = false
  for id, role in pairs(self._allroles.roles) do
    if role:IsNew() and not bHasNew then
      bHasNew = true
    end
  end
  if self._allroles.hasNewRole ~= bHasNew then
    self._allroles.hasNewRole = bHasNew
    return true
  end
end

function DM_AllRoles:RefreshRoleNewState(roleId, isNew)
  local role = self._allroles.roles[roleId]
  role:SetNewState(isNew)
  local CEraseNewRoleRedDot = LuaNetManager.CreateProtocol("protocol.login.cerasenewrolereddot")
  CEraseNewRoleRedDot.roleId = roleId
  if CEraseNewRoleRedDot then
    CEraseNewRoleRedDot:Send()
  end
end

function DM_AllRoles:OnSRefreshRoleGood(protocol)
  local role = self._allroles.roles[protocol.roleId]
  if role then
    role:SetRelationLevel(protocol.level)
    role:SetRelationProgress(protocol.progress)
  end
end

function DM_AllRoles:OnSSweepreSult(protocol)
  for k, v in pairs(protocol.roleGoodLv) do
    local role = self._allroles.roles[k]
    if role then
      role:SetRelationLevel(v)
    end
  end
  for k, v in pairs(protocol.roleGoodCurExp) do
    local role = self._allroles.roles[k]
    if role then
      role:SetRelationProgress(v)
    end
  end
end

function DM_AllRoles:OnSBattleEnd(protocol)
  for k, v in pairs(protocol.roleGoodLv) do
    local role = self._allroles.roles[k]
    if role then
      role:SetRelationLevel(v)
    end
  end
  for k, v in pairs(protocol.roleGoodCurExp) do
    local role = self._allroles.roles[k]
    if role then
      role:SetRelationProgress(v)
    end
  end
end

function DM_AllRoles:OnSReceiveAward(protocol)
  local role = self._allroles.roles[protocol.roleId]
  if role then
    role:SetRelationReceiveMap(protocol.level)
  end
end

function DM_AllRoles:OnSRefreshWitchSkills(protocol)
  local leader
  for roleId, role in pairs(self._allroles.roles) do
    if role:GetIsLeader() then
      leader = role
      break
    end
  end
  if leader then
    leader:RefreshLeaderSkills(protocol.changedSkills)
  end
end

function DM_AllRoles:OnSUnlockWitchSkill(protocol)
  local leader
  for roleId, role in pairs(self._allroles.roles) do
    if role:GetIsLeader() then
      leader = role
      break
    end
  end
  if leader then
    leader:AddLeaderSkill(protocol)
  end
end

function DM_AllRoles:OnSShowSpecialWeapon(protocol)
  for i, v in ipairs(protocol.roles) do
    local role = self._allroles.roles[v]
    if role then
      role:SetUniqueEquipLevel(0)
    end
  end
end

function DM_AllRoles:OnSGetSpecialWeaponInfo(protocol)
  local role = self._allroles.roles[protocol.roleId]
  if role then
    role:SetUniqueEquipAttrs(protocol)
    role:SetUniqueEquipSkillOpen(protocol.skillOpen)
  end
end

function DM_AllRoles:OnSSpecialWeaponlvUp(protocol)
  local role = self._allroles.roles[protocol.roleId]
  if role then
    if not role:IsUnlockUniqueEquip() then
      local SSpecialWeaponSkillSwitch = require("protocols.def.protocol.item.sspecialweaponskillswitch")
      role:SetUniqueEquipSkillOpen(SSpecialWeaponSkillSwitch.OPEN)
    end
    role:SetUniqueEquipAttrs(protocol)
  end
end

function DM_AllRoles:OnSSpecialWeaponSkillSwitch(protocol)
  local role = self._allroles.roles[protocol.roleId]
  if role then
    role:SetUniqueEquipSkillOpen(protocol.skillOpen)
  end
end

function DM_AllRoles:OnSChangeSkin(protocol)
  local role
  local roleId = protocol.roleId
  for k, v in pairs(self._allroles.roles) do
    if v:GetId() == roleId then
      role = v
      break
    end
  end
  if role then
    role:SetFashionId(protocol.skin2Change)
  end
end

function DM_AllRoles:OnSGetRoleSkin(protocol)
  local role
  local roleId = protocol.roleId
  for k, v in pairs(self._allroles.roles) do
    if v:GetId() == roleId then
      role = v
      break
    end
  end
  if role then
    role:UpdateFashion(protocol.skins)
  end
end

function DM_AllRoles:SetSkinRedDotById(skinId)
  local skinRecorder = CSkin:GetRecorder(skinId)
  if skinRecorder then
    local role = self._allroles.roles[skinRecorder.roleid]
    if role then
      role:SetSkinRedDot(skinRecorder, true)
    end
  else
    LogErrorFormat("OnSSkinRedPoints", "recorder with id %s is not exist in cskin", skinId)
  end
end

function DM_AllRoles:OnSSkinRedPoints(protocol)
  for i, v in ipairs(protocol.looked) do
    self:SetSkinRedDotById(v)
  end
end

function DM_AllRoles:OnSReceiveRoleSkin(protocol)
  self:SetSkinRedDotById(protocol.skins.skinID)
end

function DM_AllRoles:SetSkinRedDotChecked(skinRecorder)
  local role = self._allroles.roles[skinRecorder.roleid]
  if role then
    role:SetSkinRedDot(skinRecorder)
  end
end

function DM_AllRoles:OnSProfessionRune(protocol)
  if protocol.roleId and self._allroles.roles[protocol.roleId] then
    local role = self._allroles.roles[protocol.roleId]
    role:SetRuneLevel(protocol.professionRune)
  end
end

return DM_AllRoles
