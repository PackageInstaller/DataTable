local CArenaReward = BeanManager.GetTableByName("dungeonselect.carenareward")
local CArenaLoopReward = BeanManager.GetTableByName("dungeonselect.carenaloopreward")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CArenaSeasonConfig = BeanManager.GetTableByName("dungeonselect.carenaseasonconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local OfflinePvpRewardDialog = class("OfflinePvpRewardDialog", Dialog)
OfflinePvpRewardDialog.AssetBundleName = "ui/layouts.offlinepvp"
OfflinePvpRewardDialog.AssetName = "OffLinePVPReward"

function OfflinePvpRewardDialog:Ctor(...)
  OfflinePvpRewardDialog.super.Ctor(self, ...)
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

function OfflinePvpRewardDialog:OnCreate()
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
  self._topGroup = self:GetChild("TopGroup")
  self._topGroupFrame = TableFrame.Create(self._topGroup, self, false, false, true)
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._receiveAllBtn:Subscribe_PointerClickEvent(self.OnReceiveAllBtnClicked, self)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.ReloadRTopFrame, Common.n_RefreshCurrency, nil)
end

function OfflinePvpRewardDialog:OnDestroy()
  self._frame:Destroy()
  self._topGroupFrame:Destroy()
end

function OfflinePvpRewardDialog:Init(data)
  self._data = {}
  self._dataMap = {}
  self._totalScore = data.totalPithy
  self._scoreText:SetText(self._totalScore)
  self._gainList = data.rewardList
  self._maxContinueID = data.maxContinueId
  local ArenaRewardMaxId = #CArenaReward:GetAllIds()
  local ArenaLoopRewardMaxId = #CArenaLoopReward:GetAllIds()
  self._loopStartScore = CArenaReward:GetRecorder(ArenaRewardMaxId).totalScore
  self._loopMaxScore = CArenaLoopReward:GetRecorder(ArenaLoopRewardMaxId).totalScore
  self._overflowScore = self._totalScore - self._loopStartScore
  if self._overflowScore < 0 then
    self._overflowScore = 0
  end
  local loopRewardCount = self._overflowScore / self._loopMaxScore
  loopRewardCount = math.floor(loopRewardCount) + 10
  local allIds = CArenaReward:GetAllIds()
  for i, v in ipairs(allIds) do
    local recorder = CArenaReward:GetRecorder(v)
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
  for i = 1, loopRewardCount do
    local loopRewardId = i % ArenaLoopRewardMaxId
    if loopRewardId == 0 then
      loopRewardId = ArenaLoopRewardMaxId
    end
    local recorder = CArenaLoopReward:GetRecorder(loopRewardId)
    local temp = {}
    temp.id = recorder.id
    currentLoopScore = currentLoopScore + recorder.totalScore
    temp.score = currentLoopScore
    if temp.score <= self._totalScore then
      self._currentIndex = i + existingCount
    end
    temp.percent = (recorder.totalScore - (temp.score - self._totalScore)) / recorder.totalScore
    temp.itemId = recorder.itemId
    temp.itemCount = recorder.itemNums
    temp.lock = temp.score > self._totalScore
    temp.rewardId = i + ArenaRewardMaxId
    temp.itemType = recorder.itemType
    self._dataMap[temp.rewardId] = temp
  end
  for k, v in pairs(self._dataMap) do
    if k <= self._maxContinueID then
      v.gain = true
    end
  end
  for i, id in ipairs(self._gainList) do
    if self._dataMap[id] then
      self._dataMap[id].gain = true
    end
  end
  local camp = NekoData.BehaviorManager.BM_Activity:GetArenaCamp()
  self._char1:SetActive(camp == 1)
  self._char2:SetActive(camp == 2)
  local day = NekoData.BehaviorManager.BM_Activity:GetArenaEndDay()
  local str = TextManager.GetText(CStringRes:GetRecorder(1379).msgTextID)
  str = string.gsub(str, "%$parameter1%$", day)
  self._endTime:SetText(str)
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
  self._topGroupFrame:ReloadAllCell()
end

function OfflinePvpRewardDialog:Refresh(ids)
  for i, id in ipairs(ids) do
    self._dataMap[id].gain = true
    self._dataMap[id].lock = self._dataMap[id].score > self._totalScore
    self._frame:ReloadCellsAtIndex({id})
  end
end

function OfflinePvpRewardDialog:NumberOfCell(frame)
  if frame == self._topGroupFrame then
    return #self._moneyTypeInfo
  else
    return #self._dataMap
  end
end

function OfflinePvpRewardDialog:CellAtIndex(frame, index)
  if frame == self._topGroupFrame then
    return "shop.shoptopgroupcell"
  else
    return "mainline.offlinepvp.offlinepvprewardcell"
  end
end

function OfflinePvpRewardDialog:DataAtIndex(frame, index)
  if frame == self._topGroupFrame then
    return self._moneyTypeInfo[index]
  else
    return self._dataMap[index]
  end
end

function OfflinePvpRewardDialog:OnLeftArrowClicked()
  local rightIndex = self._frame:GetRightIndex()
  self._frame:MoveRightToIndex(rightIndex - 1, true)
end

function OfflinePvpRewardDialog:OnRightArrowClicked()
  local leftIndex = self._frame:GetLeftIndex()
  self._frame:MoveLeftToIndex(leftIndex + 1, true)
end

function OfflinePvpRewardDialog:MoveToCurrentIndex()
  self._frame:MoveIndexToCentreInTime(self._currentIndex, 0.1)
end

function OfflinePvpRewardDialog:OnCurPosChange(frame, tag)
  local width = self._panel:GetRectSize()
  if width < self._frame:GetTotalLength() and frame == self._frame then
    self._leftArrow:SetActive(tag ~= 0)
    self._rightArrow:SetActive(tag ~= 1)
  end
end

function OfflinePvpRewardDialog:OnRankBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.ranking.carenaranking")
  csend.index = 0
  csend:Send()
end

function OfflinePvpRewardDialog:OnShopBtnClicked()
  local arenaId = NekoData.BehaviorManager.BM_Activity:GetArenaId()
  local recorder = CArenaSeasonConfig:GetRecorder(arenaId)
  NekoData.DataManager.DM_Shop:ClientSetOpenShopID(recorder.shopId)
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
end

function OfflinePvpRewardDialog:OnReceiveAllBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.copenreward")
  csend.process = 0
  csend:Send()
end

function OfflinePvpRewardDialog:OnBackBtnClicked()
  self:Destroy()
end

function OfflinePvpRewardDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function OfflinePvpRewardDialog:ReloadRTopFrame()
  self._topGroupFrame:ReloadAllCell()
end

return OfflinePvpRewardDialog
