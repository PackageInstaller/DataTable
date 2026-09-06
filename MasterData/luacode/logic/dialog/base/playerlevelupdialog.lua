local TableFrame = require("framework.ui.frame.table.tableframe")
local CPlayerLevel = BeanManager.GetTableByName("role.cplayerlevel")
local CPlayerLevelUnlockDungeon = BeanManager.GetTableByName("role.cplayerlevelunlockdungeon")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local PlayerLevelUpDialog = class("PlayerLevelUpDialog", Dialog)
PlayerLevelUpDialog.AssetBundleName = "ui/layouts.basemainhud"
PlayerLevelUpDialog.AssetName = "MagicLevelUp"

function PlayerLevelUpDialog:Ctor(...)
  PlayerLevelUpDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

function PlayerLevelUpDialog:OnCreate()
  self._levelNum = self:GetChild("Back/LevelNum")
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._unlockLevel = self:GetChild("LevelLock")
  self._unlockLevel_title = self:GetChild("LevelLock/Title")
  self._unlockLevel_image = self:GetChild("LevelLock/Image")
  self._unlockLevel_stage = self:GetChild("LevelLock/Num")
  self._unlockLevel_name = self:GetChild("LevelLock/Name")
  self._rootWindow:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._rootWindow:Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

function PlayerLevelUpDialog:OnDestroy()
  self._frame:Destroy()
  if self._timer then
    GameTimer.RemoveTask(self._timer)
  end
end

function PlayerLevelUpDialog:SetData(data)
  self._data = {}
  self._level = data.level
  self._levelNum:SetText(data.level)
  if data.strengthGet > 0 then
    local temp = {
      tag = "StrengthGet",
      value = data.strengthGet
    }
    table.insert(self._data, temp)
  end
  if data.strengthLimit > CPlayerLevel:GetRecorder(self._level - 1).strengthLimit then
    local temp = {
      tag = "Spirit",
      value = data.strengthLimit
    }
    table.insert(self._data, temp)
  end
  local record = CPlayerLevel:GetRecorder(data.level)
  local unlockList = record.unlockFunction
  for i, v in ipairs(unlockList) do
    local temp = {tag = "Function", value = v}
    table.insert(self._data, temp)
  end
  if record.unlockAfter ~= 0 then
    table.insert(self._data, {
      tag = "After",
      value = record.unlockAfter
    })
  end
  self._frame:ReloadAllCell()
  self._unlockDungeonId = record.unlockDungeon
  if self._unlockDungeonId == 0 then
    self._timer = GameTimer.AddTask(5, 0, self.Destroy, self)
  elseif #self._data <= 0 then
    self._stateName = "MagicLevelUp"
    self:OnBackBtnClicked()
  end
end

function PlayerLevelUpDialog:NumberOfCell(frame)
  return #self._data
end

function PlayerLevelUpDialog:CellAtIndex(frame, index)
  if self._data[index].tag == "Function" then
    return "base.playerlevelupfunctioncell"
  elseif self._data[index].tag == "Spirit" then
    return "base.playerlevelupmaxcell"
  elseif self._data[index].tag == "StrengthGet" then
    return "base.playerleveluprestorecell"
  elseif self._data[index].tag == "After" then
    return "base.playerlevelupaftercell"
  end
end

function PlayerLevelUpDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function PlayerLevelUpDialog:OnBackBtnClicked()
  if not self._stateName then
    return
  end
  if self._unlockDungeonId and self._unlockDungeonId ~= 0 and self._stateName == "MagicLevelUp" then
    local record = CPlayerLevelUnlockDungeon:GetRecorder(self._unlockDungeonId)
    if not record then
      LogErrorFormat("PlayerLevelUpDialog", "Can not find record by id：%s in CPlayerLevelUnlockDungeon", self._unlockDungeonId)
    else
      self._unlockLevel:SetActive(true)
      self._rootWindow:PlayAnimation("MagicLevelUp2")
      self._unlockLevel_title:SetText(TextManager.GetText(record.type))
      local imgRecord = CImagePathTable:GetRecorder(record.image) or DataCommon.DefaultImageAsset
      self._unlockLevel_image:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      self._unlockLevel_stage:SetText(record.stage)
      self._unlockLevel_name:SetText(TextManager.GetText(record.nama))
      self._timer = GameTimer.AddTask(5, 0, self.Destroy, self)
    end
    self._unlockDungeonId = nil
  elseif self._unlockDungeonId == 0 or not self._unlockDungeonId and self._stateName == "MagicLevelUp2" then
    self:Destroy()
  end
end

function PlayerLevelUpDialog:GetLevel()
  return self._level
end

function PlayerLevelUpDialog:OnAnimationStateExit(handle, stateName, normalizedTime)
  self._stateName = stateName
end

return PlayerLevelUpDialog
