-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildmemberdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GuildMemberDialog = class("GuildMemberDialog", Dialog)
GuildMemberDialog.AssetBundleName = "ui/layouts.guild"
GuildMemberDialog.AssetName = "GuildMember"
GuildMemberDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildMemberDialog
  ((GuildMemberDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = nil
end

GuildMemberDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._num = self:GetChild("Back/Num/Num")
  self._numMax = self:GetChild("Back/Num/NumMax")
  self._dismissBtn = self:GetChild("Back/DismissBtn")
  self._dismissBtnText = self:GetChild("Back/DismissBtn/_Text")
  self._leaveBtn = self:GetChild("Back/LeaveBtn")
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._dismissBtn):Subscribe_PointerClickEvent(self.OnDismissBtnClicked, self)
  ;
  (self._leaveBtn):Subscribe_PointerClickEvent(self.OnLeaveBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetDismissBtnState, Common.n_OnSDismissParty, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSNotifyPosition, Common.n_OnSNotifyPosition, nil)
end

GuildMemberDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GuildMemberDialog.Init = function(self, list)
  -- function num : 0_3 , upvalues : _ENV
  self._data = list
  ;
  (self._num):SetText(#self._data)
  ;
  (self._numMax):SetText(((NekoData.BehaviorManager).BM_Guild):GetGuildTotalCount())
  ;
  (self._dismissBtn):SetActive(((NekoData.BehaviorManager).BM_Guild):GetPower_DissolveGuild())
  self:SetDismissBtnState()
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

GuildMemberDialog.SetDismissBtnState = function(self)
  -- function num : 0_4 , upvalues : _ENV, CStringRes
  local str = nil
  if ((NekoData.BehaviorManager).BM_Guild):IsCoolingOff() then
    str = (CStringRes:GetRecorder(1460)).msgTextID
    str = (TextManager.GetText)(str)
  else
    str = (CStringRes:GetRecorder(1459)).msgTextID
    str = (TextManager.GetText)(str)
  end
  ;
  (self._dismissBtnText):SetText(str)
end

GuildMemberDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

GuildMemberDialog.OnDismissBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guild):IsCoolingOff() then
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.cdismissparty")
    if csend then
      local operate = 0
      csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
      csend.operate = operate
      csend:Send()
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(104, nil, function()
    -- function num : 0_6_0 , upvalues : _ENV
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.cdismissparty")
    if csend then
      local operate = 1
      csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
      csend.operate = operate
      csend:Send()
    end
  end
)
    end
  end
end

GuildMemberDialog.OnLeaveBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(105, nil, function()
    -- function num : 0_7_0 , upvalues : _ENV
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.cleaveparty")
    if csend then
      csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
      csend:Send()
    end
  end
)
end

GuildMemberDialog.NumberOfCell = function(self, frame)
  -- function num : 0_8
  return #self._data
end

GuildMemberDialog.CellAtIndex = function(self, frame)
  -- function num : 0_9
  return "guild.guildmembercell"
end

GuildMemberDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._data)[index]
end

GuildMemberDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_11
  local width, height = (self._panel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(1 - proportion)
  else
    ;
    (self._scrollBar):SetScrollSize(1)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

GuildMemberDialog.OnSNotifyPosition = function(self, notification)
  -- function num : 0_12 , upvalues : _ENV
  local data = notification.userInfo
  if data.userId == ((NekoData.BehaviorManager).BM_Game):GetUserId() and data.position == -1 then
    self:Destroy()
    return 
  end
end

return GuildMemberDialog

