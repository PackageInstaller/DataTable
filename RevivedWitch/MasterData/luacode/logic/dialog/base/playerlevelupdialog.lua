-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/base/playerlevelupdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CPlayerLevel = (BeanManager.GetTableByName)("role.cplayerlevel")
local CPlayerLevelUnlockDungeon = (BeanManager.GetTableByName)("role.cplayerlevelunlockdungeon")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local PlayerLevelUpDialog = class("PlayerLevelUpDialog", Dialog)
PlayerLevelUpDialog.AssetBundleName = "ui/layouts.basemainhud"
PlayerLevelUpDialog.AssetName = "MagicLevelUp"
PlayerLevelUpDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PlayerLevelUpDialog
  ((PlayerLevelUpDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

PlayerLevelUpDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._levelNum = self:GetChild("Back/LevelNum")
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._unlockLevel = self:GetChild("LevelLock")
  self._unlockLevel_title = self:GetChild("LevelLock/Title")
  self._unlockLevel_image = self:GetChild("LevelLock/Image")
  self._unlockLevel_stage = self:GetChild("LevelLock/Num")
  self._unlockLevel_name = self:GetChild("LevelLock/Name")
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._rootWindow):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

PlayerLevelUpDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
  end
end

PlayerLevelUpDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CPlayerLevel
  self._data = {}
  self._level = data.level
  ;
  (self._levelNum):SetText(data.level)
  do
    if data.strengthGet > 0 then
      local temp = {tag = "StrengthGet", value = data.strengthGet}
      ;
      (table.insert)(self._data, temp)
    end
    do
      if (CPlayerLevel:GetRecorder(self._level - 1)).strengthLimit < data.strengthLimit then
        local temp = {tag = "Spirit", value = data.strengthLimit}
        ;
        (table.insert)(self._data, temp)
      end
      local record = CPlayerLevel:GetRecorder(data.level)
      local unlockList = record.unlockFunction
      for i,v in ipairs(unlockList) do
        local temp = {tag = "Function", value = v}
        ;
        (table.insert)(self._data, temp)
      end
      if record.unlockAfter ~= 0 then
        (table.insert)(self._data, {tag = "After", value = record.unlockAfter})
      end
      ;
      (self._frame):ReloadAllCell()
      self._unlockDungeonId = record.unlockDungeon
      if self._unlockDungeonId == 0 then
        self._timer = (GameTimer.AddTask)(5, 0, self.Destroy, self)
      else
        if #self._data <= 0 then
          self._stateName = "MagicLevelUp"
          self:OnBackBtnClicked()
        end
      end
    end
  end
end

PlayerLevelUpDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

PlayerLevelUpDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if ((self._data)[index]).tag == "Function" then
    return "base.playerlevelupfunctioncell"
  else
    if ((self._data)[index]).tag == "Spirit" then
      return "base.playerlevelupmaxcell"
    else
      if ((self._data)[index]).tag == "StrengthGet" then
        return "base.playerleveluprestorecell"
      else
        if ((self._data)[index]).tag == "After" then
          return "base.playerlevelupaftercell"
        end
      end
    end
  end
end

PlayerLevelUpDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

PlayerLevelUpDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : CPlayerLevelUnlockDungeon, _ENV, CImagePathTable
  if not self._stateName then
    return 
  end
  if self._unlockDungeonId and self._unlockDungeonId ~= 0 and self._stateName == "MagicLevelUp" then
    local record = CPlayerLevelUnlockDungeon:GetRecorder(self._unlockDungeonId)
    if not record then
      LogErrorFormat("PlayerLevelUpDialog", "Can not find record by id：%s in CPlayerLevelUnlockDungeon", self._unlockDungeonId)
    else
      ;
      (self._unlockLevel):SetActive(true)
      ;
      (self._rootWindow):PlayAnimation("MagicLevelUp2")
      ;
      (self._unlockLevel_title):SetText((TextManager.GetText)(record.type))
      if not CImagePathTable:GetRecorder(record.image) then
        local imgRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._unlockLevel_image):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      ;
      (self._unlockLevel_stage):SetText(record.stage)
      ;
      (self._unlockLevel_name):SetText((TextManager.GetText)(record.nama))
      self._timer = (GameTimer.AddTask)(5, 0, self.Destroy, self)
    end
    do
      do
        self._unlockDungeonId = nil
        if self._unlockDungeonId == 0 or not self._unlockDungeonId and self._stateName == "MagicLevelUp2" then
          self:Destroy()
        end
      end
    end
  end
end

PlayerLevelUpDialog.GetLevel = function(self)
  -- function num : 0_8
  return self._level
end

PlayerLevelUpDialog.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_9
  self._stateName = stateName
end

return PlayerLevelUpDialog

