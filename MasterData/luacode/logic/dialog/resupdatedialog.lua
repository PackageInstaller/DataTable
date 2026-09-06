local UpdateManagerGame = CS.PixelNeko.FileSystem.Update.UpdateManagerGame
local UpdateManagerGameStep = CS.PixelNeko.FileSystem.Update.UpdateManagerGameStep
local ResUpdateDialog = class("ResUpdateDialog", Dialog)
ResUpdateDialog.AssetBundleName = "ui/layouts"
ResUpdateDialog.AssetName = "DownLoadLanguage"

function ResUpdateDialog:Ctor(...)
  ResUpdateDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._resName = ""
  self._totalNeedDownLoadSize = 0
  self._networkState = CS.UnityEngine.Application.internetReachability
  self._eventDownloadPatchesHandler = 0
  self._eventDownloadPatchesFailHandler = 0
  self._eventCheckDownloadPatchesHandler = 0
  self._eventCheckDownloadPatchesFailHandler = 0
  self._eventMergeHandler = 0
  self._eventMergeFailHandler = 0
  self._eventCleanHandler = 0
  self._eventUpdateManagerGameTerminatedHandler = 0
end

function ResUpdateDialog:OnCreate()
  self._uiProgressBar = self:GetChild("Canvas/DownLoad/DownLoadProgressBar/Progress")
  self._downLoadDescribe = self:GetChild("Canvas/DownLoad/Text")
  self._downLoadEffect = self:GetChild("Canvas/DownLoad/Effect")
  self._errorTips = self:GetChild("Confirm/DownloadErrorTips")
  self._errorTipsTxt = self:GetChild("Confirm/DownloadErrorTips/Text")
  self._errorTipsBtn = self:GetChild("Confirm/DownloadErrorTips/Confirm")
  self._errorTipsBtn:Subscribe_PointerClickEvent(self.OnErrorTipsBtnClicked, self)
  self._errorTips:SetActive(false)
  self._downLoadEffect:SetActive(false)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  self._eventDownloadPatchesHandler = UpdateManagerGame.EventDownloadPatches:Subscribe(self, self.OnEventDownloadPatches)
  self._eventDownloadPatchesFailHandler = UpdateManagerGame.EventDownloadPatchesFail:Subscribe(self, self.OnEventDownloadPatchesFail)
  self._eventCheckDownloadPatchesHandler = UpdateManagerGame.EventCheckDownloadPatches:Subscribe(self, self.OnEventCheckDownloadPatches)
  self._eventCheckDownloadPatchesFailHandler = UpdateManagerGame.EventCheckDownloadPatchesFail:Subscribe(self, self.OnEventCheckDownloadPatchesFail)
  self._eventMergeHandler = UpdateManagerGame.EventMerge:Subscribe(self, self.OnEventMerge)
  self._eventMergeFailHandler = UpdateManagerGame.EventMergeFail:Subscribe(self, self.OnEventMergeFail)
  self._eventCleanHandler = UpdateManagerGame.EventClean:Subscribe(self, self.OnEventClean)
  self._eventUpdateManagerGameTerminatedHandler = UpdateManagerGame.EventUpdateManagerGameTerminated:Subscribe(self, self.OnEventUpdateManagerGameTerminated)
end

function ResUpdateDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  UpdateManagerGame.EventDownloadPatches:Unsubscribe(self._eventDownloadPatchesHandler)
  UpdateManagerGame.EventDownloadPatchesFail:Unsubscribe(self._eventDownloadPatchesFailHandler)
  UpdateManagerGame.EventCheckDownloadPatches:Unsubscribe(self._eventCheckDownloadPatchesHandler)
  UpdateManagerGame.EventCheckDownloadPatchesFail:Unsubscribe(self._eventCheckDownloadPatchesFailHandler)
  UpdateManagerGame.EventMerge:Unsubscribe(self._eventMergeHandler)
  UpdateManagerGame.EventMergeFail:Unsubscribe(self._eventMergeFailHandler)
  UpdateManagerGame.EventClean:Unsubscribe(self._eventCleanHandler)
  UpdateManagerGame.EventUpdateManagerGameTerminated:Unsubscribe(self._eventUpdateManagerGameTerminatedHandler)
  self._resName = ""
end

function ResUpdateDialog:SetResName(resName)
  self._resName = resName
  local valid, step = UpdateManagerGame.TryGetUpdateManagerGameStep(self._resName)
  if valid then
    if step == UpdateManagerGameStep.DownloadPatches then
      self:OnEventDownloadPatches(self._resName)
    elseif step == UpdateManagerGameStep.DownloadPatchesFail then
      self:OnEventDownloadPatchesFail(self._resName)
    elseif step == UpdateManagerGameStep.CheckDownloadPatches then
      self:OnEventCheckDownloadPatches(self._resName)
    elseif step == UpdateManagerGameStep.CheckDownloadPatchesError then
      self:OnEventCheckDownloadPatchesFail(self._resName)
    elseif step == UpdateManagerGameStep.Merge then
      self:OnEventMerge(self._resName)
    elseif step == UpdateManagerGameStep.MergeFail then
      self:OnEventMergeFail(self._resName)
    elseif step == UpdateManagerGameStep.Clean then
      self:OnEventClean(self._resName)
    end
  end
