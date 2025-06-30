-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/presetequipdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local PreSetEquipDialog = class("PreSetEquipDialog", Dialog)
PreSetEquipDialog.AssetBundleName = "ui/layouts.equip"
PreSetEquipDialog.AssetName = "EquipSet"
PreSetEquipDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PreSetEquipDialog
  ((PreSetEquipDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = nil
end

local isPreSet = true
PreSetEquipDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._title = self:GetChild("Tips/Title")
  self._cancelBtn = self:GetChild("Tips/Button0")
  self._confirmBtn = self:GetChild("Tips/Button1")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnClearBtnClick, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._equipSmallPanel1 = self:GetChild("Tips/Equip1")
  self._equipSmallPanel1RedDot = self:GetChild("Tips/Equip1/Dot")
  self._equipSmallPanel2RedDot = self:GetChild("Tips/Equip2/Dot")
  self._equipSmallPanel3RedDot = self:GetChild("Tips/Equip3/Dot")
  ;
  (self._equipSmallPanel1RedDot):SetActive(false)
  ;
  (self._equipSmallPanel2RedDot):SetActive(false)
  ;
  (self._equipSmallPanel3RedDot):SetActive(false)
  self._equipCell1 = self:GetChild("Tips/Equip1/EquipCell")
  self._equipCell1Frame = self:GetChild("Tips/Equip1/EquipCell/BackGround/Frame")
  self._equipCell1Icon = self:GetChild("Tips/Equip1/EquipCell/BackGround/Icon")
  self._equipCell1Suit = self:GetChild("Tips/Equip1/EquipCell/BackGround/Suit")
  self._equipCell1SuitGrey = self:GetChild("Tips/Equip1/EquipCell/BackGround/SuitGrey")
  self._equipCell1SpecialFMImage = self:GetChild("Tips/Equip1/EquipCell/BackGround/FuMo")
  self._equipCell1_animator = ((self:GetChild("Tips/Equip1")):GetUIObject()):GetComponent("Animator")
  self._equipCell1PinJiStat = self:GetChild("Tips/Equip1/EquipCell/BackGround/BreakPoint")
  self._equipCell1Empty = self:GetChild("Tips/Equip1/EquipCellEmpty")
  self._equip1LockImg = self:GetChild("Tips/Equip1/Lock")
  self._equipCell1Lv = self:GetChild("Tips/Equip1/EquipCell/BackGround/Level/Num")
  self._equipSmallPanel2 = self:GetChild("Tips/Equip2")
  self._equipCell2 = self:GetChild("Tips/Equip2/EquipCell")
  self._equipCell2Frame = self:GetChild("Tips/Equip2/EquipCell/BackGround/Frame")
  self._equipCell2Icon = self:GetChild("Tips/Equip2/EquipCell/BackGround/Icon")
  self._equipCell2Suit = self:GetChild("Tips/Equip2/EquipCell/BackGround/Suit")
  self._equipCell2SuitGrey = self:GetChild("Tips/Equip2/EquipCell/BackGround/SuitGrey")
  self._equipCell2SpecialFMImage = self:GetChild("Tips/Equip2/EquipCell/BackGround/FuMo")
  self._equipCell2_animator = ((self:GetChild("Tips/Equip2")):GetUIObject()):GetComponent("Animator")
  self._equipCell2PinJiStat = self:GetChild("Tips/Equip2/EquipCell/BackGround/BreakPoint")
  self._equipCell2Empty = self:GetChild("Tips/Equip2/EquipCellEmpty")
  self._equip2LockImg = self:GetChild("Tips/Equip2/Lock")
  self._equipCell2Lv = self:GetChild("Tips/Equip2/EquipCell/BackGround/Level/Num")
  self._equipSmallPanel3 = self:GetChild("Tips/Equip3")
  self._equipCell3 = self:GetChild("Tips/Equip3/EquipCell")
  self._equipCell3Frame = self:GetChild("Tips/Equip3/EquipCell/BackGround/Frame")
  self._equipCell3Icon = self:GetChild("Tips/Equip3/EquipCell/BackGround/Icon")
  self._equipCell3Suit = self:GetChild("Tips/Equip3/EquipCell/BackGround/Suit")
  self._equipCell3SuitGrey = self:GetChild("Tips/Equip3/EquipCell/BackGround/SuitGrey")
  self._equipCell3SpecialFMImage = self:GetChild("Tips/Equip3/EquipCell/BackGround/FuMo")
  self._equipCell3_animator = ((self:GetChild("Tips/Equip3")):GetUIObject()):GetComponent("Animator")
  self._equipCell3PinJiStat = self:GetChild("Tips/Equip3/EquipCell/BackGround/BreakPoint")
  self._equipCell3Empty = self:GetChild("Tips/Equip3/EquipCellEmpty")
  self._equip3LockImg = self:GetChild("Tips/Equip3/Lock")
  self._equipCell3Lv = self:GetChild("Tips/Equip3/EquipCell/BackGround/Level/Num")
  ;
  (self._equipSmallPanel1):Subscribe_PointerClickEvent(self.OnEquipPanel1Click, self)
  ;
  (self._equipSmallPanel2):Subscribe_PointerClickEvent(self.OnEquipPanel2Click, self)
  ;
  (self._equipSmallPanel3):Subscribe_PointerClickEvent(self.OnEquipPanel3Click, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshEquipPanel, Common.n_EquipPresetChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshEquipPanel, Common.n_EnchantEquip, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshEquipPanel, Common.n_EquipBreak, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshEquipPanel, Common.n_EquipLevelUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshEquipPanel, Common.n_EquipExpUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshEquipPanel, Common.n_ItemRemove, nil)
end

PreSetEquipDialog.SetData = function(self, data)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  self.lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Equip_Unlock)
  ;
  (self._equip1LockImg):SetActive(self.lock)
  ;
  (self._equip2LockImg):SetActive(self.lock)
  ;
  (self._equip3LockImg):SetActive(self.lock)
  self._data = data
  self:RefreshEquipPanel()
  ;
  (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1661)).msgTextID))
