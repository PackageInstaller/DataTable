-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/roleachievementgetmodalshowcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAchievementBagConfig = (BeanManager.GetTableByName)("mission.cachievebadgeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RoleAchievementGetModalShowCell = class("RoleAchievementGetModalShowCell", Dialog)
RoleAchievementGetModalShowCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementGetModalShowCell.AssetName = "AchievementAllMedalCell"
RoleAchievementGetModalShowCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAchievementGetModalShowCell
  ((RoleAchievementGetModalShowCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

RoleAchievementGetModalShowCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Medal")
  self._name = self:GetChild("Name")
  self._detail = self:GetChild("Condition")
  self._getState = self:GetChild("Txt")
  self._select = self:GetChild("Select")
  self._loading = self:GetChild("Loading")
  ;
  (self._loading):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

RoleAchievementGetModalShowCell.OnDestroy = function(self)
  -- function num : 0_2
end

RoleAchievementGetModalShowCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CAchievementBagConfig, CImagePathTable
  self._id = data.id
  ;
  (self._select):SetActive(false)
  if (table.indexof)((self._delegate)._showList, data.id) then
    (self._select):SetActive(true)
  end
  local record = CAchievementBagConfig:GetRecorder(data.id)
  if not CImagePathTable:GetRecorder(record.imageID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(record.nameTextID))
  ;
  (self._detail):SetText((TextManager.GetText)(record.descriptionTextID))
  ;
  (self._getState):SetActive(false)
end

RoleAchievementGetModalShowCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):OnCellClicked(self._id)
end

RoleAchievementGetModalShowCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : _ENV
  if eventName == "ChangeSelect" then
    (self._select):SetActive(false)
    for k,v in pairs(arg) do
      if v == self._id then
        (self._select):SetActive(true)
        break
      end
    end
  end
end

return RoleAchievementGetModalShowCell

