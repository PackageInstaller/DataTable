-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/assistbattle/addfriendsecondconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local AddFriendSecondConfirmDialog = class("AddFriendSecondConfirmDialog", Dialog)
AddFriendSecondConfirmDialog.AssetBundleName = "ui/layouts.teamedit"
AddFriendSecondConfirmDialog.AssetName = "ChooseAssistSecondConfirm1"
AddFriendSecondConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AddFriendSecondConfirmDialog
  ((AddFriendSecondConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._confirmFunc = nil
end

AddFriendSecondConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
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
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
  self:Init()
end

AddFriendSecondConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2
end

AddFriendSecondConfirmDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringres
  local supportRoleInfo = ((NekoData.BehaviorManager).BM_Team):GetSupportRole()
  local role = supportRoleInfo.role
  local image = role:GetShapeLittleHeadImageRecord()
  ;
  (self._photo):SetSprite(image.assetBundle, image.assetName)
  image = role:GetSmallRarityFrameRecord()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  image = role:GetRarityBottomBackRecord()
  ;
  (self._downRankBack):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._level):SetText(role:GetShowLv())
  image = role:GetRarityImageRecord()
  ;
  (self._rank):SetSprite(image.assetBundle, image.assetName)
  image = role:GetVocationImageRecord()
  ;
  (self._job):SetSprite(image.assetBundle, image.assetName)
  local breakLv = role:GetBreakLv()
  ;
  (self._breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._breakLevelBack):SetActive(breakLv > 0)
  ;
  (self._breakLevelNum):SetActive(breakLv > 0)
  if breakLv > 0 then
    image = role:GetCurBreakFrame1ImageRecord()
    ;
    (self._breakLevelBack):SetSprite(image.assetBundle, image.assetName)
    ;
    (self._breakLevelNum):SetText(breakLv)
  end
  image = role:GetElementImageRecord()
  ;
  (self._element):SetSprite(image.assetBundle, image.assetName)
  local str = (TextManager.GetText)((CStringres:GetRecorder(1080)).msgTextID)
  ;
  (self._text):SetText((string.gsub)(str, "%$parameter1%$", (supportRoleInfo.user):GetName()))
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

AddFriendSecondConfirmDialog.SetConfirmFunc = function(self, func)
  -- function num : 0_4
  self._confirmFunc = func
end

AddFriendSecondConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

AddFriendSecondConfirmDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_6
  (self._confirmFunc)()
  self._confirmFunc = nil
  self:Destroy()
end

return AddFriendSecondConfirmDialog

