-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/yardmusic/rewarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CAudioPlayerAchievement = (BeanManager.GetTableByName)("courtyard.caudioplayerachievement")
local RewardStatus = (LuaNetManager.GetBeanDef)("protocol.yard.musiccollectionrewardsstatus")
local Item = require("logic.manager.experimental.types.item")
local BottomToTop = 2
local RewardDialog = class("RewardDialog", Dialog)
RewardDialog.AssetBundleName = "ui/layouts.yard"
RewardDialog.AssetName = "MusicPlayerAchievement"
RewardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RewardDialog
  ((RewardDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._rewardList = {}
end

RewardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame
  self._closeBtn = self:GetChild("CloseBtn")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._width = (self._panel):GetRectSize()
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
end

RewardDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

local FirstCanGetIndex = function(self)
  -- function num : 0_3 , upvalues : _ENV, RewardStatus
  for i,v in ipairs(self._rewardList) do
    if v.rewardStatus == RewardStatus.AVAILABLE then
      return i
    end
  end
end

RewardDialog.Init = function(self)
  -- function num : 0_4 , upvalues : _ENV, CAudioPlayerAchievement, FirstCanGetIndex
  while (self._rewardList)[#self._rewardList] do
    (table.remove)(self._rewardList, #self._rewardList)
  end
  local rewards = ((NekoData.BehaviorManager).BM_YardMusic):GetRewards()
  for k,v in pairs(rewards) do
    local record = CAudioPlayerAchievement:GetRecorder(k)
    ;
    (table.insert)(self._rewardList, {rewardId = v.rewardId, rewardStatus = v.rewardStatus, record = record})
  end
  ;
  (table.sort)(self._rewardList, function(a, b)
    -- function num : 0_4_0
    do return a.rewardId < b.rewardId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local firstCanGetIndex = FirstCanGetIndex(self)
  ;
  (self._frame):ReloadAllCell()
  if firstCanGetIndex then
    (self._frame):MoveTopToIndex(firstCanGetIndex)
  else
    ;
    (self._frame):MoveToTop()
  end
end

RewardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._rewardList
end

RewardDialog.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "yardmusic.rewardcell"
end

RewardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._rewardList)[index]
end

RewardDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

RewardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

return RewardDialog

