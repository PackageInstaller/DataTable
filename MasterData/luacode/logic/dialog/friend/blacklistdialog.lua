local BlackListDialog = class("BlackListDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
BlackListDialog.AssetBundleName = "ui/layouts.friends"
BlackListDialog.AssetName = "FriendsBlackList"

function BlackListDialog:Ctor(...)
  BlackListDialog.super.Ctor(self, ...)
end

function BlackListDialog:OnCreate()
  self._txtNum = self:GetChild("BlackList/NumPanel/Num")
  self._txtMaxNum = self:GetChild("BlackList/NumPanel/NumMax")
  self._frame = self:GetChild("BlackList/Frame")
  self._listHelper = TableFrame.Create(self._frame, self, true, true, false)
  self._scrollBar = self:GetChild("BlackList/Scrollbar")
  self._scrollBar:SetScrollDirection(3)
  self._empty = self:GetChild("Empty")
  self:SetData()
  LuaNotificationCenter.AddObserver(self, self.SetData, Common.n_FriendIdentityChange, nil)
end

function BlackListDialog:OnDestroy()
  self._listHelper:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BlackListDialog:SetData()
  self._cellInfo = {}
  local allfriends = NekoData.BehaviorManager.BM_Friends:GetAllFriend()
  for id, friend in pairs(allfriends) do
    if friend:IsBlack() then
      table.insert(self._cellInfo, friend)
    end
  end
  self:RefreshUIInfo()
  self._empty:SetActive(#self._cellInfo == 0)
end

function BlackListDialog:RefreshUIInfo()
  self._listHelper:ReloadAllCell()
  self._txtNum:SetText(tostring(#self._cellInfo))
  self._txtMaxNum:SetText(tostring(NekoData.BehaviorManager.BM_Friends:GetMaxtBlackFriendsNum()))
end

function BlackListDialog:NumberOfCell(helper)
  return #self._cellInfo
end

function BlackListDialog:CellAtIndex(helper, index)
  return "friend.blacklistcell"
end

function BlackListDialog:DataAtIndex(helper, index)
  return self._cellInfo[index]
end

function BlackListDialog:OnCurPosChange(frame, proportion)
  if frame == self._listHelper then
    local width, height = self._frame:GetRectSize()
    local total = self._listHelper:GetTotalLength()
    if height < total then
      self._scrollBar:SetActive(true)
      self._scrollBar:SetScrollSize(height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetActive(false)
    end
  end
end

return BlackListDialog
