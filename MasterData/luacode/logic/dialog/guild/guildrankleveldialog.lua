local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local GuildRankLevelDialog = class("GuildRankLevelDialog", Dialog)
GuildRankLevelDialog.AssetBundleName = "ui/layouts.guild"
GuildRankLevelDialog.AssetName = "GuildRank_Level"
local BottomToTop = 3

function GuildRankLevelDialog:Ctor(...)
  GuildRankLevelDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

function GuildRankLevelDialog:OnCreate()
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._noDataImage = self:GetChild("Image")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnSOpenParty, Common.n_OnSOpenParty, nil)
end

function GuildRankLevelDialog:OnDestroy()
  self._frame:Destroy()
end

function GuildRankLevelDialog:OnSOpenParty()
  DialogManager.DestroySingletonDialog("guild.guildrankleveldialog")
end

function GuildRankLevelDialog:SetData(protocol)
  if protocol and #protocol.allParty > 0 then
    self._noDataImage:SetActive(false)
    self._data = protocol.allParty
  else
    self._noDataImage:SetActive(true)
    for index, _ in ipairs(self._data) do
      self._data[index] = nil
    end
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function GuildRankLevelDialog:NumberOfCell(frame)
  return #self._data
end

function GuildRankLevelDialog:CellAtIndex(frame)
  return "guild.guildlevelrankcell"
end

function GuildRankLevelDialog:DataAtIndex(frame, index)
  return {
    data = self._data[index],
    index = index
  }
end

function GuildRankLevelDialog:OnCurPosChange(frame, proportion)
  local width, height = self._panel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(1 - proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function GuildRankLevelDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("guild.guildrankleveldialog")
end

return GuildRankLevelDialog
