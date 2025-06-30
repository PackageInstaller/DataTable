-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/seasonpvp/seasonpvprankingdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CArenaLoopReward = (BeanManager.GetTableByName)("dungeonselect.carenaloopreward")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CArenaSeasonConfig = (BeanManager.GetTableByName)("dungeonselect.carenaseasonconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CDreamMain = (BeanManager.GetTableByName)("dungeonselect.cdreammain")
local CDreamRank = (BeanManager.GetTableByName)("dungeonselect.cdreamrank")
local Item = require("logic.manager.experimental.types.item")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local ItemIdType = {Role = 27, Equip = 299}
local TableFrame = require("framework.ui.frame.table.tableframe")
local SeasonPvpRankingDialog = class("SeasonPvpRankingDialog", Dialog)
SeasonPvpRankingDialog.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpRankingDialog.AssetName = "SeasonPVPRank"
local RankType = {CurrentSeason = 0, Totle = 1}
SeasonPvpRankingDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SeasonPvpRankingDialog
  ((SeasonPvpRankingDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
  self._playerIndex = -1
end

SeasonPvpRankingDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, RankType, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._rolePanel = self:GetChild("Panel/Role")
  self._live2D = self:GetChild("Panel/Role/Live2D")
  self._photo = self:GetChild("Panel/Role/Photo")
  self._playerCell = self:GetChild("Panel/OffLinePVPRankCell")
  self._rank_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Panel/Rank")
  self._namePlayer_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Panel/PlayerInfo/NameBack/NamePlayer")
  self._name_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Panel/PlayerInfo/NameBack/Name")
  self._headPhoto_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Panel/PlayerInfo/HeadPhoto/Photo")
  self._headPhotoFrame_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Panel/PlayerInfo/HeadPhoto/Frame")
  self._level_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Panel/PlayerInfo/LvBack/Level")
  self._score_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Panel/Num")
  self._back1_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Back1")
  self._back2_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Back2")
  self._back3_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Back3")
  self._backPlayer_playerCell = self:GetChild("Panel/OffLinePVPRankCell/BackPlayer")
  self._backNormal_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Back")
  self._rank1_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Panel/Rank1")
  self._rank2_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Panel/Rank2")
  self._rank3_playerCell = self:GetChild("Panel/OffLinePVPRankCell/Panel/Rank3")
  self._rankItems = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC126: Confused about usage of register: R5 in 'UnsetPending'

      (self._rankItems)[i] = {back = self:GetChild("Panel/OffLinePVPRankCell/CellItem" .. i), frame = self:GetChild("Panel/OffLinePVPRankCell/CellItem" .. i .. "/Panel/ItemCell/_BackGround/Frame"), icon = self:GetChild("Panel/OffLinePVPRankCell/CellItem" .. i .. "/Panel/ItemCell/_BackGround/Icon"), select = self:GetChild("Panel/OffLinePVPRankCell/CellItem" .. i .. "/Panel/ItemCell/_BackGround/Select"), count = self:GetChild("Panel/OffLinePVPRankCell/CellItem" .. i .. "/Panel/ItemCell/_Count")}
    end
  end
  for i = 1, 4 do
    (((self._rankItems)[i]).icon):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnItemIconClick(i)
  end
, self)
  end
  self._groupBtn1 = self:GetChild("Panel/GroupBtn1")
  self._groupBtn2 = self:GetChild("Panel/GroupBtn2")
  self._panel = self:GetChild("Panel/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._groupBtn1):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, RankType
    self:ShowRankByType(RankType.CurrentSeason)
  end
, self)
  ;
  (self._groupBtn2):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self, RankType
    self:ShowRankByType(RankType.Totle)
  end
, self)
  self._topGroup = self:GetChild("TopGroup")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.ReloadRTopFrame, Common.n_RefreshCurrency, nil)
end

SeasonPvpRankingDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

SeasonPvpRankingDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : RankType, _ENV, Item
  self._index = data.index
  ;
  (self._groupBtn1):SetSelected(self._index == RankType.CurrentSeason)
  ;
  (self._groupBtn2):SetSelected(self._index == RankType.Totle)
  self._data = data.ranking
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  self._playerRanking = data.playerRanking
  if (self._playerRanking).rank == -1 then
    (self._playerCell):SetActive(false)
  else
    for i,v in ipairs(self._data) do
      if (v.baseUserData).userId == ((NekoData.BehaviorManager).BM_Game):GetUserId() then
        self._playerIndex = v.rank
      end
    end
    if self._playerIndex == 1 then
      (self._playerCell):SetActive(false)
    else
      (self._playerCell):SetActive(true)
      self:SetPlayerCellData()
    end
  end
  self:SetLive2D()
  self._moneyTypeInfo = {
{moneyType = DataCommon.PVPKeys}
, 
{moneyType = DataCommon.PVPCoin}
}
  if self._index == RankType.Totle then
    for i = 1, 4 do
      (((self._rankItems)[i]).back):SetActive(true)
      ;
      (((self._rankItems)[i]).select):SetActive(false)
      ;
      (((self._rankItems)[i]).count):SetText("")
      ;
      (((self._rankItems)[i]).frame):SetSprite("ui/imagesets.component1.assetbundle", "ItemCellBackEmpty")
    end
  else
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
          local imageRecord = (self.item):GetIcon()
          ;
          (((self._rankItems)[i]).icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          imageRecord = (self.item):GetPinJiImage()
          ;
          (((self._rankItems)[i]).frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          (((self._rankItems)[i]).count):SetText((NumberManager.GetNumber)(itemNum))
        else
          (((self._rankItems)[i]).back):SetActive(true)
          ;
          (((self._rankItems)[i]).select):SetActive(false)
          ;
          (((self._rankItems)[i]).icon):SetActive(false)
          ;
          (((self._rankItems)[i]).count):SetText("")
          ;
          (((self._rankItems)[i]).frame):SetSprite("ui/imagesets.component1.assetbundle", "ItemCellBackEmpty")
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
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

SeasonPvpRankingDialog.GetRankRewardRecord = function(self)
  -- function num : 0_4 , upvalues : CDreamRank
  local allIds = CDreamRank:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDreamRank:GetRecorder(allIds[i])
    if recorder.rankDown <= (self._playerRanking).pithy and (self._playerRanking).pithy <= recorder.rankUp then
      return recorder
    end
  end
  return nil
end

SeasonPvpRankingDialog.SetPlayerCellData = function(self)
  -- function num : 0_5 , upvalues : HeadPhotoTable, CImagePathTable, _ENV, HeadPhotoFrameTable
  (self._rank_playerCell):SetText((self._playerRanking).rank)
  ;
  (self._score_playerCell):SetText((self._playerRanking).pithy)
  local userInfo = (self._playerRanking).baseUserData
  ;
  (self._level_playerCell):SetText(userInfo.userLv)
  ;
  (self._name_playerCell):SetActive(false)
  ;
  (self._namePlayer_playerCell):SetText(userInfo.userName)
  ;
  (self._back1_playerCell):SetActive((self._playerRanking).rank == 1)
  ;
  (self._back2_playerCell):SetActive((self._playerRanking).rank == 2)
  ;
  (self._back3_playerCell):SetActive((self._playerRanking).rank == 3)
  ;
  (self._rank1_playerCell):SetActive((self._playerRanking).rank == 1)
  ;
  (self._rank2_playerCell):SetActive((self._playerRanking).rank == 2)
  ;
  (self._rank3_playerCell):SetActive((self._playerRanking).rank == 3)
  ;
  (self._rank_playerCell):SetActive((self._playerRanking).rank > 3)
  ;
  (self._backPlayer_playerCell):SetActive(true)
  ;
  (self._backNormal_playerCell):SetActive(false)
  local headPhotoRecord = (HeadPhotoTable:GetRecorder(userInfo.avatarId))
  -- DECOMPILER ERROR at PC99: Overwrote pending register: R3 in 'AssignReg'

  local imageRecord = .end
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headPhoto_playerCell):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("SeasonPvpRankingDialog", "userInfo.avatarId %s is wrong", userInfo.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if headPhotoFrameRecord then
    if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headPhotoFrame_playerCell):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("SeasonPvpRankingDialog", "userInfo.frameId %s is wrong", userInfo.frameId)
  end
  -- DECOMPILER ERROR: 13 unprocessed JMP targets
end

SeasonPvpRankingDialog.SetLive2D = function(self)
  -- function num : 0_6 , upvalues : _ENV, CDreamMain, CNpcShapeTable, CImagePathTable
  if self._hasL2D then
    return 
  end
  self._hasL2D = true
  local data = ((NekoData.BehaviorManager).BM_Battle):GetSeasonData()
  local MainRecorder = CDreamMain:GetRecorder(data.seasonId)
  local shapeid = MainRecorder.factionShape1
  local shapeRecord = CNpcShapeTable:GetRecorder(shapeid)
  ;
  (self._rolePanel):SetAnimatorTrigger("loadReady")
  if (Live2DManager.CanUse)() and shapeRecord and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    if self._handler then
      (self._live2D):Release(self._handler)
      self._live2D = nil
      self._handler = nil
    end
    ;
    (self._photo):SetActive(false)
    self._handler = (self._live2D):AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  else
    if shapeRecord then
      if not CImagePathTable:GetRecorder(shapeRecord.lihuiID) then
        local lihuiImage = DataCommon.DefaultImageAsset
      end
      ;
      (self._photo):SetActive(true)
      ;
      (self._photo):SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
      local scale = shapeRecord.photoScale
      ;
      (self._photo):SetLocalScale(scale, scale, scale)
      ;
      (self._photo):SetAnchoredPosition((shapeRecord.photoLocation)[1], (shapeRecord.photoLocation)[2])
    end
  end
end

SeasonPvpRankingDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._data
end

SeasonPvpRankingDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "mainline.seasonpvp.seasonpvprankcell"
end

SeasonPvpRankingDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return {data = (self._data)[index], index = index}
end

SeasonPvpRankingDialog.OnCurPosChange = function(self, frame, tag)
  -- function num : 0_10
end

SeasonPvpRankingDialog.ShowRankByType = function(self, type)
  -- function num : 0_11 , upvalues : _ENV
  if self._index == type then
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.ranking.carenaranking")
  csend.index = type
  csend:Send()
end

SeasonPvpRankingDialog.OnBackBtnClicked = function(self)
  -- function num : 0_12
  self:Destroy()
end

SeasonPvpRankingDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

SeasonPvpRankingDialog.ReloadRTopFrame = function(self)
  -- function num : 0_14
  (self._topGroupFrame):ReloadAllCell()
end

SeasonPvpRankingDialog.OnItemIconClick = function(self, index)
  -- function num : 0_15 , upvalues : RankType, Item, ItemIdType, CRoleItem, _ENV
  if self._index == RankType.Totle then
    return 
  end
  if not self._rankRecord then
    return 
  end
  local item = ((Item.Create)(((self._rankRecord).item)[index]))
  -- DECOMPILER ERROR at PC14: Overwrote pending register: R3 in 'AssignReg'

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
    -- function num : 0_15_0 , upvalues : self, index
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

return SeasonPvpRankingDialog

