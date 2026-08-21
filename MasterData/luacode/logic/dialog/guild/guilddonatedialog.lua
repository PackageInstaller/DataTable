-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guilddonatedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CGuildAttribute = (BeanManager.GetTableByName)("guild.cguildattribute")
local CDonateValue = (BeanManager.GetTableByName)("guild.cdonatevalue")
local CWtichDonate = (BeanManager.GetTableByName)("guild.cwtichdonate")
local Item = require("logic.manager.experimental.types.item")
local GuildDonateDialog = class("GuildDonateDialog", Dialog)
GuildDonateDialog.AssetBundleName = "ui/layouts.guild"
GuildDonateDialog.AssetName = "GuildDonate"
GuildDonateDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildDonateDialog
  ((GuildDonateDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._cellData = {}
  self._donateData = {}
end

GuildDonateDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._iBtn = self:GetChild("Back/Ibtn")
  self._refreshTimeText = self:GetChild("Back/RefreshTimeText")
  self._progress = self:GetChild("Back/Progress/Line1")
  self._progressPreView = self:GetChild("Back/Progress/Line2")
  self._dot = {}
  for i = 1, 5 do
    do
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R5 in 'UnsetPending'

      (self._dot)[i] = {num = self:GetChild("Back/Progress/Dot" .. i .. "/Num"), dotGrey = self:GetChild("Back/Progress/Dot" .. i .. "/DotGrey"), dot = self:GetChild("Back/Progress/Dot" .. i .. "/Dot"), itemFrame = self:GetChild("Back/Progress/Dot" .. i .. "/Award/ItemCell/_BackGround/Frame"), itemIcon = self:GetChild("Back/Progress/Dot" .. i .. "/Award/ItemCell/_BackGround/Icon"), itemCount = self:GetChild("Back/Progress/Dot" .. i .. "/Award/ItemCell/_Count"), itemGet = self:GetChild("Back/Progress/Dot" .. i .. "/Award/Get"), canReceiveEffect = self:GetChild("Back/Progress/Dot" .. i .. "/Award/Effect"), cellBack = self:GetChild("Back/Progress/Dot" .. i .. "/Award/ItemCell")}
      ;
      (((self._dot)[i]).cellBack):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnAwardClick(i)
  end
, self)
    end
  end
  self._panel = self:GetChild("Back/Frame")
  self._frame = (GridFrame.Create)(self._panel, self, true, 5)
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._addBtn = self:GetChild("Back/Num/Add")
  self._minusBtn = self:GetChild("Back/Num/Reduce")
  self._maxBtn = self:GetChild("Back/Num/MaxBtn")
  self._minBtn = self:GetChild("Back/Num/MinBtn")
  self._slideBar = self:GetChild("Back/Num/HandleScrollbar")
  self._slideBarProgress = self:GetChild("Back/Num/HandleScrollbar/__Sliding Area/Progress")
  ;
  (self._slideBar):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnScrollbarValueChange()
  end
)
  self._guildMoneyAddNum_add = self:GetChild("Back/GuildMoney/Add")
  self._guildMoneyAddNum = self:GetChild("Back/GuildMoney/Num")
  self._guildMoneyProgressPreView = self:GetChild("Back/GuildMoney/Loading/Loading/BackGround/Progress2")
  self._guildMoneyProgress = self:GetChild("Back/GuildMoney/Loading/Loading/BackGround/Progress")
  self._guildMoneyProgressNum = self:GetChild("Back/GuildMoney/Loading/Num/Num")
  self._guildMoneyProgressLim = self:GetChild("Back/GuildMoney/Loading/Num/Lim")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
  ;
  (self._minusBtn):Subscribe_PointerClickEvent(self.OnMinusBtnClick, self)
  ;
  (self._maxBtn):Subscribe_PointerClickEvent(self.OnMaxBtnClick, self)
  ;
  (self._minBtn):Subscribe_PointerClickEvent(self.OnMinBtnClick, self)
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIbtnClick, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._width = (self._panel):GetRectSize()
  self._maxPartyCoin = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(102)).Value)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_SPartyDonate, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshAward, Common.n_SReceiveDonateAward, nil)
