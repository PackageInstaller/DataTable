local GridFrame = require("framework.ui.frame.grid.gridframe")
local CInviterRewards = BeanManager.GetTableByName("activity.cinviterrewards")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local Item = require("logic.manager.experimental.types.item")
local InviteAwardListDlg = class("InviteAwardListDlg", Dialog)
InviteAwardListDlg.AssetBundleName = "ui/layouts.invite"
InviteAwardListDlg.AssetName = "InviteTaskFrame"

function InviteAwardListDlg:Ctor(...)
  InviteAwardListDlg.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._frame = nil
end

function InviteAwardListDlg:OnCreate()
  self._closeBtn = self:GetChild("CloseBtn")
  self._framePanel = self:GetChild("Frame")
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(3)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = GridFrame.Create(self._framePanel, self, true, 1)
end

function InviteAwardListDlg:OnDestroy()
  self._frame:Destroy()
  self.rewardsList = nil
end

function InviteAwardListDlg:UpdateReward(data)
  local rewardId = data.rewardID
  if data.result == 1 then
    if data.nextReward then
      local v = data.nextReward
      local record = CInviterRewards:GetRecorder(v.rewardID)
      local vc = {
        rewardID = v.rewardID,
        rewardState = v.rewardState,
        progress = v.progress
      }
      if record then
        local item = Item.Create(record.itemID[1])
        vc.item = {
          item = item,
          num = record.itemAmount[1],
          dontShowName = true
        }
        vc.maxPlayer = record.playerAmount
        vc.level = record.level
      end
      table.insert(self.rewardsList, vc)
    end
    local hasAward = false
    for k, v in pairs(self.rewardsList) do
      if v.rewardID == rewardId then
        self.rewardsList[k].rewardState = 2
      else
        hasAward = v.rewardState == 1 or hasAward
      end
    end
    if not hasAward then
      NekoData.DataManager.DM_Activity:ClearInviteRedDot(2)
      LuaNotificationCenter.PostNotification(Common.n_RefreshActivities, nil, nil)
      LuaNotificationCenter.PostNotification(Common.n_RefreshActivityRewards, nil, nil)
    end
    table.sort(self.rewardsList, function(v1, v2)
      if v1.rewardState < 2 and v2.rewardState < 2 then
        if v1.rewardState == v2.rewardState then
          return v1.rewardID < v2.rewardID
        else
          return v1.rewardState > v2.rewardState
        end
      elseif v1.rewardState == v2.rewardState then
        return v1.rewardID < v2.rewardID
      else
        return v1.rewardState < v2.rewardState
      end
    end)
    self._frame:ReloadAllCell()
  end
end

function InviteAwardListDlg:Update(data)
  if not data or not data.rewardsList then
    warn("award data nil")
    return
  end
  self.rewardsList = {}
  local d = data.rewardsList
  local a, b = {}, {}
  for k, v in ipairs(d) do
    local record = CInviterRewards:GetRecorder(v.rewardID)
    local vc = {
      rewardID = v.rewardID,
      rewardState = v.rewardState,
      progress = v.progress
    }
    if record then
      local item = Item.Create(record.itemID[1])
      vc.item = {
        item = item,
        num = record.itemAmount[1],
        dontShowName = true
      }
      vc.maxPlayer = record.playerAmount
      vc.level = record.level
    end
    table.insert(self.rewardsList, vc)
  end
  table.sort(self.rewardsList, function(v1, v2)
    if v1.rewardState < 2 and v2.rewardState < 2 then
      if v1.rewardState == v2.rewardState then
        return v1.rewardID < v2.rewardID
      else
        return v1.rewardState > v2.rewardState
      end
    elseif v1.rewardState == v2.rewardState then
      return v1.rewardID < v2.rewardID
    else
      return v1.rewardState < v2.rewardState
    end
  end)
  self._frame:ReloadAllCell()
end

function InviteAwardListDlg:NumberOfCell(frame)
  if frame == self._frame then
    return #self.rewardsList
  end
end

function InviteAwardListDlg:CellAtIndex(frame, index)
  if frame == self._frame then
    return "invite.inviteawardcell"
  end
end

function InviteAwardListDlg:DataAtIndex(frame, index)
  if frame == self._frame then
    return self.rewardsList[index]
  end
end

function InviteAwardListDlg:OnCurPosChange(frame, proportion)
  local width, height = self._framePanel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetScrollSize(1)
    self._scrollBar:SetScrollValue(proportion)
  end
end

function InviteAwardListDlg:OnBackBtnClicked()
  self:Destroy()
end

return InviteAwardListDlg