end

function ResUpdateDialog:OnErrorTipsBtnClicked()
  UpdateManagerGame.NextStep(self._resName)
  self._errorTips:SetActive(false)
end

function ResUpdateDialog:OnUpdate()
  local valid, step = UpdateManagerGame.TryGetUpdateManagerGameStep(self._resName)
  if valid then
    if step == UpdateManagerGameStep.DownloadPatches then
      local c, t = UpdateManagerGame.GetDownloadPatchesProgress(self._resName)
      if 20971520 < t then
        self._downLoadDescribe:SetText(TextManager.GetText(700875, string.format("%.2f", t / 1024 / 1024), string.format("%.2f", c / 1024 / 1024)))
      else
        self._downLoadDescribe:SetText(TextManager.GetText(700874, string.format("%.2f", t / 1024), string.format("%.2f", c / 1024)))
      end
      if c == t and 0 < c then
        self._uiProgressBar:SetFillAmount(1)
      else
        self._uiProgressBar:SetFillAmount(c / t)
      end
    elseif step == UpdateManagerGameStep.Merge then
      local c, t = UpdateManagerGame.GetMergeProgress(self._resName)
      if t == 0 then
        self._downLoadDescribe:SetText(TextManager.GetText(700878))
      else
        self._downLoadDescribe:SetText(TextManager.GetText(700879, t, c))
      end
      if c == t and 0 < c then
        self._uiProgressBar:SetFillAmount(1)
      else
        self._uiProgressBar:SetFillAmount(c / t)
      end
    end
  end
end

function ResUpdateDialog:OnEventDownloadPatches(resName)
  if self._resName == resName then
    self._downLoadEffect:SetActive(true)
    self:OnUpdate()
  end
end

function ResUpdateDialog:OnEventDownloadPatchesFail(resName)
  if self._resName == resName then
    self._downLoadEffect:SetActive(false)
    self._downLoadDescribe:SetText(TextManager.GetText(700876))
    local c, t = UpdateManagerGame.GetDownloadPatchesProgress(resName)
    self._errorTips:SetActive(true)
    if 20971520 < t then
      self._errorTipsTxt:SetText(TextManager.GetText(700885, string.format("%.2f", (t - c) / 1024 / 1024)))
    else
      self._errorTipsTxt:SetText(TextManager.GetText(700884, string.format("%.2f", (t - c) / 1024)))
    end
    if c == t and 0 < c then
      self._uiProgressBar:SetFillAmount(1)
    else
      self._uiProgressBar:SetFillAmount(c / t)
    end
  end
end

function ResUpdateDialog:OnEventCheckDownloadPatches(resName)
  if self._resName == resName then
    self._downLoadEffect:SetActive(true)
    self._downLoadDescribe:SetText(TextManager.GetText(700889))
    self._uiProgressBar:SetFillAmount(1)
  end
end

function ResUpdateDialog:OnEventCheckDownloadPatchesFail(resName)
  if self._resName == resName then
    self._downLoadEffect:SetActive(false)
    self._downLoadDescribe:SetText(TextManager.GetText(700877))
    local c, t = UpdateManagerGame.GetDownloadPatchesProgress(resName)
    self._errorTips:SetActive(true)
    if 20971520 < t then
      self._errorTipsTxt:SetText(TextManager.GetText(700887, string.format("%.2f", t / 1024 / 1024), string.format("%.2f", c / 1024 / 1024)))
    else
      self._errorTipsTxt:SetText(TextManager.GetText(700886, string.format("%.2f", t / 1024), string.format("%.2f", c / 1024)))
    end
    self._uiProgressBar:SetFillAmount(0)
  end
end

function ResUpdateDialog:OnEventMerge(resName)
  if self._resName == resName then
    self._downLoadEffect:SetActive(true)
    self:OnUpdate()
  end
end

function ResUpdateDialog:OnEventMergeFail(resName)
  if self._resName == resName then
    self._downLoadEffect:SetActive(false)
    self._downLoadDescribe:SetText(TextManager.GetText(700880))
    self._errorTips:SetActive(true)
    self._errorTipsTxt:SetText(TextManager.GetText(700888))
    self._uiProgressBar:SetFillAmount(0)
  end
end

function ResUpdateDialog:OnEventClean(resName)
  if self._resName == resName then
    self._downLoadEffect:SetActive(true)
    self._downLoadDescribe:SetText(TextManager.GetText(700881))
    self._uiProgressBar:SetFillAmount(1)
  end
end

function ResUpdateDialog:OnEventUpdateManagerGameTerminated(resName)
  if self._resName == resName then
    self:Destroy()
  end
end

return ResUpdateDialog
