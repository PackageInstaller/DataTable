local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GuildMainMemberTabCell = class("GuildMainMemberTabCell", Dialog)
GuildMainMemberTabCell.AssetBundleName = "ui/layouts.guild"
GuildMainMemberTabCell.AssetName = "GuildMainMember"

function GuildMainMemberTabCell:Ctor(...)
  GuildMainMemberTabCell.super.Ctor(self, ...)
  self._data = nil
end

function GuildMainMemberTabCell:OnCreate()
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._num = self:GetChild("Back/Num/Num")
  self._numMax = self:GetChild("Back/Num/NumMax")
  self._dismissBtn = self:GetChild("Back/DismissBtn")
  self._dismissBtnText = self:GetChild("Back/DismissBtn/_Text")
  self._leaveBtn = self:GetChild("Back/LeaveBtn")
  self._checkBtn = self:GetChild("Back/CheckBtn")
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._dismissBtn:Subscribe_PointerClickEvent(self.OnDismissBtnClicked, self)
  self._leaveBtn:Subscribe_PointerClickEvent(self.OnLeaveBtnClicked, self)
  self._checkBtn:Subscribe_PointerClickEvent(self.OnCheckBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.SetDismissBtnState, Common.n_OnSDismissParty, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSNotifyPosition, Common.n_OnSNotifyPosition, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSCheckPartyMember, Common.n_OnSCheckPartyMember)
end

function GuildMainMemberTabCell:OnDestroy()
  self._frame:Destroy()
end

function GuildMainMemberTabCell:OnSCheckPartyMember(notification)
  self._data = notification.userInfo
  self._num:SetText(#self._data)
  self._numMax:SetText(NekoData.BehaviorManager.BM_Guild:GetGuildTotalCount())
  self._dismissBtn:SetActive(NekoData.BehaviorManager.BM_Guild:GetPower_DissolveGuild())
  self._checkBtn:SetActive(NekoData.BehaviorManager.BM_Guild:GetPower_MembersReview())
  if NekoData.BehaviorManager.BM_Guild:GetPower_DissolveGuild() then
    self:SetDismissBtnState()
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function GuildMainMemberTabCell:RefreshCell()
  local csend = LuaNetManager.CreateProtocol("protocol.party.ccheckpartymemberinfo")
  if csend then
    csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
    csend:Send()
  end
end

function GuildMainMemberTabCell:SetDismissBtnState()
  local str
  if NekoData.BehaviorManager.BM_Guild:IsCoolingOff() then
    str = CStringRes:GetRecorder(1460).msgTextID
    str = TextManager.GetText(str)
  else
    str = CStringRes:GetRecorder(1459).msgTextID
    str = TextManager.GetText(str)
  end
  self._dismissBtnText:SetText(str)
end

function GuildMainMemberTabCell:OnDismissBtnClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(104, nil, function()
    local csend = LuaNetManager.CreateProtocol("protocol.party.cdismissparty")
    if csend then
      local operate = 1
      if NekoData.BehaviorManager.BM_Guild:IsCoolingOff() then
        operate = 0
      end
      csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
      csend.operate = operate
      csend:Send()
    end
  end)
end

function GuildMainMemberTabCell:OnLeaveBtnClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(105, nil, function()
    local csend = LuaNetManager.CreateProtocol("protocol.party.cleaveparty")
    if csend then
      csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
      csend:Send()
    end
  end)
end

function GuildMainMemberTabCell:OnCheckBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.party.ccheckmemberapply")
  if csend then
    csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
    csend:Send()
  end
end

function GuildMainMemberTabCell:NumberOfCell(frame)
  return #self._data
end

function GuildMainMemberTabCell:CellAtIndex(frame)
  return "guild.guildmembercell"
end

function GuildMainMemberTabCell:DataAtIndex(frame, index)
  return self._data[index]
end

function GuildMainMemberTabCell:OnCurPosChange(frame, proportion)
  local width, height = self._panel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(1 - proportion)
  else
    self._scrollBar:SetScrollSize(1)
    self._scrollBar:SetScrollValue(proportion)
  end
end

function GuildMainMemberTabCell:OnSNotifyPosition(notification)
  local data = notification.userInfo
  if data.userId == NekoData.BehaviorManager.BM_Game:GetUserId() then
    if data.position == -1 then
      self:Destroy()
      return
    end
  else
    self:RefreshCell()
  end
end

return GuildMainMemberTabCell
