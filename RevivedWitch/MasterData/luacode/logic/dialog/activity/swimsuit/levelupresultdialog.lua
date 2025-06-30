-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/levelupresultdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CHexagonland = (BeanManager.GetTableByName)("activity.chexagonland")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local LevelUpResultDialog = class("LevelUpResultDialog", Dialog)
LevelUpResultDialog.AssetBundleName = "ui/layouts.activitysummer"
LevelUpResultDialog.AssetName = "ActivitySummerLevelUp"
LevelUpResultDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LevelUpResultDialog
  ((LevelUpResultDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._canClick = false
end

LevelUpResultDialog.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Frame/Name")
  self._item = self:GetChild("Frame/Item")
  self._levelNum = self:GetChild("Frame/Level/LevelNum")
  self._txt = self:GetChild("Frame/Txt")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

LevelUpResultDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
end

LevelUpResultDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CStringRes, CHexagonland, CImagePathTable
  (self._levelNum):SetText(data.level)
  if data.ID == 12 then
    (self._txt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1604)).msgTextID))
  else
    if data.ID == 9 then
      (self._txt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1605)).msgTextID))
    end
  end
  local record = CHexagonland:GetRecorder(data.ID)
  if record then
    (self._name):SetText((TextManager.GetText)(record.name))
    if not CImagePathTable:GetRecorder(record.image) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._item):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  do
    self._timer = (GameTimer.AddTask)(1, -1, function()
    -- function num : 0_3_0 , upvalues : self
    self._canClick = true
  end
)
  end
end

LevelUpResultDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  if self._canClick then
    self:Destroy()
  end
end

return LevelUpResultDialog

