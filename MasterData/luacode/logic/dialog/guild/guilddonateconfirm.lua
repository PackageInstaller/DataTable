local TableFrame = require("framework.ui.frame.table.tableframe")
local CDonateValue = BeanManager.GetTableByName("guild.cdonatevalue")
local UIManager = CS.PixelNeko.UI.UIManager
local GuildDonateConfirm = class("GuildDonateConfirm", Dialog)
GuildDonateConfirm.AssetBundleName = "ui/layouts.guild"
GuildDonateConfirm.AssetName = "GuildDonateConfirm"

function GuildDonateConfirm:Ctor(...)
  GuildDonateConfirm.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._cellData = {}
end

function GuildDonateConfirm:OnCreate()
  self._back = self:GetChild("Back")
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, false, true)
  self._leftArrow = self:GetChild("Back/LeftArrow")
  self._rightArrow = self:GetChild("Back/RightArrow")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._coinNum = self:GetChild("Back/Text2/Num")
  self._exp = self:GetChild("Back/Text4")
  self._expNum = self:GetChild("Back/Text4/Num")
  self._process = self:GetChild("Back/Text3")
  self._processNum = self:GetChild("Back/Text3/Num")
  self._tips = self:GetChild("Back/Tips")
  self._tips:SetActive(false)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClicked, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.Close, self)
end

function GuildDonateConfirm:OnDestroy()
  self._frame:Destroy()
end

function GuildDonateConfirm:SetData(donateInfoList)
  local coin = 0
  local exp = 0
  local process = 0
  for i, v in ipairs(donateInfoList) do
    local itemID = NekoData.BehaviorManager.BM_BagInfo:GetItemID(v.itemKey)
    local recorder = CDonateValue:GetRecorder(itemID)
    coin = coin + recorder.Awardnumicon * v.count
    exp = exp + recorder.GuildExpnum * v.count
    process = process + recorder.Donatenum * v.count
  end
  self._coinNum:SetText(coin)
  self._expNum:SetText(exp)
  self._processNum:SetText(process)
  self._cellData = donateInfoList
  self._frame:ReloadAllCell()
  local width = self._panel:GetRectSize()
  if width < self._frame:GetTotalLength() then
    self._leftArrow:SetActive(false)
  else
    self._leftArrow:SetActive(false)
    self._rightArrow:SetActive(false)
  end
end

function GuildDonateConfirm:NumberOfCell(frame)
  return #self._cellData
end

function GuildDonateConfirm:CellAtIndex(frame)
  return "guild.guilddonateconfirmitemcell"
end

function GuildDonateConfirm:OnLeftArrowClicked()
  local rightIndex = self._frame:GetRightIndex()
  self._frame:MoveRightToIndex(rightIndex - 1, true)
end

function GuildDonateConfirm:OnRightArrowClicked()
  local leftIndex = self._frame:GetLeftIndex()
  self._frame:MoveLeftToIndex(leftIndex + 1, true)
end

function GuildDonateConfirm:OnCurPosChange(frame, tag)
  local width = self._panel:GetRectSize()
  if width < self._frame:GetTotalLength() and frame == self._frame then
    self._leftArrow:SetActive(tag ~= 0)
    self._rightArrow:SetActive(tag ~= 1)
  end
end

function GuildDonateConfirm:DataAtIndex(frame, index)
  return self._cellData[index]
end

function GuildDonateConfirm:OnConfirmBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.party.cpartydonate")
  csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
  local donateItems = {}
  for i, v in ipairs(self._cellData) do
    local id = NekoData.BehaviorManager.BM_BagInfo:GetItemID(v.itemKey)
    donateItems[id] = v.count
  end
  csend.donateItems = donateItems
  csend:Send()
  self:Destroy()
end

function GuildDonateConfirm:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:Destroy()
  end
end

function GuildDonateConfirm:Close(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.position.x, args.position.y) then
    self:OnBackBtnClicked()
  end
end

function GuildDonateConfirm:OnBackBtnClicked()
  self:Destroy()
end

return GuildDonateConfirm
