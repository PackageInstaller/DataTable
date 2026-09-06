local MainLineFloorEquipCell = class("MainLineFloorEquipCell", Dialog)
MainLineFloorEquipCell.AssetBundleName = "ui/layouts.basecharacterinfo"
MainLineFloorEquipCell.AssetName = "BaseCharacterInfoEquipCell"

function MainLineFloorEquipCell:Ctor(...)
  MainLineFloorEquipCell.super.Ctor(self, ...)
end

function MainLineFloorEquipCell:OnCreate()
  self._frame = self:GetChild("BackGround/Frame")
  self._icon = self:GetChild("BackGround/Icon")
  self._select = self:GetChild("BackGround/Select")
  self._back = self:GetChild("EquipBack")
  self._check = self:GetChild("Check")
  self._check:SetActive(false)
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function MainLineFloorEquipCell:OnDestroy()
end

function MainLineFloorEquipCell:RefreshCell(equip)
  if equip.get then
    self._check:SetActive(true)
  else
    self._check:SetActive(false)
  end
  if equip.item then
    self._equip = equip.item
  else
    self._equip = equip
  end
  local record
  record = self._equip:GetPinJiImage()
  self._frame:SetSprite(record.assetBundle, record.assetName)
  record = self._equip:GetIcon()
  self._icon:SetSprite(record.assetBundle, record.assetName)
end

function MainLineFloorEquipCell:OnCellClicked()
  self._select:SetActive(true)
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
  if self._equip:IsGained() then
    tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
    if tipsDialog then
      tipsDialog:Init(self._equip:GetKey())
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
  else
    tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
    if tipsDialog then
      tipsDialog:Init(self._equip:GetID())
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

function MainLineFloorEquipCell:SetSelect(flag)
  self._select:SetActive(flag)
end

return MainLineFloorEquipCell
