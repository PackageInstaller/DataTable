-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equipchangenewcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local EquipChangeNewCell = class("EquipChangeNewCell", Dialog)
EquipChangeNewCell.AssetBundleName = "ui/layouts.equip"
EquipChangeNewCell.AssetName = "EquipPopCell"
EquipChangeNewCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipChangeNewCell
  ((EquipChangeNewCell.super).Ctor)(self, ...)
  self._guideEffectHandler = nil
end

EquipChangeNewCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("Frame/Panel/Frame")
  self._icon = self:GetChild("Frame/Panel/Icon")
  self._strengthenLv = self:GetChild("Frame/Panel/Level")
  self._strengthenLvNum = self:GetChild("Frame/Panel/Level/Num")
  self._strengthenLvNumMax = self:GetChild("Frame/Panel/Level/NumMax")
  self._lvTxt = self:GetChild("Frame/Panel/Level/Txt")
  self._select = self:GetChild("Frame/Panel/Select")
  self._new = self:GetChild("Frame/Panel/New")
  self._lock = self:GetChild("Frame/Panel/Lock")
  self._guideEffect = self:GetChild("Effect")
  self._charBack = self:GetChild("Frame/Panel/CharBack")
  self._charPhoto = self:GetChild("Frame/Panel/CharPhoto")
  self._same = self:GetChild("Frame/Panel/Same")
  self._currentPresetEquipTag = self:GetChild("Frame/Panel/Preset")
  ;
  (self._charPhoto):SetActive(false)
  self._currentEquipTag = self:GetChild("Frame/Panel/Equip")
  self._specialFMImage = self:GetChild("Frame/Panel/FuMo")
  self._animator = ((self._rootWindow):GetUIObject()):GetComponent("Animator")
  self._pinJiStar = self:GetChild("Frame/Panel/BreakPoint")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnCellLongPress, self)
  ;
  (self._currentEquipTag):SetActive(false)
  ;
  (self._currentPresetEquipTag):SetActive(false)
  ;
  (self._strengthenLvNumMax):SetActive(false)
  ;
  (self._lvTxt):SetActive(false)
end

EquipChangeNewCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

EquipChangeNewCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, AnimationHelper
  local score = data:GetScore()
  local record = data:GetIcon()
  ;
  (self._icon):SetSprite(record.assetBundle, record.assetName)
  record = data:GetPinJiImage()
  ;
  (self._frame):SetSprite(record.assetBundle, record.assetName)
  ;
  (self._strengthenLvNum):SetText(data:GetStrengthenLevel())
  if data:GetKey() == (self._delegate)._currentEquipKey then
    if (self._delegate)._isPreset then
      (self._currentPresetEquipTag):SetActive(true)
    else
      ;
      (self._currentEquipTag):SetActive(true)
    end
    local roleKey = data:GetRoleKey()
    if roleKey == 0 then
      (self._charPhoto):SetActive(false)
      ;
      (self._charBack):SetActive(false)
    else
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
      ;
      (self._charPhoto):SetActive(true)
      ;
      (self._charBack):SetActive(true)
      local imageRecord = role:GetSkillHeadImageRecord()
      ;
      (self._charPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  else
    do
      ;
      (self._currentPresetEquipTag):SetActive(false)
      ;
      (self._currentEquipTag):SetActive(false)
      local roleKey = data:GetRoleKey()
      if roleKey == 0 then
        (self._charPhoto):SetActive(false)
        ;
        (self._charBack):SetActive(false)
      else
        local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
        ;
        (self._charPhoto):SetActive(true)
        ;
        (self._charBack):SetActive(true)
        local imageRecord = role:GetSkillHeadImageRecord()
        ;
        (self._charPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      do
        if data:GetKey() == (self._delegate)._selectEquipKey then
          (self._select):SetActive(true)
        else
          ;
          (self._select):SetActive(false)
        end
        if data:IsChecked() then
          (self._new):SetActive(false)
        else
          ;
          (self._new):SetActive(true)
        end
        if data:IsLocked() then
          (self._lock):SetActive(true)
        else
          ;
          (self._lock):SetActive(false)
        end
        if data:GetFinalRandomEntry() then
          (self._specialFMImage):SetActive(true)
          ;
          (AnimationHelper.SetAnimatorInteger2)((self._rootWindow):GetUIObject(), "par", 1)
        else
          ;
          (self._specialFMImage):SetActive(false)
          ;
          (AnimationHelper.SetAnimatorInteger2)((self._rootWindow):GetUIObject(), "par", 0)
        end
        ;
        (self._pinJiStar):SetText(data:GetEquipStarStr())
        ;
        (self._same):SetActive(false)
        local suitmap = (self._delegate):GetRoleEquipSuitMapExceptCurrentType()
        for k,v in pairs(suitmap) do
          if v and v > 0 and v == data:GetEquipSuitId() then
            (self._same):SetActive(true)
            return 
          end
        end
      end
    end
  end
end

EquipChangeNewCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._cellData):GetKey() ~= (self._delegate)._selectEquipKey then
    do
      if not (self._cellData):IsChecked() then
        local cviewequip = (LuaNetManager.CreateProtocol)("protocol.item.cviewequip")
        if cviewequip then
          cviewequip.key = (self._cellData):GetKey()
          cviewequip:Send()
        end
      end
      ;
      (self._delegate):SetSelectedEquip((self._cellData):GetKey())
      ;
      (self._delegate):SetSelectedEquip((self._cellData):GetKey())
    end
  end
end

EquipChangeNewCell.OnCellLongPress = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not self._guideTag then
    local width, height = (self:GetRootWindow()):GetRectSize()
    if not (DialogManager.GetDialog)("equip.equiptipsdialog") then
      local tipsDialog = (DialogManager.GetDialog)("equip.equiptipspreviewdialog")
    end
    if not tipsDialog then
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init((self._cellData):GetKey())
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_5_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
      end
    end
  end
end

EquipChangeNewCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_6 , upvalues : _ENV
  if eventName == "SetEquipSelected" then
    if arg == (self._cellData):GetKey() then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
  else
    -- DECOMPILER ERROR at PC31: Unhandled construct in 'MakeBoolean' P1

    if eventName == "EquipChecked" and arg.key == (self._cellData):GetKey() then
      self._cellData = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(arg.key)
      self:RefreshCell(self._cellData)
    end
  end
  -- DECOMPILER ERROR at PC46: Unhandled construct in 'MakeBoolean' P1

  if eventName == "EquipIdentifySuccess" and arg.equipKey == (self._cellData):GetKey() then
    (self._delegate):OnRefresh()
  end
  -- DECOMPILER ERROR at PC62: Unhandled construct in 'MakeBoolean' P1

  if eventName == "EquipLockStateChanged" and arg.key == (self._cellData):GetKey() then
    self._cellData = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(arg.key)
    self:RefreshCell(self._cellData)
  end
  if eventName == "EquipInfoChange" and arg.equipKey == (self._cellData):GetKey() then
    self._cellData = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(arg.equipKey)
    self:RefreshCell(self._cellData)
  end
end

return EquipChangeNewCell

