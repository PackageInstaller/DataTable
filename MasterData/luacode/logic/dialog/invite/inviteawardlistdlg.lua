-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/invite/inviteawardlistdlg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CInviterRewards = (BeanManager.GetTableByName)("activity.cinviterrewards")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local Item = require("logic.manager.experimental.types.item")
local InviteAwardListDlg = class("InviteAwardListDlg", Dialog)
InviteAwardListDlg.AssetBundleName = "ui/layouts.invite"
InviteAwardListDlg.AssetName = "InviteTaskFrame"
InviteAwardListDlg.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InviteAwardListDlg
  ((InviteAwardListDlg.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._frame = nil
end

InviteAwardListDlg.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._closeBtn = self:GetChild("CloseBtn")
  self._framePanel = self:GetChild("Frame")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(3)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = (GridFrame.Create)(self._framePanel, self, true, 1)
end

InviteAwardListDlg.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
  self.rewardsList = nil
end

InviteAwardListDlg.UpdateReward = function(self, data)
  -- function num : 0_3 , upvalues : CInviterRewards, Item, _ENV
  local rewardId = data.rewardID
  if data.result == 1 then
    if data.nextReward then
      local v = data.nextReward
      local record = CInviterRewards:GetRecorder(v.rewardID)
      local vc = {rewardID = v.rewardID, rewardState = v.rewardState, progress = v.progress}
      do
        do
          if record then
            local item = (Item.Create)((record.itemID)[1])
            vc.item = {item = item, num = (record.itemAmount)[1], dontShowName = true}
            vc.maxPlayer = record.playerAmount
            vc.level = record.level
          end
          ;
          (table.insert)(self.rewardsList, vc)
          do
            local hasAward = false
            for k,v in pairs(self.rewardsList) do
              -- DECOMPILER ERROR at PC51: Confused about usage of register: R9 in 'UnsetPending'

              if v.rewardID == rewardId then
                ((self.rewardsList)[k]).rewardState = 2
              else
              end
              hasAward = v.rewardState ~= 1 and hasAward
            end
            if not hasAward then
              ((NekoData.DataManager).DM_Activity):ClearInviteRedDot(2)
              ;
              (LuaNotificationCenter.PostNotification)(Common.n_RefreshActivities, nil, nil)
              ;
              (LuaNotificationCenter.PostNotification)(Common.n_RefreshActivityRewards, nil, nil)
            end
            ;
            (table.sort)(self.rewardsList, function(v1, v2)
    -- function num : 0_3_0
    if v1.rewardState == v2.rewardState then
      if v1.rewardID >= v2.rewardID then
        do return v1.rewardState >= 2 or v2.rewardState >= 2 end
        do return v2.rewardState < v1.rewardState end
        if v1.rewardID >= v2.rewardID then
          do return v1.rewardState ~= v2.rewardState end
          do return v1.rewardState < v2.rewardState end
          -- DECOMPILER ERROR: 8 unprocessed JMP targets
        end
      end
    end
  end
)
            ;
            (self._frame):ReloadAllCell()
            -- DECOMPILER ERROR: 4 unprocessed JMP targets
          end
        end
      end
    end
  end
end

InviteAwardListDlg.Update = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, CInviterRewards, Item
  if not data or not data.rewardsList then
    warn("award data nil")
    return 
  end
  self.rewardsList = {}
  local d = data.rewardsList
  local a, b = {}, {}
  for k,v in ipairs(d) do
    local record = CInviterRewards:GetRecorder(v.rewardID)
    local vc = {rewardID = v.rewardID, rewardState = v.rewardState, progress = v.progress}
    do
      do
        if record then
          local item = (Item.Create)((record.itemID)[1])
          vc.item = {item = item, num = (record.itemAmount)[1], dontShowName = true}
          vc.maxPlayer = record.playerAmount
          vc.level = record.level
        end
        ;
        (table.insert)(self.rewardsList, vc)
        -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  (table.sort)(self.rewardsList, function(v1, v2)
    -- function num : 0_4_0
    if v1.rewardState == v2.rewardState then
      if v1.rewardID >= v2.rewardID then
        do return v1.rewardState >= 2 or v2.rewardState >= 2 end
        do return v2.rewardState < v1.rewardState end
        if v1.rewardID >= v2.rewardID then
          do return v1.rewardState ~= v2.rewardState end
          do return v1.rewardState < v2.rewardState end
          -- DECOMPILER ERROR: 8 unprocessed JMP targets
        end
      end
    end
  end
)
  ;
  (self._frame):ReloadAllCell()
end

InviteAwardListDlg.NumberOfCell = function(self, frame)
  -- function num : 0_5
  if frame == self._frame then
    return #self.rewardsList
  end
end

InviteAwardListDlg.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._frame then
    return "invite.inviteawardcell"
  end
end

InviteAwardListDlg.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._frame then
    return (self.rewardsList)[index]
  end
end

InviteAwardListDlg.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
  local width, height = (self._framePanel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetScrollSize(1)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

InviteAwardListDlg.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

return InviteAwardListDlg

