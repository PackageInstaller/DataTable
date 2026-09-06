local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local InvitePlayerCell = class("InvitePlayerCell", Dialog)
InvitePlayerCell.AssetBundleName = "ui/layouts.invite"
InvitePlayerCell.AssetName = "InvitePlayerCell"

function InvitePlayerCell:Ctor(...)
  InvitePlayerCell.super.Ctor(self, ...)
end

function InvitePlayerCell:OnCreate()
  self._head = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("PlayerInfo/NameBack/Name")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._uid = self:GetChild("IDNum")
  self._isFriend = self:GetChild("Type1")
  self._hasApplied = self:GetChild("Type2")
  self._addBtn = self:GetChild("AddBtn")
  self._addBtn:Subscribe_PointerClickEvent(self.AddFriend, self)
end

function InvitePlayerCell:RefreshCell(data)
  self._data = data
  local type = data.identity
  self._hasApplied:SetActive(false)
  if type == 1 then
    self._isFriend:SetActive(true)
    self._addBtn:SetActive(false)
    self._hasApplied:SetActive(false)
  elseif type == 6 then
    self._isFriend:SetActive(false)
    self._addBtn:SetActive(true)
    self._hasApplied:SetActive(false)
  elseif type == 5 then
    self._addBtn:SetActive(false)
    self._hasApplied:SetActive(true)
    self._isFriend:SetActive(false)
  end
  local userData = data.baseUserData
  self._uid:SetText(userData.userId)
  self._level:SetText(userData.userLv)
  self._name:SetText(userData.userName)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userData.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._head:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._head:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("RankCell", "headPhotoRecord not found. avatarId = %s", userData.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userData.frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._frame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("RankCell", "headPhotoFrameRecord not found. frameId = %s", userData.frameId)
  end
end

function InvitePlayerCell:AddFriend()
  local cmd = LuaNetManager.CreateProtocol("protocol.chat.caddfriend")
  cmd.userId = self._data and self._data.baseUserData.userId
  cmd:Send()
  self._data.identity = 5
  self:RefreshCell(self._data)
end

return InvitePlayerCell
