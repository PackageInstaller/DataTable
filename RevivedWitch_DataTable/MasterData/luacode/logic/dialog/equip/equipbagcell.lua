-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equipbagcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local EquipBagCell = class("EquipBagCell", Dialog)
EquipBagCell.AssetBundleName = "ui/layouts.equip"
EquipBagCell.AssetName = "EquipListCell"
EquipBagCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBagCell
  ((EquipBagCell.super).Ctor)(self, ...)
end

EquipBagCell.OnCreate = function(self)
  -- function num : 0_1
  self._panel = self:GetChild("Frame/Panel")
  self._frame = self:GetChild("Frame/Panel/Frame")
  self._icon = self:GetChild("Frame/Panel/Icon")
  self._strengthenLv = self:GetChild("Frame/Panel/Level")
  self._strengthenLvNum = self:GetChild("Frame/Panel/Level/Num")
  self._strengthenLvMax = self:GetChild("Frame/Panel/Level/NumMax")
  ;
  (self._strengthenLvMax):SetActive(false)
  self._levelTxt = self:GetChild("Frame/Panel/Level/Txt")
  ;
  (self._levelTxt):SetActive(false)
  self._select = self:GetChild("Frame/Panel/Select")
  self._new = self:GetChild("Frame/Panel/New")
  self._lock = self:GetChild("Frame/Panel/LockBtn")
  self._charBack = self:GetChild("Frame/Panel/CharBack")
  self._charPhoto = self:GetChild("Frame/Panel/CharPhoto")
  self._specialFMImage = self:GetChild("Frame/Panel/FuMo")
  self._pinjiStar = self:GetChild("Frame/Panel/BreakPoint")
  self._animator = ((self._rootWindow):GetUIObject()):GetComponent("Animator")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

EquipBagCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipBagCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, AnimationHelper
  if not data then
    (self._panel):SetActive(false)
  else
    if (self._delegate).GetSelectEquipKey and data:GetKey() == (self._delegate):GetSelectEquipKey() then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
    ;
    (self._panel):SetActive(true)
    local record = nil
    ;
    (self._frame):SetActive(true)
    ;
    (self._strengthenLv):SetActive(true)
    record = data:GetPinJiImage()
    ;
    (self._frame):SetSprite(record.assetBundle, record.assetName)
    ;
    (self._strengthenLvNum):SetText(data:GetStrengthenLevel())
    record = data:GetIcon()
    ;
    (self._icon):SetSprite(record.assetBundle, record.assetName)
    if data:IsChecked() then
      (self._new):SetActive(false)
    else
      ;
      (self._new):SetActive(true)
    end
    if data:IsLocked() then
      (self._lock):SetActive(true)
      ;
      (self._lock):SetSelected(true)
    else
      ;
      (self._lock):SetActive(false)
    end
    local roleKey = data:GetRoleKey()
    if roleKey ~= 0 then
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
      ;
      (self._charPhoto):SetActive(true)
      ;
      (self._charBack):SetActive(true)
      local imageRecord = role:GetSkillHeadImageRecord()
      ;
      (self._charPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      do
        ;
        (self._charPhoto):SetActive(false)
        ;
        (self._charBack):SetActive(false)
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
        (self._pinjiStar):SetText(data:GetEquipStarStr())
      end
    end
  end
end

EquipBagCell.OnCellClicked = function(self)
  -- function num : 0_4
  if self._cellData then
    (self._select):SetActive(true)
    if (self._delegate)._inResolvePanel and not (self._grey):IsActive() then
      (self._delegate):ChooseResolveEquips(self._cellData)
    end
  end
  ;
  (self._delegate):OnCellClicked(self._cellData)
end

EquipBagCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : _ENV
  if self._cellData then
    if eventName == "OpenEquipResolve" then
      if (self._cellData):GetRoleKey() ~= 0 or not (self._cellData):CanResolve() then
        (self._grey):SetActive(true)
      else
        if (self._cellData):IsLocked() then
          (self._grey):SetActive(true)
        else
          ;
          (self._grey):SetActive(false)
        end
      end
    else
      if eventName == "CloseEquipResolve" then
        (self._grey):SetActive(false)
        ;
        (self._select):SetActive(false)
      else
        if eventName == "ChooseResolveEquip" then
          if (self._delegate)._resolveMaxNum <= #(self._delegate)._resolveEquips and not (self._delegate):IsInResolveEquips(self._cellData) then
            (self._grey):SetActive(true)
          else
            if (self._cellData):GetRoleKey() == 0 and (self._cellData):CanResolve() and not (self._cellData):IsLocked() then
              (self._grey):SetActive(false)
            end
          end
          if (self._delegate):IsInResolveEquips(self._cellData) then
            (self._select):SetActive(true)
          else
            ;
            (self._select):SetActive(false)
          end
        else
          -- DECOMPILER ERROR at PC115: Unhandled construct in 'MakeBoolean' P1

          if eventName == "EquipLockStateChanged" and arg.key == (self._cellData):GetKey() then
            self._cellData = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(arg.key)
            self:RefreshCell(self._cellData)
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC130: Unhandled construct in 'MakeBoolean' P1

  if eventName == "EquipIdentifySuccess" and arg.equipKey == (self._cellData):GetKey() then
    (self._delegate):RefreshTabCell()
  end
  -- DECOMPILER ERROR at PC146: Unhandled construct in 'MakeBoolean' P1

  if eventName == "EquipChecked" and arg.key == (self._cellData):GetKey() then
    self._cellData = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(arg.key)
    self:RefreshCell(self._cellData)
  end
  if eventName == "SetSelectedEquip" then
    if arg == (self._cellData):GetKey() then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
  end
end

return EquipBagCell

