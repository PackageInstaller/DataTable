local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local DungeonHelpDialog = class("DungeonHelpDialog", Dialog)
DungeonHelpDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonHelpDialog.AssetName = "DungeonHelp"

function DungeonHelpDialog:Ctor(...)
  DungeonHelpDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._time = 0
end

function DungeonHelpDialog:OnCreate()
  self._dontPopToggle = self:GetChild("BackImage/_Toggle_0")
  self._confirmBtn = self:GetChild("BackImage/ConfirmBtn")
  self._confirmBtnText = self:GetChild("BackImage/ConfirmBtn/_Text")
  self._cancelBtn = self:GetChild("BackImage/CancelBtn")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._dontPopToggle:Subscribe_ValueChangedEvent(self.OnValueChanged, self)
end

function DungeonHelpDialog:OnDestroy()
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function DungeonHelpDialog:SetEffect(effect)
  self._time = tonumber(CVarconfig:GetRecorder(87).Value)
  self._tipEffect = effect
  self._confirmBtn:SetInteractable(false)
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  self._task = ServerGameTimer.AddTask(0, 1, function()
    self:TipBtnTask()
  end, nil)
end

function DungeonHelpDialog:TipBtnTask()
  self._time = self._time - 1
  self:SetTipBtnText()
  if self._time == 0 then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function DungeonHelpDialog:SetTipBtnText()
  if self._time > 0 then
    local str = TextManager.GetText(CStringRes:GetRecorder(1484).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(self._time))
    self._confirmBtnText:SetText(str)
    self._confirmBtn:SetInteractable(false)
  else
    local str = TextManager.GetText(CStringRes:GetRecorder(1485).msgTextID)
    self._confirmBtnText:SetText(str)
    self._confirmBtn:SetInteractable(true)
  end
end

function DungeonHelpDialog:OnConfirmBtnClicked()
  self._tipEffect:Run()
  self:Destroy()
end

function DungeonHelpDialog:OnBackBtnClicked()
  self:Destroy()
end

function DungeonHelpDialog:OnValueChanged()
  SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon):DontPop(self._dontPopToggle:GetIsOnType())
end

return DungeonHelpDialog
