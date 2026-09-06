local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local CShareReward = BeanManager.GetTableByName("sharesystem.csharereward")
local CInvitationGit = BeanManager.GetTableByName("welfare.cinvitationgit")
local Item = require("logic.manager.experimental.types.item")
local InviteShareDialog = class("InviteShareDialog", Dialog)
InviteShareDialog.AssetBundleName = "ui/layouts.welfare"
InviteShareDialog.AssetName = "ReturnWelfareInviteFace"

function InviteShareDialog:Ctor(...)
  InviteShareDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function InviteShareDialog:OnCreate()
  DialogManager.GetGroup("ClickEffect"):SetObjectActive(false)
  self._playerInfo = self:GetChild("PlayerInfo")
  self._head = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("PlayerInfo/NameBack/Name")
  self._invideCode = self:GetChild("IDNum")
  self._text = self:GetChild("IDTxt")
  self._tips = self:GetChild("TipsText")
  self._backImg = self:GetChild("Image/BackImage")
  local record = CInvitationGit:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.invitePlayerReturn)
  if record then
    local imageRecord = cimagepath:GetRecorder(record.publicityMap) or DataCommon.DefaultImageAsset
    self._backImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("InviteShareDialog", "invitation id %s is not in cinvitationgit. back image change failed", NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.invitePlayerReturn)
  end
end

function InviteShareDialog:ShowShareInfo(show)
  self._playerInfo:SetActive(show)
  self._text:SetActive(show)
  self._tips:SetActive(show)
end

function InviteShareDialog:Init(showShareInfo, invideCode, shared)
  if showShareInfo then
    self:ShowShareInfo(showShareInfo)
    local userData = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
    local headPhotoRecord = HeadPhotoTable:GetRecorder(userData.avatarId)
    if headPhotoRecord then
      local imageRecord = cimagepath:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
      self._head:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      self._head:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
      LogErrorFormat("RankCell", "headPhotoRecord not found. avatarId = %s", userData.avatarId)
    end
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userData.frameId)
    if headPhotoFrameRecord then
      local imageRecord = cimagepath:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
      self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      self._frame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    end
    self._name:SetText(userData.username)
    self._invideCode:SetText(invideCode)
  else
    self:ShowShareInfo(false)
  end
  self._runner = self:GetRootWindow():GetUIObject():AddComponent(typeof(CS.PixelNeko.Tools.ScreenShot))
  self._runner:StartCoroutine(xLuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
    local plat = CS.PixelNeko.LuaManager.GetSystemType()
    local systemType = require("protocols.bean.protocol.common.systemtype")
    local getTextureCount = 0
    if plat == systemType.IOS then
      local path = CS.PixelNeko.Tools.ScreenShotHelper.CaptureToFile(os.time() .. ".png")
      self._shareTimer = GameTimer.AddTask(0.2, 0.1, function()
        getTextureCount = getTextureCount + 1
        local texture = CS.PixelNeko.Tools.ExternalImageLoaderHelper.GetTexture(path)
        if texture or getTextureCount >= DataCommon.GetTextureCount then
          LogInfoFormat("InviteShareDialog", "--- getTextureCount = %s, texture = %s, GetTextureCount = %s ---", getTextureCount, texture, DataCommon.GetTextureCount)
          DialogManager.CreateSingletonDialog("invite.inviteshareshotdlg"):SetData(texture, shared)
          if self._shareTimer then
            GameTimer.RemoveTask(self._shareTimer)
            self._shareTimer = nil
          end
          self._canShare = true
          self:Destroy()
        end
      end, nil, true)
    else
      local texture = CS.UnityEngine.ScreenCapture.CaptureScreenshotAsTexture()
      self._shareTimer = GameTimer.AddTask(0.2, 0, function()
        DialogManager.CreateSingletonDialog("invite.inviteshareshotdlg"):SetData(texture, shared)
        self._shareTimer = nil
        self._canShare = true
        self:Destroy()
      end)
    end
  end))
end

function InviteShareDialog:OnDestroy()
  if self._shareTimer then
    GameTimer.RemoveTask(self._shareTimer)
    self._shareTimer = nil
  end
end

return InviteShareDialog
