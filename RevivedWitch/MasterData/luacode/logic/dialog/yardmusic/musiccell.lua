-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/yardmusic/musiccell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SongStatus = (LuaNetManager.GetBeanDef)("protocol.yard.song")
local MusicCell = class("MusicCell", Dialog)
MusicCell.AssetBundleName = "ui/layouts.yard"
MusicCell.AssetName = "MusicPlayerAldumCell"
MusicCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MusicCell
  ((MusicCell.super).Ctor)(self, ...)
end

MusicCell.OnCreate = function(self)
  -- function num : 0_1
  self._panel = self:GetChild("Panel/Panel")
  self._canUnlockPanel = self:GetChild("Panel/Panel/LockBack")
  self._canNotUnlockPanel = self:GetChild("Panel/Undiscovered")
  self._canNotUnlockPanel_txt = self:GetChild("Panel/Undiscovered/Title")
  self._new = self:GetChild("Panel/Panel/New")
  self._select = self:GetChild("Panel/Panel/Select")
  self._musicName = self:GetChild("Panel/Panel/Music")
  self._musicAuthor = self:GetChild("Panel/Panel/Author")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellMouseClicked, self)
end

MusicCell.OnDestroy = function(self)
  -- function num : 0_2
end

MusicCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, SongStatus
  if data.floor then
    (self._panel):SetActive(false)
    ;
    (self._canNotUnlockPanel):SetActive(true)
    ;
    (self._canUnlockPanel):SetActive(false)
    ;
    (self._new):SetActive(false)
    ;
    (self._canNotUnlockPanel_txt):SetText((TextManager.GetText)((data.record).audioName))
  else
    ;
    (self._panel):SetActive(true)
    ;
    (self._canNotUnlockPanel):SetActive(false)
    ;
    (self._new):SetActive(data.status == SongStatus.NEW)
    if data.status == SongStatus.unlock then
      (self._canUnlockPanel):SetActive(false)
    else
      (self._canUnlockPanel):SetActive(true)
    end
    ;
    (self._musicName):SetText((TextManager.GetText)((data.record).audioName))
    ;
    (self._musicAuthor):SetText((TextManager.GetText)((data.record).author))
  end
  ;
  (self._select):SetActive(not (self._delegate)._selectMusic or data.id == ((self._delegate)._selectMusic).id)
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

MusicCell.OnCellMouseClicked = function(self)
  -- function num : 0_4
  (self._delegate):SelectMusic(self._cellData, false, true)
end

MusicCell.OnEvent = function(self, eventName, args)
  -- function num : 0_5 , upvalues : SongStatus
  -- DECOMPILER ERROR at PC17: Unhandled construct in 'MakeBoolean' P1

  if (self._delegate)._selectMusic and (self._cellData).id ~= ((self._delegate)._selectMusic).id then
    (self._select):SetActive(eventName ~= "SelectedMusic")
    ;
    (self._new):SetActive((self._cellData).status == SongStatus.NEW)
    if eventName == "MusicUnlocked" and (self._cellData).id == args.id then
      self:RefreshCell(args)
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

return MusicCell

