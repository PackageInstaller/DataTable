-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/birthday/sharefullscreendialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ShareFullScreenDialog = class("ShareFullScreenDialog", Dialog)
ShareFullScreenDialog.AssetBundleName = "ui/layouts.activitylogin"
ShareFullScreenDialog.AssetName = "ActivityLoginShareFullScreen"
ShareFullScreenDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShareFullScreenDialog
  ((ShareFullScreenDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ShareFullScreenDialog.OnCreate = function(self)
  -- function num : 0_1
  self._wishText = self:GetChild("Image/WishImg/Text")
  self._qrCode = self:GetChild("Image/Code")
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
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  ;
  (self._wishText):SetText((self._bm):GetWishRecordText())
  local imgRecord = CImagePathTable:GetRecorder(((NekoData.BehaviorManager).BM_Gacha):GetShareQRCodeID())
  ;
  (self._qrCode):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
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
        ((DialogManager.CreateSingletonDialog)("activity.birthday.sharedialog")):SetData(texture)
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
      ((DialogManager.CreateSingletonDialog)("activity.birthday.sharedialog")):SetData(texture)
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

