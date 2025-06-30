-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildmainmembertabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GuildMainMemberTabCell = class("GuildMainMemberTabCell", Dialog)
GuildMainMemberTabCell.AssetBundleName = "ui/layouts.guild"
GuildMainMemberTabCell.AssetName = "GuildMainMember"
GuildMainMemberTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildMainMemberTabCell
  ((GuildMainMemberTabCell.super).Ctor)(self, ...)
  self._data = nil
end

GuildMainMemberTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._num = self:GetChild("Back/Num/Num")
  self._numMax = self:GetChild("Back/Num/NumMax")
  self._dismissBtn = self:GetChild("Back/DismissBtn")
  self._dismissBtnText = self:GetChild("Back/DismissBtn/_Text")
  self._leaveBtn = self:GetChild("Back/LeaveBtn")
  self._checkBtn = self:GetChild("Back/CheckBtn")
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._dismissBtn):Subscribe_PointerClickEvent(self.OnDismissBtnClicked, self)
  ;
  (self._leaveBtn):Subscribe_PointerClickEvent(self.OnLeaveBtnClicked, self)
  ;
  (self._checkBtn):Subscribe_PointerClickEvent(self.OnCheckBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetDismissBtnState, Common.n_OnSDismissParty, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSNotifyPosition, Common.n_OnSNotifyPosition, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSCheckPartyMember, Common.n_OnSCheckPartyMember)
end

GuildMainMemberTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GuildMainMemberTabCell.OnSCheckPartyMember = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV
  self._data = notification.userInfo
  ;
  (self._num):SetText(#self._data)
  ;
  (self._numMax):SetText(((NekoData.BehaviorManager).BM_Guild):GetGuildTotalCount())
  ;
  (self._dismissBtn):SetActive(((NekoData.BehaviorManager).BM_Guild):GetPower_DissolveGuild())
  ;
  (self._checkBtn):SetActive(((NekoData.BehaviorManager).BM_Guild):GetPower_MembersReview())
  if ((NekoData.BehaviorManager).BM_Guild):GetPower_DissolveGuild() then
    self:SetDismissBtnState()
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

GuildMainMemberTabCell.RefreshCell = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckpartymemberinfo")
  if csend then
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    csend:Send()
  end
end

GuildMainMemberTabCell.SetDismissBtnState = function(self)
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

GuildMainMemberTabCell.OnDismissBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(104, nil, function()
    -- function num : 0_6_0 , upvalues : _ENV
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.cdismissparty")
    if csend then
      local operate = 1
      if ((NekoData.BehaviorManager).BM_Guild):IsCoolingOff() then
        operate = 0
      end
      csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
      csend.operate = operate
      csend:Send()
    end
  end
)
end

GuildMainMemberTabCell.OnLeaveBtnClicked = function(self)
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

GuildMainMemberTabCell.OnCheckBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckmemberapply")
  if csend then
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    csend:Send()
  end
end

GuildMainMemberTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_9
  return #self._data
end

GuildMainMemberTabCell.CellAtIndex = function(self, frame)
  -- function num : 0_10
  return "guild.guildmembercell"
end

GuildMainMemberTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  return (self._data)[index]
end

GuildMainMemberTabCell.OnCurPosChange = function(self, frame, proportion)
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

GuildMainMemberTabCell.OnSNotifyPosition = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV
  local data = notification.userInfo
  -- DECOMPILER ERROR at PC13: Unhandled construct in 'MakeBoolean' P1

  if data.userId == ((NekoData.BehaviorManager).BM_Game):GetUserId() and data.position == -1 then
    self:Destroy()
    return 
  end
  self:RefreshCell()
end

return GuildMainMemberTabCell