end

GuildDonateDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

GuildDonateDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CWtichDonate, Item
  local data = ((NekoData.BehaviorManager).BM_Guild):GetPartyDonateData()
  self._donateData = {}
  local items = ((NekoData.BehaviorManager).BM_BagInfo):GetGuildDonateItems()
  self._cellData = {}
  for i,item in ipairs(items) do
    (table.insert)(self._cellData, {item = item, selectCount = 0, isSelect = false})
  end
  self._process = data.process
  self._processPreView = data.process
  self._partyCoin = data.partyCoin
  self._partyCoinPreView = data.partyCoin
  local dotIds = CWtichDonate:GetAllIds()
  for i,v in ipairs(dotIds) do
    local recorder = CWtichDonate:GetRecorder(i)
    local gain = ((NekoData.BehaviorManager).BM_Guild):IsDonateAwardGain(i)
    ;
    (((self._dot)[i]).itemGet):SetActive(gain)
    ;
    (((self._dot)[i]).num):SetText(recorder.DonatePoint)
    ;
    (((self._dot)[i]).itemCount):SetText(recorder.Awardnum)
    ;
    (((self._dot)[i]).dot):SetActive(recorder.DonatePoint <= self._process)
    ;
    (((self._dot)[i]).canReceiveEffect):SetActive((recorder.DonatePoint <= self._process and not gain))
    local item = (Item.Create)(recorder.GuildAward)
    local imageRecorder = item:GetIcon()
    ;
    (((self._dot)[i]).itemIcon):SetSprite(imageRecorder.assetBundle, imageRecorder.assetName)
    imageRecorder = item:GetPinJiImage()
    ;
    (((self._dot)[i]).itemFrame):SetSprite(imageRecorder.assetBundle, imageRecorder.assetName)
  end
  local recorder = CWtichDonate:GetRecorder(#dotIds)
  self._maxProcess = recorder.DonatePoint
  ;
  (self._progress):SetFillAmount(self._process / self._maxProcess)
  ;
  (self._progressPreView):SetFillAmount(self._process / self._maxProcess)
  ;
  (self._guildMoneyProgress):SetFillAmount(self._partyCoin / self._maxPartyCoin)
  ;
  (self._guildMoneyProgressPreView):SetFillAmount(self._partyCoin / self._maxPartyCoin)
  ;
  (self._guildMoneyProgressLim):SetText(self._maxPartyCoin)
  ;
  (self._guildMoneyProgressNum):SetText(self._partyCoin)
  ;
  (self._guildMoneyAddNum):SetText(0)
  ;
  (self._guildMoneyAddNum):SetActive(false)
  ;
  (self._guildMoneyAddNum_add):SetActive(false)
  ;
  (self._frame):ReloadAllCell()
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

GuildDonateDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local data = ((NekoData.BehaviorManager).BM_Guild):GetPartyDonateData()
  self._donateData = {}
  self._process = data.process
  self._processPreView = data.process
  self._partyCoin = data.partyCoin
  self._partyCoinPreView = data.partyCoin
  ;
  (self._progress):SetFillAmount(self._process / self._maxProcess)
  ;
  (self._progressPreView):SetFillAmount(self._process / self._maxProcess)
  ;
  (self._guildMoneyProgress):SetFillAmount(self._partyCoin / self._maxPartyCoin)
  ;
  (self._guildMoneyProgressPreView):SetFillAmount(self._partyCoin / self._maxPartyCoin)
  ;
  (self._guildMoneyProgressLim):SetText(self._maxPartyCoin)
  ;
  (self._guildMoneyProgressNum):SetText(self._partyCoin)
  ;
  (self._guildMoneyAddNum):SetText(0)
  ;
  (self._guildMoneyAddNum):SetActive(false)
  ;
  (self._guildMoneyAddNum_add):SetActive(false)
  local items = ((NekoData.BehaviorManager).BM_BagInfo):GetGuildDonateItems()
  self._cellData = {}
  for i,item in ipairs(items) do
    (table.insert)(self._cellData, {item = item, selectCount = 0, isSelect = false})
  end
  ;
  (self._frame):FireEvent("ClearSelectData")
  ;
  (self._frame):ReloadAllCell()
  self._selectItemKey = nil
  self:RefreshDonateData()
  self:RefreshAward()
end

GuildDonateDialog.RefreshAward = function(self)
  -- function num : 0_5 , upvalues : CWtichDonate, _ENV
  local dotIds = CWtichDonate:GetAllIds()
  for i,v in ipairs(dotIds) do
    local gain = ((NekoData.BehaviorManager).BM_Guild):IsDonateAwardGain(i)
    local recorder = CWtichDonate:GetRecorder(i)
    ;
    (((self._dot)[i]).dot):SetActive(recorder.DonatePoint <= self._process)
    ;
    (((self._dot)[i]).canReceiveEffect):SetActive((recorder.DonatePoint <= self._process and not gain))
    ;
    (((self._dot)[i]).itemGet):SetActive(gain)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

GuildDonateDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._cellData
end

GuildDonateDialog.CellAtIndex = function(self, frame)
  -- function num : 0_7
  return "guild.guilddonateitemcell"
end

GuildDonateDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._cellData)[index]
end

GuildDonateDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_9
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

GuildDonateDialog.SetSelectedItemData = function(self, data)
  -- function num : 0_10 , upvalues : _ENV, CDonateValue
  self._btnChanging = true
  self._selectItemKey = data.key
  self._seleckItemCount = data.selectCount
  self._selectItemMaxCount = data.maxCount
  ;
  (self._frame):FireEvent("SetItemSelectedState", self._selectItemKey)
  local itemId = ((NekoData.BehaviorManager).BM_BagInfo):GetItemID(self._selectItemKey)
  local recorder = CDonateValue:GetRecorder(itemId)
  self._canSelectMaxNum = (self._maxPartyCoin - self._partyCoinPreView) / recorder.Awardnumicon + data.selectCount
  self._canSelectMaxNum = (math.ceil)(self._canSelectMaxNum)
  if self._selectItemMaxCount < self._canSelectMaxNum then
    self._canSelectMaxNum = self._selectItemMaxCount
  end
  if self._seleckItemCount == 0 then
    (self._slideBar):SetScrollValue(0)
  else
    ;
    (self._slideBar):SetScrollValue(self._seleckItemCount / self._canSelectMaxNum)
  end
  ;
  (self._slideBarProgress):SetFillAmount((self._slideBar):GetScrollValue())
  if self._seleckItemCount == 0 then
    if self._partyCoinPreView < self._maxPartyCoin then
      self:OnAddBtnClick()
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100367)
      ;
      (self._frame):FireEvent("SetItemSelectedState", nil)
      self._selectItemKey = nil
    end
  end
  self._btnChanging = false
end

GuildDonateDialog.OnAddBtnClick = function(self)
  -- function num : 0_11 , upvalues : _ENV, CDonateValue
  self._btnChanging = true
  if not self._selectItemKey then
    self._btnChanging = false
    return 
  end
  if self._selectItemMaxCount <= self._seleckItemCount then
    return 
  end
  if self._partyCoinPreView < self._maxPartyCoin then
    local itemId = ((NekoData.BehaviorManager).BM_BagInfo):GetItemID(self._selectItemKey)
    local recorder = CDonateValue:GetRecorder(itemId)
    self._partyCoinPreView = self._partyCoinPreView + recorder.Awardnumicon
    self._processPreView = self._processPreView + recorder.Donatenum
    self._seleckItemCount = self._seleckItemCount + 1
    self:RefreshDonateData()
    self:RefreshSlideState()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100367)
      self._btnChanging = false
    end
  end
