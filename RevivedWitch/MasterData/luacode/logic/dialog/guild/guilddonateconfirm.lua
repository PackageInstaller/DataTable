-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guilddonateconfirm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CDonateValue = (BeanManager.GetTableByName)("guild.cdonatevalue")
local UIManager = ((CS.PixelNeko).UI).UIManager
local GuildDonateConfirm = class("GuildDonateConfirm", Dialog)
GuildDonateConfirm.AssetBundleName = "ui/layouts.guild"
GuildDonateConfirm.AssetName = "GuildDonateConfirm"
GuildDonateConfirm.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildDonateConfirm
  ((GuildDonateConfirm.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._cellData = {}
end

GuildDonateConfirm.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._back = self:GetChild("Back")
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, false, true)
  self._leftArrow = self:GetChild("Back/LeftArrow")
  self._rightArrow = self:GetChild("Back/RightArrow")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._coinNum = self:GetChild("Back/Text2/Num")
  self._exp = self:GetChild("Back/Text4")
  self._expNum = self:GetChild("Back/Text4/Num")
  self._process = self:GetChild("Back/Text3")
  self._processNum = self:GetChild("Back/Text3/Num")
  self._tips = self:GetChild("Back/Tips")
  ;
  (self._tips):SetActive(false)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.Close, self)
end

GuildDonateConfirm.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GuildDonateConfirm.SetData = function(self, donateInfoList)
  -- function num : 0_3 , upvalues : _ENV, CDonateValue
  local coin = 0
  local exp = 0
  local process = 0
  for i,v in ipairs(donateInfoList) do
    local itemID = ((NekoData.BehaviorManager).BM_BagInfo):GetItemID(v.itemKey)
    local recorder = CDonateValue:GetRecorder(itemID)
    coin = coin + recorder.Awardnumicon * v.count
    exp = exp + recorder.GuildExpnum * v.count
    process = process + recorder.Donatenum * v.count
  end
  ;
  (self._coinNum):SetText(coin)
  ;
  (self._expNum):SetText(exp)
  ;
  (self._processNum):SetText(process)
  self._cellData = donateInfoList
  ;
  (self._frame):ReloadAllCell()
  local width = (self._panel):GetRectSize()
  if width < (self._frame):GetTotalLength() then
    (self._leftArrow):SetActive(false)
  else
    ;
    (self._leftArrow):SetActive(false)
    ;
    (self._rightArrow):SetActive(false)
  end
end

GuildDonateConfirm.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._cellData
end

GuildDonateConfirm.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "guild.guilddonateconfirmitemcell"
end

GuildDonateConfirm.OnLeftArrowClicked = function(self)
  -- function num : 0_6
  local rightIndex = (self._frame):GetRightIndex()
  ;
  (self._frame):MoveRightToIndex(rightIndex - 1, true)
end

GuildDonateConfirm.OnRightArrowClicked = function(self)
  -- function num : 0_7
  local leftIndex = (self._frame):GetLeftIndex()
  ;
  (self._frame):MoveLeftToIndex(leftIndex + 1, true)
end

GuildDonateConfirm.OnCurPosChange = function(self, frame, tag)
  -- function num : 0_8
  local width = (self._panel):GetRectSize()
  if tag == 0 then
    (self._leftArrow):SetActive(width >= (self._frame):GetTotalLength() or frame ~= self._frame)
    ;
    (self._rightArrow):SetActive(tag ~= 1)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

GuildDonateConfirm.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._cellData)[index]
end

GuildDonateConfirm.OnConfirmBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cpartydonate")
  csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
  local donateItems = {}
  for i,v in ipairs(self._cellData) do
    local id = ((NekoData.BehaviorManager).BM_BagInfo):GetItemID(v.itemKey)
    donateItems[id] = v.count
  end
  csend.donateItems = donateItems
  csend:Send()
  self:Destroy()
end

GuildDonateConfirm.OnEveryWhereClick = function(self, args)
  -- function num : 0_11 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:Destroy()
  end
end

GuildDonateConfirm.Close = function(self, args)
  -- function num : 0_12 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (args.position).x, (args.position).y) then
    self:OnBackBtnClicked()
  end
end

GuildDonateConfirm.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

return GuildDonateConfirm