end

PreSetEquipDialog.OnDestroy = function(self)
  -- function num : 0_3
end

PreSetEquipDialog.AddNewModal = function(self, dialog)
  -- function num : 0_4
  if dialog._dialogName == "equip.equipchangenewdialog" then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

PreSetEquipDialog.OnClearBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV, EquipTypeEnum
  local isExist = (self._data):IsPreSetEquipListExist()
  if isExist then
    local presetEquipList = (self._data):GetPreSetEquipKeyList()
    do
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(126, nil, function()
    -- function num : 0_5_0 , upvalues : presetEquipList, EquipTypeEnum, _ENV, self
    do
      if presetEquipList[EquipTypeEnum.WEAPON] then
        local csend = (LuaNetManager.CreateProtocol)("protocol.item.cchangepresetequip")
        if csend then
          csend.roleId = (self._data):GetId()
          csend.equipType = EquipTypeEnum.WEAPON
          csend.equipKey = 0
          csend:Send()
        end
      end
      do
        if presetEquipList[EquipTypeEnum.ARMOR] then
          local csend = (LuaNetManager.CreateProtocol)("protocol.item.cchangepresetequip")
          if csend then
            csend.roleId = (self._data):GetId()
            csend.equipType = EquipTypeEnum.ARMOR
            csend.equipKey = 0
            csend:Send()
          end
        end
        if presetEquipList[EquipTypeEnum.JEWELRY] then
          local csend = (LuaNetManager.CreateProtocol)("protocol.item.cchangepresetequip")
          if csend then
            csend.roleId = (self._data):GetId()
            csend.equipType = EquipTypeEnum.JEWELRY
            csend.equipKey = 0
            csend:Send()
          end
        end
      end
    end
  end
)
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100432)
    end
  end
end

