local BlackListCell = class("BlackListCell", Dialog)
BlackListCell.AssetBundleName = "ui/layouts.friends"
BlackListCell.AssetName = "FriendsBlackListCell"

function BlackListCell:Ctor(...)
  BlackListCell.super.Ctor(self, ...)
end

function BlackListCell:OnCreate()
  self._id = self:GetChild("IDNum")
  self._playerinfo = self:GetChild("PlayerInfo")
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._name = self:GetChild("PlayerInfo/NameBack/Name")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._onlineImg = self:GetChild("OnLineImg")
  self._offlineImg = self:GetChild("OffLineImg")
  self._lastActiveNum = self:GetChild("OffLineImg/Text")
  self._btnRecover = self:GetChild("RecoverBtn")
  self._btnRecover:Subscribe_PointerClickEvent(self.OnRecoverClicked, self)
  self._playerinfo:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function BlackListCell:OnDestroy()
  DialogManager.DestroySingletonDialog("friend.playinfotipsdialog")
end

function BlackListCell:RefreshCell(data)
  self._onlineImg:SetActive(data:IsOnLine())
  self._offlineImg:SetActive(not data:IsOnLine())
  if not data:IsOnLine() then
    self._lastActiveNum:SetText(data:GetStatusStr())
  end
  local imageinfo = data:GetHeadImagePath()
  self._id:SetText(data:GetID())
  if imageinfo then
    self._icon:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  self._level:SetText(data:GetLevel())
  self._name:SetText(data:GetName())
  imageinfo = data:GetFrameImagePath()
  if imageinfo then
    self._frame:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
end

function BlackListCell:OnRecoverClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(40, nil, function()
    NekoData.BehaviorManager.BM_Friends:RequesRecoverBlackFriend(self._cellData:GetID())
  end, {}, nil, {})
end

function BlackListCell:OnCellClicked()
  DialogManager.CreateSingletonDialog("friend.playinfotipsdialog"):Init(self._cellData, false)
end

return BlackListCell
