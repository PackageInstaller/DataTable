-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equipchangenewdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CMessageTip = (BeanManager.GetTableByName)("message.cmessagetip")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local UIManager = ((CS.PixelNeko).UI).UIManager
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local ColumnsNum = 4
local MinRowNum = 3
local BreakTimesString = {(TextManager.GetText)((CMessageTip:GetRecorder(100147)).msgTextID), (TextManager.GetText)((CMessageTip:GetRecorder(100148)).msgTextID), (TextManager.GetText)((CMessageTip:GetRecorder(100149)).msgTextID), (TextManager.GetText)((CMessageTip:GetRecorder(100150)).msgTextID); [0] = (TextManager.GetText)((CMessageTip:GetRecorder(100146)).msgTextID)}
local EquipChangeNewDialog = class("EquipChangeNewDialog", Dialog)
EquipChangeNewDialog.AssetBundleName = "ui/layouts.equip"
EquipChangeNewDialog.AssetName = "EquipPop"
EquipChangeNewDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipChangeNewDialog
  ((EquipChangeNewDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._isLock = false
  self._role = nil
  self._equipType = nil
  self._currentEquipKey = nil
  self._selectEquipKey = nil
  self._current = nil
  self._select = nil
  self._currentCanWearEquipList = {}
  self._leftFrameDataList = {}
  self._roleFinalAttrsMap = {}
  self._currentEquipAllAttrMap = {}
  self._currentEquipAttrGrowthMap = {}
  self._propContrastData = {}
  self._changeBtnGuideEffectHandler = nil
  self._screeningConditions = {}
  self._sortCriteriaNameId = 1500042
  self._isAscendingOrder = false
  self._listByConditions = {}
  self._receiveSChangeEquip = true
end

EquipChangeNewDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, GridFrame, ColumnsNum, TableFrame
  self._backClickPanel = self:GetChild("Image")
  ;
  (self._backClickPanel):Subscribe_PointerClickEvent(self.OnBackClick, self)
  self._listBack = self:GetChild("EquipBack")
  self._filterBtn = self:GetChild("FliterBtn")
  self._levelBtn = self:GetChild("LevelBtn")
  self._levelBtnTxt = self:GetChild("LevelBtn/_Text")
  self._sortBtn = self:GetChild("SortBtn")
  self._sortUpBtnImg = self:GetChild("SortBtn/Up")
  ;
  (self._sortUpBtnImg):SetActive(self._isAscendingOrder)
  self._sortDownBtnImg = self:GetChild("SortBtn/Down")
  ;
  (self._sortDownBtnImg):SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt = self:GetChild("SortBtn/_TextUp")
  ;
  (self._sortUpBtnTxt):SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt = self:GetChild("SortBtn/_TextDown")
  ;
  (self._sortDownBtnTxt):SetActive(not self._isAscendingOrder)
  ;
  (self._filterBtn):Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  ;
  (self._levelBtn):Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  ;
  (self._sortBtn):Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = ((require("logic.dialog.common.filterdialog")).Create)(self._filterPanel)
  self._resolveBtn = self:GetChild("ResolveBtn")
  ;
  (self._resolveBtn):Subscribe_PointerClickEvent(self.OnResolveBtnClick, self)
  self._panel = self:GetChild("ItemFrame")
  self._frame = (GridFrame.Create)(self._panel, self, true, ColumnsNum)
  ;
  (self._frame):SetMargin(15, 0)
  self._select_panel = self:GetChild("SelectTips/TipsBack")
  self._select_rank = self:GetChild("SelectTips/TipsBack/Top/EquipCell/BackGround/Frame")
  self._select_icon = self:GetChild("SelectTips/TipsBack/Top/EquipCell/BackGround/Icon")
  self._select_charPhoto = self:GetChild("SelectTips/TipsBack/Top/EquipCell/CharPhoto")
  self._select_charPhotoBack = self:GetChild("SelectTips/TipsBack/Top/EquipCell/CharBack")
  self._select_pinJiStar = self:GetChild("SelectTips/TipsBack/Top/EquipCell/BackGround/BreakPoint")
  self._select_specialFMImage = self:GetChild("SelectTips/TipsBack/Top/EquipCell/BackGround/FuMo")
  self._select_animator = ((self:GetChild("SelectTips")):GetUIObject()):GetComponent("Animator")
  self._select_score = self:GetChild("SelectTips/TipsBack/Top/Fight/Num")
  self._select_equipName = self:GetChild("SelectTips/TipsBack/Top/EquipName")
  self._select_lv = self:GetChild("SelectTips/TipsBack/Top/Level/Num")
  self._select_lvMax = self:GetChild("SelectTips/TipsBack/Top/Level/NumMax")
  self._select_field = self:GetChild("SelectTips/TipsBack/Frame")
  self._select_lockBtn = self:GetChild("SelectTips/TipsBack/Top/LockBtn")
  self._select_forgeBtn = self:GetChild("SelectTips/TipsBack/ForgeBtn")
  ;
  (self._select_lockBtn):Subscribe_PointerClickEvent(self.OnLockBtnClick, self)
  ;
  (self._select_forgeBtn):Subscribe_PointerClickEvent(self.OnForgeBtnClick, self)
  self._select_frame = (TableFrame.Create)(self._select_field, self, true, true, true)
  self._x_select = (self._select_field):GetSize()
  self._rootX_select = (self._select_panel):GetSize()
  self._pos_x_select = (self._select_panel):GetPosition()
  self._current_panel = self:GetChild("CurrentTips/TipsBack")
  self._current_rank = self:GetChild("CurrentTips/TipsBack/Top/EquipCell/BackGround/Frame")
  self._current_icon = self:GetChild("CurrentTips/TipsBack/Top/EquipCell/BackGround/Icon")
  self._current_charPhoto = self:GetChild("CurrentTips/TipsBack/Top/EquipCell/CharPhoto")
  self._current_charPhotoBack = self:GetChild("CurrentTips/TipsBack/Top/EquipCell/CharBack")
  self._current_pinJiStar = self:GetChild("CurrentTips/TipsBack/Top/EquipCell/BackGround/BreakPoint")
  self._current_specialFMImage = self:GetChild("CurrentTips/TipsBack/Top/EquipCell/BackGround/FuMo")
  self._current_animator = ((self:GetChild("CurrentTips")):GetUIObject()):GetComponent("Animator")
  self._current_equipTag = self:GetChild("CurrentTips/TipsBack/Top/EquipCell/BackGround/Equip")
  self._current_equipSetTag = self:GetChild("CurrentTips/TipsBack/Top/EquipCell/BackGround/EquipSet")
  self._current_score = self:GetChild("CurrentTips/TipsBack/Top/Fight/Num")
  self._current_equipName = self:GetChild("CurrentTips/TipsBack/Top/EquipName")
  self._current_lv = self:GetChild("CurrentTips/TipsBack/Top/Level/Num")
  self._current_lvMax = self:GetChild("CurrentTips/TipsBack/Top/Level/NumMax")
  self._current_field = self:GetChild("CurrentTips/TipsBack/Frame")
  self._current_lockBtn = self:GetChild("CurrentTips/TipsBack/Top/LockBtn")
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._current_lockBtn):Subscribe_PointerClickEvent(self.OnCurrentLockBtnClick, self)
  self._current_frame = (TableFrame.Create)(self._current_field, self, true, true, true)
  self._x_current = (self._current_field):GetSize()
  self._rootX_current = (self._current_panel):GetSize()
  self._pos_x_current = (self._current_panel):GetPosition()
  self._propContrastBack = self:GetChild("SelectTips/TipsBack/PropContrastBack")
  self._propContrastPanel = self:GetChild("SelectTips/TipsBack/PropContrast")
  self._propContrastFrame = (GridFrame.Create)(self._propContrastPanel, self, true, 2, false)
  self._changeBtn = self:GetChild("SelectTips/TipsBack/ChangeBtn")
  self._unEquipBtn = self:GetChild("SelectTips/TipsBack/UnEquipBtn")
  self._equipBtn = self:GetChild("SelectTips/TipsBack/EquipBtn")
  ;
  (self._changeBtn):Subscribe_PointerClickEvent(self.OnChangeBtnClicked, self)
  ;
  (self._unEquipBtn):Subscribe_PointerClickEvent(self.OnUnEquipBtnClicked, self)
  ;
  (self._equipBtn):Subscribe_PointerClickEvent(self.OnChangeBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEquipLockStateChanged, Common.n_EquipLockStateChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEquipChanged, Common.n_EquipChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEquipPresetChanged, Common.n_EquipPresetChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_EnchantEquip, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_EquipBreak, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_EquipLevelUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_EquipExpUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEquipChecked, Common.n_EquipChecked, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleUpdateProperties, Common.n_UpdateProperties, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDecomposeEquips, Common.n_DecomposeEquips, nil)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(2)
  self:CheckCachedFM()
end

EquipChangeNewDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._filterDlg then
    (self._filterDlg):Destroy()
    self._filterDlg = nil
  end
  ;
  (self._frame):Destroy()
  ;
  (self._select_frame):Destroy()
  ;
  (self._current_frame):Destroy()
  ;
  (self._propContrastFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (UIBackManager.SetUIBackShow)(false)
end

EquipChangeNewDialog.CheckCachedFM = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_BagInfo):HasCachedFMKey() == false then
    return 
  end
  local keyTable = ((NekoData.BehaviorManager).BM_BagInfo):GetCachedFMKeyTable()
  local fmResultTipDialog = (DialogManager.CreateSingletonDialog)("equipforge.equipfmresultdialog")
  fmResultTipDialog:RefreshFromCachedFM(keyTable)
end

EquipChangeNewDialog.OnRefresh = function(self, notification)
  -- function num : 0_4
  self:Init((self._role):GetRoleId(), self._equipType, self._currentEquipKey, self._isPreset)
  if notification then
    (self._frame):FireEvent("EquipInfoChange", notification.userInfo)
  end
end

EquipChangeNewDialog.OnDecomposeEquips = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in ipairs((notification.userInfo).equipKeys) do
    if v == self._currentEquipKey then
      self._currentEquipKey = nil
    end
    if v == self._selectEquipKey then
      self._selectEquipKey = nil
    end
  end
  self:OnRefresh(notification)
end

EquipChangeNewDialog.Init = function(self, roleKey, equipType, equipKey, isPreset)
  -- function num : 0_6 , upvalues : _ENV
  self:ScreeningAndSorting()
  self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
  self._isPreset = isPreset
  self._roleEquipSuitMap = (self._role):GetRoleEquipSuitMap()
  self._roleSuitSkillMap = (self._role):GetSuitSkillsMap()
  if isPreset then
    self._roleEquipSuitMap = (self._role):GetPreSetRoleEquipSuitMap()
    self._roleSuitSkillMap = (self._role):GetPreSetRoleEquipSuitMap()
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._roleEquipSuitMap)[equipType] = nil
  self._equipType = equipType
  ;
  ((NekoData.BehaviorManager).BM_Dungeon):ClearEquipRedDataWithRoleKeyAndEquipType(roleKey, equipType)
  self._currentEquipKey = equipKey
  for k,v in pairs(self._currentEquipAllAttrMap) do
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R10 in 'UnsetPending'

    (self._currentEquipAllAttrMap)[k] = nil
  end
  for k,v in pairs(self._currentEquipAttrGrowthMap) do
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R10 in 'UnsetPending'

    (self._currentEquipAttrGrowthMap)[k] = nil
  end
  if equipKey then
    local currentEquip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(equipKey)
    if currentEquip then
      for k,v in pairs(currentEquip:GetAllAttr()) do
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R11 in 'UnsetPending'

        (self._currentEquipAllAttrMap)[k] = v
      end
      for k,v in pairs(currentEquip:GetAttrGrowth()) do
        -- DECOMPILER ERROR at PC80: Confused about usage of register: R11 in 'UnsetPending'

        (self._currentEquipAttrGrowthMap)[k] = v
      end
    end
  end
  do
    if not self._currentEquipKey then
      (self._changeBtn):SetActive(false)
      ;
      (self._unEquipBtn):SetActive(true)
    else
      ;
      (self._changeBtn):SetActive(true)
      ;
      (self._unEquipBtn):SetActive(false)
    end
    self:InitRightPanel()
    self:ScreeningAndSorting()
    self:RefreshRightPanel()
  end
