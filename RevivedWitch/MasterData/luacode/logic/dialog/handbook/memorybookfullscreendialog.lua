-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/memorybookfullscreendialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MemoryBookFullScreenDialog = class("MemoryBookFullScreenDialog", Dialog)
MemoryBookFullScreenDialog.AssetBundleName = "ui/layouts.activitypuzzle"
MemoryBookFullScreenDialog.AssetName = "ActivityPuzzleShareFullScreen"
MemoryBookFullScreenDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MemoryBookFullScreenDialog
  ((MemoryBookFullScreenDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

MemoryBookFullScreenDialog.OnCreate = function(self)
  -- function num : 0_1
  self._backImage = self:GetChild("Panel/BackImage")
  self._tips = self:GetChild("Panel/Tips")
end

MemoryBookFullScreenDialog.SetData = function(self, data)
  -- function num : 0_2 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder(data.SharePic_id) then
    local imgRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._backImage):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._tips):SetText((TextManager.GetText)(data.ShareText_id))
  ;
  ((DialogManager.GetGroup)("ClickEffect")):SetObjectActive(false)
  self._runner = ((self:GetRootWindow()):GetUIObject()):AddComponent(typeof(((CS.PixelNeko).Tools).ScreenShot))
  ;
  (self._runner):StartCoroutine((xLuaUtil.cs_generator)(function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(0.25))
    local plat = (((CS.PixelNeko).LuaManager).GetSystemType)()
    local systemType = require("protocols.bean.protocol.common.systemtype")
    local getTextureCount = 0
    if plat == systemType.IOS then
      local path = ((((CS.PixelNeko).Tools).ScreenShotHelper).CaptureToFile)((os.time)() .. ".png")
      do
        self._shareTimer = (GameTimer.AddTask)(0.2, 0.1, function()
      -- function num : 0_2_0_0 , upvalues : getTextureCount, _ENV, path, self
      getTextureCount = getTextureCount + 1
      local texture = ((((CS.PixelNeko).Tools).ExternalImageLoaderHelper).GetTexture)(path)
      if texture or DataCommon.GetTextureCount <= getTextureCount then
        LogInfoFormat("MemoryBookFullScreenDialog", "--- getTextureCount = %s, texture = %s, GetTextureCount = %s ---", getTextureCount, texture, DataCommon.GetTextureCount)
        ;
        ((DialogManager.CreateSingletonDialog)("handbook.memoryshareresultdialog")):SetData(texture)
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
      -- function num : 0_2_0_1 , upvalues : _ENV, texture, self
      ((DialogManager.CreateSingletonDialog)("handbook.memoryshareresultdialog")):SetData(texture)
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

MemoryBookFullScreenDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self._shareTimer then
    (GameTimer.RemoveTask)(self._shareTimer)
    self._shareTimer = nil
  end
end

return MemoryBookFullScreenDialog

