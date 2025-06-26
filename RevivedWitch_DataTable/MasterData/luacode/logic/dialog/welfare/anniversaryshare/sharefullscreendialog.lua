-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/anniversaryshare/sharefullscreendialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local ShareFullScreenDialog = class("ShareFullScreenDialog", Dialog)
ShareFullScreenDialog.AssetBundleName = "ui/layouts.welfare"
ShareFullScreenDialog.AssetName = "ActivityShareWelfareFullScreen"
ShareFullScreenDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShareFullScreenDialog
  ((ShareFullScreenDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ShareFullScreenDialog.OnCreate = function(self)
  -- function num : 0_1
  self._backImage = self:GetChild("Image/BackImage")
  self._qrCode = self:GetChild("Image/Code")
  self._playerName = self:GetChild("Image/PlayerInfo/NameBack/Name")
  self._playerID = self:GetChild("Image/PlayerInfo/IDFrame/ID")
  self._playerPhoto = self:GetChild("Image/PlayerInfo/HeadPhoto/Photo")
  self._playerFrame = self:GetChild("Image/PlayerInfo/HeadPhoto/Frame")
  self._text = self:GetChild("Image/TxtFrame/Txt1/Text")
  self:SetData()
end

ShareFullScreenDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._shareTimer then
    (GameTimer.RemoveTask)(self._shareTimer)
    self._shareTimer = nil
  end
end

ShareFullScreenDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable, HeadPhotoTable, HeadPhotoFrameTable
  self._dm = (NekoData.DataManager).DM_AnniversaryShare
  self._bm = (NekoData.BehaviorManager).BM_AnniversaryShare
  local textID = (self._bm):GetImgToTextID()
  if textID > 0 then
    (self._text):SetText((TextManager.GetText)(textID))
  else
    ;
    (self._text):SetText("")
  end
  if not CImagePathTable:GetRecorder((self._bm):GetPictureID()) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._backImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = CImagePathTable:GetRecorder(((NekoData.BehaviorManager).BM_Gacha):GetShareQRCodeID())
  ;
  (self._qrCode):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  ;
  (self._playerID):SetText(tostring(userInfo.userid))
  ;
  (self._playerName):SetText(tostring(userInfo.username))
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._playerPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._playerFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  ((DialogManager.GetGroup)("ClickEffect")):SetObjectActive(false)
  self._runner = ((self:GetRootWindow()):GetUIObject()):AddComponent(typeof(((CS.PixelNeko).Tools).ScreenShot))
  ;
  (self._runner):StartCoroutine((xLuaUtil.cs_generator)(function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(0.25))
    local plat = (((CS.PixelNeko).LuaManager).GetSystemType)()
    local systemType = require("protocols.bean.protocol.common.systemtype")
    local getTextureCount = 0
    if plat == systemType.IOS then
      local path = ((((CS.PixelNeko).Tools).ScreenShotHelper).CaptureToFile)((os.time)() .. ".png")
      do
        self._shareTimer = (GameTimer.AddTask)(0.2, 0.1, function()
      -- function num : 0_3_0_0 , upvalues : getTextureCount, _ENV, path, self
      getTextureCount = getTextureCount + 1
      local texture = ((((CS.PixelNeko).Tools).ExternalImageLoaderHelper).GetTexture)(path)
      if texture or DataCommon.GetTextureCount <= getTextureCount then
        LogInfoFormat("ShareFullScreenDialog", "--- getTextureCount = %s, texture = %s, GetTextureCount = %s ---", getTextureCount, texture, DataCommon.GetTextureCount)
        ;
        ((DialogManager.CreateSingletonDialog)("welfare.anniversaryshare.shareresultdialog")):SetData(texture)
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
      -- function num : 0_3_0_1 , upvalues : _ENV, texture, self
      ((DialogManager.CreateSingletonDialog)("welfare.anniversaryshare.shareresultdialog")):SetData(texture)
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

ShareFullScreenDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return ShareFullScreenDialog