PreSetEquipDialog.IsReplaceable = function(self, equipType, currentEquipKey)
  -- function num : 0_6 , upvalues : _ENV, CEquipItemTable
  self._bagEquipList = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipList()
  local typeEquipList = {}
  for i,v in ipairs(self._bagEquipList) do
    if v:GetEquipType() == equipType and v:GetKey() ~= currentEquipKey then
      (table.insert)(typeEquipList, v)
    end
  end
  local canWearEquipList = {}
  local roleEquipTypeList = (self._data):GetRoleEquipTypeList()
  for key,value in pairs(roleEquipTypeList) do
    for k,v in pairs(CEquipItemTable:GetAllIds()) do
      local equipItemRecord = CEquipItemTable:GetRecorder(v)
      if equipItemRecord.equipAttrib == tonumber(value) then
        local str = equipItemRecord.roleLimit
        if str and str == "" then
          (table.insert)(canWearEquipList, v)
        else
          local list = {}
          if str and str ~= "" then
            list = (string.split)(str, ";")
          end
          if (table.keyof)(list, tostring((self._data):GetId())) then
            (table.insert)(canWearEquipList, v)
          end
        end
      end
    end
  end
  local currentCanWearEquipList = {}
  for index,value in ipairs(typeEquipList) do
    for i,v in ipairs(canWearEquipList) do
      if value:GetID() == v then
        (table.insert)(currentCanWearEquipList, value)
      end
    end
  end
  do return #currentCanWearEquipList > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

