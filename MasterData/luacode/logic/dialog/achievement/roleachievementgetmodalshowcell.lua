local CAchievementBagConfig = BeanManager.GetTableByName("mission.cachievebadgeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleAchievementGetModalShowCell = class("RoleAchievementGetModalShowCell", Dialog)
RoleAchievementGetModalShowCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementGetModalShowCell.AssetName = "AchievementAllMedalCell"

function RoleAchievementGetModalShowCell:Ctor(...)
  RoleAchievementGetModalShowCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function RoleAchievementGetModalShowCell:OnCreate()
  self._icon = self:GetChild("Medal")
  self._name = self:GetChild("Name")
  self._detail = self:GetChild("Condition")
  self._getState = self:GetChild("Txt")
  self._select = self:GetChild("Select")
  self._loading = self:GetChild("Loading")
  self._loading:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function RoleAchievementGetModalShowCell:OnDestroy()
end

function RoleAchievementGetModalShowCell:RefreshCell(data)
  self._id = data.id
  self._select:SetActive(false)
  if table.indexof(self._delegate._showList, data.id) then
    self._select:SetActive(true)
  end
  local record = CAchievementBagConfig:GetRecorder(data.id)
  local imageRecord = CImagePathTable:GetRecorder(record.imageID) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(record.nameTextID))
  self._detail:SetText(TextManager.GetText(record.descriptionTextID))
  self._getState:SetActive(false)
end

function RoleAchievementGetModalShowCell:OnCellClicked()
  self._delegate:OnCellClicked(self._id)
end

function RoleAchievementGetModalShowCell:OnEvent(eventName, arg)
  if eventName == "ChangeSelect" then
    self._select:SetActive(false)
    for k, v in pairs(arg) do
      if v == self._id then
        self._select:SetActive(true)
        break
      end
    end
  end
end

return RoleAchievementGetModalShowCell
