-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/selectaudiocell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SelectAudioCell = class("SelectAudioCell", Dialog)
SelectAudioCell.AssetBundleName = "ui/layouts.setting"
SelectAudioCell.AssetName = "SettingLanguageCell"
SelectAudioCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SelectAudioCell
  ((SelectAudioCell.super).Ctor)(self, ...)
end

SelectAudioCell.OnCreate = function(self)
  -- function num : 0_1
  self._audioName = self:GetChild("GroupBtn4/Text")
  self._selectIcon = self:GetChild("GroupBtn4/Select")
  self._downLoadIcon = self:GetChild("GroupBtn4/Download")
  self._blackBack = self:GetChild("GroupBtn4/Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

SelectAudioCell.OnDestroy = function(self)
  -- function num : 0_2
end

SelectAudioCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._audioName):SetText(data.audioName)
  if data.index % 2 ~= 1 then
    (self._blackBack):SetActive(not data.index)
    ;
    (self._selectIcon):SetActive(false)
    ;
    (self._downLoadIcon):SetActive(false)
    if data.state == 0 then
      (self._downLoadIcon):SetActive(true)
    elseif data.state == 2 then
      (self._selectIcon):SetActive(true)
    elseif data.state == 3 then
      (self._downLoadIcon):SetActive(true)
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

SelectAudioCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):OnSelectAudio(self._cellData)
end

return SelectAudioCell

