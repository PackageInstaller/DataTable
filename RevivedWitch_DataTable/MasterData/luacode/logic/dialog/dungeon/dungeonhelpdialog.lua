-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonhelpdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local DungeonHelpDialog = class("DungeonHelpDialog", Dialog)
DungeonHelpDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonHelpDialog.AssetName = "DungeonHelp"
DungeonHelpDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonHelpDialog
  ((DungeonHelpDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._time = 0
end

DungeonHelpDialog.OnCreate = function(self)
  -- function num : 0_1
  self._dontPopToggle = self:GetChild("BackImage/_Toggle_0")
  self._confirmBtn = self:GetChild("BackImage/ConfirmBtn")
  self._confirmBtnText = self:GetChild("BackImage/ConfirmBtn/_Text")
  self._cancelBtn = self:GetChild("BackImage/CancelBtn")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._dontPopToggle):Subscribe_ValueChangedEvent(self.OnValueChanged, self)
end

DungeonHelpDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

DungeonHelpDialog.SetEffect = function(self, effect)
  -- function num : 0_3 , upvalues : _ENV, CVarconfig
  self._time = tonumber((CVarconfig:GetRecorder(87)).Value)
  self._tipEffect = effect
  ;
  (self._confirmBtn):SetInteractable(false)
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_0 , upvalues : self
    self:TipBtnTask()
  end
, nil)
end

DungeonHelpDialog.TipBtnTask = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._time = self._time - 1
  self:SetTipBtnText()
  if self._time == 0 then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

DungeonHelpDialog.SetTipBtnText = function(self)
  -- function num : 0_5 , upvalues : _ENV, CStringRes
  if self._time > 0 then
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1484)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", tostring(self._time))
    ;
    (self._confirmBtnText):SetText(str)
    ;
    (self._confirmBtn):SetInteractable(false)
  else
    do
      local str = (TextManager.GetText)((CStringRes:GetRecorder(1485)).msgTextID)
      ;
      (self._confirmBtnText):SetText(str)
      ;
      (self._confirmBtn):SetInteractable(true)
    end
  end
end

DungeonHelpDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_6
  (self._tipEffect):Run()
  self:Destroy()
end

DungeonHelpDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

DungeonHelpDialog.OnValueChanged = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):DontPop((self._dontPopToggle):GetIsOnType())
end

return DungeonHelpDialog

