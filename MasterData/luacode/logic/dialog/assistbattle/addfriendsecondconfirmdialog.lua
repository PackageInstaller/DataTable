local CStringres = BeanManager.GetTableByName("message.cstringres")
local AddFriendSecondConfirmDialog = class("AddFriendSecondConfirmDialog", Dialog)
AddFriendSecondConfirmDialog.AssetBundleName = "ui/layouts.teamedit"
AddFriendSecondConfirmDialog.AssetName = "ChooseAssistSecondConfirm1"

function AddFriendSecondConfirmDialog:Ctor(...)
  AddFriendSecondConfirmDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._confirmFunc = nil
end

function AddFriendSecondConfirmDialog:OnCreate()
  self._text = self:GetChild("Text")
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._frame = self:GetChild("CharSmallCell/Frame")
  self._photo = self:GetChild("CharSmallCell/Photo")
  self._downRankBack = self:GetChild("CharSmallCell/DownRankBack")
  self._level = self:GetChild("CharSmallCell/Level/Num")
  self._rankBack = self:GetChild("CharSmallCell/RankBack")
  self._rank = self:GetChild("CharSmallCell/Rank")
  self._job = self:GetChild("CharSmallCell/Job")
  self._breakLevelBackBlack = self:GetChild("CharSmallCell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("CharSmallCell/BreakLevelBack")
  self._breakLevelNum = self:GetChild("CharSmallCell/BreakLevelNum")
  self._breakLevel = self:GetChild("CharSmallCell/BreakLevel")
  self._element = self:GetChild("CharSmallCell/Element")
  self._grey = self:GetChild("CharSmallCell/Grey")
  self._select = self:GetChild("CharSmallCell/Select")
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
  self:Init()
end

function AddFriendSecondConfirmDialog:OnDestroy()
end

function AddFriendSecondConfirmDialog:Init()
  local supportRoleInfo = NekoData.BehaviorManager.BM_Team:GetSupportRole()
  local role = supportRoleInfo.role
  local image = role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  image = role:GetRarityBottomBackRecord()
  self._downRankBack:SetSprite(image.assetBundle, image.assetName)
  self._level:SetText(role:GetShowLv())
  image = role:GetRarityImageRecord()
  self._rank:SetSprite(image.assetBundle, image.assetName)
  image = role:GetVocationImageRecord()
  self._job:SetSprite(image.assetBundle, image.assetName)
  local breakLv = role:GetBreakLv()
  self._breakLevelBackBlack:SetActive(breakLv == 0)
  self._breakLevelBack:SetActive(0 < breakLv)
  self._breakLevelNum:SetActive(0 < breakLv)
  if 0 < breakLv then
    image = role:GetCurBreakFrame1ImageRecord()
    self._breakLevelBack:SetSprite(image.assetBundle, image.assetName)
    self._breakLevelNum:SetText(breakLv)
  end
  image = role:GetElementImageRecord()
  self._element:SetSprite(image.assetBundle, image.assetName)
  local str = TextManager.GetText(CStringres:GetRecorder(1080).msgTextID)
  self._text:SetText(string.gsub(str, "%$parameter1%$", supportRoleInfo.user:GetName()))
end

function AddFriendSecondConfirmDialog:SetConfirmFunc(func)
  self._confirmFunc = func
end

function AddFriendSecondConfirmDialog:OnBackBtnClicked()
  self:Destroy()
end

function AddFriendSecondConfirmDialog:OnClickConfirmBtn()
  self._confirmFunc()
  self._confirmFunc = nil
  self:Destroy()
end

return AddFriendSecondConfirmDialog
