local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkin = BeanManager.GetTableByName("role.cskin")
local XiGuaRankPlayerCell = class("XiGuaRankPlayerCell", Dialog)
XiGuaRankPlayerCell.AssetBundleName = "ui/layouts.activitysummer"
XiGuaRankPlayerCell.AssetName = "ActivitySummerXiGuaRankCell"

function XiGuaRankPlayerCell:Ctor(...)
  XiGuaRankPlayerCell.super.Ctor(self, ...)
end

function XiGuaRankPlayerCell:OnCreate()
  self._back = {
    [1] = self:GetChild("Back1"),
    [2] = self:GetChild("Back2"),
    [3] = self:GetChild("Back3")
  }
  self._backNormal = self:GetChild("Back")
  self._backPlayer = self:GetChild("BackPlayer")
  self._rank = {
    [1] = self:GetChild("Panel/Rank1"),
    [2] = self:GetChild("Panel/Rank2"),
    [3] = self:GetChild("Panel/Rank3")
  }
  self._rankNormal = self:GetChild("Panel/Rank")
  self._photo = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
  self._role = {
    [1] = self:GetChild("Panel/CharBack3/Char"),
    [2] = self:GetChild("Panel/CharBack2/Char"),
    [3] = self:GetChild("Panel/CharBack1/Char")
  }
  self._maxDamageNum = self:GetChild("Panel/Num")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function XiGuaRankPlayerCell:OnDestroy()
end

function XiGuaRankPlayerCell:RefreshCell(data)
  self._index = data.index
  self._data = data.data
  local personRank = self._data.rank
  local personUserData = self._data.baseUserData
  local personBossData = self._data.watermelonPanelData
  for i = 1, 3 do
    self._back[i]:SetActive(i == personRank)
    self._rank[i]:SetActive(i == personRank)
  end
  if 3 < personRank then
    self._rankNormal:SetActive(true)
    self._rankNormal:SetText(personRank)
    if personUserData.userId == NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid then
      self._backPlayer:SetActive(true)
      self._backNormal:SetActive(false)
    else
      self._backPlayer:SetActive(false)
      self._backNormal:SetActive(true)
    end
  else
    self._backNormal:SetActive(false)
    self._rankNormal:SetActive(false)
    self._backPlayer:SetActive(false)
  end
  self._name:SetText(personUserData.userName)
  self._level:SetText(personUserData.userLv)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(personUserData.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photo:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("XiGuaRankPlayerCell", "headPhotoRecord not found. avatarId = %s", personUserData.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(personUserData.frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photoFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("XiGuaRankPlayerCell", "headPhotoFrameRecord not found. frameId = %s", personUserData.frameId)
  end
  for index, roleID in ipairs(personBossData.roleIdList) do
    if self._role[index] then
      if 0 < roleID then
        self._role[index]:SetActive(true)
        local shapeCfg
        local skinID = personBossData.roleSkinList[index]
        if 0 < skinID then
          local skin = CSkin:GetRecorder(skinID)
          shapeCfg = CNpcShapeTable:GetRecorder(skin.shapeID)
        else
          local roleCfg = RoleConfigTable:GetRecorder(roleID)
          shapeCfg = CNpcShapeTable:GetRecorder(roleCfg.shapeID)
        end
        local imageRecord = CImagePathTable:GetRecorder(shapeCfg.skillHeadID) or DataCommon.DefaultImageAsset
        self._role[index]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        self._role[index]:SetActive(false)
      end
    end
  end
  self._maxDamageNum:SetText(personBossData.damage)
end

function XiGuaRankPlayerCell:OnCellClicked()
  self._delegate:OnePalyerCellClicked(self._index)
end

return XiGuaRankPlayerCell
