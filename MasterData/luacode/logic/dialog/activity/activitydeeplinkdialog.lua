local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CDeepLink = BeanManager.GetTableByName("activity.cdeeplink")
local ActivityDeepLinkDialog = class("ActivityDeepLinkDialog", Dialog)
ActivityDeepLinkDialog.AssetBundleName = "ui/layouts.activityhalloween"
ActivityDeepLinkDialog.AssetName = "ActivityHalloweenInto"

function ActivityDeepLinkDialog:Ctor(...)
  ActivityDeepLinkDialog.super.Ctor(self, ...)
  self._groupName = "Message"
end

function ActivityDeepLinkDialog:OnCreate()
  self._goBtn = self:GetChild("BackImage/GoBtn")
  self._exitBtn = self:GetChild("BackImage/BackBtn")
  self._backImg = self:GetChild("BackImage")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._exitBtn:Subscribe_PointerClickEvent(self.OnExitBtnClicked, self)
  self._record = nil
  if CS.PixelNeko.P1.DeepLink.ClearDeeplinkJsonString then
    CS.PixelNeko.P1.DeepLink.ClearDeeplinkJsonString()
  end
  CS.PixelNeko.P1.DeepLink.SetInfo("")
  local str = CS.PixelNeko.P1.DeepLink.GetInfo()
  LogInfoFormat("DeepLinkFSM", "after clear deeplinkStr = %s", str)
end

function ActivityDeepLinkDialog:RefreshDeepLink(deeplinstr)
  local record = self:GetRecordByDeepLinkStr(deeplinstr)
  if not record then
    return
  end
  local imageRecord = CImagePathTable:GetRecorder(record.pic)
  if not imageRecord then
    return
  end
  self._record = record
  self._backImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function ActivityDeepLinkDialog:GetRecordByDeepLinkStr(deeplinstr)
  for _, id in ipairs(CDeepLink:GetAllIds()) do
    local record = CDeepLink:GetRecorder(id)
    if record.deeplinkid == deeplinstr then
      return record
    end
  end
  return
end

function ActivityDeepLinkDialog:OnDestroy()
end

function ActivityDeepLinkDialog:OnGoBtnClicked()
  if self._record then
    NekoData.BehaviorManager.BM_GotoDialog:HandleGoto(self._record.activityid)
  end
  self:Destroy()
end

function ActivityDeepLinkDialog:OnExitBtnClicked()
  self:Destroy()
end

return ActivityDeepLinkDialog
