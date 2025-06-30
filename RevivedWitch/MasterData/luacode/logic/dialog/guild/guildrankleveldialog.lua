-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildrankleveldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local GuildRankLevelDialog = class("GuildRankLevelDialog", Dialog)
GuildRankLevelDialog.AssetBundleName = "ui/layouts.guild"
GuildRankLevelDialog.AssetName = "GuildRank_Level"
local BottomToTop = 3
GuildRankLevelDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildRankLevelDialog
  ((GuildRankLevelDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

GuildRankLevelDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, BottomToTop, _ENV
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._noDataImage = self:GetChild("Image")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSOpenParty, Common.n_OnSOpenParty, nil)
end

GuildRankLevelDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GuildRankLevelDialog.OnSOpenParty = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guild.guildrankleveldialog")
end

GuildRankLevelDialog.SetData = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  if protocol and #protocol.allParty > 0 then
    (self._noDataImage):SetActive(false)
    self._data = protocol.allParty
  else
    ;
    (self._noDataImage):SetActive(true)
    for index,_ in ipairs(self._data) do
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

      (self._data)[index] = nil
    end
  end
  do
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  end
end

GuildRankLevelDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

GuildRankLevelDialog.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "guild.guildlevelrankcell"
end

GuildRankLevelDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return {data = (self._data)[index], index = index}
end

GuildRankLevelDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
  local width, height = (self._panel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(1 - proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

GuildRankLevelDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guild.guildrankleveldialog")
end

return GuildRankLevelDialog

