local UIManager = CS.PixelNeko.UI.UIManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local CharEquipPart = class("CharEquipPart")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local self

function CharEquipPart.OnCreate(delegate)
  self = delegate
  self._equip_equipBtn = self:GetChild("BackGround/RightPanel/Equip/EquipBtn")
  self._equip_unEquipBtn = self:GetChild("BackGround/RightPanel/Equip/UnEquipBtn")
  self._equip_equipBtn:Subscribe_PointerClickEvent(CharEquipPart.OnEquipBtnClick, self)
  self._equip_unEquipBtn:Subscribe_PointerClickEvent(CharEquipPart.OnUnEquipBtnClick, self)
  LuaNotificationCenter.AddObserver(CharEquipPart, CharEquipPart.OnEquipLevelUp, Common.n_EquipLevelUp, nil)
  LuaNotificationCenter.AddObserver(CharEquipPart, CharEquipPart.OnEquipLevelUp, Common.n_EquipExpUp, nil)
  LuaNotificationCenter.AddObserver(CharEquipPart, CharEquipPart.OnEquipLevelUp, Common.n_EnchantEquip, nil)
  LuaNotificationCenter.AddObserver(CharEquipPart, CharEquipPart.OnEquipChanged, Common.n_EquipChanged, nil)
end

function CharEquipPart.OnDestroy()
  DialogManager.DestroySingletonDialog("guide.guidedialog")
  self = nil
  LuaNotificationCenter.RemoveObserver(CharEquipPart)
end

function CharEquipPart.IsReplaceable(equipType, currentEquipKey)
  self._bagEquipList = NekoData.BehaviorManager.BM_BagInfo:GetEquipList()
  local typeEquipList = {}
  for i, v in ipairs(self._bagEquipList) do
    if v:GetEquipType() == equipType and v:GetKey() ~= currentEquipKey then
      table.insert(typeEquipList, v)
    end
  end
  local canWearEquipList = {}
  local roleEquipTypeList = self._data:GetRoleEquipTypeList()
  for key, value in pairs(roleEquipTypeList) do
    for k, v in pairs(CEquipItemTable:GetAllIds()) do
      local equipItemRecord = CEquipItemTable:GetRecorder(v)
      if equipItemRecord.equipAttrib == tonumber(value) then
        local str = equipItemRecord.roleLimit
        if str and str == "" then
          table.insert(canWearEquipList, v)
        else
          local list = {}
          if str and str ~= "" then
            list = string.split(str, ";")
          end
          if table.keyof(list, tostring(self._data:GetId())) then
            table.insert(canWearEquipList, v)
          end
        end
      end
    end
  end
  local currentCanWearEquipList = {}
  for index, value in ipairs(typeEquipList) do
    for i, v in ipairs(canWearEquipList) do
      if value:GetID() == v then
        table.insert(currentCanWearEquipList, value)
      end
    end
  end
  return 0 < #currentCanWearEquipList
end

function CharEquipPart.OnEquipLevelUp(a, notification)
  if notification.userInfo.equipKey == self._weaponKey then
    self._weapon = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(self._weaponKey)
  elseif notification.userInfo.equipKey == self._armorKey then
    self._armor = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(self._armorKey)
  elseif notification.userInfo.equipKey == self._jewelryKey then
    self._jewelry = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(self._jewelryKey)
  end
end

