-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildmainmember.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GuildMainMember = class("GuildMainMember", Dialog)
GuildMainMember.AssetBundleName = "ui/layouts.guild"
GuildMainMember.AssetName = "GuildMember"
GuildMainMember.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildMainMember
  ((GuildMainMember.super).Ctor)(self, ...)
  self._data = nil
  self._groupName = "Modal"
end

GuildMainMember.OnCreate = function(self)
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

GuildMainMember.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GuildMainMember.OnSCheckPartyMember = function(self, list)
  -- function num : 0_3 , upvalues : _ENV
  self._data = list
  ;
  (self._num):SetText(#self._data)
  ;
  (self._numMax):SetText(((NekoData.BehaviorManager).BM_Guild):GetGuildTotalCount())
  ;
  (self._dismissBtn):SetActive(((NekoData.BehaviorManager).BM_Guild):GetPower_DissolveGuild())
  if ((NekoData.BehaviorManager).BM_Guild):GetPower_DissolveGuild() then
    self:SetDismissBtnState()
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

GuildMainMember.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckpartymemberinfo")
  if csend then
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    csend:Send()
  end
end

GuildMainMember.SetDismissBtnState = function(self)
  -- function num : 0_5 , upvalues : _ENV, CStringRes
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

GuildMainMember.OnDismissBtnClicked = function(self)
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

GuildMainMember.OnLeaveBtnClicked = function(self)
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

GuildMainMember.OnCheckBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckmemberapply")
  if csend then
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    csend:Send()
  end
end

GuildMainMember.NumberOfCell = function(self, frame)
  -- function num : 0_9
  return #self._data
end

GuildMainMember.CellAtIndex = function(self, frame)
  -- function num : 0_10
  return "guild.guildmembercell"
end

GuildMainMember.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  return (self._data)[index]
end

GuildMainMember.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_12
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

GuildMainMember.OnSNotifyPosition = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV
  local data = notification.userInfo
  -- DECOMPILER ERROR at PC13: Unhandled construct in 'MakeBoolean' P1

  if data.userId == ((NekoData.BehaviorManager).BM_Game):GetUserId() and data.position == -1 then
    self:Destroy()
    return 
  end
  self:Refresh()
end

GuildMainMember.OnBackBtnClicked = function(self)
  -- function num : 0_14
  self:Destroy()
end

return GuildMainMember

