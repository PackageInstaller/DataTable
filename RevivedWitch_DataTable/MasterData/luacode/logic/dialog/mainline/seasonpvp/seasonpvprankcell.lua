-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/seasonpvp/seasonpvprankcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CDreamRank = (BeanManager.GetTableByName)("dungeonselect.cdreamrank")
local Item = require("logic.manager.experimental.types.item")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local ItemIdType = {Role = 27, Equip = 299}
local SeasonPvpRankCell = class("SeasonPvpRankCell", Dialog)
SeasonPvpRankCell.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpRankCell.AssetName = "SeasonPVPRankCell"
local RankType = {CurrentSeason = 0, Totle = 1}
SeasonPvpRankCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SeasonPvpRankCell
  ((SeasonPvpRankCell.super).Ctor)(self, ...)
end

SeasonPvpRankCell.OnCreate = function(self)
  -- function num : 0_1
  self._namePlayer = self:GetChild("Panel/PlayerInfo/NameBack/NamePlayer")
  self._name = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._headPhoto = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
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
    do
      -- DECOMPILER ERROR at PC102: Confused about usage of register: R5 in 'UnsetPending'

      (self._rankItems)[i] = {back = self:GetChild("CellItem" .. i), frame = self:GetChild("CellItem" .. i .. "/Panel/ItemCell/_BackGround/Frame"), icon = self:GetChild("CellItem" .. i .. "/Panel/ItemCell/_BackGround/Icon"), select = self:GetChild("CellItem" .. i .. "/Panel/ItemCell/_BackGround/Select"), count = self:GetChild("CellItem" .. i .. "/Panel/ItemCell/_Count")}
    end
  end
  for i = 1, 4 do
    (((self._rankItems)[i]).icon):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnItemIconClick(i)
  end
, self)
  end
end

SeasonPvpRankCell.OnDestroy = function(self)
  -- function num : 0_2
end

SeasonPvpRankCell.SetBack = function(self, rank)
  -- function num : 0_3
  (self._back1):SetActive(rank == 1)
  ;
  (self._back2):SetActive(rank == 2)
  ;
  (self._back3):SetActive(rank == 3)
  ;
  (self._backNormal):SetActive(rank > 3)
  ;
  (self._rank1):SetActive(rank == 1)
  ;
  (self._rank2):SetActive(rank == 2)
  ;
  (self._rank3):SetActive(rank == 3)
  ;
  (self._rank):SetActive(rank > 3)
  ;
  (self._backPlayer):SetActive(false)
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

SeasonPvpRankCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable, RankType, Item
  self._data = data.data
  ;
  (self._rank):SetText((self._data).rank)
  ;
  (self._score):SetText((self._data).pithy)
  self:SetBack((self._data).rank)
  local userInfo = (self._data).baseUserData
  ;
  (self._level):SetText(userInfo.userLv)
  if userInfo.userId == ((NekoData.BehaviorManager).BM_Game):GetUserId() then
    (self._name):SetActive(false)
    ;
    (self._namePlayer):SetActive(true)
    ;
    (self._namePlayer):SetText(userInfo.userName)
  else
    ;
    (self._name):SetActive(true)
    ;
    (self._namePlayer):SetActive(false)
    ;
    (self._name):SetText(userInfo.userName)
  end
  local headPhotoRecord = (HeadPhotoTable:GetRecorder(userInfo.avatarId))
  local imageRecord = nil
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("SeasonPvpRankCell", "userInfo.avatarId %s is wrong", userInfo.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if headPhotoFrameRecord then
    if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headPhotoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("SeasonPvpRankCell", "userInfo.frameId %s is wrong", userInfo.frameId)
  end
  if (self._delegate)._index == RankType.Totle then
    for i = 1, 4 do
      (((self._rankItems)[i]).back):SetActive(false)
    end
  else
    do
      self._rankRecord = self:GetRankRewardRecord()
      if self._rankRecord then
        for i = 1, 4 do
          if ((self._rankRecord).item)[i] > 0 then
            (((self._rankItems)[i]).back):SetActive(true)
            ;
            (((self._rankItems)[i]).select):SetActive(false)
            ;
            (((self._rankItems)[i]).icon):SetActive(true)
            local itemId = ((self._rankRecord).item)[i]
            local itemNum = ((self._rankRecord).num)[i]
            self.item = (Item.Create)(itemId)
            local itmeImageRecord = (self.item):GetIcon()
            ;
            (((self._rankItems)[i]).icon):SetSprite(itmeImageRecord.assetBundle, itmeImageRecord.assetName)
            itmeImageRecord = (self.item):GetPinJiImage()
            ;
            (((self._rankItems)[i]).frame):SetSprite(itmeImageRecord.assetBundle, itmeImageRecord.assetName)
            ;
            (((self._rankItems)[i]).count):SetText((NumberManager.GetNumber)(itemNum))
          else
            do
              do
                ;
                (((self._rankItems)[i]).back):SetActive(true)
                ;
                (((self._rankItems)[i]).select):SetActive(false)
                ;
                (((self._rankItems)[i]).icon):SetActive(false)
                ;
                (((self._rankItems)[i]).count):SetText("")
                ;
                (((self._rankItems)[i]).frame):SetSprite("ui/imagesets.component1.assetbundle", "ItemCellBackEmpty")
                -- DECOMPILER ERROR at PC228: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC228: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC228: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      else
        for i = 1, 4 do
          (((self._rankItems)[i]).back):SetActive(true)
          ;
          (((self._rankItems)[i]).select):SetActive(false)
          ;
          (((self._rankItems)[i]).count):SetText("")
          ;
          (((self._rankItems)[i]).frame):SetSprite("ui/imagesets.component1.assetbundle", "ItemCellBackEmpty")
        end
      end
    end
  end
end

SeasonPvpRankCell.GetRankRewardRecord = function(self)
  -- function num : 0_5 , upvalues : CDreamRank
  local allIds = CDreamRank:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDreamRank:GetRecorder(allIds[i])
    if recorder.rankDown <= (self._data).pithy and (self._data).pithy <= recorder.rankUp then
      return recorder
    end
  end
  return nil
end

SeasonPvpRankCell.OnItemIconClick = function(self, index)
  -- function num : 0_6 , upvalues : RankType, Item, ItemIdType, CRoleItem, _ENV
  if (self._delegate)._index == RankType.Totle then
    return 
  end
  if not self._rankRecord then
    return 
  end
  local item = ((Item.Create)(((self._rankRecord).item)[index]))
  -- DECOMPILER ERROR at PC15: Overwrote pending register: R3 in 'AssignReg'

  local dialog = .end
  if item:GetItemTypeId() == ItemIdType.Role then
    local roleID = (CRoleItem:GetRecorder(item:GetID())).roleid
    dialog = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
    if dialog then
      dialog:Init({
roleIdList = {roleID}
, 
cfgIdList = {4}
, index = 1}, (dialog.ShowType).BaseLevelInfo)
    end
  else
    do
      if item:GetItemTypeId() == ItemIdType.Equip then
        dialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
        if dialog then
          dialog:Init(item:GetID())
          dialog:SetTipsParmFunc(function()
    -- function num : 0_6_0 , upvalues : self, index
    local width, height = ((self._itemBacks)[index]):GetRectSize()
    local pos = ((self._itemBacks)[index]):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
        end
      else
        dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
        if dialog then
          dialog:Init({item = item})
        end
      end
    end
  end
end

return SeasonPvpRankCell

