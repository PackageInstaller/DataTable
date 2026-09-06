local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MemoryBookFullScreenDialog = class("MemoryBookFullScreenDialog", Dialog)
MemoryBookFullScreenDialog.AssetBundleName = "ui/layouts.activitypuzzle"
MemoryBookFullScreenDialog.AssetName = "ActivityPuzzleShareFullScreen"

function MemoryBookFullScreenDialog:Ctor(...)
  MemoryBookFullScreenDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function MemoryBookFullScreenDialog:OnCreate()
  self._backImage = self:GetChild("Panel/BackImage")
  self._tips = self:GetChild("Panel/Tips")
end

function MemoryBookFullScreenDialog:SetData(data)
  local imgRecord = CImagePathTable:GetRecorder(data.SharePic_id) or DataCommon.DefaultImageAsset
  self._backImage:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._tips:SetText(TextManager.GetText(data.ShareText_id))
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
          LogInfoFormat("MemoryBookFullScreenDialog", "--- getTextureCount = %s, texture = %s, GetTextureCount = %s ---", getTextureCount, texture, DataCommon.GetTextureCount)
          DialogManager.CreateSingletonDialog("handbook.memoryshareresultdialog"):SetData(texture)
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
        DialogManager.CreateSingletonDialog("handbook.memoryshareresultdialog"):SetData(texture)
        self._shareTimer = nil
        self._canShare = true
        self:Destroy()
      end)
    end
  end))
end

function MemoryBookFullScreenDialog:OnDestroy()
  if self._shareTimer then
    GameTimer.RemoveTask(self._shareTimer)
    self._shareTimer = nil
  end
end

return MemoryBookFullScreenDialog
