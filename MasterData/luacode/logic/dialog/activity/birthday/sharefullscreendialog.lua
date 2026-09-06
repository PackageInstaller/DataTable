local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ShareFullScreenDialog = class("ShareFullScreenDialog", Dialog)
ShareFullScreenDialog.AssetBundleName = "ui/layouts.activitylogin"
ShareFullScreenDialog.AssetName = "ActivityLoginShareFullScreen"

function ShareFullScreenDialog:Ctor(...)
  ShareFullScreenDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShareFullScreenDialog:OnCreate()
  self._wishText = self:GetChild("Image/WishImg/Text")
  self:SetData()
end

function ShareFullScreenDialog:OnDestroy()
  if self._shareTimer then
    GameTimer.RemoveTask(self._shareTimer)
    self._shareTimer = nil
  end
end

function ShareFullScreenDialog:SetData(data)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  self._wishText:SetText(self._bm:GetWishRecordText())
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
          DialogManager.CreateSingletonDialog("activity.birthday.sharedialog"):SetData(texture)
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
        DialogManager.CreateSingletonDialog("activity.birthday.sharedialog"):SetData(texture)
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
