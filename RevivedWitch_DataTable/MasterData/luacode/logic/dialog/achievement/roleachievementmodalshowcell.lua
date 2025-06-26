-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/roleachievementmodalshowcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAchievementBagConfig = (BeanManager.GetTableByName)("mission.cachievebadgeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RoleAchievementModalShowCell = class("RoleAchievementModalShowCell", Dialog)
RoleAchievementModalShowCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementModalShowCell.AssetName = "AchievementAllMedalCell"
RoleAchievementModalShowCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAchievementModalShowCell
  ((RoleAchievementModalShowCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

RoleAchievementModalShowCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Medal")
  self._grey = self:GetChild("MedalGrey")
  self._name = self:GetChild("Name")
  self._detail = self:GetChild("Condition")
  self._getState = self:GetChild("Txt")
  self._progress = self:GetChild("Loading/BackGround/Progress")
  self._progressNum = self:GetChild("Loading/Num")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMouseClicked, self)
end

RoleAchievementModalShowCell.OnDestroy = function(self)
  -- function num : 0_2
end

RoleAchievementModalShowCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAchievementBagConfig, CImagePathTable, _ENV
  local record = nil
  local getLen = #data.getList
  if getLen > 0 then
    record = CAchievementBagConfig:GetRecorder(((data.getList)[getLen]).id)
    ;
    (self._icon):SetActive(true)
    ;
    (self._grey):SetActive(false)
  else
    record = CAchievementBagConfig:GetRecorder((data.noGetList)[1])
    ;
    (self._icon):SetActive(false)
    ;
    (self._grey):SetActive(true)
  end
  if not CImagePathTable:GetRecorder(record.imageID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._grey):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)((data.recorder).nameTextID))
  local totalNum = #(data.recorder).badgeIDList
  ;
  (self._progress):SetFillAmount(getLen / totalNum)
  ;
  (self._progressNum):SetText(getLen .. "/" .. totalNum)
  ;
  (self._getState):SetActive(getLen == 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

RoleAchievementModalShowCell.OnMouseClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("achievement.medaltipsdialog")):SetData(self._cellData)
end

return RoleAchievementModalShowCell

