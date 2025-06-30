-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinepvp/offlinepvprewarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CArenaReward = (BeanManager.GetTableByName)("dungeonselect.carenareward")
local CArenaLoopReward = (BeanManager.GetTableByName)("dungeonselect.carenaloopreward")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CArenaSeasonConfig = (BeanManager.GetTableByName)("dungeonselect.carenaseasonconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local OfflinePvpRewardDialog = class("OfflinePvpRewardDialog", Dialog)
OfflinePvpRewardDialog.AssetBundleName = "ui/layouts.offlinepvp"
OfflinePvpRewardDialog.AssetName = "OffLinePVPReward"
OfflinePvpRewardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OfflinePvpRewardDialog
  ((OfflinePvpRewardDialog.super).Ctor)(self, ...)
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

OfflinePvpRewardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
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
  self._frame = (TableFrame.Create)(self._panel, self, false)
  self._topGroup = self:GetChild("TopGroup")
  self._topGroupFrame = (TableFrame.Create)(self._topGroup, self, false, false, true)
  ;
  (self._rankBtn):Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  ;
  (self._receiveAllBtn):Subscribe_PointerClickEvent(self.OnReceiveAllBtnClicked, self)
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.ReloadRTopFrame, Common.n_RefreshCurrency, nil)
end

OfflinePvpRewardDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
  ;
  (self._topGroupFrame):Destroy()
end

OfflinePvpRewardDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : CArenaReward, CArenaLoopReward, _ENV, CStringRes
  self._data = {}
  self._dataMap = {}
  self._totalScore = data.totalPithy
  ;
  (self._scoreText):SetText(self._totalScore)
  self._gainList = data.rewardList
  self._maxContinueID = data.maxContinueId
  local ArenaRewardMaxId = #CArenaReward:GetAllIds()
  local ArenaLoopRewardMaxId = #CArenaLoopReward:GetAllIds()
  self._loopStartScore = (CArenaReward:GetRecorder(ArenaRewardMaxId)).totalScore
  self._loopMaxScore = (CArenaLoopReward:GetRecorder(ArenaLoopRewardMaxId)).totalScore
  self._overflowScore = self._totalScore - self._loopStartScore
  if self._overflowScore < 0 then
    self._overflowScore = 0
  end
  local loopRewardCount = self._overflowScore / self._loopMaxScore
  loopRewardCount = (math.floor)(loopRewardCount) + 10
  local allIds = CArenaReward:GetAllIds()
  for i,v in ipairs(allIds) do
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
    temp.lock = self._totalScore < temp.score
    temp.rewardId = recorder.id
    temp.itemType = recorder.itemType
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self._dataMap)[i] = temp
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
    temp.lock = self._totalScore < temp.score
    temp.rewardId = i + ArenaRewardMaxId
    temp.itemType = recorder.itemType
    -- DECOMPILER ERROR at PC149: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self._dataMap)[temp.rewardId] = temp
  end
  for k,v in pairs(self._dataMap) do
    if k <= self._maxContinueID then
      v.gain = true
    end
  end
  for i,id in ipairs(self._gainList) do
    -- DECOMPILER ERROR at PC171: Confused about usage of register: R13 in 'UnsetPending'

    if (self._dataMap)[id] then
      ((self._dataMap)[id]).gain = true
    end
  end
  local camp = ((NekoData.BehaviorManager).BM_Activity):GetArenaCamp()
  ;
  (self._char1):SetActive(camp == 1)
  ;
  (self._char2):SetActive(camp == 2)
  local day = ((NekoData.BehaviorManager).BM_Activity):GetArenaEndDay()
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1379)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", day)
  ;
  (self._endTime):SetText(str)
  ;
  (self._frame):ReloadAllCell()
  self:MoveToCurrentIndex()
  self._moneyTypeInfo = {
{moneyType = DataCommon.PVPKeys}
, 
{moneyType = DataCommon.PVPCoin}
}
  ;
  (self._topGroupFrame):ReloadAllCell()
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

OfflinePvpRewardDialog.Refresh = function(self, ids)
  -- function num : 0_4 , upvalues : _ENV
  for i,id in ipairs(ids) do
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R7 in 'UnsetPending'

    ((self._dataMap)[id]).gain = true
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._dataMap)[id]).lock = self._totalScore < ((self._dataMap)[id]).score
    ;
    (self._frame):ReloadCellsAtIndex({id})
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

OfflinePvpRewardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  if frame == self._topGroupFrame then
    return #self._moneyTypeInfo
  else
    return #self._dataMap
  end
end

OfflinePvpRewardDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._topGroupFrame then
    return "shop.shoptopgroupcell"
  else
    return "mainline.offlinepvp.offlinepvprewardcell"
  end
end

OfflinePvpRewardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._topGroupFrame then
    return (self._moneyTypeInfo)[index]
  else
    return (self._dataMap)[index]
  end
end

OfflinePvpRewardDialog.OnLeftArrowClicked = function(self)
  -- function num : 0_8
  local rightIndex = (self._frame):GetRightIndex()
  ;
  (self._frame):MoveRightToIndex(rightIndex - 1, true)
end

OfflinePvpRewardDialog.OnRightArrowClicked = function(self)
  -- function num : 0_9
  local leftIndex = (self._frame):GetLeftIndex()
  ;
  (self._frame):MoveLeftToIndex(leftIndex + 1, true)
end

OfflinePvpRewardDialog.MoveToCurrentIndex = function(self)
  -- function num : 0_10
  (self._frame):MoveIndexToCentreInTime(self._currentIndex, 0.1)
end

OfflinePvpRewardDialog.OnCurPosChange = function(self, frame, tag)
  -- function num : 0_11
  local width = (self._panel):GetRectSize()
  if tag == 0 then
    (self._leftArrow):SetActive(width >= (self._frame):GetTotalLength() or frame ~= self._frame)
    ;
    (self._rightArrow):SetActive(tag ~= 1)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

OfflinePvpRewardDialog.OnRankBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.ranking.carenaranking")
  csend.index = 0
  csend:Send()
end

OfflinePvpRewardDialog.OnShopBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV, CArenaSeasonConfig
  local arenaId = ((NekoData.BehaviorManager).BM_Activity):GetArenaId()
  local recorder = CArenaSeasonConfig:GetRecorder(arenaId)
  ;
  ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(recorder.shopId)
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
end

OfflinePvpRewardDialog.OnReceiveAllBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.copenreward")
  csend.process = 0
  csend:Send()
end

OfflinePvpRewardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_15
  self:Destroy()
end

OfflinePvpRewardDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

OfflinePvpRewardDialog.ReloadRTopFrame = function(self)
  -- function num : 0_17
  (self._topGroupFrame):ReloadAllCell()
end

return OfflinePvpRewardDialog

