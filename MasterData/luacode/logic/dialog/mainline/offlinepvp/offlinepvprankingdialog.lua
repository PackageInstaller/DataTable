-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinepvp/offlinepvprankingdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CArenaReward = (BeanManager.GetTableByName)("dungeonselect.carenareward")
local CArenaLoopReward = (BeanManager.GetTableByName)("dungeonselect.carenaloopreward")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CArenaSeasonConfig = (BeanManager.GetTableByName)("dungeonselect.carenaseasonconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local OfflinePvpRankingDialog = class("OfflinePvpRankingDialog", Dialog)
OfflinePvpRankingDialog.AssetBundleName = "ui/layouts.offlinepvp"
OfflinePvpRankingDialog.AssetName = "OffLinePVPRank"
local RankType = {CurrentSeason = 0, Totle = 1}
OfflinePvpRankingDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OfflinePvpRankingDialog
  ((OfflinePvpRankingDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
  self._playerIndex = -1
end

OfflinePvpRankingDialog.OnCreate = function(self)
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
    -- function num : 0_1_0 , upvalues : self, RankType
    self:ShowRankByType(RankType.CurrentSeason)
  end
, self)
  ;
  (self._groupBtn2):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, RankType
    self:ShowRankByType(RankType.Totle)
  end
, self)
  self._topGroup = self:GetChild("TopGroup")
  self._topGroupFrame = (TableFrame.Create)(self._topGroup, self, false, false, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.ReloadRTopFrame, Common.n_RefreshCurrency, nil)
end

OfflinePvpRankingDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (self._topGroupFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

OfflinePvpRankingDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : RankType, _ENV
  (self._groupBtn1):SetSelected(data.index == RankType.CurrentSeason)
  ;
  (self._groupBtn2):SetSelected(data.index == RankType.Totle)
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
  ;
  (self._topGroupFrame):ReloadAllCell()
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

OfflinePvpRankingDialog.SetPlayerCellData = function(self)
  -- function num : 0_4 , upvalues : HeadPhotoTable, CImagePathTable, _ENV, HeadPhotoFrameTable
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
    LogErrorFormat("OfflinePvpRankingDialog", "userInfo.avatarId %s is wrong", userInfo.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if headPhotoFrameRecord then
    if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headPhotoFrame_playerCell):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("OfflinePvpRankingDialog", "userInfo.frameId %s is wrong", userInfo.frameId)
  end
  -- DECOMPILER ERROR: 13 unprocessed JMP targets
end

OfflinePvpRankingDialog.SetLive2D = function(self)
  -- function num : 0_5 , upvalues : _ENV, CArenaSeasonConfig, CNpcShapeTable, CImagePathTable
  if self._hasL2D then
    return 
  end
  self._hasL2D = true
  local arenaId = ((NekoData.BehaviorManager).BM_Activity):GetArenaId()
  local camp = ((NekoData.BehaviorManager).BM_Activity):GetArenaCamp()
  local recorder = (CArenaSeasonConfig:GetRecorder(arenaId))
  local shapeid = nil
  if camp == 1 then
    shapeid = recorder.factionShape1
  else
    if camp == 2 then
      shapeid = recorder.factionShape2
    end
  end
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

OfflinePvpRankingDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  if frame == self._topGroupFrame then
    return #self._moneyTypeInfo
  else
    return #self._data
  end
end

OfflinePvpRankingDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._topGroupFrame then
    return "shop.shoptopgroupcell"
  else
    return "mainline.offlinepvp.offlinepvprankcell"
  end
end

OfflinePvpRankingDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._topGroupFrame then
    return (self._moneyTypeInfo)[index]
  else
    return {data = (self._data)[index], index = index}
  end
end

OfflinePvpRankingDialog.OnCurPosChange = function(self, frame, tag)
  -- function num : 0_9
end

OfflinePvpRankingDialog.ShowRankByType = function(self, type)
  -- function num : 0_10 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.ranking.carenaranking")
  csend.index = type
  csend:Send()
end

OfflinePvpRankingDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11
  self:Destroy()
end

OfflinePvpRankingDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

OfflinePvpRankingDialog.ReloadRTopFrame = function(self)
  -- function num : 0_13
  (self._topGroupFrame):ReloadAllCell()
end

return OfflinePvpRankingDialog