end

GuildDonateDialog.OnMinusBtnClick = function(self)
  -- function num : 0_12 , upvalues : _ENV, CDonateValue
  self._btnChanging = true
  if not self._selectItemKey then
    self._btnChanging = false
    return 
  end
  if self._seleckItemCount == 0 then
    self._btnChanging = false
    return 
  end
  local itemId = ((NekoData.BehaviorManager).BM_BagInfo):GetItemID(self._selectItemKey)
  local recorder = CDonateValue:GetRecorder(itemId)
  self._partyCoinPreView = self._partyCoinPreView - recorder.Awardnumicon
  self._processPreView = self._processPreView - recorder.Donatenum
  self._seleckItemCount = self._seleckItemCount - 1
  self:RefreshDonateData()
  self:RefreshSlideState()
  self._btnChanging = false
end

GuildDonateDialog.OnMaxBtnClick = function(self)
  -- function num : 0_13 , upvalues : _ENV, CDonateValue
  self._btnChanging = true
  if not self._selectItemKey then
    self._btnChanging = false
    return 
  end
  if self._partyCoinPreView < self._maxPartyCoin then
    local itemId = ((NekoData.BehaviorManager).BM_BagInfo):GetItemID(self._selectItemKey)
    local recorder = CDonateValue:GetRecorder(itemId)
    local remainingCount = (self._maxPartyCoin - self._partyCoinPreView) / recorder.Awardnumicon
    remainingCount = (math.ceil)(remainingCount)
    if self._selectItemMaxCount < remainingCount then
      local addcount = self._selectItemMaxCount - self._seleckItemCount
      self._seleckItemCount = self._seleckItemCount + addcount
      self._partyCoinPreView = self._partyCoinPreView + recorder.Awardnumicon * addcount
      self._processPreView = self._processPreView + recorder.Donatenum * addcount
    else
      do
        do
          do
            local addcount = nil
            if self._seleckItemCount + remainingCount < self._selectItemMaxCount then
              addcount = remainingCount
            else
              addcount = self._selectItemMaxCount - self._seleckItemCount
            end
            self._seleckItemCount = self._seleckItemCount + (addcount)
            self._partyCoinPreView = self._partyCoinPreView + recorder.Awardnumicon * (addcount)
            self._processPreView = self._processPreView + recorder.Donatenum * (addcount)
            self:RefreshDonateData()
            self:RefreshSlideState()
            self._btnChanging = false
          end
        end
      end
    end
  end
end

GuildDonateDialog.OnMinBtnClick = function(self)
  -- function num : 0_14 , upvalues : _ENV, CDonateValue
  self._btnChanging = true
  if not self._selectItemKey then
    self._btnChanging = false
    return 
  end
  local minusCount = self._seleckItemCount
  local itemId = ((NekoData.BehaviorManager).BM_BagInfo):GetItemID(self._selectItemKey)
  local recorder = CDonateValue:GetRecorder(itemId)
  self._partyCoinPreView = self._partyCoinPreView - recorder.Awardnumicon * minusCount
  self._processPreView = self._processPreView - recorder.Donatenum * minusCount
  self._seleckItemCount = 0
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._donateData)[self._selectItemKey] = nil
  self:RefreshDonateData()
  self:RefreshSlideState()
  self._btnChanging = false
end

GuildDonateDialog.OnScrollbarValueChange = function(self)
  -- function num : 0_15
  if not self._btnChanging then
    self:RefreshSlideState((self._slideBar):GetScrollValue())
  end
end

