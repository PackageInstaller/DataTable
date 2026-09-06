local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CDreamRank = BeanManager.GetTableByName("dungeonselect.cdreamrank")
local Item = require("logic.manager.experimental.types.item")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local ItemIdType = {Role = 27, Equip = 299}
local SeasonPvpRankCell = class("SeasonPvpRankCell", Dialog)
SeasonPvpRankCell.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpRankCell.AssetName = "SeasonPVPRankCell"
local RankType = {CurrentSeason = 0, Totle = 1}

function SeasonPvpRankCell:Ctor(...)
  SeasonPvpRankCell.super.Ctor(self, ...)
end

function SeasonPvpRankCell:OnCreate()
  self._namePlayer = self:GetChild("Panel/PlayerInfo/NameBack/NamePlayer")
  self._name = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._headPhoto = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._headPhoto:Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self._headPhotoFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
  self._score = self:GetChild("Panel/Num")
  self._back1 = self:GetChild("Back1")
  self._back2 = self:GetChild("Back2")
  self._back3 = self:GetChild("Back3")
  self._backPlayer = self:GetChild("BackPlayer")
  self._backNormal = self:GetChild("Back")
  self._rank = self:GetChild("Panel/Rank")
  self._rank1 = self:GetChild("Panel/Rank1")
  self._rank2 = self:GetChild("Panel/Rank2")
  self._rank3 = self:GetChild("Panel/Rank3")
  self._rankItems = {}
  for i = 1, 4 do
    self._rankItems[i] = {
      back = self:GetChild("CellItem" .. i),
      frame = self:GetChild("CellItem" .. i .. "/Panel/ItemCell/_BackGround/Frame"),
      icon = self:GetChild("CellItem" .. i .. "/Panel/ItemCell/_BackGround/Icon"),
      select = self:GetChild("CellItem" .. i .. "/Panel/ItemCell/_BackGround/Select"),
      count = self:GetChild("CellItem" .. i .. "/Panel/ItemCell/_Count")
    }
  end
  for i = 1, 4 do
    self._rankItems[i].icon:Subscribe_PointerClickEvent(function()
      self:OnItemIconClick(i)
    end, self)
  end
end

function SeasonPvpRankCell:OnDestroy()
end

function SeasonPvpRankCell:SetBack(rank)
  self._back1:SetActive(rank == 1)
  self._back2:SetActive(rank == 2)
  self._back3:SetActive(rank == 3)
  self._backNormal:SetActive(3 < rank)
  self._rank1:SetActive(rank == 1)
  self._rank2:SetActive(rank == 2)
  self._rank3:SetActive(rank == 3)
  self._rank:SetActive(3 < rank)
  self._backPlayer:SetActive(false)
end

function SeasonPvpRankCell:RefreshCell(data)
  self._data = data.data
  self._rank:SetText(self._data.rank)
  self._score:SetText(self._data.pithy)
  self:SetBack(self._data.rank)
  local userInfo = self._data.baseUserData
  self._level:SetText(userInfo.userLv)
  if userInfo.userId == NekoData.BehaviorManager.BM_Game:GetUserId() then
    self._name:SetActive(false)
    self._namePlayer:SetActive(true)
    self._namePlayer:SetText(userInfo.userName)
  else
    self._name:SetActive(true)
    self._namePlayer:SetActive(false)
    self._name:SetText(userInfo.userName)
  end
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  local imageRecord
  if headPhotoRecord then
    imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("SeasonPvpRankCell", "userInfo.avatarId %s is wrong", userInfo.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if headPhotoFrameRecord then
    imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._headPhotoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("SeasonPvpRankCell", "userInfo.frameId %s is wrong", userInfo.frameId)
  end
  if self._delegate._index == RankType.Totle then
    for i = 1, 4 do
      self._rankItems[i].back:SetActive(false)
    end
  else
    self._rankRecord = self:GetRankRewardRecord()
    if self._rankRecord then
      for i = 1, 4 do
        if self._rankRecord.item[i] > 0 then
          self._rankItems[i].back:SetActive(true)
          self._rankItems[i].select:SetActive(false)
          self._rankItems[i].icon:SetActive(true)
          local itemId = self._rankRecord.item[i]
          local itemNum = self._rankRecord.num[i]
          self.item = Item.Create(itemId)
          local itmeImageRecord = self.item:GetIcon()
          self._rankItems[i].icon:SetSprite(itmeImageRecord.assetBundle, itmeImageRecord.assetName)
          itmeImageRecord = self.item:GetPinJiImage()
          self._rankItems[i].frame:SetSprite(itmeImageRecord.assetBundle, itmeImageRecord.assetName)
          self._rankItems[i].count:SetText(NumberManager.GetNumber(itemNum))
        else
          self._rankItems[i].back:SetActive(true)
          self._rankItems[i].select:SetActive(false)
          self._rankItems[i].icon:SetActive(false)
          self._rankItems[i].count:SetText("")
          self._rankItems[i].frame:SetSprite("ui/imagesets.component1.assetbundle", "ItemCellBackEmpty")
        end
      end
    else
      for i = 1, 4 do
        self._rankItems[i].back:SetActive(true)
        self._rankItems[i].select:SetActive(false)
        self._rankItems[i].count:SetText("")
        self._rankItems[i].frame:SetSprite("ui/imagesets.component1.assetbundle", "ItemCellBackEmpty")
      end
    end
  end
end

function SeasonPvpRankCell:GetRankRewardRecord()
  local allIds = CDreamRank:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDreamRank:GetRecorder(allIds[i])
    if self._data.pithy >= recorder.rankDown and self._data.pithy <= recorder.rankUp then
      return recorder
    end
  end
  return nil
end

function SeasonPvpRankCell:OnItemIconClick(index)
  if self._delegate._index == RankType.Totle then
    return
  end
  if not self._rankRecord then
    return
  end
  local item = Item.Create(self._rankRecord.item[index])
  local dialog
  if item:GetItemTypeId() == ItemIdType.Role then
    local roleID = CRoleItem:GetRecorder(item:GetID()).roleid
    dialog = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
    if dialog then
      dialog:Init({
        roleIdList = {roleID},
        cfgIdList = {4},
        index = 1
      }, dialog.ShowType.BaseLevelInfo)
    end
  elseif item:GetItemTypeId() == ItemIdType.Equip then
    dialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
    if dialog then
      dialog:Init(item:GetID())
      dialog:SetTipsParmFunc(function()
        local width, height = self._itemBacks[index]:GetRectSize()
        local pos = self._itemBacks[index]:GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  else
    dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if dialog then
      dialog:Init({item = item})
    end
  end
end

function SeasonPvpRankCell:OnHeadPhotoClicked()
  if self._data.baseUserData.userId ~= NekoData.BehaviorManager.BM_Game:GetUserId() then
    self:SendCLookOtherInfo(self._data.baseUserData.userId)
  end
end

function SeasonPvpRankCell:SendCLookOtherInfo(userId)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clookotherinfo")
  if protocol then
    protocol.userId = userId
    protocol:Send()
  end
end

return SeasonPvpRankCell
