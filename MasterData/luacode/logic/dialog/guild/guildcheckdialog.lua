local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local GuildCheckDialog = class("GuildCheckDialog", Dialog)
GuildCheckDialog.AssetBundleName = "ui/layouts.guild"
GuildCheckDialog.AssetName = "GuildCheck"

function GuildCheckDialog:Ctor(...)
  GuildCheckDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function GuildCheckDialog:OnCreate()
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._emptyTxt = self:GetChild("Back/EmptyTxt")
  self._toggleNoNeedCheck = self:GetChild("Back/ToggleGroup/_Toggle_0")
  self._toggleNeedCheck = self:GetChild("Back/ToggleGroup/_Toggle_1")
  self._frame = TableFrame.Create(self._panel, self, true, true)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._toggleNoNeedCheck:Subscribe_PointerClickEvent(function()
    self:ChangeCheckType(1)
  end, self)
  self._toggleNeedCheck:Subscribe_PointerClickEvent(function()
    self:ChangeCheckType(0)
  end, self)
  LuaNotificationCenter.AddObserver(self, self.OnSModifyAutoAccept, Common.n_OnSModifyAutoAccept, nil)
end

function GuildCheckDialog:OnDestroy()
  self._frame:Destroy()
end

function GuildCheckDialog:Init(list)
  self._data = list
  self._checkType = NekoData.BehaviorManager.BM_Guild:GetGuildCheckType()
  self._toggleNoNeedCheck:SetIsOnType(self._checkType == 1)
  self._toggleNeedCheck:SetIsOnType(self._checkType == 0)
  if not NekoData.BehaviorManager.BM_Guild:GetPower_ChangeJoinType() then
    self._toggleNoNeedCheck:SetInteractable(false)
    self._toggleNeedCheck:SetInteractable(false)
  end
  self._emptyTxt:SetActive(not self._data or #self._data == 0)
  if self._data then
    self._frame:ReloadAllCell()
  end
end

function GuildCheckDialog:NumberOfCell(frame)
  return #self._data
end

function GuildCheckDialog:CellAtIndex(frame)
  return "guild.guildcheckcell"
end

function GuildCheckDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function GuildCheckDialog:OnCurPosChange(frame, proportion)
  local width, height = self._panel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetScrollSize(1)
    self._scrollBar:SetScrollValue(proportion)
  end
end

function GuildCheckDialog:OnBackBtnClicked()
  self:Destroy()
end

function GuildCheckDialog:ChangeCheckType(flag)
  if not NekoData.BehaviorManager.BM_Guild:GetPower_ChangeJoinType() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100310, nil)
    return
  end
  if self._checkType == flag then
    return
  end
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(106, nil, function()
    local csend = LuaNetManager.CreateProtocol("protocol.party.cmodifyautoaccept")
    if csend then
      csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
      csend.autoAcceptApply = flag
      csend:Send()
    end
  end, nil, function()
    self._toggleNoNeedCheck:SetIsOnType(self._checkType == 1)
    self._toggleNeedCheck:SetIsOnType(self._checkType == 0)
  end)
end

function GuildCheckDialog:OnSModifyAutoAccept(notification)
  self._checkType = NekoData.BehaviorManager.BM_Guild:GetGuildCheckType()
  self._toggleNoNeedCheck:SetIsOnType(self._checkType == 1)
  self._toggleNeedCheck:SetIsOnType(self._checkType == 0)
end

return GuildCheckDialog