GuildDonateDialog.RefreshSlideState = function(self, currentRate)
  -- function num : 0_16 , upvalues : _ENV, CDonateValue
  if not self._canSelectMaxNum or self._canSelectMaxNum == 0 then
    return 
  end
  if currentRate then
    local changeCount = (math.floor)(self._canSelectMaxNum * currentRate) - self._seleckItemCount
    ;
    (self._slideBar):SetScrollValue(currentRate)
    self._seleckItemCount = self._seleckItemCount + changeCount
    local itemId = ((NekoData.BehaviorManager).BM_BagInfo):GetItemID(self._selectItemKey)
    local recorder = CDonateValue:GetRecorder(itemId)
    self._partyCoinPreView = self._partyCoinPreView + recorder.Awardnumicon * changeCount
    self._processPreView = self._processPreView + recorder.Donatenum * changeCount
    self:RefreshDonateData()
  else
    do
      do
        local rate = 0
        if self._canSelectMaxNum ~= 0 then
          rate = self._seleckItemCount / self._canSelectMaxNum
        end
        ;
        (self._slideBar):SetScrollValue(rate)
        ;
        (self._slideBarProgress):SetFillAmount((self._slideBar):GetScrollValue())
      end
    end
  end
end

GuildDonateDialog.RefreshDonateData = function(self)
  -- function num : 0_17
  if not self._selectItemKey then
    (self._guildMoneyProgressPreView):SetFillAmount(self._partyCoin / self._maxPartyCoin)
    ;
    (self._progressPreView):SetFillAmount(self._process / self._maxProcess)
    ;
    (self._guildMoneyAddNum):SetText(0)
    ;
    (self._guildMoneyAddNum):SetActive(false)
    ;
    (self._guildMoneyAddNum_add):SetActive(false)
    return 
  end
  ;
  (self._frame):FireEvent("ChangeItemSelectCount", {key = self._selectItemKey, count = self._seleckItemCount})
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  if self._seleckItemCount == 0 then
    (self._donateData)[self._selectItemKey] = nil
  else
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._donateData)[self._selectItemKey] = self._seleckItemCount
  end
  ;
  (self._progressPreView):SetFillAmount(self._processPreView / self._maxProcess)
  ;
  (self._guildMoneyProgressPreView):SetFillAmount(self._partyCoinPreView / self._maxPartyCoin)
  local addCount = self._partyCoinPreView - self._partyCoin
  ;
  (self._guildMoneyAddNum):SetText(addCount)
  ;
  (self._guildMoneyAddNum):SetActive(addCount > 0)
  ;
  (self._guildMoneyAddNum_add):SetActive(addCount > 0)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

GuildDonateDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local donateInfoList = {}
  for k,v in pairs(self._donateData) do
    (table.insert)(donateInfoList, {itemKey = k, count = v})
  end
  if #donateInfoList > 0 then
    local dialog = (DialogManager.CreateSingletonDialog)("guild.guilddonateconfirm")
    dialog:SetData(donateInfoList)
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100354)
    end
  end
end

GuildDonateDialog.OnAwardClick = function(self, index)
  -- function num : 0_19 , upvalues : CWtichDonate, _ENV, Item
  local dotRecorder = CWtichDonate:GetRecorder(index)
  if dotRecorder.DonatePoint <= self._process and not ((NekoData.BehaviorManager).BM_Guild):IsDonateAwardGain(index) then
    local csend = (LuaNetManager.CreateProtocol)("protocol.party.creceivedonateaward")
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    csend.awardId = index
    csend:Send()
  else
    do
      local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
      if tipsDialog then
        tipsDialog:Init({item = (Item.Create)(35004)})
        local width, height = (self:GetRootWindow()):GetRectSize()
        tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
      end
    end
  end
end

GuildDonateDialog.OnBackBtnClicked = function(self)
  -- function num : 0_20
  self:Destroy()
end

GuildDonateDialog.OnIbtnClick = function(self)
  -- function num : 0_21 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("guild.guilddonatetips")
end

GuildDonateDialog.AddNewModal = function(self)
  -- function num : 0_22
end

return GuildDonateDialog

