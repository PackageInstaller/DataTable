local TableFrame = require("framework.ui.frame.table.tableframe")
local CAudioPlayerAchievement = BeanManager.GetTableByName("courtyard.caudioplayerachievement")
local RewardStatus = LuaNetManager.GetBeanDef("protocol.yard.musiccollectionrewardsstatus")
local Item = require("logic.manager.experimental.types.item")
local BottomToTop = 2
local RewardDialog = class("RewardDialog", Dialog)
RewardDialog.AssetBundleName = "ui/layouts.yard"
RewardDialog.AssetName = "MusicPlayerAchievement"

function RewardDialog:Ctor(...)
  RewardDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._rewardList = {}
end

function RewardDialog:OnCreate()
  self._closeBtn = self:GetChild("CloseBtn")
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._width, self._height = self._panel:GetRectSize()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
end

function RewardDialog:OnDestroy()
  self._frame:Destroy()
end

local function FirstCanGetIndex(self)
  for i, v in ipairs(self._rewardList) do
    if v.rewardStatus == RewardStatus.AVAILABLE then
      return i
    end
  end
end

function RewardDialog:Init()
  while self._rewardList[#self._rewardList] do
    table.remove(self._rewardList, #self._rewardList)
  end
  local rewards = NekoData.BehaviorManager.BM_YardMusic:GetRewards()
  for k, v in pairs(rewards) do
    local record = CAudioPlayerAchievement:GetRecorder(k)
    table.insert(self._rewardList, {
      rewardId = v.rewardId,
      rewardStatus = v.rewardStatus,
      record = record
    })
  end
  table.sort(self._rewardList, function(a, b)
    return a.rewardId < b.rewardId
  end)
  local firstCanGetIndex = FirstCanGetIndex(self)
  self._frame:ReloadAllCell()
  if firstCanGetIndex then
    self._frame:MoveTopToIndex(firstCanGetIndex)
  else
    self._frame:MoveToTop()
  end
end

function RewardDialog:NumberOfCell(frame)
  return #self._rewardList
end

function RewardDialog:CellAtIndex(frame)
  return "yardmusic.rewardcell"
end

function RewardDialog:DataAtIndex(frame, index)
  return self._rewardList[index]
end

function RewardDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function RewardDialog:OnBackBtnClicked()
  self:Destroy()
end

return RewardDialog
