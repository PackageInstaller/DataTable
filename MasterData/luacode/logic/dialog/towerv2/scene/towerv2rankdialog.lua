local TableFrame = require("framework.ui.frame.table.tableframe")
local TowerV2RankCellHelper = require("logic.dialog.towerv2.scene.towerv2rankcellhelper")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CStairEventRanklist = BeanManager.GetTableByName("dungeonselect.cstaireventranklist")
local TopToBottom = 4
local TowerV2RankDialog = class("TowerV2RankDialog", Dialog)
TowerV2RankDialog.AssetBundleName = "ui/layouts.stair"
TowerV2RankDialog.AssetName = "StairRank"

function TowerV2RankDialog:Ctor(...)
  TowerV2RankDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._playerRankData = nil
  self._totalRankData = {}
end

function TowerV2RankDialog:OnCreate()
  self._backBtn = self:GetChild("Back/CloseBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetActive(false)
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._noRank = self:GetChild("NoRank")
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._activityChristmasCallRankCell = self:GetChild("ActivityChristmasCallRankCell")
  self._playerCallRankCellHelper = TowerV2RankCellHelper.Create(self._activityChristmasCallRankCell, true)
  self._timeText = self:GetChild("Back/Time")
  self._timeText:SetActive(false)
  self._text1 = self:GetChild("Back/Text")
  self._text1:SetActive(false)
  LuaNotificationCenter.AddObserver(self, self.RefreshRankData, Common.n_OnSSimpleRank, nil)
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_BattleStateEnter, nil)
  self:SetStaticRes()
  self:SetData()
end

function TowerV2RankDialog:SetStaticRes()
  self._text1:SetText(TextManager.GetText(CStringRes:GetRecorder(1690).msgTextID, self._exchangeNum))
  self._timeText:SetText(TextManager.GetText(CStringRes:GetRecorder(1667).msgTextID, self._exchangeNum))
end

function TowerV2RankDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  if self._playerCallRankCellHelper then
    self._playerCallRankCellHelper:OnDestroy()
  end
end

function TowerV2RankDialog:SetData()
  local protocol = LuaNetManager.CreateProtocol("protocol.ranking.csimplerank")
  if protocol then
    protocol.rankType = NekoData.BehaviorManager.BM_SimpleRank:GetRankTypeDef().ROUGE_TOWER
    protocol.rankId = 0
    protocol:Send()
  end
  self:RefreshRankData()
end

function TowerV2RankDialog:RefreshRankData(notification)
  local rankData = NekoData.BehaviorManager.BM_SimpleRank:GetTowerV2RankData()
  if rankData == nil then
    return
  end
  rankData = rankData[0]
  self.mRankData = rankData
  self._noRank:SetActive(next(rankData.totalRanking) == nil)
  for key, _ in pairs(self._totalRankData) do
    self._totalRankData[key] = nil
  end
  for _, value in ipairs(rankData.totalRanking) do
    table.insert(self._totalRankData, {
      remoteData = value,
      localData = self:GetRankRewardRecord(value.rank)
    })
  end
  self._playerRankData = {
    remoteData = rankData.playerRanking,
    localData = self:GetRankRewardRecord(rankData.playerRanking.rank)
  }
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  if self._playerCallRankCellHelper then
    self._playerCallRankCellHelper:RefreshCell(self._playerRankData)
  end
end

function TowerV2RankDialog:GetRankRewardRecord(rank)
  local allIds = CStairEventRanklist:GetAllIds()
  for i = 1, #allIds do
    local recorder = CStairEventRanklist:GetRecorder(allIds[i])
    if rank >= recorder.upLimite and rank <= recorder.downLimite then
      return recorder
    end
  end
  return nil
end

function TowerV2RankDialog:OnBackBtnClicked()
  self:Destroy()
end

function TowerV2RankDialog:CellAtIndex(frame, index)
  return "towerv2.scene.towerv2rankcell"
end

function TowerV2RankDialog:NumberOfCell(frame, index)
  return #self._totalRankData
end

function TowerV2RankDialog:DataAtIndex(frame, index)
  return self._totalRankData[index]
end

function TowerV2RankDialog:OnCurPosChange(frame, proportion)
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

return TowerV2RankDialog
