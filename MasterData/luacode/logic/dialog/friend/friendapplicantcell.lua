local FriendApplicantCell = class("FriendApplicantCell", Dialog)
FriendApplicantCell.AssetBundleName = "ui/layouts.friends"
FriendApplicantCell.AssetName = "FriendApplicationCell"

function FriendApplicantCell:Ctor(...)
  FriendApplicantCell.super.Ctor(self, ...)
end

function FriendApplicantCell:OnCreate()
  self._playerinfo = self:GetChild("PlayerInfo")
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._name = self:GetChild("PlayerInfo/NameBack/Name")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._btnAgree = self:GetChild("AgreeBtn")
  self._btnRefuse = self:GetChild("RefuseBtn")
  self._onLineImg = self:GetChild("OnLineImg")
  self._offLineImg = self:GetChild("OffLineImg")
  self._lastActiveNum = self:GetChild("OffLineImg/Text")
  self._id = self:GetChild("IDNum")
  self._btnAgree:Subscribe_PointerClickEvent(self.OnAgreeClicked, self)
  self._btnRefuse:Subscribe_PointerClickEvent(self.OnRefuseClicked, self)
  self._playerinfo:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function FriendApplicantCell:OnDestroy()
  DialogManager.DestroySingletonDialog("friend.playinfotipsdialog")
end

function FriendApplicantCell:RefreshCell(data)
  local imageinfo = data:GetHeadImagePath()
  if imageinfo then
    self._icon:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  imageinfo = data:GetFrameImagePath()
  if imageinfo then
    self._frame:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  self._id:SetText(data:GetID())
  self._level:SetText(data:GetLevel())
  self._name:SetText(data:GetName())
  self._onLineImg:SetActive(data:IsOnLine())
  self._offLineImg:SetActive(not data:IsOnLine())
  if not data:IsOnLine() then
    self._lastActiveNum:SetText(data:GetStatusStr())
  end
end

function FriendApplicantCell:OnAgreeClicked()
  NekoData.BehaviorManager.BM_Friends:ResponseApplicant(self._cellData:GetID(), 1)
end

function FriendApplicantCell:OnRefuseClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(18, nil, function()
    NekoData.BehaviorManager.BM_Friends:ResponseApplicant(self._cellData:GetID(), 0)
  end, {}, nil, {})
end

function FriendApplicantCell:OnCellClicked()
  DialogManager.CreateSingletonDialog("friend.playinfotipsdialog"):Init(self._cellData, false)
end

return FriendApplicantCell
