local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GuildMemberDialog = class("GuildMemberDialog", Dialog)
GuildMemberDialog.AssetBundleName = "ui/layouts.guild"
GuildMemberDialog.AssetName = "GuildMember"

function GuildMemberDialog:Ctor(...)
  GuildMemberDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = nil
end

function GuildMemberDialog:OnCreate()
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._num = self:GetChild("Back/Num/Num")
  self._numMax = self:GetChild("Back/Num/NumMax")
  self._dismissBtn = self:GetChild("Back/DismissBtn")
  self._dismissBtnText = self:GetChild("Back/DismissBtn/_Text")
  self._leaveBtn = self:GetChild("Back/LeaveBtn")
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._dismissBtn:Subscribe_PointerClickEvent(self.OnDismissBtnClicked, self)
  self._leaveBtn:Subscribe_PointerClickEvent(self.OnLeaveBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.SetDismissBtnState, Common.n_OnSDismissParty, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSNotifyPosition, Common.n_OnSNotifyPosition, nil)
end

function GuildMemberDialog:OnDestroy()
  self._frame:Destroy()
end

function GuildMemberDialog:Init(list)
  self._data = list
  self._num:SetText(#self._data)
  self._numMax:SetText(NekoData.BehaviorManager.BM_Guild:GetGuildTotalCount())
  self._dismissBtn:SetActive(NekoData.BehaviorManager.BM_Guild:GetPower_DissolveGuild())
  self:SetDismissBtnState()
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function GuildMemberDialog:SetDismissBtnState()
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

function GuildMemberDialog:OnBackBtnClicked()
  self:Destroy()
end

function GuildMemberDialog:OnDismissBtnClicked()
  if NekoData.BehaviorManager.BM_Guild:IsCoolingOff() then
    local csend = LuaNetManager.CreateProtocol("protocol.party.cdismissparty")
    if csend then
      local operate = 0
      csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
      csend.operate = operate
      csend:Send()
    end
  else
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(104, nil, function()
      local csend = LuaNetManager.CreateProtocol("protocol.party.cdismissparty")
      if csend then
        local operate = 1
        csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
        csend.operate = operate
        csend:Send()
      end
    end)
  end
end

function GuildMemberDialog:OnLeaveBtnClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(105, nil, function()
    local csend = LuaNetManager.CreateProtocol("protocol.party.cleaveparty")
    if csend then
      csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
      csend:Send()
    end
  end)
end

function GuildMemberDialog:NumberOfCell(frame)
  return #self._data
end

function GuildMemberDialog:CellAtIndex(frame)
  return "guild.guildmembercell"
end

function GuildMemberDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function GuildMemberDialog:OnCurPosChange(frame, proportion)
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

function GuildMemberDialog:OnSNotifyPosition(notification)
  local data = notification.userInfo
  if data.userId == NekoData.BehaviorManager.BM_Game:GetUserId() and data.position == -1 then
    self:Destroy()
    return
  end
end

return GuildMemberDialog
