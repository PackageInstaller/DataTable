-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/resupdatedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UpdateManagerGame = (((CS.PixelNeko).FileSystem).Update).UpdateManagerGame
local UpdateManagerGameStep = (((CS.PixelNeko).FileSystem).Update).UpdateManagerGameStep
local ResUpdateDialog = class("ResUpdateDialog", Dialog)
ResUpdateDialog.AssetBundleName = "ui/layouts"
ResUpdateDialog.AssetName = "DownLoadLanguage"
ResUpdateDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResUpdateDialog, _ENV
  ((ResUpdateDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._resName = ""
  self._totalNeedDownLoadSize = 0
  self._networkState = ((CS.UnityEngine).Application).internetReachability
  self._eventDownloadPatchesHandler = 0
  self._eventDownloadPatchesFailHandler = 0
  self._eventCheckDownloadPatchesHandler = 0
  self._eventCheckDownloadPatchesFailHandler = 0
  self._eventMergeHandler = 0
  self._eventMergeFailHandler = 0
  self._eventCleanHandler = 0
  self._eventUpdateManagerGameTerminatedHandler = 0
end

ResUpdateDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, UpdateManagerGame
  self._uiProgressBar = self:GetChild("Canvas/DownLoad/DownLoadProgressBar/Progress")
  self._downLoadDescribe = self:GetChild("Canvas/DownLoad/Text")
  self._downLoadEffect = self:GetChild("Canvas/DownLoad/Effect")
  self._errorTips = self:GetChild("Confirm/DownloadErrorTips")
  self._errorTipsTxt = self:GetChild("Confirm/DownloadErrorTips/Text")
  self._errorTipsBtn = self:GetChild("Confirm/DownloadErrorTips/Confirm")
  ;
  (self._errorTipsBtn):Subscribe_PointerClickEvent(self.OnErrorTipsBtnClicked, self)
  ;
  (self._errorTips):SetActive(false)
  ;
  (self._downLoadEffect):SetActive(false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  self._eventDownloadPatchesHandler = (UpdateManagerGame.EventDownloadPatches):Subscribe(self, self.OnEventDownloadPatches)
  self._eventDownloadPatchesFailHandler = (UpdateManagerGame.EventDownloadPatchesFail):Subscribe(self, self.OnEventDownloadPatchesFail)
  self._eventCheckDownloadPatchesHandler = (UpdateManagerGame.EventCheckDownloadPatches):Subscribe(self, self.OnEventCheckDownloadPatches)
  self._eventCheckDownloadPatchesFailHandler = (UpdateManagerGame.EventCheckDownloadPatchesFail):Subscribe(self, self.OnEventCheckDownloadPatchesFail)
  self._eventMergeHandler = (UpdateManagerGame.EventMerge):Subscribe(self, self.OnEventMerge)
  self._eventMergeFailHandler = (UpdateManagerGame.EventMergeFail):Subscribe(self, self.OnEventMergeFail)
  self._eventCleanHandler = (UpdateManagerGame.EventClean):Subscribe(self, self.OnEventClean)
  self._eventUpdateManagerGameTerminatedHandler = (UpdateManagerGame.EventUpdateManagerGameTerminated):Subscribe(self, self.OnEventUpdateManagerGameTerminated)
end

ResUpdateDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV, UpdateManagerGame
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (UpdateManagerGame.EventDownloadPatches):Unsubscribe(self._eventDownloadPatchesHandler)
  ;
  (UpdateManagerGame.EventDownloadPatchesFail):Unsubscribe(self._eventDownloadPatchesFailHandler)
  ;
  (UpdateManagerGame.EventCheckDownloadPatches):Unsubscribe(self._eventCheckDownloadPatchesHandler)
  ;
  (UpdateManagerGame.EventCheckDownloadPatchesFail):Unsubscribe(self._eventCheckDownloadPatchesFailHandler)
  ;
  (UpdateManagerGame.EventMerge):Unsubscribe(self._eventMergeHandler)
  ;
  (UpdateManagerGame.EventMergeFail):Unsubscribe(self._eventMergeFailHandler)
  ;
  (UpdateManagerGame.EventClean):Unsubscribe(self._eventCleanHandler)
  ;
  (UpdateManagerGame.EventUpdateManagerGameTerminated):Unsubscribe(self._eventUpdateManagerGameTerminatedHandler)
  self._resName = ""
end

ResUpdateDialog.SetResName = function(self, resName)
  -- function num : 0_3 , upvalues : UpdateManagerGame, UpdateManagerGameStep
  self._resName = resName
  local valid, step = (UpdateManagerGame.TryGetUpdateManagerGameStep)(self._resName)
  if valid then
    if step == UpdateManagerGameStep.DownloadPatches then
      self:OnEventDownloadPatches(self._resName)
    else
      if step == UpdateManagerGameStep.DownloadPatchesFail then
        self:OnEventDownloadPatchesFail(self._resName)
      else
        if step == UpdateManagerGameStep.CheckDownloadPatches then
          self:OnEventCheckDownloadPatches(self._resName)
        else
          if step == UpdateManagerGameStep.CheckDownloadPatchesError then
            self:OnEventCheckDownloadPatchesFail(self._resName)
          else
            if step == UpdateManagerGameStep.Merge then
              self:OnEventMerge(self._resName)
            else
              if step == UpdateManagerGameStep.MergeFail then
                self:OnEventMergeFail(self._resName)
              else
                if step == UpdateManagerGameStep.Clean then
                  self:OnEventClean(self._resName)
                end
              end
            end
          end
        end
      end
    end
  end
end

ResUpdateDialog.OnErrorTipsBtnClicked = function(self)
  -- function num : 0_4 , upvalues : UpdateManagerGame
  (UpdateManagerGame.NextStep)(self._resName)
  ;
  (self._errorTips):SetActive(false)
end

ResUpdateDialog.OnUpdate = function(self)
  -- function num : 0_5 , upvalues : UpdateManagerGame, UpdateManagerGameStep, _ENV
  local valid, step = (UpdateManagerGame.TryGetUpdateManagerGameStep)(self._resName)
  if valid then
    if step == UpdateManagerGameStep.DownloadPatches then
      local c, t = (UpdateManagerGame.GetDownloadPatchesProgress)(self._resName)
      if t > 20971520 then
        (self._downLoadDescribe):SetText((TextManager.GetText)(700875, (string.format)("%.2f", t / 1024 / 1024), (string.format)("%.2f", c / 1024 / 1024)))
      else
        ;
        (self._downLoadDescribe):SetText((TextManager.GetText)(700874, (string.format)("%.2f", t / 1024), (string.format)("%.2f", c / 1024)))
      end
      if c == t and c > 0 then
        (self._uiProgressBar):SetFillAmount(1)
      else
        ;
        (self._uiProgressBar):SetFillAmount(c / t)
      end
    else
      do
        if step == UpdateManagerGameStep.Merge then
          local c, t = (UpdateManagerGame.GetMergeProgress)(self._resName)
          if t == 0 then
            (self._downLoadDescribe):SetText((TextManager.GetText)(700878))
          else
            ;
            (self._downLoadDescribe):SetText((TextManager.GetText)(700879, t, c))
          end
          if c == t and c > 0 then
            (self._uiProgressBar):SetFillAmount(1)
          else
            ;
            (self._uiProgressBar):SetFillAmount(c / t)
          end
        end
      end
    end
  end
end

ResUpdateDialog.OnEventDownloadPatches = function(self, resName)
  -- function num : 0_6
  if self._resName == resName then
    (self._downLoadEffect):SetActive(true)
    self:OnUpdate()
  end
end

ResUpdateDialog.OnEventDownloadPatchesFail = function(self, resName)
  -- function num : 0_7 , upvalues : _ENV, UpdateManagerGame
  if self._resName == resName then
    (self._downLoadEffect):SetActive(false)
    ;
    (self._downLoadDescribe):SetText((TextManager.GetText)(700876))
    local c, t = (UpdateManagerGame.GetDownloadPatchesProgress)(resName)
    ;
    (self._errorTips):SetActive(true)
    if t > 20971520 then
      (self._errorTipsTxt):SetText((TextManager.GetText)(700885, (string.format)("%.2f", (t - c) / 1024 / 1024)))
    else
      ;
      (self._errorTipsTxt):SetText((TextManager.GetText)(700884, (string.format)("%.2f", (t - c) / 1024)))
    end
    if c == t and c > 0 then
      (self._uiProgressBar):SetFillAmount(1)
    else
      ;
      (self._uiProgressBar):SetFillAmount(c / t)
    end
  end
end

ResUpdateDialog.OnEventCheckDownloadPatches = function(self, resName)
  -- function num : 0_8 , upvalues : _ENV
  if self._resName == resName then
    (self._downLoadEffect):SetActive(true)
    ;
    (self._downLoadDescribe):SetText((TextManager.GetText)(700889))
    ;
    (self._uiProgressBar):SetFillAmount(1)
  end
end

ResUpdateDialog.OnEventCheckDownloadPatchesFail = function(self, resName)
  -- function num : 0_9 , upvalues : _ENV, UpdateManagerGame
  if self._resName == resName then
    (self._downLoadEffect):SetActive(false)
    ;
    (self._downLoadDescribe):SetText((TextManager.GetText)(700877))
    local c, t = (UpdateManagerGame.GetDownloadPatchesProgress)(resName)
    ;
    (self._errorTips):SetActive(true)
    if t > 20971520 then
      (self._errorTipsTxt):SetText((TextManager.GetText)(700887, (string.format)("%.2f", t / 1024 / 1024), (string.format)("%.2f", c / 1024 / 1024)))
    else
      ;
      (self._errorTipsTxt):SetText((TextManager.GetText)(700886, (string.format)("%.2f", t / 1024), (string.format)("%.2f", c / 1024)))
    end
    ;
    (self._uiProgressBar):SetFillAmount(0)
  end
end

ResUpdateDialog.OnEventMerge = function(self, resName)
  -- function num : 0_10
  if self._resName == resName then
    (self._downLoadEffect):SetActive(true)
    self:OnUpdate()
  end
end

ResUpdateDialog.OnEventMergeFail = function(self, resName)
  -- function num : 0_11 , upvalues : _ENV
  if self._resName == resName then
    (self._downLoadEffect):SetActive(false)
    ;
    (self._downLoadDescribe):SetText((TextManager.GetText)(700880))
    ;
    (self._errorTips):SetActive(true)
    ;
    (self._errorTipsTxt):SetText((TextManager.GetText)(700888))
    ;
    (self._uiProgressBar):SetFillAmount(0)
  end
end

ResUpdateDialog.OnEventClean = function(self, resName)
  -- function num : 0_12 , upvalues : _ENV
  if self._resName == resName then
    (self._downLoadEffect):SetActive(true)
    ;
    (self._downLoadDescribe):SetText((TextManager.GetText)(700881))
    ;
    (self._uiProgressBar):SetFillAmount(1)
  end
end

ResUpdateDialog.OnEventUpdateManagerGameTerminated = function(self, resName)
  -- function num : 0_13
  if self._resName == resName then
    self:Destroy()
  end
end

return ResUpdateDialog