end

EquipChangeNewDialog.InitRightPanel = function(self)
  -- function num : 0_7 , upvalues : _ENV, CEquipItemTable
  self._currentEquip = nil
  if self._currentEquipKey then
    self._currentEquip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(self._currentEquipKey)
  end
  self._bagEquipList = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipList()
  self._typeEquipList = {}
  for i,v in ipairs(self._bagEquipList) do
    if v:GetEquipType() == self._equipType and v:GetKey() ~= self._currentEquipKey then
      (table.insert)(self._typeEquipList, v)
    end
  end
  self._canWearEquipList = {}
  local roleEquipTypeList = (self._role):GetRoleEquipTypeList()
  for key,value in pairs(roleEquipTypeList) do
    for k,v in pairs(CEquipItemTable:GetAllIds()) do
      local equipItemRecord = CEquipItemTable:GetRecorder(v)
      if equipItemRecord.equipAttrib == tonumber(value) then
        local str = equipItemRecord.roleLimit
        if str and str == "" then
          (table.insert)(self._canWearEquipList, v)
        else
          local list = {}
          if str and str ~= "" then
            list = (string.split)(str, ";")
          end
          if (table.keyof)(list, tostring((self._role):GetId())) then
            (table.insert)(self._canWearEquipList, v)
          end
        end
      end
    end
  end
  do
    while (self._currentCanWearEquipList)[#self._currentCanWearEquipList] do
      (table.remove)(self._currentCanWearEquipList, #self._currentCanWearEquipList)
    end
    for index,value in ipairs(self._typeEquipList) do
      if (table.indexof)(self._canWearEquipList, value:GetID()) then
        (table.insert)(self._currentCanWearEquipList, value)
      end
    end
    if self._currentEquip then
      (table.insert)(self._currentCanWearEquipList, self._currentEquip)
    end
  end
end

EquipChangeNewDialog.RefreshRightPanel = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local key = nil
  if self._currentEquipKey then
    self._currentEquip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(self._currentEquipKey)
    if self._currentEquip then
      key = (self._currentEquip):GetKey()
    end
  end
  if not key then
    key = self._selectEquipKey
  end
  self:SetSelectedEquip(key)
end

EquipChangeNewDialog.SetSelectedEquip = function(self, selectEquipKey)
  -- function num : 0_9 , upvalues : _ENV
  self._selectEquipKey = selectEquipKey
  if selectEquipKey then
    (self._select_panel):SetActive(true)
    self._select = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(selectEquipKey)
  else
    ;
    (self._select_panel):SetActive(false)
    ;
    (self._current_panel):SetActive(false)
    ;
    (self._frame):FireEvent("SetEquipSelected", self._selectEquipKey)
    return 
  end
  ;
  (self._frame):FireEvent("SetEquipSelected", self._selectEquipKey)
  do
    if self._select and not (self._select):IsChecked() then
      local cviewequip = (LuaNetManager.CreateProtocol)("protocol.item.cviewequip")
      if cviewequip then
        cviewequip.key = self._selectEquipKey
        cviewequip:Send()
      end
    end
    for k,v in pairs(self._roleFinalAttrsMap) do
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R7 in 'UnsetPending'

      (self._roleFinalAttrsMap)[k] = nil
    end
    for k,v in pairs((self._role):GetProperties()) do
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R7 in 'UnsetPending'

      (self._roleFinalAttrsMap)[k] = v
    end
    self:RefreshLeftPanel()
  end
end

EquipChangeNewDialog.SetPropContrast = function(self)
  -- function num : 0_10 , upvalues : _ENV, RoleConfigTable, CstringCfg, AnimationHelper, CEquipItemTable, Cequipbreakcfg
  local selectEquip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(self._selectEquipKey)
  local currentEquip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(self._currentEquipKey)
  self._propContrastData = {}
  local currentRoleProp = (self._role):GetProperties()
  local previewRoleProp = {}
  setmetatable(currentRoleProp, {__index = function()
    -- function num : 0_10_0
    return 0
  end
})
  setmetatable(previewRoleProp, {__index = function()
    -- function num : 0_10_1
    return 0
  end
})
  for key,value in pairs(currentRoleProp) do
    previewRoleProp[key] = value
  end
  if currentEquip then
    local currentEquipAttrs = currentEquip:GetAllAttr()
    for key,value in pairs(currentEquipAttrs) do
      previewRoleProp[key] = previewRoleProp[key] - value
    end
  end
  do
    local selectEquipAttrs = selectEquip:GetAllAttr()
    for key,value in pairs(selectEquipAttrs) do
      if not previewRoleProp[key] then
        previewRoleProp[key] = 0
      end
      previewRoleProp[key] = previewRoleProp[key] + value
    end
    local roleVocationId = (RoleConfigTable:GetRecorder((self._role):GetId())).vocation
    local contrast = {}
    contrast.name = (TextManager.GetText)((CstringCfg:GetRecorder(1191)).msgTextID)
    if roleVocationId == 5 then
      contrast.value = 0
    else
      local damageType = ((self._role):GetDamageType())
      local currentDamageIncrease, previewDamageIncrease = nil, nil
      if damageType == 1 then
        currentDamageIncrease = currentRoleProp[90]
        previewDamageIncrease = previewRoleProp[90]
      else
        if damageType == 2 then
          currentDamageIncrease = currentRoleProp[110]
          previewDamageIncrease = previewRoleProp[110]
        end
      end
      local currenDamage = currentRoleProp[30] * (1 + currentRoleProp[550] / 1000) * (1 + currentRoleProp[170] / 1000 * 0.25) * (currentRoleProp[130] / 1000 * (currentRoleProp[140] / 1000) + (1 - currentRoleProp[130] / 1000)) * (1 + currentDamageIncrease / 1000)
      local previewDamage = previewRoleProp[30] * (1 + previewRoleProp[550] / 1000) * (1 + previewRoleProp[170] / 1000 * 0.25) * (previewRoleProp[130] / 1000 * (previewRoleProp[140] / 1000) + (1 - previewRoleProp[130] / 1000)) * (1 + previewDamageIncrease / 1000)
      contrast.value = (previewDamage - currenDamage) / currenDamage * 100
    end
    do
      ;
      (table.insert)(self._propContrastData, contrast)
      contrast = {}
      contrast.name = (TextManager.GetText)((CstringCfg:GetRecorder(1192)).msgTextID)
      if roleVocationId == 5 then
        local currenTreatment = currentRoleProp[30] * (1 + currentRoleProp[550] / 1000) * (1 + currentRoleProp[170] / 1000 * 0.25) * (currentRoleProp[130] / 1000 * (currentRoleProp[140] / 1000) + (1 - currentRoleProp[130] / 1000)) * (1 + currentRoleProp[530] / 1000)
        local previewTreatment = previewRoleProp[30] * (1 + previewRoleProp[550] / 1000) * (1 + previewRoleProp[170] / 1000 * 0.25) * (previewRoleProp[130] / 1000 * (previewRoleProp[140] / 1000) + (1 - previewRoleProp[130] / 1000)) * (1 + previewRoleProp[530] / 1000)
        contrast.value = (previewTreatment - currenTreatment) / currenTreatment * 100
      else
        do
          contrast.value = 0
          ;
          (table.insert)(self._propContrastData, contrast)
          contrast = {}
          contrast.name = (TextManager.GetText)((CstringCfg:GetRecorder(1194)).msgTextID)
          local currenMagicDef = currentRoleProp[20] * (1 + currentRoleProp[580]) / 1000 * (3000 + currentRoleProp[60] * (1 + currentRoleProp[570]) / 1000) / 3000 / (1 - currentRoleProp[120] / 1000)
          local previewMagicDef = previewRoleProp[20] * (1 + currentRoleProp[580]) / 1000 * (3000 + previewRoleProp[60] * (1 + previewRoleProp[570]) / 1000) / 3000 / (1 - previewRoleProp[120] / 1000)
          contrast.value = (previewMagicDef - currenMagicDef) / currenMagicDef * 100
          ;
          (table.insert)(self._propContrastData, contrast)
          contrast = {}
          contrast.name = (TextManager.GetText)((CstringCfg:GetRecorder(1193)).msgTextID)
          local currenPhysicsDef = currentRoleProp[20] * (1 + currentRoleProp[580]) / 1000 * (3000 + currentRoleProp[50] * (1 + currentRoleProp[560]) / 1000) / 3000 / (1 - currentRoleProp[100] / 1000)
          local previewPhysicsDef = previewRoleProp[20] * (1 + currentRoleProp[580]) / 1000 * (3000 + previewRoleProp[50] * (1 + previewRoleProp[560]) / 1000) / 3000 / (1 - previewRoleProp[100] / 1000)
          contrast.value = (previewPhysicsDef - currenPhysicsDef) / currenPhysicsDef * 100
          ;
          (table.insert)(self._propContrastData, contrast)
          ;
          (self._propContrastFrame):ReloadAllCell()
          local equip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(self._currentEquipKey)
          local record = equip:GetIcon()
          ;
          (self._current_icon):SetSprite(record.assetBundle, record.assetName)
          local roleKey = equip:GetRoleKey()
          if roleKey ~= 0 then
            local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
            ;
            (self._current_charPhoto):SetActive(true)
            ;
            (self._current_charPhotoBack):SetActive(true)
            local imageRecord = role:GetSkillHeadImageRecord()
            ;
            (self._current_charPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          else
            do
              ;
              (self._current_charPhoto):SetActive(false)
              ;
              (self._current_charPhotoBack):SetActive(false)
              record = equip:GetPinJiImage()
              ;
              (self._current_rank):SetSprite(record.assetBundle, record.assetName)
              ;
              (self._current_lv):SetText(equip:GetStrengthenLevel())
              ;
              (self._current_lvMax):SetText(equip:GetStrengthenMaxLevel())
              ;
              (self._current_equipName):SetText(equip:GetName())
              ;
              (self._current_score):SetText(equip:GetScore())
              ;
              (self._current_pinJiStar):SetText(equip:GetEquipStarStr())
              ;
              (self._current_specialFMImage):SetActive(equip:GetFinalRandomEntry())
              if equip:GetFinalRandomEntry() then
                (AnimationHelper.SetAnimatorInteger2)((self:GetChild("CurrentTips")):GetUIObject(), "par", 1)
              else
                ;
                (AnimationHelper.SetAnimatorInteger2)((self:GetChild("CurrentTips")):GetUIObject(), "par", 0)
              end
              self._currentDownDataList = {}
              local temp = {}
              temp.tag = "Title1"
              ;
              (table.insert)(self._currentDownDataList, temp)
              local basePropRecord = {}
              record = CEquipItemTable:GetRecorder(equip:GetID())
              for i,v in ipairs(record.abilityID) do
                local temp = {}
                temp.tag = "BaseProp"
                temp.attrId = v
                temp.value = (record.abilityValue)[i] * (record.initMagnify + (equip:GetStrengthenLevel() - 1) + equip:GetCurrentBreakMultiple())
                ;
                (table.insert)(basePropRecord, temp)
              end
              ;
              (table.sort)(basePropRecord, function(a, b)
    -- function num : 0_10_2
    do return a.attrId < b.attrId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
              for i,v in ipairs(basePropRecord) do
                (table.insert)(self._currentDownDataList, v)
              end
              local randomWordList = equip:GetRandomEntry()
              if #randomWordList > 0 then
                temp = {}
                temp.tag = "Title2"
                ;
                (table.insert)(self._currentDownDataList, temp)
              end
              local cequipbreakcfgAll = (Cequipbreakcfg:GetAllIds())
              local unLockNumRecord = nil
              for i,id in pairs(cequipbreakcfgAll) do
                local record = Cequipbreakcfg:GetRecorder(id)
                if (self._select):GetPinJiID() == record.pinJi and (self._select):GetStage() == record.breaklv then
                  unLockNumRecord = record.unlockAbilityNum
                end
              end
              for i,v in pairs(randomWordList) do
                local temp = {}
                temp.tag = "RandomProp"
                temp.attrId = v.attr
                temp.value = v.attrValue
                temp.randomAbilityId = v.randomId
                temp.randomIndex = v.index
                temp.kind = v.kind
                ;
                (table.insert)(self._currentDownDataList, temp)
              end
              local suit = equip:GetEquipSuitRecorder()
              if suit then
                local temp = {}
                temp.tag = "SuitInfo"
                temp.suitName = suit.suitName
                temp.suitImg = suit.suitImg
                ;
                (table.insert)(self._currentDownDataList, temp)
                local skillIDs = suit.suitSkillID
                for i,v in ipairs(skillIDs) do
                  if v ~= 0 then
                    temp = {}
                    temp.tag = "SuitSkill"
                    temp.count = i
                    temp.skillID = v
                    if (self._roleSuitSkillMap)[suit.id] then
                      for i,skillid in ipairs(((self._roleSuitSkillMap)[suit.id]).skillIds) do
                        if skillid == v then
                          temp.takeEffect = true
                        end
                      end
                    end
                    do
                      do
                        ;
                        (table.insert)(self._currentDownDataList, temp)
                        -- DECOMPILER ERROR at PC615: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC615: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC615: LeaveBlock: unexpected jumping out IF_STMT

                      end
                    end
                  end
                end
              end
              do
                local temp = {tag = "Describe", value = equip:GetDestribe()}
                ;
                (table.insert)(self._currentDownDataList, temp)
                ;
                (self._current_frame):ReloadAllCell()
                local totallength = (self._current_frame):GetTotalLength()
                local delta = totallength - self._oy_current
                if delta < 0 then
                  (self._current_field):SetSize(self._x_current, self._ox_current, self._y_current, self._oy_current + delta)
                  ;
                  (self._current_panel):SetSize(self._rootX_current, self._rootOX_current, self._rooty_current, self._rootOY_current + delta)
                  ;
                  (self._current_panel):SetPosition(self._pos_x_current, self._pos_offset_x_current, self._pos_y_current, self._pos_offset_y_current - delta)
                  ;
                  (self._current_frame):SetSlide(false)
                end
                ;
                (self._current_frame):MoveToTop()
                self._isCurrentLock = equip:IsLocked()
                ;
                (self._current_lockBtn):SetActive(true)
                if self._isCurrentLock then
                  (self._current_lockBtn):SetSelected(true)
                else
                  ;
                  (self._current_lockBtn):SetSelected(false)
                end
              end
            end
          end
        end
      end
    end
  end
end

EquipChangeNewDialog.RefreshLeftPanel = function(self)
  -- function num : 0_11 , upvalues : _ENV, AnimationHelper, CEquipItemTable, Cequipbreakcfg
  local equip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(self._selectEquipKey)
  local record = equip:GetIcon()
  ;
  (self._select_icon):SetSprite(record.assetBundle, record.assetName)
  local roleKey = equip:GetRoleKey()
  if roleKey ~= 0 then
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
    ;
    (self._select_charPhoto):SetActive(true)
    ;
    (self._select_charPhotoBack):SetActive(true)
    local imageRecord = role:GetSkillHeadImageRecord()
    ;
    (self._select_charPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      ;
      (self._select_charPhoto):SetActive(false)
      ;
      (self._select_charPhotoBack):SetActive(false)
      record = equip:GetPinJiImage()
      ;
      (self._select_rank):SetSprite(record.assetBundle, record.assetName)
      ;
      (self._select_lv):SetText(equip:GetStrengthenLevel())
      ;
      (self._select_lvMax):SetText(equip:GetStrengthenMaxLevel())
      ;
      (self._select_equipName):SetText(equip:GetName())
      ;
      (self._select_score):SetText(equip:GetScore())
      ;
      (self._select_pinJiStar):SetText(equip:GetEquipStarStr())
      ;
      (self._select_specialFMImage):SetActive(equip:GetFinalRandomEntry())
      if equip:GetFinalRandomEntry() then
        (AnimationHelper.SetAnimatorInteger2)((self:GetChild("SelectTips")):GetUIObject(), "par", 1)
      else
        ;
        (AnimationHelper.SetAnimatorInteger2)((self:GetChild("SelectTips")):GetUIObject(), "par", 0)
      end
      self._downDataList = {}
      local temp = {}
      temp.tag = "Title1"
      ;
      (table.insert)(self._downDataList, temp)
      local basePropRecord = {}
      record = CEquipItemTable:GetRecorder(equip:GetID())
      for i,v in ipairs(record.abilityID) do
        local temp = {}
        temp.tag = "BaseProp"
        temp.attrId = v
        temp.value = (record.abilityValue)[i] * (record.initMagnify + (equip:GetStrengthenLevel() - 1) + equip:GetCurrentBreakMultiple())
        ;
        (table.insert)(basePropRecord, temp)
      end
      ;
      (table.sort)(basePropRecord, function(a, b)
    -- function num : 0_11_0
    do return a.attrId < b.attrId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      for i,v in ipairs(basePropRecord) do
        (table.insert)(self._downDataList, v)
      end
      local randomWordList = equip:GetRandomEntry()
      if #randomWordList > 0 then
        temp = {}
        temp.tag = "Title2"
        ;
        (table.insert)(self._downDataList, temp)
      end
      local cequipbreakcfgAll = (Cequipbreakcfg:GetAllIds())
      local unLockNumRecord = nil
      for i,id in pairs(cequipbreakcfgAll) do
        local record = Cequipbreakcfg:GetRecorder(id)
        if (self._select):GetPinJiID() == record.pinJi and (self._select):GetStage() == record.breaklv then
          unLockNumRecord = record.unlockAbilityNum
        end
      end
      for i,v in pairs(randomWordList) do
        local temp = {}
        temp.tag = "RandomProp"
        temp.attrId = v.attr
        temp.value = v.attrValue
        temp.randomAbilityId = v.randomId
        temp.randomIndex = v.index
        temp.kind = v.kind
        ;
        (table.insert)(self._downDataList, temp)
      end
      local suit = equip:GetEquipSuitRecorder()
      if suit then
        local temp = {}
        temp.tag = "SuitInfo"
        temp.suitName = suit.suitName
        temp.suitImg = suit.suitImg
        ;
        (table.insert)(self._downDataList, temp)
        local skillIDs = suit.suitSkillID
        for i,v in ipairs(skillIDs) do
          if v ~= 0 then
            temp = {}
            temp.tag = "SuitSkill"
            temp.count = i
            temp.skillID = v
            if self._currentEquipKey and self._currentEquipKey ~= 0 and self._selectEquipKey == self._currentEquipKey and (self._roleSuitSkillMap)[suit.id] then
              for i,skillid in ipairs(((self._roleSuitSkillMap)[suit.id]).skillIds) do
                if skillid == v then
                  temp.takeEffect = true
                end
              end
            end
            do
              do
                ;
                (table.insert)(self._downDataList, temp)
                -- DECOMPILER ERROR at PC288: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC288: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC288: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
      do
        local temp = {tag = "Describe", value = equip:GetDestribe()}
        ;
        (table.insert)(self._downDataList, temp)
        ;
        (self._select_frame):ReloadAllCell()
        local totallength = (self._select_frame):GetTotalLength()
        local delta = totallength - self._oy_select
        if delta < 0 then
          (self._select_field):SetSize(self._x_select, self._ox_select, self._y_select, self._oy_select + delta)
          ;
          (self._select_panel):SetSize(self._rootX_select, self._rootOX_select, self._rooty_select, self._rootOY_select + delta)
          ;
          (self._select_panel):SetPosition(self._pos_x_select, self._pos_offset_x_select, self._pos_y_select, self._pos_offset_y_select - delta)
          ;
          (self._select_frame):SetSlide(false)
        end
        ;
        (self._select_frame):MoveToTop()
        self._isLock = equip:IsLocked()
        ;
        (self._select_lockBtn):SetActive(true)
        if self._isLock then
          (self._select_lockBtn):SetSelected(true)
        else
          ;
          (self._select_lockBtn):SetSelected(false)
        end
        self:SetChangeBtns()
        if self._currentEquipKey and self._currentEquipKey ~= 0 and self._selectEquipKey ~= self._currentEquipKey then
          (self._current_panel):SetActive(true)
          if self._isPreset then
            (self._current_equipTag):SetActive(false)
            ;
            (self._current_equipSetTag):SetActive(true)
          else
            ;
            (self._current_equipTag):SetActive(true)
            ;
            (self._current_equipSetTag):SetActive(false)
          end
          ;
          (self._propContrastPanel):SetActive(true)
          ;
          (self._propContrastBack):SetActive(true)
          self:SetPropContrast()
        else
          ;
          (self._current_panel):SetActive(false)
          ;
          (self._propContrastPanel):SetActive(false)
          ;
          (self._propContrastBack):SetActive(false)
        end
      end
    end
  end
end

EquipChangeNewDialog.GetNumByEquipId = function(self, id)
  -- function num : 0_12 , upvalues : _ENV
  local count = 0
  for i,v in ipairs(self._listByConditions) do
    if v:GetID() == id then
      count = count + 1
    end
  end
  return count
end

EquipChangeNewDialog.ScreeningAndSorting = function(self)
  -- function num : 0_13 , upvalues : _ENV, EquipTypeEnum
  (self._levelBtnTxt):SetText((TextManager.GetText)(self._sortCriteriaNameId))
  while (self._listByConditions)[#self._listByConditions] do
    (table.remove)(self._listByConditions, #self._listByConditions)
  end
  for i,v in ipairs(self._currentCanWearEquipList) do
    (table.insert)(self._listByConditions, v)
  end
  for k,v in pairs(self._screeningConditions) do
    local select = false
    if k == 1 then
      local indexMap = {}
      for index,value in ipairs(v) do
        select = true
        for i,equip in ipairs(self._listByConditions) do
          if value.nameid == 1500047 and equip:GetPinJiID() == 3 then
            indexMap[i] = i
          else
            if value.nameid == 1500048 and equip:GetPinJiID() == 2 then
              indexMap[i] = i
            else
              if value.nameid == 1500049 and equip:GetPinJiID() == 1 then
                indexMap[i] = i
              else
                if value.nameid == 1500062 and equip:GetPinJiID() == 5 then
                  indexMap[i] = i
                end
              end
            end
          end
        end
      end
      if select then
        local deleteList = {}
        for i = 1, #self._listByConditions do
          if not indexMap[i] then
            (table.insert)(deleteList, i)
          end
        end
        do
          do
            while deleteList[#deleteList] do
              (table.remove)(self._listByConditions, deleteList[#deleteList])
              ;
              (table.remove)(deleteList, #deleteList)
            end
            if k == 2 then
              local indexMap = {}
              for index,value in ipairs(v) do
                select = true
                for i,equip in ipairs(self._listByConditions) do
                  if value.nameid == 1500043 and equip:GetEquipType() == EquipTypeEnum.WEAPON then
                    indexMap[i] = i
                  else
                    if value.nameid == 1500044 and equip:GetEquipType() == EquipTypeEnum.ARMOR then
                      indexMap[i] = i
                    else
                      if value.nameid == 1500045 and equip:GetEquipType() == EquipTypeEnum.JEWELRY then
                        indexMap[i] = i
                      end
                    end
                  end
                end
              end
              if select then
                local deleteList = {}
                for i = 1, #self._listByConditions do
                  if not indexMap[i] then
                    (table.insert)(deleteList, i)
                  end
                end
                do
                  do
                    while deleteList[#deleteList] do
                      (table.remove)(self._listByConditions, deleteList[#deleteList])
                      ;
                      (table.remove)(deleteList, #deleteList)
                    end
                    if k == 3 then
                      local indexMap = {}
                      for index,value in ipairs(v) do
                        select = true
                        for i,equip in ipairs(self._listByConditions) do
                          if equip:GetEquipSuitId() > 0 and value.nameid == 1500069 then
                            indexMap[i] = i
                          else
                            if equip:GetEquipSuitId() == 0 and value.nameid == 1500070 then
                              indexMap[i] = i
                            end
                          end
                        end
                      end
                      if select then
                        local deleteList = {}
                        for i = 1, #self._listByConditions do
                          if not indexMap[i] then
                            (table.insert)(deleteList, i)
                          end
                        end
                        do
                          do
                            while deleteList[#deleteList] do
                              (table.remove)(self._listByConditions, deleteList[#deleteList])
                              ;
                              (table.remove)(deleteList, #deleteList)
                            end
                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC266: LeaveBlock: unexpected jumping out IF_STMT

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
    end
  end
  ;
  (table.sort)(self._listByConditions, function(a, b)
    -- function num : 0_13_0 , upvalues : self
    local _a, _b = nil, nil
    if self._sortCriteriaNameId == 1500032 then
      _a = a:GetPinJiID()
      _b = b:GetPinJiID()
    else
      if self._sortCriteriaNameId == 1500033 then
        _a = a:GetStrengthenLevel()
        _b = b:GetStrengthenLevel()
      else
        if self._sortCriteriaNameId == 1500042 then
          _a = a:GetScore()
          _b = b:GetScore()
        else
          if self._sortCriteriaNameId == 1500034 then
            _a = self:GetNumByEquipId(a:GetID())
            _b = self:GetNumByEquipId(b:GetID())
          else
            if self._sortCriteriaNameId == 1500035 then
              _a = a:GetKey()
              _b = b:GetKey()
            else
              if self._sortCriteriaNameId == 1500036 then
                _a = a:GetLimitEquip()
                _b = b:GetLimitEquip()
              else
                if self._sortCriteriaNameId == 1500037 then
                  _a = a:GetEquipMaxHp()
                  _b = b:GetEquipMaxHp()
                else
                  if self._sortCriteriaNameId == 1500038 then
                    _a = a:GetEquipATK()
                    _b = b:GetEquipATK()
                  else
                    if self._sortCriteriaNameId == 1500039 then
                      _a = a:GetEquipMagAtk()
                      _b = b:GetEquipMagAtk()
                    else
                      if self._sortCriteriaNameId == 1500040 then
                        _a = a:GetEquipDef()
                        _b = b:GetEquipDef()
                      else
                        if self._sortCriteriaNameId == 1500041 then
                          _a = a:GetEquipMagDef()
                          _b = b:GetEquipMagDef()
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
    if _a == _b and self._sortCriteriaNameId ~= 1500035 then
      local aId, bId = nil, nil
      if self._sortCriteriaNameId == 1500032 or self._sortCriteriaNameId == 1500033 or self._sortCriteriaNameId == 1500042 then
        aId = a:GetID()
      end
      if aId == bId then
        local aKey, bKey = nil, nil
        aKey = a:GetKey()
        if bKey >= aKey then
          do
            do return not self._isAscendingOrder end
            do return aKey < bKey end
            if aId >= bId then
              do
                do return not self._isAscendingOrder end
                do return bId < aId end
                if _a >= _b then
                  do return not self._isAscendingOrder end
                  do return _b < _a end
                  -- DECOMPILER ERROR: 12 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
)
  local lastPos = (self._frame):GetCurrentPosition()
  ;
  (self._frame):ReloadAllCell()
  if lastPos then
    (self._frame):MoveToAssignedPos(lastPos)
  end
  if #self._listByConditions == 0 then
    self._selectEquipKey = nil
  end
  self:SetChangeBtns()
end

EquipChangeNewDialog.OnFilterBtnClick = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 1, "EquipChange", self._screeningConditions)
end

EquipChangeNewDialog.OnLevelBtnClick = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 2, "EquipChange", self._sortCriteriaNameId)
end

EquipChangeNewDialog.OnSortBtnClick = function(self)
  -- function num : 0_16
  self._isAscendingOrder = not self._isAscendingOrder
  ;
  (self._sortUpBtnImg):SetActive(self._isAscendingOrder)
  ;
  (self._sortDownBtnImg):SetActive(not self._isAscendingOrder)
  ;
  (self._sortUpBtnTxt):SetActive(self._isAscendingOrder)
  ;
  (self._sortDownBtnTxt):SetActive(not self._isAscendingOrder)
  self:ScreeningAndSorting()
end

EquipChangeNewDialog.SetSortCriteriaNameId = function(self, nameId)
  -- function num : 0_17
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
  end
end

EquipChangeNewDialog.SetScreeningConditions = function(self, screeningConditions)
  -- function num : 0_18
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

EquipChangeNewDialog.OnLockBtnClick = function(self)
  -- function num : 0_19 , upvalues : _ENV
  self._isLock = not self._isLock
  if self._isLock then
    (self._frame):FireEvent("LockEquip", self._selectEquipKey)
    ;
    (self._select_lockBtn):SetSelected(true)
    local clockequip = (LuaNetManager.CreateProtocol)("protocol.item.clockequip")
    if clockequip then
      clockequip.key = self._selectEquipKey
      clockequip:Send()
    end
  else
    do
      ;
      (self._frame):FireEvent("UnLockEquip", self._selectEquipKey)
      ;
      (self._select_lockBtn):SetSelected(false)
      local clockequip = (LuaNetManager.CreateProtocol)("protocol.item.clockequip")
      if clockequip then
        clockequip.key = self._selectEquipKey
        clockequip:Send()
      end
    end
  end
end

EquipChangeNewDialog.OnCurrentLockBtnClick = function(self)
  -- function num : 0_20 , upvalues : _ENV
  self._isCurrentLock = not self._isCurrentLock
  if self._isCurrentLock then
    (self._frame):FireEvent("LockEquip", self._currentEquipKey)
    ;
    (self._current_lockBtn):SetSelected(true)
    local clockequip = (LuaNetManager.CreateProtocol)("protocol.item.clockequip")
    if clockequip then
      clockequip.key = self._currentEquipKey
      clockequip:Send()
    end
  else
    do
      ;
      (self._frame):FireEvent("UnLockEquip", self._currentEquipKey)
      ;
      (self._current_lockBtn):SetSelected(false)
      local clockequip = (LuaNetManager.CreateProtocol)("protocol.item.clockequip")
      if clockequip then
        clockequip.key = self._currentEquipKey
        clockequip:Send()
      end
    end
  end
end

EquipChangeNewDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

EquipChangeNewDialog.OnEquipLockStateChanged = function(self, notification)
  -- function num : 0_22 , upvalues : _ENV
  for i,v in ipairs(self._listByConditions) do
    local key = (notification.userInfo).key
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

    if v:GetKey() == key then
      (self._listByConditions)[i] = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(key)
    end
  end
  ;
  (self._frame):FireEvent("EquipLockStateChanged", notification.userInfo)
end

EquipChangeNewDialog.OnEquipChecked = function(self, notification)
  -- function num : 0_23 , upvalues : _ENV
  while (self._bagEquipList)[#self._bagEquipList] do
    (table.remove)(self._bagEquipList, #self._bagEquipList)
  end
  for i,v in ipairs(((NekoData.BehaviorManager).BM_BagInfo):GetEquipList()) do
    (table.insert)(self._bagEquipList, v)
  end
  for i,v in ipairs(self._listByConditions) do
    local key = (notification.userInfo).key
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R8 in 'UnsetPending'

    if v:GetKey() == key then
      (self._listByConditions)[i] = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(key)
    end
  end
  ;
  (self._frame):FireEvent("EquipChecked", notification.userInfo)
end

EquipChangeNewDialog.OnChangeBtnClicked = function(self)
  -- function num : 0_24 , upvalues : _ENV
  local equip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(self._selectEquipKey)
  local roleKey = equip:GetRoleKey()
  if roleKey ~= 0 and not self._isPreset then
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
    local name = role:GetRoleName()
    local lv = role:GetLevel()
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(13, {name}, function()
    -- function num : 0_24_0 , upvalues : self
    self:SendCchangeequipment()
  end
, {}, nil, {})
  else
    do
      self:SendCchangeequipment()
    end
  end
end

EquipChangeNewDialog.SendCchangeequipment = function(self)
  -- function num : 0_25 , upvalues : _ENV
  if self._isPreset then
    local cchangeEquipment = (LuaNetManager.CreateProtocol)("protocol.item.cchangepresetequip")
    if cchangeEquipment then
      cchangeEquipment.equipKey = self._selectEquipKey
      cchangeEquipment.equipType = self._equipType
      cchangeEquipment.roleId = (self._role):GetRoleId()
      cchangeEquipment:Send()
    end
  else
    do
      if self._receiveSChangeEquip then
        local cchangeEquipment = (LuaNetManager.CreateProtocol)("protocol.item.cchangeequipment")
        if cchangeEquipment then
          self._receiveSChangeEquip = false
          local data = {}
          data[self._selectEquipKey] = (self._role):GetRoleId()
          cchangeEquipment.equipToRole = data
          cchangeEquipment:Send()
        end
      end
    end
  end
end

EquipChangeNewDialog.OnUnEquipBtnClicked = function(self)
  -- function num : 0_26 , upvalues : _ENV
  do
    -- DECOMPILER ERROR at PC10: Unhandled construct in 'MakeBoolean' P1

    if self._isPreset and self._currentEquipKey ~= 0 then
      local cchangeEquipment = (LuaNetManager.CreateProtocol)("protocol.item.cchangepresetequip")
      if cchangeEquipment then
        cchangeEquipment.equipKey = 0
        cchangeEquipment.equipType = self._equipType
        cchangeEquipment.roleId = (self._role):GetRoleId()
        cchangeEquipment:Send()
      end
    end
    if self._receiveSChangeEquip then
      local cchangeEquipment = (LuaNetManager.CreateProtocol)("protocol.item.cchangeequipment")
      if cchangeEquipment then
        self._receiveSChangeEquip = false
        local data = {}
        data[self._currentEquipKey] = 0
        cchangeEquipment.equipToRole = data
        cchangeEquipment:Send()
      end
    end
  end
end

EquipChangeNewDialog.OnRoleUpdateProperties = function(self, notification)
  -- function num : 0_27 , upvalues : _ENV
  if (notification.userInfo).roleId == (self._role):GetRoleId() then
    self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._role):GetRoleId())
    for k,v in pairs(self._roleFinalAttrsMap) do
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

      (self._roleFinalAttrsMap)[k] = nil
    end
    for k,v in pairs((self._role):GetProperties()) do
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

      (self._roleFinalAttrsMap)[k] = v
    end
    self:RefreshLeftPanel()
  end
end

EquipChangeNewDialog.OnEquipChanged = function(self, notification)
  -- function num : 0_28 , upvalues : _ENV, EquipTypeEnum
  self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._role):GetRoleId())
  if self._equipType == EquipTypeEnum.WEAPON then
    self._currentEquipKey = (self._role):GetWeapon()
  else
    if self._equipType == EquipTypeEnum.ARMOR then
      self._currentEquipKey = (self._role):GetArmor()
    else
      if self._equipType == EquipTypeEnum.JEWELRY then
        self._currentEquipKey = (self._role):GetJewelry()
      end
    end
  end
  self:SetChangeBtns()
  self._receiveSChangeEquip = true
  self:OnRefresh()
end

EquipChangeNewDialog.OnEquipPresetChanged = function(self, notification)
  -- function num : 0_29 , upvalues : _ENV, EquipTypeEnum
  self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._role):GetRoleId())
  if self._equipType == EquipTypeEnum.WEAPON then
    self._currentEquipKey = (self._role):GetPreSetWeapon()
  else
    if self._equipType == EquipTypeEnum.ARMOR then
      self._currentEquipKey = (self._role):GetPreSetArmor()
    else
      if self._equipType == EquipTypeEnum.JEWELRY then
        self._currentEquipKey = (self._role):GetPreSetJewelry()
      end
    end
  end
  self:SetChangeBtns()
  self._receiveSChangePreSetEquip = true
  self:OnRefresh()
end

EquipChangeNewDialog.SetChangeBtns = function(self)
  -- function num : 0_30
  if self._selectEquipKey and self._selectEquipKey == self._currentEquipKey then
    (self._changeBtn):SetActive(false)
    ;
    (self._unEquipBtn):SetActive(true)
    ;
    (self._equipBtn):SetActive(false)
  else
    if self._selectEquipKey then
      if self._currentEquipKey and self._currentEquipKey ~= 0 then
        (self._unEquipBtn):SetActive(false)
        ;
        (self._changeBtn):SetActive(true)
        ;
        (self._equipBtn):SetActive(false)
      else
        ;
        (self._changeBtn):SetActive(false)
        ;
        (self._unEquipBtn):SetActive(false)
        ;
        (self._equipBtn):SetActive(true)
      end
    else
      ;
      (self._changeBtn):SetActive(false)
      ;
      (self._unEquipBtn):SetActive(false)
      ;
      (self._equipBtn):SetActive(false)
    end
  end
end

EquipChangeNewDialog.OnResolveBtnClick = function(self)
  -- function num : 0_31 , upvalues : _ENV
  if (DialogManager.GetDialog)("equip.equipchangenewdialog") then
    (DialogManager.CreateSingletonDialog)("equip.equipresolvedialog")
  end
end

EquipChangeNewDialog.GetEquipType = function(self)
  -- function num : 0_32
  return self._equipType
end

EquipChangeNewDialog.NumberOfCell = function(self, frame)
  -- function num : 0_33
  if frame == self._frame then
    return #self._listByConditions
  else
    if frame == self._select_frame then
      return #self._downDataList
    else
      if frame == self._current_frame then
        return #self._currentDownDataList
      else
        if frame == self._propContrastFrame then
          return #self._propContrastData
        end
      end
    end
  end
end

EquipChangeNewDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_34
  if frame == self._frame then
    return "equip.equipchangenewcell"
  else
    if frame == self._select_frame then
      if ((self._downDataList)[index]).tag == "BaseProp" then
        return "equip.equipchangebasepropcell"
      else
        if ((self._downDataList)[index]).tag == "RandomProp" then
          return "equip.equiptiprandompropcell"
        else
          if ((self._downDataList)[index]).tag == "SuitInfo" then
            return "equip.equiptipssuitinfocell"
          else
            if ((self._downDataList)[index]).tag == "SuitSkill" then
              return "equip.equiptipssuitskillcell"
            else
              if ((self._downDataList)[index]).tag == "Describe" then
                return "equip.equiptipdescribecell"
              else
                if ((self._downDataList)[index]).tag == "Title1" then
                  return "equip.equippoptitlecell1"
                else
                  if ((self._downDataList)[index]).tag == "Title2" then
                    return "equip.equippoptitlecell2"
                  end
                end
              end
            end
          end
        end
      end
    else
      if frame == self._current_frame then
        if ((self._currentDownDataList)[index]).tag == "BaseProp" then
          return "equip.equipchangebasepropcell"
        else
          if ((self._currentDownDataList)[index]).tag == "RandomProp" then
            return "equip.equiptiprandompropcell"
          else
            if ((self._currentDownDataList)[index]).tag == "SuitInfo" then
              return "equip.equiptipssuitinfocell"
            else
              if ((self._currentDownDataList)[index]).tag == "SuitSkill" then
                return "equip.equiptipssuitskillcell"
              else
                if ((self._currentDownDataList)[index]).tag == "Describe" then
                  return "equip.equiptipdescribecell"
                else
                  if ((self._currentDownDataList)[index]).tag == "Title1" then
                    return "equip.equippoptitlecell1"
                  else
                    if ((self._currentDownDataList)[index]).tag == "Title2" then
                      return "equip.equippoptitlecell2"
                    end
                  end
                end
              end
            end
          end
        end
      else
        if frame == self._propContrastFrame then
          return "equip.equipchangenewpropcell"
        end
      end
    end
  end
end

EquipChangeNewDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_35
  if frame == self._frame then
    return (self._listByConditions)[index]
  else
    if frame == self._select_frame then
      return (self._downDataList)[index]
    else
      if frame == self._current_frame then
        return (self._currentDownDataList)[index]
      else
        if frame == self._propContrastFrame then
          return (self._propContrastData)[index]
        end
      end
    end
  end
end

EquipChangeNewDialog.ShouldLengthChange = function(self)
  -- function num : 0_36
  return true
end

EquipChangeNewDialog.GetRoleEquipSuitMapExceptCurrentType = function(self)
  -- function num : 0_37
  return self._roleEquipSuitMap
end

EquipChangeNewDialog.OnBackClick = function(self)
  -- function num : 0_38
  if self._selectEquipKey then
    self:SetSelectedEquip(nil)
  else
    self:Destroy()
  end
end

EquipChangeNewDialog.OnForgeBtnClick = function(self)
  -- function num : 0_39 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("equipforge.equipforgedialog")):Init(self._selectEquipKey)
end

EquipChangeNewDialog.OnBackBtnClicked = function(self)
  -- function num : 0_40
  self:Destroy()
end

return EquipChangeNewDialog

