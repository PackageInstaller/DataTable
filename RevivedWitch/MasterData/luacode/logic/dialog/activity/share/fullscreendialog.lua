-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/share/fullscreendialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
local FullScreenDialog = class("FullScreenDialog", Dialog)
FullScreenDialog.AssetBundleName = "ui/layouts.share"
FullScreenDialog.AssetName = "ActivityShareFullScreen"
FullScreenDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FullScreenDialog
  ((FullScreenDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
end

FullScreenDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, cimagepath
  ((DialogManager.GetGroup)("ClickEffect")):SetObjectActive(false)
  self._qrcode = self:GetChild("Image/Code")
  local qrCodeID = ((NekoData.BehaviorManager).BM_Gacha):GetShareQRCodeID()
  if qrCodeID == -1 then
    (self._qrcode):SetActive(false)
  else
    local img = cimagepath:GetRecorder(qrCodeID)
    ;
    (self._qrcode):SetSprite(img.assetBundle, img.assetName)
  end
  do
    self._runner = ((self:GetRootWindow()):GetUIObject()):AddComponent(typeof(((CS.PixelNeko).Tools).ScreenShot))
    ;
    (self._runner):StartCoroutine((xLuaUtil.cs_generator)(function()
    -- function num : 0_1_0 , upvalues : _ENV, self
    (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(0.25))
    local plat = (((CS.PixelNeko).LuaManager).GetSystemType)()
    local systemType = require("protocols.bean.protocol.common.systemtype")
    local getTextureCount = 0
    if plat == systemType.IOS then
      local path = ((((CS.PixelNeko).Tools).ScreenShotHelper).CaptureToFile)((os.time)() .. ".png")
      do
        self._shareTimer = (GameTimer.AddTask)(0.2, 0.1, function()
      -- function num : 0_1_0_0 , upvalues : getTextureCount, _ENV, path, self
      getTextureCount = getTextureCount + 1
      local texture = ((((CS.PixelNeko).Tools).ExternalImageLoaderHelper).GetTexture)(path)
      if texture or DataCommon.GetTextureCount <= getTextureCount then
        LogInfoFormat("FullScreenDialog", "--- getTextureCount = %s, texture = %s, GetTextureCount = %s ---", getTextureCount, texture, DataCommon.GetTextureCount)
        ;
        ((DialogManager.CreateSingletonDialog)("activity.share.sharesingledialog")):SetData(texture)
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
      -- function num : 0_1_0_1 , upvalues : _ENV, texture, self
      ((DialogManager.CreateSingletonDialog)("activity.share.sharesingledialog")):SetData(texture)
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

FullScreenDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._shareTimer then
    (GameTimer.RemoveTask)(self._shareTimer)
    self._shareTimer = nil
  end
end

return FullScreenDialog

