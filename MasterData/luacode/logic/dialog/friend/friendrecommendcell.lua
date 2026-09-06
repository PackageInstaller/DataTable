local FriendRecommendCell = class("FriendRecommendCell", Dialog)
FriendRecommendCell.AssetBundleName = "ui/layouts.friends"
FriendRecommendCell.AssetName = "FriendsSearchResultCell"

function FriendRecommendCell:Ctor(...)
  FriendRecommendCell.super.Ctor(self, ...)
end

function FriendRecommendCell:OnCreate()
  self._playerinfo = self:GetChild("PlayerInfo")
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._name = self:GetChild("PlayerInfo/NameBack/Name")
  self._id = self:GetChild("IDNum")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._btnAdd = self:GetChild("AddBtn")
  self._onLineImg = self:GetChild("OnLineImg")
  self._offLineImg = self:GetChild("OffLineImg")
  self._lastActiveNum = self:GetChild("OffLineImg/Text")
  self._btnAdd:Subscribe_PointerClickEvent(self.OnAddClicked, self)
  self._playerinfo:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function FriendRecommendCell:OnDestroy()
  DialogManager.DestroySingletonDialog("friend.playinfotipsdialog")
end

function FriendRecommendCell:RefreshCell(data)
  local imageinfo = data:GetHeadImagePath()
  if imageinfo then
    self._icon:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  imageinfo = data:GetFrameImagePath()
  if imageinfo then
    self._frame:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  self._level:SetText(data:GetLevel())
  self._name:SetText(data:GetName())
  self._id:SetText(data:GetID())
  self._onLineImg:SetActive(data:IsOnLine())
  self._offLineImg:SetActive(not data:IsOnLine())
  if not data:IsOnLine() then
    self._lastActiveNum:SetText(data:GetStatusStr())
  end
  self._hasSendAddFriendProtocol = false
end

function FriendRecommendCell:OnAddClicked()
  if NekoData.BehaviorManager.BM_Game:GetUserId() == self._cellData:GetID() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100043)
    return
  end
  local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(self._cellData:GetID())
  if friend and friend:IsBlack() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100046)
    return
  end
  if friend and friend:IsFriend() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100045)
    return
  end
  NekoData.BehaviorManager.BM_Friends:RequesAddFriend(self._cellData:GetID())
end

function FriendRecommendCell:OnCellClicked()
  DialogManager.CreateSingletonDialog("friend.playinfotipsdialog"):Init(self._cellData, false)
end

return FriendRecommendCell
