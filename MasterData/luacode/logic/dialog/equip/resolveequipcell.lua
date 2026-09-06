local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ResolveEquipCell = class("ResolveEquipCell", Dialog)
ResolveEquipCell.AssetBundleName = "ui/layouts.equip"
ResolveEquipCell.AssetName = "EquipResolveCell"

function ResolveEquipCell:Ctor(...)
  ResolveEquipCell.super.Ctor(self, ...)
end

function ResolveEquipCell:OnCreate()
  self._frame = self:GetChild("Panel/Frame")
  self._icon = self:GetChild("Panel/Icon")
  self._strengthenLv = self:GetChild("Panel/Level/Num")
  self._select = self:GetChild("Panel/Select")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():Subscribe_LongPressEvent(self.OnCellLongPress, self)
end

function ResolveEquipCell:OnDestroy()
end

function ResolveEquipCell:RefreshCell(data)
  if not data then
    self:GetChild("Panel/Level"):SetActive(false)
    local imageRecord = CImagePathTable:GetRecorder(10374)
    self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = DataCommon.NullImageAsset
    self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self:SetSelectState(false)
    return
  end
  self:GetChild("Panel/Level"):SetActive(true)
  local record = data:GetPinJiImage()
  self._frame:SetSprite(record.assetBundle, record.assetName)
  record = data:GetIcon()
  self._icon:SetSprite(record.assetBundle, record.assetName)
  local strengthenLv = data:GetStrengthenLevel()
  if strengthenLv == 0 then
    self._strengthenLv:SetActive(false)
  else
    self._strengthenLv:SetActive(true)
    self._strengthenLv:SetText(tostring(strengthenLv))
  end
  if self._delegate:IsInResolveEquips(data) then
    self:SetSelectState(true)
  else
    self:SetSelectState(false)
  end
end

function ResolveEquipCell:SetSelectState(bSelect)
  self._bSelectState = bSelect
  self._select:SetActive(bSelect)
end

function ResolveEquipCell:OnCellClicked()
  if not self._cellData then
    return
  end
  self:SetSelectState(not self._bSelectState)
  self._delegate:OnSelectEquipsChange(self._cellData, self._bSelectState)
end

function ResolveEquipCell:OnCellLongPress()
  if not self._cellData then
    return
  end
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
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

function ResolveEquipCell:OnEvent(eventName, arg)
  if self._cellData and eventName == "ChooseResolveEquip" then
    if self._delegate:IsInResolveEquips(self._cellData) then
      self:SetSelectState(true)
    else
      self:SetSelectState(false)
    end
  end
end

return ResolveEquipCell
