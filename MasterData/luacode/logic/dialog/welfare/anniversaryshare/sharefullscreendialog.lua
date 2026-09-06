local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local ShareFullScreenDialog = class("ShareFullScreenDialog", Dialog)
ShareFullScreenDialog.AssetBundleName = "ui/layouts.welfare"
ShareFullScreenDialog.AssetName = "ActivityShareWelfareFullScreen"

function ShareFullScreenDialog:Ctor(...)
  ShareFullScreenDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShareFullScreenDialog:OnCreate()
  self._backImage = self:GetChild("Image/BackImage")
  self._playerName = self:GetChild("Image/PlayerInfo/NameBack/Name")
  self._playerID = self:GetChild("Image/PlayerInfo/IDFrame/ID")
  self._playerPhoto = self:GetChild("Image/PlayerInfo/HeadPhoto/Photo")
  self._playerFrame = self:GetChild("Image/PlayerInfo/HeadPhoto/Frame")
  self._text = self:GetChild("Image/TxtFrame/Txt1/Text")
  self:SetData()
end

function ShareFullScreenDialog:OnDestroy()
  if self._shareTimer then
    GameTimer.RemoveTask(self._shareTimer)
    self._shareTimer = nil
  end
end

function ShareFullScreenDialog:SetData(data)
  self._dm = NekoData.DataManager.DM_AnniversaryShare
  self._bm = NekoData.BehaviorManager.BM_AnniversaryShare
  local textID = self._bm:GetImgToTextID()
  if 0 < textID then
    self._text:SetText(TextManager.GetText(textID))
  else
    self._text:SetText("")
  end
  local imageRecord = CImagePathTable:GetRecorder(self._bm:GetPictureID()) or DataCommon.DefaultImageAsset
  self._backImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  self._playerID:SetText(tostring(userInfo.userid))
  self._playerName:SetText(tostring(userInfo.username))
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._playerPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._playerFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  DialogManager.GetGroup("ClickEffect"):SetObjectActive(false)
  self._runner = self:GetRootWindow():GetUIObject():AddComponent(typeof(CS.PixelNeko.Tools.ScreenShot))
  self._runner:StartCoroutine(xLuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.25))
    local plat = CS.PixelNeko.LuaManager.GetSystemType()
    local systemType = require("protocols.bean.protocol.common.systemtype")
    local getTextureCount = 0
    if plat == systemType.IOS then
      local path = CS.PixelNeko.Tools.ScreenShotHelper.CaptureToFile(os.time() .. ".png")
      self._shareTimer = GameTimer.AddTask(0.2, 0.1, function()
        getTextureCount = getTextureCount + 1
        local texture = CS.PixelNeko.Tools.ExternalImageLoaderHelper.GetTexture(path)
        if texture or getTextureCount >= DataCommon.GetTextureCount then
          LogInfoFormat("ShareFullScreenDialog", "--- getTextureCount = %s, texture = %s, GetTextureCount = %s ---", getTextureCount, texture, DataCommon.GetTextureCount)
          DialogManager.CreateSingletonDialog("welfare.anniversaryshare.shareresultdialog"):SetData(texture)
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
        DialogManager.CreateSingletonDialog("welfare.anniversaryshare.shareresultdialog"):SetData(texture)
        self._shareTimer = nil
        self._canShare = true
        self:Destroy()
      end)
    end
  end))
end

function ShareFullScreenDialog:OnBackBtnClicked()
  self:Destroy()
end

return ShareFullScreenDialog
