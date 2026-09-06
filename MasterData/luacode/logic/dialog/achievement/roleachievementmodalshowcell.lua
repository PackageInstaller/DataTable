local CAchievementBagConfig = BeanManager.GetTableByName("mission.cachievebadgeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleAchievementModalShowCell = class("RoleAchievementModalShowCell", Dialog)
RoleAchievementModalShowCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementModalShowCell.AssetName = "AchievementAllMedalCell"

function RoleAchievementModalShowCell:Ctor(...)
  RoleAchievementModalShowCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function RoleAchievementModalShowCell:OnCreate()
  self._icon = self:GetChild("Medal")
  self._grey = self:GetChild("MedalGrey")
  self._name = self:GetChild("Name")
  self._detail = self:GetChild("Condition")
  self._getState = self:GetChild("Txt")
  self._progress = self:GetChild("Loading/BackGround/Progress")
  self._progressNum = self:GetChild("Loading/Num")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnMouseClicked, self)
end

function RoleAchievementModalShowCell:OnDestroy()
end

function RoleAchievementModalShowCell:RefreshCell(data)
  local record
  local getLen = #data.getList
  if 0 < getLen then
    record = CAchievementBagConfig:GetRecorder(data.getList[getLen].id)
    self._icon:SetActive(true)
    self._grey:SetActive(false)
  else
    record = CAchievementBagConfig:GetRecorder(data.noGetList[1])
    self._icon:SetActive(false)
    self._grey:SetActive(true)
  end
  local imageRecord = CImagePathTable:GetRecorder(record.imageID) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._grey:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(data.recorder.nameTextID))
  local totalNum = #data.recorder.badgeIDList
  self._progress:SetFillAmount(getLen / totalNum)
  self._progressNum:SetText(getLen .. "/" .. totalNum)
  self._getState:SetActive(getLen == 0)
end

function RoleAchievementModalShowCell:OnMouseClicked()
  DialogManager.CreateSingletonDialog("achievement.medaltipsdialog"):SetData(self._cellData)
end

return RoleAchievementModalShowCell
