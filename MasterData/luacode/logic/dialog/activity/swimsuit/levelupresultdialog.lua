local CHexagonland = BeanManager.GetTableByName("activity.chexagonland")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local LevelUpResultDialog = class("LevelUpResultDialog", Dialog)
LevelUpResultDialog.AssetBundleName = "ui/layouts.activitysummer"
LevelUpResultDialog.AssetName = "ActivitySummerLevelUp"

function LevelUpResultDialog:Ctor(...)
  LevelUpResultDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._canClick = false
end

function LevelUpResultDialog:OnCreate()
  self._name = self:GetChild("Frame/Name")
  self._item = self:GetChild("Frame/Item")
  self._levelNum = self:GetChild("Frame/Level/LevelNum")
  self._txt = self:GetChild("Frame/Txt")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function LevelUpResultDialog:OnDestroy()
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
end

function LevelUpResultDialog:SetData(data)
  self._levelNum:SetText(data.level)
  if data.ID == 12 then
    self._txt:SetText(TextManager.GetText(CStringRes:GetRecorder(1604).msgTextID))
  elseif data.ID == 9 then
    self._txt:SetText(TextManager.GetText(CStringRes:GetRecorder(1605).msgTextID))
  end
  local record = CHexagonland:GetRecorder(data.ID)
  if record then
    self._name:SetText(TextManager.GetText(record.name))
    local imageRecord = CImagePathTable:GetRecorder(record.image) or DataCommon.DefaultImageAsset
    self._item:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self._timer = GameTimer.AddTask(1, -1, function()
    self._canClick = true
  end)
end

function LevelUpResultDialog:OnBackBtnClicked()
  if self._canClick then
    self:Destroy()
  end
end

return LevelUpResultDialog
