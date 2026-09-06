local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TopToBottom = 4
local RankDialog = class("RankDialog", Dialog)
RankDialog.AssetBundleName = "ui/layouts.activitynewyear"
RankDialog.AssetName = "ActivityNewYearRank"

function RankDialog:Ctor(...)
  RankDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._playerRankData = nil
  self._totalRankData = {}
end

function RankDialog:OnCreate()
  self._backBtn = self:GetChild("Back/CloseBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
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
    self._playerRankCell_top3Element[i] = {}
    self._playerRankCell_top3Element[i].rankIcon = self:GetChild("ActivityNewYearRankCell/Panel/Rank" .. i)
    self._playerRankCell_top3Element[i].back = self:GetChild("ActivityNewYearRankCell/Back" .. i)
  end
  self._playerRankCell_BackPlayer = self:GetChild("ActivityNewYearRankCell/BackPlayer")
  self._text1 = self:GetChild("Back/Text")
  self._emptyUI = self:GetChild("NoRank")
  self._awardImage = self:GetChild("Image")
  LuaNotificationCenter.AddObserver(self, self.RefreshRankData, Common.n_OnSSimpleRank, nil)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID)
  self:SetStaticRes()
  self:RefreshRankData()
end

function RankDialog:SetStaticRes()
  self._text1:SetText(TextManager.GetText(self._bm:GetCfgRecorder().getAwardWordId, self._bm:GetCfgRecorder().rankForReward))
  local imageRecord = CImagePathTable:GetRecorder(self._bm:GetCfgRecorder().rankRewardIconId) or DataCommon.DefaultImageAsset
  self._awardImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function RankDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function RankDialog:RefreshRankData()
  local rankData = NekoData.BehaviorManager.BM_SimpleRank:GetSpringFestivalRankData()
  if rankData == nil then
    return
  end
  rankData = rankData[self._bm:GetRankID()]
  self._totalRankData = rankData.totalRanking
  self._frame:ReloadAllCell()
  self:SetPlayerCell(rankData.playerRanking)
  self._emptyUI:SetActive(#self._totalRankData == 0)
end

function RankDialog:SetPlayerCell(data)
  local userName, score, rank, frameId, avatarId, userLv
  userName = data.baseUserData.userName
  score = data.score
  rank = data.rank
  frameId = data.baseUserData.frameId
  avatarId = data.baseUserData.avatarId
  userLv = data.baseUserData.userLv
  if frameId == 0 then
    frameId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().frameId
  end
  if avatarId == 0 then
    avatarId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().avatarId
  end
  if userLv == 0 then
    userLv = NekoData.BehaviorManager.BM_Game:GetUserLevel()
  end
  for i, v in ipairs(self._playerRankCell_top3Element) do
    v.rankIcon:SetActive(rank == i)
    v.back:SetActive(rank == i)
  end
  self._playerRankCell_rankNum:SetActive(3 < rank or rank == -1)
  self._playerRankCell_back:SetActive(3 < rank)
  local rankNum
  if rank == -1 then
    rankNum = TextManager.GetText(701760)
  else
    rankNum = rank
  end
  self._playerRankCell_rankNum:SetText(rankNum)
  self._playerRankCell_callScoreNum:SetText(score)
  self._playerRankCell_userName:SetText(userName)
  self._playerRankCell_level:SetText(userLv)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._playerRankCell_headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._playerRankCell_headFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("CallRankCell", "headPhotoFrameRecord not found. frameId = %s", frameId)
  end
  local headPhotoRecord = HeadPhotoTable:GetRecorder(avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._playerRankCell_headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._playerRankCell_headPhoto:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("CallRankCell", "headPhotoRecord not found. avatarId = %s", avatarId)
  end
end

function RankDialog:OnBackBtnClicked()
  self:Destroy()
end

function RankDialog:CellAtIndex(frame, index)
  return "activity.springfestival.rankcell"
end

function RankDialog:NumberOfCell(frame, index)
  return #self._totalRankData
end

function RankDialog:DataAtIndex(frame, index)
  return self._totalRankData[index]
end

function RankDialog:OnCurPosChange(frame, proportion)
  local width, height = self._panel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

return RankDialog
