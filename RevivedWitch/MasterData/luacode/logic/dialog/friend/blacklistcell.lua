-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/blacklistcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BlackListCell = class("BlackListCell", Dialog)
BlackListCell.AssetBundleName = "ui/layouts.friends"
BlackListCell.AssetName = "FriendsBlackListCell"
BlackListCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BlackListCell
  ((BlackListCell.super).Ctor)(self, ...)
end

BlackListCell.OnCreate = function(self)
  -- function num : 0_1
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
  ;
  (self._btnRecover):Subscribe_PointerClickEvent(self.OnRecoverClicked, self)
  ;
  (self._playerinfo):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

BlackListCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("friend.playinfotipsdialog")
end

BlackListCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._onlineImg):SetActive(data:IsOnLine())
  ;
  (self._offlineImg):SetActive(not data:IsOnLine())
  if not data:IsOnLine() then
    (self._lastActiveNum):SetText(data:GetStatusStr())
  end
  local imageinfo = data:GetHeadImagePath()
  ;
  (self._id):SetText(data:GetID())
  if imageinfo then
    (self._icon):SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  ;
  (self._level):SetText(data:GetLevel())
  ;
  (self._name):SetText(data:GetName())
  imageinfo = data:GetFrameImagePath()
  if imageinfo then
    (self._frame):SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
end

BlackListCell.OnRecoverClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(40, nil, function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    ((NekoData.BehaviorManager).BM_Friends):RequesRecoverBlackFriend((self._cellData):GetID())
  end
, {}, nil, {})
end

BlackListCell.OnCellClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("friend.playinfotipsdialog")):Init(self._cellData, false)
end

return BlackListCell

