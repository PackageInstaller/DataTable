-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildcheckdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local GuildCheckDialog = class("GuildCheckDialog", Dialog)
GuildCheckDialog.AssetBundleName = "ui/layouts.guild"
GuildCheckDialog.AssetName = "GuildCheck"
GuildCheckDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildCheckDialog
  ((GuildCheckDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

GuildCheckDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._emptyTxt = self:GetChild("Back/EmptyTxt")
  self._toggleNoNeedCheck = self:GetChild("Back/ToggleGroup/_Toggle_0")
  self._toggleNeedCheck = self:GetChild("Back/ToggleGroup/_Toggle_1")
  self._frame = (TableFrame.Create)(self._panel, self, true, true)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._toggleNoNeedCheck):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:ChangeCheckType(1)
  end
, self)
  ;
  (self._toggleNeedCheck):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:ChangeCheckType(0)
  end
, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSModifyAutoAccept, Common.n_OnSModifyAutoAccept, nil)
end

GuildCheckDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GuildCheckDialog.Init = function(self, list)
  -- function num : 0_3 , upvalues : _ENV
  self._data = list
  self._checkType = ((NekoData.BehaviorManager).BM_Guild):GetGuildCheckType()
  ;
  (self._toggleNoNeedCheck):SetIsOnType(self._checkType == 1)
  ;
  (self._toggleNeedCheck):SetIsOnType(self._checkType == 0)
  if not ((NekoData.BehaviorManager).BM_Guild):GetPower_ChangeJoinType() then
    (self._toggleNoNeedCheck):SetInteractable(false)
    ;
    (self._toggleNeedCheck):SetInteractable(false)
  end
  ;
  (self._emptyTxt):SetActive(not self._data or #self._data == 0)
  if self._data then
    (self._frame):ReloadAllCell()
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

GuildCheckDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

GuildCheckDialog.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "guild.guildcheckcell"
end

GuildCheckDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

GuildCheckDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_7
  local width, height = (self._panel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetScrollSize(1)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

GuildCheckDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

GuildCheckDialog.ChangeCheckType = function(self, flag)
  -- function num : 0_9 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Guild):GetPower_ChangeJoinType() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100310, nil)
    return 
  end
  if self._checkType == flag then
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(106, nil, function()
    -- function num : 0_9_0 , upvalues : _ENV, flag
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.cmodifyautoaccept")
    if csend then
      csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
      csend.autoAcceptApply = flag
      csend:Send()
    end
  end
, nil, function()
    -- function num : 0_9_1 , upvalues : self
    (self._toggleNoNeedCheck):SetIsOnType(self._checkType == 1)
    ;
    (self._toggleNeedCheck):SetIsOnType(self._checkType == 0)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
end

GuildCheckDialog.OnSModifyAutoAccept = function(self, notification)
  -- function num : 0_10 , upvalues : _ENV
  self._checkType = ((NekoData.BehaviorManager).BM_Guild):GetGuildCheckType()
  ;
  (self._toggleNoNeedCheck):SetIsOnType(self._checkType == 1)
  ;
  (self._toggleNeedCheck):SetIsOnType(self._checkType == 0)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return GuildCheckDialog

