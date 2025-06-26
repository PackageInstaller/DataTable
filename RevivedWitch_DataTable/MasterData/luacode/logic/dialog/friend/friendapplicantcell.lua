-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/friendapplicantcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FriendApplicantCell = class("FriendApplicantCell", Dialog)
FriendApplicantCell.AssetBundleName = "ui/layouts.friends"
FriendApplicantCell.AssetName = "FriendApplicationCell"
FriendApplicantCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FriendApplicantCell
  ((FriendApplicantCell.super).Ctor)(self, ...)
end

FriendApplicantCell.OnCreate = function(self)
  -- function num : 0_1
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
  ;
  (self._btnAgree):Subscribe_PointerClickEvent(self.OnAgreeClicked, self)
  ;
  (self._btnRefuse):Subscribe_PointerClickEvent(self.OnRefuseClicked, self)
  ;
  (self._playerinfo):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

FriendApplicantCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("friend.playinfotipsdialog")
end

FriendApplicantCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local imageinfo = data:GetHeadImagePath()
  if imageinfo then
    (self._icon):SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  imageinfo = data:GetFrameImagePath()
  if imageinfo then
    (self._frame):SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  ;
  (self._id):SetText(data:GetID())
  ;
  (self._level):SetText(data:GetLevel())
  ;
  (self._name):SetText(data:GetName())
  ;
  (self._onLineImg):SetActive(data:IsOnLine())
  ;
  (self._offLineImg):SetActive(not data:IsOnLine())
  if not data:IsOnLine() then
    (self._lastActiveNum):SetText(data:GetStatusStr())
  end
end

FriendApplicantCell.OnAgreeClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Friends):ResponseApplicant((self._cellData):GetID(), 1)
end

FriendApplicantCell.OnRefuseClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(18, nil, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    ((NekoData.BehaviorManager).BM_Friends):ResponseApplicant((self._cellData):GetID(), 0)
  end
, {}, nil, {})
end

FriendApplicantCell.OnCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("friend.playinfotipsdialog")):Init(self._cellData, false)
end

return FriendApplicantCell

