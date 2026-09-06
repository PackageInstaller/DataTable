local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CTowerDungeonType = BeanManager.GetTableByName("dungeonselect.ctowerdungeontype")
local TowerMainCell = class("TowerMainCell", Dialog)
TowerMainCell.AssetBundleName = "ui/layouts.mainline"
TowerMainCell.AssetName = "towermaincell"

function TowerMainCell:Ctor(...)
  TowerMainCell.super.Ctor(self, ...)
end

function TowerMainCell:OnCreate()
  self._normalBoard = self:GetChild("Normal")
  self._img = self:GetChild("Normal/Img")
  self._name = self:GetChild("Normal/Title")
  self._battlePower = self:GetChild("Normal/Txt2")
  self._star = self:GetChild("Normal/Star")
  self._blackBoard = self:GetChild("Normal/Black")
  self._lockBoard = self:GetChild("Lock")
  self._lockTxt = self:GetChild("Lock/Txt")
  self._lockImage = self:GetChild("Lock/ImgGrey")
  self._changeBoard = self:GetChild("Challenge")
  self._changeTxt = self:GetChild("Challenge/Txt")
  self._click = self:GetChild("Click")
  self._click:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function TowerMainCell:OnDestroy()
end

function TowerMainCell:RefreshCell(data)
  self._data = data
  local record = CTowerDungeonType:GetRecorder(data.id)
  if record then
    self._battlePower:SetText(record.recommendStrength)
    self._name:SetText(TextManager.GetText(record.nameTextID))
    self._changeBoard:SetActive(data.islock ~= 0 and data.ischallenging)
    if data.islock == 0 then
      self._normalBoard:SetActive(false)
    else
      self._normalBoard:SetActive(true)
      if self._delegate._challengingID == 0 then
        self._blackBoard:SetActive(false)
      else
        self._blackBoard:SetActive(not data.ischallenging)
      end
    end
    local imageRecord = CImagePathTable:GetRecorder(record.image) or DataCommon.DefaultImageAsset
    self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._lockImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._blackBoard:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._lockBoard:SetActive(data.islock == 0)
    self._star:SetText(record.star)
    self._lockTxt:SetText(TextManager.GetText(record.unlockdescribeTextID))
  end
end

function TowerMainCell:OnCellClicked()
  if self._data.islock == 0 then
    return
  end
  if self._delegate._challengingID ~= 0 and not self._data.ischallenging then
    return
  end
  if self._data.ischallenging then
    DialogManager.CreateSingletonDialog("tower.towerchallengingdetailtips"):SetData(self._data.id)
  else
    DialogManager.CreateSingletonDialog("tower.towerchallengedetailtips"):SetData(self._data.id)
  end
end

return TowerMainCell
