local CStringRes = BeanManager.GetTableByName("message.cstringres")
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local EquipChangeNewCell = class("EquipChangeNewCell", Dialog)
EquipChangeNewCell.AssetBundleName = "ui/layouts.equip"
EquipChangeNewCell.AssetName = "EquipPopCell"

function EquipChangeNewCell:Ctor(...)
  EquipChangeNewCell.super.Ctor(self, ...)
  self._guideEffectHandler = nil
end

function EquipChangeNewCell:OnCreate()
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
  self._charPhoto:SetActive(false)
  self._currentEquipTag = self:GetChild("Frame/Panel/Equip")
  self._specialFMImage = self:GetChild("Frame/Panel/FuMo")
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
  self._pinJiStar = self:GetChild("Frame/Panel/BreakPoint")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():Subscribe_LongPressEvent(self.OnCellLongPress, self)
  self._currentEquipTag:SetActive(false)
  self._currentPresetEquipTag:SetActive(false)
  self._strengthenLvNumMax:SetActive(false)
  self._lvTxt:SetActive(false)
end

function EquipChangeNewCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function EquipChangeNewCell:RefreshCell(data)
  local score = data:GetScore()
  local record = data:GetIcon()
  self._icon:SetSprite(record.assetBundle, record.assetName)
  record = data:GetPinJiImage()
  self._frame:SetSprite(record.assetBundle, record.assetName)
  self._strengthenLvNum:SetText(data:GetStrengthenLevel())
  if data:GetKey() == self._delegate._currentEquipKey then
    if self._delegate._isPreset then
      self._currentPresetEquipTag:SetActive(true)
    else
      self._currentEquipTag:SetActive(true)
    end
    local roleKey = data:GetRoleKey()
    if roleKey == 0 then
      self._charPhoto:SetActive(false)
      self._charBack:SetActive(false)
    else
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
      self._charPhoto:SetActive(true)
      self._charBack:SetActive(true)
      local imageRecord = role:GetSkillHeadImageRecord()
      self._charPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  else
    self._currentPresetEquipTag:SetActive(false)
    self._currentEquipTag:SetActive(false)
    local roleKey = data:GetRoleKey()
    if roleKey == 0 then
      self._charPhoto:SetActive(false)
      self._charBack:SetActive(false)
    else
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
      self._charPhoto:SetActive(true)
      self._charBack:SetActive(true)
      local imageRecord = role:GetSkillHeadImageRecord()
      self._charPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
  if data:GetKey() == self._delegate._selectEquipKey then
    self._select:SetActive(true)
  else
    self._select:SetActive(false)
  end
  if data:IsChecked() then
    self._new:SetActive(false)
  else
    self._new:SetActive(true)
  end
  if data:IsLocked() then
    self._lock:SetActive(true)
  else
    self._lock:SetActive(false)
  end
  if data:GetFinalRandomEntry() then
    self._specialFMImage:SetActive(true)
    AnimationHelper.SetAnimatorInteger2(self._rootWindow:GetUIObject(), "par", 1)
  else
    self._specialFMImage:SetActive(false)
    AnimationHelper.SetAnimatorInteger2(self._rootWindow:GetUIObject(), "par", 0)
  end
  self._pinJiStar:SetText(data:GetEquipStarStr())
  self._same:SetActive(false)
  local suitmap = self._delegate:GetRoleEquipSuitMapExceptCurrentType()
  for k, v in pairs(suitmap) do
    if v and 0 < v and v == data:GetEquipSuitId() then
      self._same:SetActive(true)
      return
    end
  end
end

function EquipChangeNewCell:OnCellClicked()
  if self._cellData:GetKey() ~= self._delegate._selectEquipKey then
    if not self._cellData:IsChecked() then
      local cviewequip = LuaNetManager.CreateProtocol("protocol.item.cviewequip")
      if cviewequip then
        cviewequip.key = self._cellData:GetKey()
        cviewequip:Send()
      end
    end
    self._delegate:SetSelectedEquip(self._cellData:GetKey())
  else
    self._delegate:SetSelectedEquip(self._cellData:GetKey())
  end
end

function EquipChangeNewCell:OnCellLongPress()
  if not self._guideTag then
    local width, height = self:GetRootWindow():GetRectSize()
    local tipsDialog = DialogManager.GetDialog("equip.equiptipsdialog") or DialogManager.GetDialog("equip.equiptipspreviewdialog")
    if not tipsDialog then
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init(self._cellData:GetKey())
        tipsDialog:SetTipsParmFunc(function()
          local width, height = self:GetRootWindow():GetRectSize()
          local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
          return {
            width = width,
            height = height,
            posX = pos.x,
            posY = pos.y
          }
        end)
      end
    end
  end
end

function EquipChangeNewCell:OnEvent(eventName, arg)
  if eventName == "SetEquipSelected" then
    if arg == self._cellData:GetKey() then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  elseif eventName == "EquipChecked" then
    if arg.key == self._cellData:GetKey() then
      self._cellData = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(arg.key)
      self:RefreshCell(self._cellData)
    end
  elseif eventName == "EquipIdentifySuccess" then
    if arg.equipKey == self._cellData:GetKey() then
      self._delegate:OnRefresh()
    end
  elseif eventName == "EquipLockStateChanged" then
    if arg.key == self._cellData:GetKey() then
      self._cellData = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(arg.key)
      self:RefreshCell(self._cellData)
    end
  elseif eventName == "EquipInfoChange" and arg.equipKey == self._cellData:GetKey() then
    self._cellData = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(arg.equipKey)
    self:RefreshCell(self._cellData)
  end
end

return EquipChangeNewCell
