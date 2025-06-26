-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/blacklistdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BlackListDialog = class("BlackListDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
BlackListDialog.AssetBundleName = "ui/layouts.friends"
BlackListDialog.AssetName = "FriendsBlackList"
BlackListDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BlackListDialog
  ((BlackListDialog.super).Ctor)(self, ...)
end

BlackListDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._txtNum = self:GetChild("BlackList/NumPanel/Num")
  self._txtMaxNum = self:GetChild("BlackList/NumPanel/NumMax")
  self._frame = self:GetChild("BlackList/Frame")
  self._listHelper = (TableFrame.Create)(self._frame, self, true, true, false)
  self._scrollBar = self:GetChild("BlackList/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(3)
  self._empty = self:GetChild("Empty")
  self:SetData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetData, Common.n_FriendIdentityChange, nil)
end

BlackListDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._listHelper):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

BlackListDialog.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._cellInfo = {}
  local allfriends = ((NekoData.BehaviorManager).BM_Friends):GetAllFriend()
  for id,friend in pairs(allfriends) do
    if friend:IsBlack() then
      (table.insert)(self._cellInfo, friend)
    end
  end
  self:RefreshUIInfo()
  ;
  (self._empty):SetActive(#self._cellInfo == 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BlackListDialog.RefreshUIInfo = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._listHelper):ReloadAllCell()
  ;
  (self._txtNum):SetText(tostring(#self._cellInfo))
  ;
  (self._txtMaxNum):SetText(tostring(((NekoData.BehaviorManager).BM_Friends):GetMaxtBlackFriendsNum()))
end

BlackListDialog.NumberOfCell = function(self, helper)
  -- function num : 0_5
  return #self._cellInfo
end

BlackListDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_6
  return "friend.blacklistcell"
end

BlackListDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_7
  return (self._cellInfo)[index]
end

BlackListDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
  if frame == self._listHelper then
    local width, height = (self._frame):GetRectSize()
    local total = (self._listHelper):GetTotalLength()
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
end

return BlackListDialog

