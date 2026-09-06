local CStringRes = BeanManager.GetTableByName("message.cstringres")
local FriendCell = class("FriendCell", Dialog)
FriendCell.AssetBundleName = "ui/layouts.friends"
FriendCell.AssetName = "FriendsListCell"

function FriendCell:Ctor(...)
  FriendCell.super.Ctor(self, ...)
end

function FriendCell:OnCreate()
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._name = self:GetChild("PlayerInfo/NameBack/Name")
  self._status = self:GetChild("PlayerInfo/OnLineTxt")
  self._onlineImg = self:GetChild("PlayerInfo/OnLineImg")
  self._offlineImg = self:GetChild("PlayerInfo/OffLineImg")
  self._lastActiveNum = self:GetChild("PlayerInfo/OffLineImg/Text")
  self._id = self:GetChild("IDNum")
  self._wndSelect = self:GetChild("Select")
  self._redIcon = self:GetChild("RedDot")
  self._click = self:GetChild("PlayerInfoClick")
  self._thumbsUpBtn = self:GetChild("ThumbsUpBtn")
  self._heart1 = self:GetChild("Heart")
  self._heart2 = self:GetChild("Heart2")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._click:Subscribe_PointerClickEvent(self.OnPlayerInfoClicked, self)
  self._thumbsUpBtn:Subscribe_PointerClickEvent(self.OnThumbsUpClicked, self)
end

function FriendCell:OnDestroy()
  DialogManager.DestroySingletonDialog("friend.playinfotipsdialog")
end

function FriendCell:RefreshCell(data)
  local imageinfo = data:GetHeadImagePath()
  if imageinfo then
    self._icon:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  self._onlineImg:SetActive(data:IsOnLine())
  self._offlineImg:SetActive(not data:IsOnLine())
  if not data:IsOnLine() then
    self._lastActiveNum:SetText(data:GetStatusStr())
  end
  self._level:SetText(data:GetLevel())
  local userNameStr
  if data:GetSpiritVip() == 1 then
    userNameStr = NekoData.BehaviorManager.BM_Message:GetString(2090, {
      data:GetName()
    })
  else
    userNameStr = data:GetName()
  end
  self._name:SetText(userNameStr)
  self._id:SetText(data:GetID())
  self._wndSelect:SetActive(data:GetID() == self._delegate._selectID)
  self._redIcon:SetActive(NekoData.BehaviorManager.BM_FriendsChat:GetNotReadNum(data:GetID()) > 0)
  self._thumbsUpBtn:SetSelected(data:GetLikeStatus() ~= 0)
  if data:GetSparkStatus() == 0 then
    self._heart1:SetActive(false)
    self._heart2:SetActive(false)
  else
    self._heart1:SetActive(data:GetSparkStatus() == 1)
    self._heart2:SetActive(data:GetSparkStatus() == 2)
  end
end

function FriendCell:OnEvent(eventName, friendid)
  if eventName == "RefreshSelectFriend" then
    self._wndSelect:SetActive(self._cellData:GetID() == friendid)
  elseif eventName == "NewMsgReceive" then
    if self._cellData:GetID() == friendid then
      self._redIcon:SetActive(true)
    end
  elseif eventName == "chatnumchange" then
    if self._cellData:GetID() == friendid then
      self._redIcon:SetActive(NekoData.BehaviorManager.BM_FriendsChat:GetNotReadNum(self._cellData:GetID()) > 0)
    end
  elseif eventName == "LikeFriends" then
    if friendid == -1 then
      self._thumbsUpBtn:SetSelected(true)
      return
    end
    if self._cellData:GetID() == friendid then
      self._thumbsUpBtn:SetSelected(true)
    end
  elseif eventName == "ShowPark" and self._cellData:GetID() == friendid then
    self._heart1:SetActive(false)
    self._heart2:SetActive(true)
  end
end

function FriendCell:OnCellClicked()
  if self._cellData:GetID() == self._delegate._selectID then
    return
  end
  self._delegate:SetSelectFriendInfo(self._cellData)
end

function FriendCell:OnPlayerInfoClicked()
  DialogManager.CreateSingletonDialog("friend.playinfotipsdialog"):Init(self._cellData, true)
  if self._cellData:GetID() == self._delegate._selectID then
    return
  end
  self._delegate:SetSelectFriendInfo(self._cellData)
end

function FriendCell:OnThumbsUpClicked()
  if self._cellData:GetLikeStatus() ~= 0 then
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clikefriends")
  protocol.userId = self._cellData:GetID()
  protocol:Send()
end

return FriendCell
