local SetBorderCell = class("SetBorderCell", Dialog)
local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CMonsterBookCfg = BeanManager.GetTableByName("handbook.cmonster_handbook")
local CGuildBossInfo = BeanManager.GetTableByName("guild.cguildchallengebossinfo")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
SetBorderCell.AssetBundleName = "ui/layouts.friends"
SetBorderCell.AssetName = "FriendsFrameSettingCell"
local TableFrame = require("framework.ui.frame.table.tableframe")
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")

function SetBorderCell:Ctor(...)
  SetBorderCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function SetBorderCell:OnCreate()
  self._img = self:GetChild("FramePic")
  self._current = self:GetChild("Current")
  self._current:SetActive(false)
  self._name = self:GetChild("Text")
  self._name:SetText("")
  self._select = self:GetChild("Select")
  self._select:SetActive(false)
  self._lockImage = self:GetChild("Lock")
  self._lockImage:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function SetBorderCell:OnDestroy()
end

function SetBorderCell:RefreshCell()
  self._name:SetText(TextManager.GetText(self._cellData.record.nameTextID))
  local imageRecord = CImagePathTable:GetRecorder(self._cellData.record.photoid)
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if self._delegate._curSelectBorderId == self._cellData.record.id then
    self._select:SetActive(true)
  else
    self._select:SetActive(false)
  end
  if self._cellData.isCurrent == 1 then
    self._current:SetActive(true)
  else
    self._current:SetActive(false)
  end
  if self._cellData.isOwned == 1 then
    self._lockImage:SetActive(false)
  else
    self._lockImage:SetActive(true)
  end
end

function SetBorderCell:OnCellClicked()
  if not self._cellData then
    return
  end
  self._delegate:OnSelectBorderCell(self._cellData.record.id)
end

function SetBorderCell:OnEvent(eventName, arg)
  if self._cellData and eventName == "ChooseBorder" then
    if self._cellData.record.id == arg then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  end
end

return SetBorderCell
