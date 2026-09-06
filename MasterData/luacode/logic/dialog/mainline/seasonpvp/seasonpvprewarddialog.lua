local CDreamArenaReward = BeanManager.GetTableByName("dungeonselect.cdreamarenareward")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CArenaSeasonConfig = BeanManager.GetTableByName("dungeonselect.carenaseasonconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local timeutils = require("logic.utils.timeutils")
local SeasonPvpRewardDialog = class("SeasonPvpRewardDialog", Dialog)
SeasonPvpRewardDialog.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpRewardDialog.AssetName = "SeasonPVPReward"

function SeasonPvpRewardDialog:Ctor(...)
  SeasonPvpRewardDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._totalPithy = 0
  self._gainList = {}
  self._loopStartScore = 0
  self._loopMaxScore = 0
  self._overflowScore = 0
  self._currentIndex = 1
  self._dataMap = {}
  self._data = {}
end

function SeasonPvpRewardDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._shopBtn = self:GetChild("Panel/ShopBtn")
  self._rankBtn = self:GetChild("Panel/RankingList")
  self._receiveAllBtn = self:GetChild("Panel/ReceiveAll")
  self._leftArrow = self:GetChild("Panel/LeftArrow")
  self._rightArrow = self:GetChild("Panel/RightArrow")
  self._panel = self:GetChild("Panel/Frame")
  self._rolePanel = self:GetChild("Panel/Role")
  self._live2D = self:GetChild("Panel/Role/Live2D")
  self._photo = self:GetChild("Panel/Role/Photo")
  self._char1 = self:GetChild("Panel/Char1")
  self._char2 = self:GetChild("Panel/Char2")
  self._scoreText = self:GetChild("Panel/Current/Txt2")
  self._endTime = self:GetChild("Panel/Time/Txt2")
  self._frame = TableFrame.Create(self._panel, self, false)
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._receiveAllBtn:Subscribe_PointerClickEvent(self.OnReceiveAllBtnClicked, self)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.ReloadRTopFrame, Common.n_RefreshCurrency, nil)
end

function SeasonPvpRewardDialog:OnDestroy()
  self._frame:Destroy()
end

function SeasonPvpRewardDialog:Init(data)
  self._data = {}
  self._dataMap = {}
  self._totalScore = data.totalPoint
  self._scoreText:SetText(self._totalScore)
  self._gainList = data.rewardList
  local ArenaRewardMaxId = #CDreamArenaReward:GetAllIds()
  self._loopStartScore = CDreamArenaReward:GetRecorder(ArenaRewardMaxId).totalScore
  self._overflowScore = self._totalScore - self._loopStartScore
  if self._overflowScore < 0 then
    self._overflowScore = 0
  end
  local allIds = CDreamArenaReward:GetAllIds()
  for i, v in ipairs(allIds) do
    local recorder = CDreamArenaReward:GetRecorder(v)
    local temp = {}
    temp.id = recorder.id
    temp.score = recorder.totalScore
    if temp.score <= self._totalScore then
      self._currentIndex = i
    end
    temp.percent = (recorder.increaseScore - (temp.score - self._totalScore)) / recorder.increaseScore
    temp.itemId = recorder.itemId
    temp.itemCount = recorder.itemNums
    temp.lock = temp.score > self._totalScore
    temp.rewardId = recorder.id
    temp.itemType = recorder.itemType
    self._dataMap[i] = temp
  end
  local currentLoopScore = self._loopStartScore
  local existingCount = #allIds
  for i, id in ipairs(self._gainList) do
    if self._dataMap[id] then
      self._dataMap[id].gain = true
    end
  end
  local camp = NekoData.BehaviorManager.BM_Activity:GetArenaCamp()
  self._char1:SetActive(camp == 1)
  self._char2:SetActive(camp == 2)
  local data = NekoData.BehaviorManager.BM_Battle:GetSeasonData()
  self._endTime:SetText(timeutils.getLeftTimeStr(data.leftTime))
  self._frame:ReloadAllCell()
  self:MoveToCurrentIndex()
  self._moneyTypeInfo = {
    {
      moneyType = DataCommon.PVPKeys
    },
    {
      moneyType = DataCommon.PVPCoin
    }
  }
end

function SeasonPvpRewardDialog:Refresh(ids)
  for i, id in ipairs(ids) do
    self._dataMap[id].gain = true
    self._dataMap[id].lock = self._dataMap[id].score > self._totalScore
    self._frame:ReloadCellsAtIndex({id})
  end
end

function SeasonPvpRewardDialog:NumberOfCell(frame)
  return #self._dataMap
end

function SeasonPvpRewardDialog:CellAtIndex(frame, index)
  return "mainline.seasonpvp.seasonpvprewardcell"
end

function SeasonPvpRewardDialog:DataAtIndex(frame, index)
  return self._dataMap[index]
end

function SeasonPvpRewardDialog:OnLeftArrowClicked()
  local rightIndex = self._frame:GetRightIndex()
  self._frame:MoveRightToIndex(rightIndex - 1, true)
end

function SeasonPvpRewardDialog:OnRightArrowClicked()
  local leftIndex = self._frame:GetLeftIndex()
  self._frame:MoveLeftToIndex(leftIndex + 1, true)
end

function SeasonPvpRewardDialog:MoveToCurrentIndex()
  self._frame:MoveIndexToCentreInTime(self._currentIndex, 0.1)
end

function SeasonPvpRewardDialog:OnCurPosChange(frame, tag)
  local width = self._panel:GetRectSize()
  if width < self._frame:GetTotalLength() and frame == self._frame then
    self._leftArrow:SetActive(tag ~= 0)
    self._rightArrow:SetActive(tag ~= 1)
  end
end

function SeasonPvpRewardDialog:OnRankBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.ranking.carenaranking")
  csend.index = 0
  csend:Send()
end

function SeasonPvpRewardDialog:OnShopBtnClicked()
  local arenaId = NekoData.BehaviorManager.BM_Activity:GetArenaId()
  local recorder = CArenaSeasonConfig:GetRecorder(arenaId)
  NekoData.DataManager.DM_Shop:ClientSetOpenShopID(recorder.shopId)
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
end

function SeasonPvpRewardDialog:OnReceiveAllBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.cfantasyconflictgetreward")
  csend.id = 0
  csend:Send()
end

function SeasonPvpRewardDialog:OnBackBtnClicked()
  self:Destroy()
end

function SeasonPvpRewardDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function SeasonPvpRewardDialog:ReloadRTopFrame()
end

return SeasonPvpRewardDialog
