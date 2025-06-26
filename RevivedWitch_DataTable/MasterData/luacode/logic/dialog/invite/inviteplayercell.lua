-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/invite/inviteplayercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local InvitePlayerCell = class("InvitePlayerCell", Dialog)
InvitePlayerCell.AssetBundleName = "ui/layouts.invite"
InvitePlayerCell.AssetName = "InvitePlayerCell"
InvitePlayerCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InvitePlayerCell
  ((InvitePlayerCell.super).Ctor)(self, ...)
end

InvitePlayerCell.OnCreate = function(self)
  -- function num : 0_1
  self._head = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("PlayerInfo/NameBack/Name")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._uid = self:GetChild("IDNum")
  self._isFriend = self:GetChild("Type1")
  self._hasApplied = self:GetChild("Type2")
  self._addBtn = self:GetChild("AddBtn")
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.AddFriend, self)
end

InvitePlayerCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : HeadPhotoTable, CImagePathTable, _ENV, HeadPhotoFrameTable
  self._data = data
  local type = data.identity
  ;
  (self._hasApplied):SetActive(false)
  if type == 1 then
    (self._isFriend):SetActive(true)
    ;
    (self._addBtn):SetActive(false)
    ;
    (self._hasApplied):SetActive(false)
  else
    if type == 6 then
      (self._isFriend):SetActive(false)
      ;
      (self._addBtn):SetActive(true)
      ;
      (self._hasApplied):SetActive(false)
    else
      if type == 5 then
        (self._addBtn):SetActive(false)
        ;
        (self._hasApplied):SetActive(true)
        ;
        (self._isFriend):SetActive(false)
      end
    end
  end
  local userData = data.baseUserData
  ;
  (self._uid):SetText(userData.userId)
  ;
  (self._level):SetText(userData.userLv)
  ;
  (self._name):SetText(userData.userName)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userData.avatarId)
  if headPhotoRecord then
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._head):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      ;
      (self._head):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
      LogErrorFormat("RankCell", "headPhotoRecord not found. avatarId = %s", userData.avatarId)
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userData.frameId)
      if headPhotoFrameRecord then
        if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        do
          ;
          (self._frame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
          LogErrorFormat("RankCell", "headPhotoFrameRecord not found. frameId = %s", userData.frameId)
        end
      end
    end
  end
end

InvitePlayerCell.AddFriend = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local cmd = (LuaNetManager.CreateProtocol)("protocol.chat.caddfriend")
  if self._data then
    cmd.userId = ((self._data).baseUserData).userId
    cmd:Send()
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._data).identity = 5
    self:RefreshCell(self._data)
  end
end

return InvitePlayerCell