function CharEquipPart.RefreshEquipList()
  local currentWeapon
  if self._weaponKey then
    currentWeapon = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(self._weaponKey)
  end
  local currentArmor
  if self._armorKey then
    currentArmor = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(self._armorKey)
  end
  local currentJewelry
  if self._jewelryKey then
    currentJewelry = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(self._jewelryKey)
  end
  self._bagEquipList = NekoData.BehaviorManager.BM_BagInfo:GetEquipList()
  local canWearEquipList = {}
  local roleEquipTypeList = self._data:GetRoleEquipTypeList()
  for key, value in pairs(roleEquipTypeList) do
    for k, v in pairs(CEquipItemTable:GetAllIds()) do
      local equipItemRecord = CEquipItemTable:GetRecorder(v)
      if equipItemRecord.equipAttrib == tonumber(value) then
        local str = equipItemRecord.roleLimit
        if str and str == "" then
          table.insert(canWearEquipList, v)
        else
          local list = {}
          if str and str ~= "" then
            list = string.split(str, ";")
          end
          if table.keyof(list, tostring(self._data:GetId())) then
            table.insert(canWearEquipList, v)
          end
        end
      end
    end
  end
  self._weaponTypeList = {}
  for i, v in ipairs(self._bagEquipList) do
    if v:GetEquipType() == EquipTypeEnum.WEAPON and v:GetKey() ~= self._weaponKey then
      table.insert(self._weaponTypeList, v)
    end
  end
  while self._currentCanWearWeaponList[#self._currentCanWearWeaponList] do
    table.remove(self._currentCanWearWeaponList, #self._currentCanWearWeaponList)
  end
  for index, value in ipairs(self._weaponTypeList) do
    if table.indexof(canWearEquipList, value:GetID()) and value:GetRoleKey() == 0 then
      table.insert(self._currentCanWearWeaponList, value)
    end
  end
  if currentWeapon then
    table.insert(self._currentCanWearWeaponList, 1, currentWeapon)
  end
  table.sort(self._currentCanWearWeaponList, function(a, b)
    if a:GetScore() > b:GetScore() then
      return true
    elseif a:GetScore() == b:GetScore() then
      if a:GetKey() > b:GetKey() then
        return true
      else
        return false
      end
    end
  end)
  self._armorTypeList = {}
  for i, v in ipairs(self._bagEquipList) do
    if v:GetEquipType() == EquipTypeEnum.ARMOR and v:GetKey() ~= self._armorKey then
      table.insert(self._armorTypeList, v)
    end
  end
  while self._currentCanWearArmorList[#self._currentCanWearArmorList] do
    table.remove(self._currentCanWearArmorList, #self._currentCanWearArmorList)
  end
  for index, value in ipairs(self._armorTypeList) do
    if table.indexof(canWearEquipList, value:GetID()) and value:GetRoleKey() == 0 then
      table.insert(self._currentCanWearArmorList, value)
    end
  end
  if currentArmor then
    table.insert(self._currentCanWearArmorList, 1, currentArmor)
  end
  table.sort(self._currentCanWearArmorList, function(a, b)
    if a:GetScore() > b:GetScore() then
      return true
    elseif a:GetScore() == b:GetScore() then
      if a:GetKey() > b:GetKey() then
        return true
      else
        return false
      end
    end
  end)
  self._jewelryTypeList = {}
  for i, v in ipairs(self._bagEquipList) do
    if v:GetEquipType() == EquipTypeEnum.JEWELRY and v:GetKey() ~= self._jewelryKey then
      table.insert(self._jewelryTypeList, v)
    end
  end
  while self._currentCanWearJewelryList[#self._currentCanWearJewelryList] do
    table.remove(self._currentCanWearJewelryList, #self._currentCanWearJewelryList)
  end
  for index, value in ipairs(self._jewelryTypeList) do
    if table.indexof(canWearEquipList, value:GetID()) and value:GetRoleKey() == 0 then
      table.insert(self._currentCanWearJewelryList, value)
    end
  end
  if currentJewelry then
    table.insert(self._currentCanWearJewelryList, 1, currentJewelry)
  end
  table.sort(self._currentCanWearJewelryList, function(a, b)
    if a:GetScore() > b:GetScore() then
      return true
    elseif a:GetScore() == b:GetScore() then
      if a:GetKey() > b:GetKey() then
        return true
      else
        return false
      end
    end
  end)
end

function CharEquipPart.MaxScoreEquip()
  CharEquipPart.RefreshEquipList()
  local data = {}
  local flag = false
  if #self._currentCanWearWeaponList ~= 0 then
    data[self._currentCanWearWeaponList[1]:GetKey()] = self._data:GetRoleId()
    self._equip_allEquip_tag = true
    flag = true
  end
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(4) then
    if not flag then
      NekoData.BehaviorManager.BM_Guide:FinishGuide(4)
      NekoData.BehaviorManager.BM_Guide:FinishGuide(53)
    else
      local tag = true
      local curTeamId = NekoData.BehaviorManager.BM_Team:GetCurrentTeamId()
      if curTeamId then
        local teamsInfo = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()
        if teamsInfo and teamsInfo[curTeamId] then
          local currentRoleList = teamsInfo[curTeamId].roles
          for k, v in pairs(currentRoleList) do
            if v == self._data:GetRoleId() and k == 1 then
              tag = false
              break
            end
          end
        end
      end
      if tag then
        NekoData.BehaviorManager.BM_Guide:FinishGuide(4)
        NekoData.BehaviorManager.BM_Guide:FinishGuide(53)
      end
    end
  end
  if #self._currentCanWearArmorList ~= 0 then
    data[self._currentCanWearArmorList[1]:GetKey()] = self._data:GetRoleId()
    self._equip_allEquip_tag = true
    flag = true
  end
  if #self._currentCanWearJewelryList ~= 0 then
    data[self._currentCanWearJewelryList[1]:GetKey()] = self._data:GetRoleId()
    self._equip_allEquip_tag = true
    flag = true
  end
  if not flag then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100012)
  else
    CharEquipPart.SendCChangeEquipment(data)
  end
end

function CharEquipPart.PreSetEquip()
  CharEquipPart.RefreshEquipList()
  local flag = false
  local data = {}
  local Weapon = self._data:GetPreSetWeapon()
  if Weapon ~= 0 then
    data[Weapon] = self._data:GetRoleId()
    self._equip_allEquip_tag = true
    flag = true
  elseif self._weaponKey then
    data[self._weaponKey] = 0
    self._weaponKey = nil
  end
  local Armor = self._data:GetPreSetArmor()
  if Armor ~= 0 then
    data[Armor] = self._data:GetRoleId()
    self._equip_allEquip_tag = true
    flag = true
  elseif self._armorKey then
    data[self._armorKey] = 0
    self._armorKey = nil
  end
  local Jewelry = self._data:GetPreSetJewelry()
  if Jewelry ~= 0 then
    data[Jewelry] = self._data:GetRoleId()
    self._equip_allEquip_tag = true
    flag = true
  elseif self._jewelryKey then
    data[self._jewelryKey] = 0
    self._jewelryKey = nil
  end
  if not flag then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100012)
  else
    CharEquipPart.SendCChangeEquipment(data)
  end
end

function CharEquipPart.OnEquipBtnClick()
  if NekoData.BehaviorManager.BM_Guide:HasFinished(4) and self._data:IsPreSetEquipListExist() then
    DialogManager.CreateSingletonDialog("equip.equipchangesecondconfirmdialog")
  else
    CharEquipPart.MaxScoreEquip()
  end
end

function CharEquipPart.OnUnEquipBtnClick()
  local data = {}
  if self._weaponKey then
    data[self._weaponKey] = 0
    self._weaponKey = nil
  end
  if self._armorKey then
    data[self._armorKey] = 0
    self._armorKey = nil
  end
  if self._jewelryKey then
    data[self._jewelryKey] = 0
    self._jewelryKey = nil
  end
  CharEquipPart.SendCChangeEquipment(data)
end

function CharEquipPart.OnEquipChanged()
  if self._equip_allEquip_tag then
    self._equip_allEquip_tag = false
    NekoData.BehaviorManager.BM_Dungeon:ClearEquipRedDataWithRoleKeyAndEquipType(self._data:GetRoleId(), EquipTypeEnum.WEAPON)
    NekoData.BehaviorManager.BM_Dungeon:ClearEquipRedDataWithRoleKeyAndEquipType(self._data:GetRoleId(), EquipTypeEnum.ARMOR)
    NekoData.BehaviorManager.BM_Dungeon:ClearEquipRedDataWithRoleKeyAndEquipType(self._data:GetRoleId(), EquipTypeEnum.JEWELRY)
  end
end

function CharEquipPart.SendCChangeEquipment(data)
  if next(data) ~= nil then
    local cchangeEquipment = LuaNetManager.CreateProtocol("protocol.item.cchangeequipment")
    if cchangeEquipment then
      cchangeEquipment.equipToRole = data
      cchangeEquipment:Send()
    end
  end
end

return CharEquipPart