PreSetEquipDialog.RefreshEquipPanel = function(self)
  -- function num : 0_7 , upvalues : _ENV, CImagePathTable, AnimationHelper, EquipTypeEnum, isPreSet
  local key = (self._data):GetRoleId()
  self._data = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
  local suitMap = (self._data):GetSuitSkillsMap()
  local suitMap = ((self._data):GetPreSetSuitSkillsMap())
  local record = nil
  local equipKey = (self._data):GetPreSetWeapon()
  if equipKey ~= 0 then
    self._weaponKey = equipKey
    self._weapon = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(equipKey)
    ;
    (self._equipCell1):SetActive(true)
    ;
    (self._equipCell1Empty):SetActive(false)
    record = (self._weapon):GetIcon()
    ;
    (self._equipCell1Icon):SetSprite(record.assetBundle, record.assetName)
    record = (self._weapon):GetPinJiImage()
    ;
    (self._equipCell1Frame):SetSprite(record.assetBundle, record.assetName)
    ;
    (self._equipCell1Suit):SetActive(not suitMap[(self._weapon):GetEquipSuitId()] or #(suitMap[(self._weapon):GetEquipSuitId()]).skillIds > 0)
    ;
    (self._equipCell1SuitGrey):SetActive(not suitMap[(self._weapon):GetEquipSuitId()] or #(suitMap[(self._weapon):GetEquipSuitId()]).skillIds == 0)
    ;
    (self._equipCell1PinJiStat):SetText((self._weapon):GetEquipStarStr())
    if (self._equipCell1Suit):IsActive() then
      record = (self._weapon):GetEquipSuitRecorder()
      if record then
        record = CImagePathTable:GetRecorder(record.suitImg)
      end
      ;
      (self._equipCell1Suit):SetSprite(record.assetBundle, record.assetName)
    end
    if (self._equipCell1SuitGrey):IsActive() then
      record = (self._weapon):GetEquipSuitRecorder()
      if record then
        record = CImagePathTable:GetRecorder(record.suitImg)
      end
      ;
      (self._equipCell1SuitGrey):SetSprite(record.assetBundle, record.assetName)
    end
    ;
    (self._equipCell1Lv):SetText((self._weapon):GetStrengthenLevel())
    ;
    (self._equipCell1SpecialFMImage):SetActive((self._weapon):GetFinalRandomEntry())
    if (self._weapon):GetFinalRandomEntry() then
      (AnimationHelper.SetAnimatorInteger2)((self._equipSmallPanel1):GetUIObject(), "par", 1)
    else
      (AnimationHelper.SetAnimatorInteger2)((self._equipSmallPanel1):GetUIObject(), "par", 0)
    end
  else
    self._weaponKey = nil
    self._weapon = nil
    ;
    (self._equipCell1):SetActive(false)
    ;
    (self._equipCell1Empty):SetActive(true)
  end
  equipKey = (self._data):GetPreSetArmor()
  if equipKey ~= 0 then
    (self._equipCell2):SetActive(true)
    ;
    (self._equipCell2Empty):SetActive(false)
    self._armorKey = equipKey
    self._armor = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(equipKey)
    record = (self._armor):GetIcon()
    ;
    (self._equipCell2Icon):SetSprite(record.assetBundle, record.assetName)
    record = (self._armor):GetPinJiImage()
    ;
    (self._equipCell2Frame):SetSprite(record.assetBundle, record.assetName)
    ;
    (self._equipCell2Suit):SetActive(not suitMap[(self._armor):GetEquipSuitId()] or #(suitMap[(self._armor):GetEquipSuitId()]).skillIds > 0)
    ;
    (self._equipCell2SuitGrey):SetActive(not suitMap[(self._armor):GetEquipSuitId()] or #(suitMap[(self._armor):GetEquipSuitId()]).skillIds == 0)
    ;
    (self._equipCell2PinJiStat):SetText((self._armor):GetEquipStarStr())
    if (self._equipCell2Suit):IsActive() then
      record = (self._armor):GetEquipSuitRecorder()
      if record then
        record = CImagePathTable:GetRecorder(record.suitImg)
      end
      ;
      (self._equipCell2Suit):SetSprite(record.assetBundle, record.assetName)
    end
    if (self._equipCell2SuitGrey):IsActive() then
      record = (self._armor):GetEquipSuitRecorder()
      if record then
        record = CImagePathTable:GetRecorder(record.suitImg)
      end
      ;
      (self._equipCell2SuitGrey):SetSprite(record.assetBundle, record.assetName)
    end
    ;
    (self._equipCell2Lv):SetText((self._armor):GetStrengthenLevel())
    ;
    (self._equipCell2SpecialFMImage):SetActive((self._armor):GetFinalRandomEntry())
    if (self._armor):GetFinalRandomEntry() then
      (AnimationHelper.SetAnimatorInteger2)((self._equipSmallPanel2):GetUIObject(), "par", 1)
    else
      (AnimationHelper.SetAnimatorInteger2)((self._equipSmallPanel2):GetUIObject(), "par", 0)
    end
  else
    self._armorKey = nil
    self._armor = nil
    ;
    (self._equipCell2):SetActive(false)
    ;
    (self._equipCell2Empty):SetActive(true)
  end
  equipKey = (self._data):GetPreSetJewelry()
  if equipKey ~= 0 then
    self._jewelryKey = equipKey
    self._jewelry = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(equipKey)
    ;
    (self._equipCell3):SetActive(true)
    ;
    (self._equipCell3Empty):SetActive(false)
    record = (self._jewelry):GetIcon()
    ;
    (self._equipCell3Icon):SetSprite(record.assetBundle, record.assetName)
    record = (self._jewelry):GetPinJiImage()
    ;
    (self._equipCell3Frame):SetSprite(record.assetBundle, record.assetName)
    ;
    (self._equipCell3Suit):SetActive(not suitMap[(self._jewelry):GetEquipSuitId()] or #(suitMap[(self._jewelry):GetEquipSuitId()]).skillIds > 0)
    ;
    (self._equipCell3SuitGrey):SetActive(not suitMap[(self._jewelry):GetEquipSuitId()] or #(suitMap[(self._jewelry):GetEquipSuitId()]).skillIds == 0)
    ;
    (self._equipCell3PinJiStat):SetText((self._jewelry):GetEquipStarStr())
    if (self._equipCell3Suit):IsActive() then
      record = (self._jewelry):GetEquipSuitRecorder()
      if record then
        record = CImagePathTable:GetRecorder(record.suitImg)
      end
      ;
      (self._equipCell3Suit):SetSprite(record.assetBundle, record.assetName)
    end
    if (self._equipCell3SuitGrey):IsActive() then
      record = (self._jewelry):GetEquipSuitRecorder()
      if record then
        record = CImagePathTable:GetRecorder(record.suitImg)
      end
      ;
      (self._equipCell3SuitGrey):SetSprite(record.assetBundle, record.assetName)
    end
    ;
    (self._equipCell3Lv):SetText((self._jewelry):GetStrengthenLevel())
    ;
    (self._equipCell3SpecialFMImage):SetActive((self._jewelry):GetFinalRandomEntry())
    if (self._jewelry):GetFinalRandomEntry() then
      (AnimationHelper.SetAnimatorInteger2)((self._equipSmallPanel3):GetUIObject(), "par", 1)
    else
      (AnimationHelper.SetAnimatorInteger2)((self._equipSmallPanel3):GetUIObject(), "par", 0)
    end
  else
    self._jewelryKey = nil
    self._jewelry = nil
    ;
    (self._equipCell3):SetActive(false)
    ;
    (self._equipCell3Empty):SetActive(true)
  end
  local dialog = (DialogManager.GetDialog)("equip.equipchangenewdialog")
  if dialog then
    if dialog:GetEquipType() == EquipTypeEnum.WEAPON then
      dialog:Init((self._data):GetRoleId(), EquipTypeEnum.WEAPON, self._weaponKey, isPreSet)
    end
    if dialog:GetEquipType() == EquipTypeEnum.ARMOR then
      dialog:Init((self._data):GetRoleId(), EquipTypeEnum.ARMOR, self._armorKey, isPreSet)
    end
    if dialog:GetEquipType() == EquipTypeEnum.JEWELRY then
      dialog:Init((self._data):GetRoleId(), EquipTypeEnum.JEWELRY, self._jewelryKey, isPreSet)
    end
  end
  -- DECOMPILER ERROR: 36 unprocessed JMP targets
end

PreSetEquipDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

PreSetEquipDialog.OnEquipPanel1Click = function(self)
  -- function num : 0_9 , upvalues : EquipTypeEnum, _ENV, isPreSet
  local tag = false
  if self._weaponKey then
    tag = true
  else
    tag = self:IsReplaceable(EquipTypeEnum.WEAPON, self._weaponKey)
  end
  if self.lock then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100263)
    return 
  end
  if tag then
    local dialog = (DialogManager.CreateSingletonDialog)("equip.equipchangenewdialog")
    dialog:Init((self._data):GetRoleId(), EquipTypeEnum.WEAPON, self._weaponKey, isPreSet)
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100012)
    end
  end
end

PreSetEquipDialog.OnEquipPanel2Click = function(self)
  -- function num : 0_10 , upvalues : EquipTypeEnum, _ENV, isPreSet
  local tag = false
  if self._armorKey then
    tag = true
  else
    tag = self:IsReplaceable(EquipTypeEnum.ARMOR, self._armorKey)
  end
  if self.lock then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100263)
    return 
  end
  if tag then
    local dialog = (DialogManager.CreateSingletonDialog)("equip.equipchangenewdialog")
    dialog:Init((self._data):GetRoleId(), EquipTypeEnum.ARMOR, self._armorKey, isPreSet)
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100012)
    end
  end
end

PreSetEquipDialog.OnEquipPanel3Click = function(self)
  -- function num : 0_11 , upvalues : EquipTypeEnum, _ENV, isPreSet
  local tag = false
  if self._jewelryKey then
    tag = true
  else
    tag = self:IsReplaceable(EquipTypeEnum.JEWELRY, self._jewelryKey)
  end
  if self.lock then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100263)
    return 
  end
  if tag then
    local dialog = (DialogManager.CreateSingletonDialog)("equip.equipchangenewdialog")
    dialog:Init((self._data):GetRoleId(), EquipTypeEnum.JEWELRY, self._jewelryKey, isPreSet)
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100012)
    end
  end
end

return PreSetEquipDialog

