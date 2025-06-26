-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/rankdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TopToBottom = 4
local RankDialog = class("RankDialog", Dialog)
RankDialog.AssetBundleName = "ui/layouts.activitynewyear"
RankDialog.AssetName = "ActivityNewYearRank"
RankDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RankDialog
  ((RankDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._playerRankData = nil
  self._totalRankData = {}
end

RankDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TopToBottom, TableFrame, _ENV
  self._backBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(TopToBottom)
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._playerRankCell = self:GetChild("ActivityNewYearRankCell")
  self._playerRankCell_rankNum = self:GetChild("ActivityNewYearRankCell/Panel/Rank")
  self._playerRankCell_back = self:GetChild("ActivityNewYearRankCell/Back")
  self._playerRankCell_headFrame = self:GetChild("ActivityNewYearRankCell/Panel/PlayerInfo/HeadPhoto/Frame")
  self._playerRankCell_headPhoto = self:GetChild("ActivityNewYearRankCell/Panel/PlayerInfo/HeadPhoto/Photo")
  self._playerRankCell_userName = self:GetChild("ActivityNewYearRankCell/Panel/PlayerInfo/NameBack/Name")
  self._playerRankCell_callScoreNum = self:GetChild("ActivityNewYearRankCell/Panel/Num")
  self._playerRankCell_level = self:GetChild("ActivityNewYearRankCell/Panel/PlayerInfo/LvBack/Level")
  self._playerRankCell_top3Element = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

    (self._playerRankCell_top3Element)[i] = {}
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._playerRankCell_top3Element)[i]).rankIcon = self:GetChild("ActivityNewYearRankCell/Panel/Rank" .. i)
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._playerRankCell_top3Element)[i]).back = self:GetChild("ActivityNewYearRankCell/Back" .. i)
  end
  self._playerRankCell_BackPlayer = self:GetChild("ActivityNewYearRankCell/BackPlayer")
  self._text1 = self:GetChild("Back/Text")
  self._emptyUI = self:GetChild("NoRank")
  self._awardImage = self:GetChild("Image")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRankData, Common.n_OnSSimpleRank, nil)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)
  self:SetStaticRes()
  self:RefreshRankData()
end

RankDialog.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CImagePathTable
  (self._text1):SetText((TextManager.GetText)(((self._bm):GetCfgRecorder()).getAwardWordId, ((self._bm):GetCfgRecorder()).rankForReward))
  if not CImagePathTable:GetRecorder(((self._bm):GetCfgRecorder()).rankRewardIconId) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._awardImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

RankDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

RankDialog.RefreshRankData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local rankData = ((NekoData.BehaviorManager).BM_SimpleRank):GetSpringFestivalRankData()
  if rankData == nil then
    return 
  end
  rankData = rankData[(self._bm):GetRankID()]
  self._totalRankData = rankData.totalRanking
  ;
  (self._frame):ReloadAllCell()
  self:SetPlayerCell(rankData.playerRanking)
  ;
  (self._emptyUI):SetActive(#self._totalRankData == 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

RankDialog.SetPlayerCell = function(self, data)
  -- function num : 0_5 , upvalues : _ENV, HeadPhotoFrameTable, CImagePathTable, HeadPhotoTable
  local userName, score, rank, frameId, avatarId, userLv = nil, nil, nil, nil, nil, nil
  userName = (data.baseUserData).userName
  score = data.score
  rank = data.rank
  frameId = (data.baseUserData).frameId
  avatarId = (data.baseUserData).avatarId
  userLv = (data.baseUserData).userLv
  if frameId == 0 then
    frameId = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).frameId
  end
  if avatarId == 0 then
    avatarId = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).avatarId
  end
  if userLv == 0 then
    userLv = ((NekoData.BehaviorManager).BM_Game):GetUserLevel()
  end
  for i,v in ipairs(self._playerRankCell_top3Element) do
    (v.rankIcon):SetActive(rank == i)
    ;
    (v.back):SetActive(rank == i)
  end
  ;
  (self._playerRankCell_rankNum):SetActive(rank > 3 or rank == -1)
  ;
  (self._playerRankCell_back):SetActive(rank > 3)
  local rankNum = nil
  if rank == -1 then
    rankNum = (TextManager.GetText)(701760)
  else
    rankNum = rank
  end
  ;
  (self._playerRankCell_rankNum):SetText(rankNum)
  ;
  (self._playerRankCell_callScoreNum):SetText(score)
  ;
  (self._playerRankCell_userName):SetText(userName)
  ;
  (self._playerRankCell_level):SetText(userLv)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(frameId)
  if headPhotoFrameRecord then
    if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._playerRankCell_headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    (self._playerRankCell_headFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
    LogErrorFormat("CallRankCell", "headPhotoFrameRecord not found. frameId = %s", frameId)
  end
  local headPhotoRecord = HeadPhotoTable:GetRecorder(avatarId)
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._playerRankCell_headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    (self._playerRankCell_headPhoto):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
    LogErrorFormat("CallRankCell", "headPhotoRecord not found. avatarId = %s", avatarId)
  end
  -- DECOMPILER ERROR: 13 unprocessed JMP targets
end

RankDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

RankDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "activity.springfestival.rankcell"
end

RankDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  return #self._totalRankData
end

RankDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._totalRankData)[index]
end

RankDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_10
  local width, height = (self._panel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

return RankDialog

