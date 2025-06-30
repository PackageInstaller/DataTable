-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/favourgiftdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 4
local CFavourExp = (BeanManager.GetTableByName)("role.cfavourexp")
local FavourGiftDialog = class("FavourGiftDialog", Dialog)
FavourGiftDialog.AssetBundleName = "ui/layouts.tujian"
FavourGiftDialog.AssetName = "FavourGift"
FavourGiftDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FavourGiftDialog
  ((FavourGiftDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._giftList = {}
end

FavourGiftDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, _ENV
  self._title = self:GetChild("BackImage/Title")
  self._closeBtn = self:GetChild("BackImage/BackBtn")
  self._scrollBar = self:GetChild("BackImage/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._giftPanel = self:GetChild("BackImage/Frame")
  self._giftFrame = (TableFrame.Create)(self._giftPanel, self, true, true, true)
  self._width = (self._giftPanel):GetRectSize()
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshReceiveAward, Common.n_RoleGoodReceiveAward, nil)
end

FavourGiftDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._giftFrame):Destroy()
end

FavourGiftDialog.OnRefreshReceiveAward = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV
  local protocol = notification.userInfo
  if protocol.roleId == (self._role):GetId() then
    self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(protocol.roleId)
    self._giftList = (self._role):GetRelationRewardList()
    for i,v in ipairs(self._giftList) do
      if v.favourLv == protocol.level then
        (self._giftFrame):ReloadCellsAtIndex({i})
        break
      end
    end
  end
end

FavourGiftDialog.SetData = function(self, roleId)
  -- function num : 0_4 , upvalues : _ENV
  self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
  self._curFavourLv = (self._role):GetRelationLevel()
  local name = (self._role):GetRoleName()
  ;
  (self._title):SetText((string.gsub)((TextManager.GetText)(502722), "%$parameter1%$", name))
  self._giftList = (self._role):GetRelationRewardList()
  local firstCanReceiveAwardIndex = nil
  for i,v in ipairs(self._giftList) do
    if v.favourLv <= self._curFavourLv and not v.received then
      firstCanReceiveAwardIndex = i
      break
    end
  end
  do
    ;
    (self._giftFrame):ReloadAllCell()
    if firstCanReceiveAwardIndex then
      (self._giftFrame):MoveTopToIndex(firstCanReceiveAwardIndex)
    else
      ;
      (self._giftFrame):MoveToTop()
    end
  end
end

FavourGiftDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._giftList
end

FavourGiftDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "handbook.favour.favourgiftcell"
end

FavourGiftDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._giftList)[index]
end

FavourGiftDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
  local total = (self._giftFrame):GetTotalLength()
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

FavourGiftDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

return FavourGiftDialog

