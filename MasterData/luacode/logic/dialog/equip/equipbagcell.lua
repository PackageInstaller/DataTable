local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local EquipBagCell = class("EquipBagCell", Dialog)
EquipBagCell.AssetBundleName = "ui/layouts.equip"
EquipBagCell.AssetName = "EquipListCell"

function EquipBagCell:Ctor(...)
  EquipBagCell.super.Ctor(self, ...)
end

function EquipBagCell:OnCreate()
  self._panel = self:GetChild("Frame/Panel")
  self._frame = self:GetChild("Frame/Panel/Frame")
  self._icon = self:GetChild("Frame/Panel/Icon")
  self._strengthenLv = self:GetChild("Frame/Panel/Level")
  self._strengthenLvNum = self:GetChild("Frame/Panel/Level/Num")
  self._strengthenLvMax = self:GetChild("Frame/Panel/Level/NumMax")
  self._strengthenLvMax:SetActive(false)
  self._levelTxt = self:GetChild("Frame/Panel/Level/Txt")
  self._levelTxt:SetActive(false)
  self._select = self:GetChild("Frame/Panel/Select")
  self._new = self:GetChild("Frame/Panel/New")
  self._lock = self:GetChild("Frame/Panel/LockBtn")
  self._charBack = self:GetChild("Frame/Panel/CharBack")
  self._charPhoto = self:GetChild("Frame/Panel/CharPhoto")
  self._specialFMImage = self:GetChild("Frame/Panel/FuMo")
  self._pinjiStar = self:GetChild("Frame/Panel/BreakPoint")
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function EquipBagCell:OnDestroy()
end

function EquipBagCell:RefreshCell(data)
  if not data then
    self._panel:SetActive(false)
  else
    if self._delegate.GetSelectEquipKey and data:GetKey() == self._delegate:GetSelectEquipKey() then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
    self._panel:SetActive(true)
    local record
    self._frame:SetActive(true)
    self._strengthenLv:SetActive(true)
    record = data:GetPinJiImage()
    self._frame:SetSprite(record.assetBundle, record.assetName)
    self._strengthenLvNum:SetText(data:GetStrengthenLevel())
    record = data:GetIcon()
    self._icon:SetSprite(record.assetBundle, record.assetName)
    if data:IsChecked() then
      self._new:SetActive(false)
    else
      self._new:SetActive(true)
    end
    if data:IsLocked() then
      self._lock:SetActive(true)
      self._lock:SetSelected(true)
    else
      self._lock:SetActive(false)
    end
    local roleKey = data:GetRoleKey()
    if roleKey ~= 0 then
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
      self._charPhoto:SetActive(true)
      self._charBack:SetActive(true)
      local imageRecord = role:GetSkillHeadImageRecord()
      self._charPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      self._charPhoto:SetActive(false)
      self._charBack:SetActive(false)
    end
    if data:GetFinalRandomEntry() then
      self._specialFMImage:SetActive(true)
      AnimationHelper.SetAnimatorInteger2(self._rootWindow:GetUIObject(), "par", 1)
    else
      self._specialFMImage:SetActive(false)
      AnimationHelper.SetAnimatorInteger2(self._rootWindow:GetUIObject(), "par", 0)
    end
    self._pinjiStar:SetText(data:GetEquipStarStr())
  end
end

function EquipBagCell:OnCellClicked()
  if self._cellData then
    self._select:SetActive(true)
    if self._delegate._inResolvePanel then
      if not self._grey:IsActive() then
        self._delegate:ChooseResolveEquips(self._cellData)
      end
    else
      self._delegate:OnCellClicked(self._cellData)
    end
  end
end

function EquipBagCell:OnEvent(eventName, arg)
  if self._cellData then
    if eventName == "OpenEquipResolve" then
      if self._cellData:GetRoleKey() ~= 0 or not self._cellData:CanResolve() then
        self._grey:SetActive(true)
      elseif self._cellData:IsLocked() then
        self._grey:SetActive(true)
      else
        self._grey:SetActive(false)
      end
    elseif eventName == "CloseEquipResolve" then
      self._grey:SetActive(false)
      self._select:SetActive(false)
    elseif eventName == "ChooseResolveEquip" then
      if #self._delegate._resolveEquips >= self._delegate._resolveMaxNum and not self._delegate:IsInResolveEquips(self._cellData) then
        self._grey:SetActive(true)
      elseif self._cellData:GetRoleKey() == 0 and self._cellData:CanResolve() and not self._cellData:IsLocked() then
        self._grey:SetActive(false)
      end
      if self._delegate:IsInResolveEquips(self._cellData) then
        self._select:SetActive(true)
      else
        self._select:SetActive(false)
      end
    elseif eventName == "EquipLockStateChanged" then
      if arg.key == self._cellData:GetKey() then
        self._cellData = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(arg.key)
        self:RefreshCell(self._cellData)
      end
    elseif eventName == "EquipIdentifySuccess" then
      if arg.equipKey == self._cellData:GetKey() then
        self._delegate:RefreshTabCell()
      end
    elseif eventName == "EquipChecked" then
      if arg.key == self._cellData:GetKey() then
        self._cellData = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(arg.key)
        self:RefreshCell(self._cellData)
      end
    elseif eventName == "SetSelectedEquip" then
      if arg == self._cellData:GetKey() then
        self._select:SetActive(true)
      else
        self._select:SetActive(false)
      end
    end
  end
end

return EquipBagCell
