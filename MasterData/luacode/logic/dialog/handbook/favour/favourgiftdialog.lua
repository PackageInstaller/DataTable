local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 4
local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local FavourGiftDialog = class("FavourGiftDialog", Dialog)
FavourGiftDialog.AssetBundleName = "ui/layouts.tujian"
FavourGiftDialog.AssetName = "FavourGift"

function FavourGiftDialog:Ctor(...)
  FavourGiftDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._giftList = {}
end

function FavourGiftDialog:OnCreate()
  self._title = self:GetChild("BackImage/Title")
  self._closeBtn = self:GetChild("BackImage/BackBtn")
  self._scrollBar = self:GetChild("BackImage/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._giftPanel = self:GetChild("BackImage/Frame")
  self._giftFrame = TableFrame.Create(self._giftPanel, self, true, true, true)
  self._width, self._height = self._giftPanel:GetRectSize()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshReceiveAward, Common.n_RoleGoodReceiveAward, nil)
end

function FavourGiftDialog:OnDestroy()
  self._giftFrame:Destroy()
end

function FavourGiftDialog:OnRefreshReceiveAward(notification)
  local protocol = notification.userInfo
  if protocol.roleId == self._role:GetId() then
    self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(protocol.roleId)
    self._giftList = self._role:GetRelationRewardList()
    for i, v in ipairs(self._giftList) do
      if v.favourLv == protocol.level then
        self._giftFrame:ReloadCellsAtIndex({i})
        break
      end
    end
  end
end

function FavourGiftDialog:SetData(roleId)
  self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  self._curFavourLv = self._role:GetRelationLevel()
  local name = self._role:GetRoleName()
  self._title:SetText(string.gsub(TextManager.GetText(502722), "%$parameter1%$", name))
  self._giftList = self._role:GetRelationRewardList()
  local firstCanReceiveAwardIndex
  for i, v in ipairs(self._giftList) do
    if v.favourLv <= self._curFavourLv and not v.received then
      firstCanReceiveAwardIndex = i
      break
    end
  end
  self._giftFrame:ReloadAllCell()
  if firstCanReceiveAwardIndex then
    self._giftFrame:MoveTopToIndex(firstCanReceiveAwardIndex)
  else
    self._giftFrame:MoveToTop()
  end
end

function FavourGiftDialog:NumberOfCell(frame)
  return #self._giftList
end

function FavourGiftDialog:CellAtIndex(frame, index)
  return "handbook.favour.favourgiftcell"
end

function FavourGiftDialog:DataAtIndex(frame, index)
  return self._giftList[index]
end

function FavourGiftDialog:OnCurPosChange(frame, proportion)
  local total = self._giftFrame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function FavourGiftDialog:OnBackBtnClicked()
  self:Destroy()
end

return FavourGiftDialog
