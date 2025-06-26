-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/inviteshareresultdlg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local CShareReward = (BeanManager.GetTableByName)("sharesystem.csharereward")
local CInvitationGit = (BeanManager.GetTableByName)("welfare.cinvitationgit")
local Item = require("logic.manager.experimental.types.item")
local InviteShareDialog = class("InviteShareDialog", Dialog)
InviteShareDialog.AssetBundleName = "ui/layouts.welfare"
InviteShareDialog.AssetName = "ReturnWelfareInviteFace"
InviteShareDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InviteShareDialog
  ((InviteShareDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

InviteShareDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CInvitationGit, cimagepath
  ((DialogManager.GetGroup)("ClickEffect")):SetObjectActive(false)
  self._qrcode = self:GetChild("Image/Code")
  self._playerInfo = self:GetChild("PlayerInfo")
  self._head = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("PlayerInfo/NameBack/Name")
  self._invideCode = self:GetChild("IDNum")
  self._text = self:GetChild("IDTxt")
  self._tips = self:GetChild("TipsText")
  self._backImg = self:GetChild("Image/BackImage")
  local record = CInvitationGit:GetRecorder((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).invitePlayerReturn)
  if record then
    if not cimagepath:GetRecorder(record.publicityMap) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._backImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      LogErrorFormat("InviteShareDialog", "invitation id %s is not in cinvitationgit. back image change failed", (((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).invitePlayerReturn)
      local qrCodeID = ((NekoData.BehaviorManager).BM_Gacha):GetShareQRCodeID()
      if qrCodeID == -1 then
        (self._qrcode):SetActive(false)
      else
        local img = cimagepath:GetRecorder(qrCodeID)
        ;
        (self._qrcode):SetSprite(img.assetBundle, img.assetName)
      end
    end
  end
end

InviteShareDialog.ShowShareInfo = function(self, show)
  -- function num : 0_2
  (self._playerInfo):SetActive(show)
  ;
  (self._text):SetActive(show)
  ;
  (self._tips):SetActive(show)
end

InviteShareDialog.Init = function(self, showShareInfo, invideCode, shared)
  -- function num : 0_3 , upvalues : _ENV, HeadPhotoTable, cimagepath, HeadPhotoFrameTable
  if showShareInfo then
    self:ShowShareInfo(showShareInfo)
    local userData = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
    local headPhotoRecord = HeadPhotoTable:GetRecorder(userData.avatarId)
    if headPhotoRecord then
      if not cimagepath:GetRecorder(headPhotoRecord.photoid) then
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
          if not cimagepath:GetRecorder(headPhotoFrameRecord.photoid) then
            local imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          do
            do
              ;
              (self._frame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
              ;
              (self._name):SetText(userData.username)
              ;
              (self._invideCode):SetText(invideCode)
              self:ShowShareInfo(false)
              self._runner = ((self:GetRootWindow()):GetUIObject()):AddComponent(typeof(((CS.PixelNeko).Tools).ScreenShot))
              ;
              (self._runner):StartCoroutine((xLuaUtil.cs_generator)(function()
    -- function num : 0_3_0 , upvalues : _ENV, self, shared
    (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(0.5))
    local plat = (((CS.PixelNeko).LuaManager).GetSystemType)()
    local systemType = require("protocols.bean.protocol.common.systemtype")
    local getTextureCount = 0
    if plat == systemType.IOS then
      local path = ((((CS.PixelNeko).Tools).ScreenShotHelper).CaptureToFile)((os.time)() .. ".png")
      do
        self._shareTimer = (GameTimer.AddTask)(0.2, 0.1, function()
      -- function num : 0_3_0_0 , upvalues : getTextureCount, _ENV, path, shared, self
      getTextureCount = getTextureCount + 1
      local texture = ((((CS.PixelNeko).Tools).ExternalImageLoaderHelper).GetTexture)(path)
      if texture or DataCommon.GetTextureCount <= getTextureCount then
        LogInfoFormat("InviteShareDialog", "--- getTextureCount = %s, texture = %s, GetTextureCount = %s ---", getTextureCount, texture, DataCommon.GetTextureCount)
        ;
        ((DialogManager.CreateSingletonDialog)("invite.inviteshareshotdlg")):SetData(texture, shared)
        if self._shareTimer then
          (GameTimer.RemoveTask)(self._shareTimer)
          self._shareTimer = nil
        end
        self._canShare = true
        self:Destroy()
      end
    end
, nil, true)
      end
    else
      do
        local texture = (((CS.UnityEngine).ScreenCapture).CaptureScreenshotAsTexture)()
        self._shareTimer = (GameTimer.AddTask)(0.2, 0, function()
      -- function num : 0_3_0_1 , upvalues : _ENV, texture, shared, self
      ((DialogManager.CreateSingletonDialog)("invite.inviteshareshotdlg")):SetData(texture, shared)
      self._shareTimer = nil
      self._canShare = true
      self:Destroy()
    end
)
      end
    end
  end
))
            end
          end
        end
      end
    end
  end
end

InviteShareDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._shareTimer then
    (GameTimer.RemoveTask)(self._shareTimer)
    self._shareTimer = nil
  end
end

return InviteShareDialog

