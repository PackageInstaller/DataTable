-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/spiritrecovercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local CapitemCfg = (BeanManager.GetTableByName)("item.capitemconfig")
local CSoulapCfg = (BeanManager.GetTableByName)("item.csoulapconfig")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local SpiritRecoverCell = class("SpiritRecoverCell", Dialog)
SpiritRecoverCell.AssetBundleName = "ui/layouts.spirit"
SpiritRecoverCell.AssetName = "SpiritRecoverCell"
local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60
local GetDelTimeStr = function(ms)
  -- function num : 0_0 , upvalues : SecToDay, _ENV, SecToHour, SecToMin
  local sec = ms // 1000
  local str = nil
  if SecToDay * 3 < sec then
    str = (TextManager.GetText)(700685)
    str = (string.gsub)(str, "%$parameter1%$", (math.floor)((os.date)("!%d", sec) - 1))
    str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%H", sec))
  else
    if SecToDay < sec then
      str = (TextManager.GetText)(700695)
      str = (string.gsub)(str, "%$parameter1%$", (math.floor)((os.date)("!%d", sec) - 1))
      str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%H", sec))
    else
      if SecToHour < sec then
        str = (TextManager.GetText)(700686)
        str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", sec))
        str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", sec))
      else
        if SecToMin < sec then
          str = (TextManager.GetText)(700687)
          str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%M", sec))
        else
          str = (TextManager.GetText)(700688)
        end
      end
    end
  end
  return str
end

SpiritRecoverCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : SpiritRecoverCell
  ((SpiritRecoverCell.super).Ctor)(self, ...)
  self._apitemCfg = nil
  self._itemName = nil
  self._delTime = nil
  self._itemKey = nil
end

SpiritRecoverCell.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("Num")
  self._countDesText = self:GetChild("Txt")
  self._name = self:GetChild("ItemName")
  self._describe = self:GetChild("Detail")
  self._limitTxt = self:GetChild("TextNum")
  self._delTimeTxt = self:GetChild("TimeRemain")
  self._applyBtn = self:GetChild("ApplyBtn")
  ;
  (self._applyBtn):Subscribe_PointerClickEvent(self.OnMouseClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpiritRecoverTimes, Common.n_RefreshSpirit, nil)
end

SpiritRecoverCell.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

SpiritRecoverCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, CSoulapCfg, CapitemCfg, CstringCfg
  local imageRecord = (data.item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local itemName = (data.item):GetName()
  ;
  (self._name):SetText(itemName)
  ;
  (self._count):SetText(tostring((data.item):GetCount()))
  if (data.item):IsSoulDrop() then
    self._souldrApCfg = CSoulapCfg:GetRecorder((data.item):GetID())
    self._apitemCfg = {}
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._apitemCfg).id = (self._souldrApCfg).id
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._apitemCfg).dailyLimitNum = (self._souldrApCfg).dailyLimitNum
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._apitemCfg).itemnums = (self._souldrApCfg).apNums
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._apitemCfg).itemids = DataCommon.SpiritID
    local recoveTimes = ((NekoData.BehaviorManager).BM_Currency):GetSpiritRecoverTimes()
    local time = recoveTimes[((self._cellData).item):GetID()] or 0
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R6 in 'UnsetPending'

    if time < #(self._souldrApCfg).soulCost then
      (self._apitemCfg).currencynums = ((self._souldrApCfg).soulCost)[time + 1]
    else
      -- DECOMPILER ERROR at PC94: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._apitemCfg).currencynums = ((self._souldrApCfg).soulCost)[#(self._souldrApCfg).soulCost]
    end
  else
    do
      if (data.item):GetID() == DataCommon.SpriteEvidence then
        self._souldrApCfg = CSoulapCfg:GetRecorder((data.item):GetID())
        self._apitemCfg = {}
        -- DECOMPILER ERROR at PC115: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self._apitemCfg).id = (self._souldrApCfg).id
        -- DECOMPILER ERROR at PC119: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self._apitemCfg).dailyLimitNum = (self._souldrApCfg).dailyLimitNum
        -- DECOMPILER ERROR at PC123: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self._apitemCfg).itemnums = (self._souldrApCfg).apNums
        -- DECOMPILER ERROR at PC127: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self._apitemCfg).itemids = DataCommon.SpriteEvidence
        -- DECOMPILER ERROR at PC132: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self._apitemCfg).currencynums = ((self._souldrApCfg).soulCost)[1]
      else
        self._apitemCfg = CapitemCfg:GetRecorder((data.item):GetID())
      end
      if not self._apitemCfg then
        LogError("item ", "capitemcfg not has item " .. (data.item):GetID())
        return 
      end
      self._itemName = (data.item):GetName()
      self._delTime = (data.item):GetDelTime()
      local str = (CstringCfg:GetRecorder(1023)).msgTextID
      if (data.item):GetID() == DataCommon.SpringFestivalFuRecoverItem then
        str = (TextManager.GetText)(701763)
      else
        if (data.item):GetID() == DataCommon.SpriteEvidence then
          str = ((NekoData.BehaviorManager).BM_Message):GetString(2098)
        else
          str = (TextManager.GetText)(str)
        end
      end
      if (self._apitemCfg).itemnums == -1 then
        str = (string.gsub)(str, "%$parameter1%$", (self._apitemCfg).currencynums)
        str = (string.gsub)(str, "%$parameter2%$", ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull())
      else
        if (self._apitemCfg).itemnums == -2 then
          str = (string.gsub)(str, "%$parameter1%$", (self._apitemCfg).currencynums)
          str = (string.gsub)(str, "%$parameter2%$", (math.ceil)(((NekoData.BehaviorManager).BM_Currency):GetSpiritFull() / 2))
        else
          str = (string.gsub)(str, "%$parameter1%$", (self._apitemCfg).currencynums)
          str = (string.gsub)(str, "%$parameter2%$", (self._apitemCfg).itemnums)
        end
      end
      ;
      (self._describe):SetText(str)
      ;
      (self._limitTxt):SetActive((self._apitemCfg).dailyLimitNum ~= -1)
      if (self._apitemCfg).dailyLimitNum ~= -1 then
        self:SetLeftRecoverTimes()
      else
        (self._limitTxt):SetUserData(nil)
      end
      if self._task then
        (ServerGameTimer.RemoveTask)(self._task)
        self._task = nil
      end
      if self._delTime then
        (self._delTimeTxt):SetActive(true)
        self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_4_0 , upvalues : self
    self:SpiritTask()
  end
, nil)
      else
        (self._delTimeTxt):SetActive(false)
      end
      ;
      (self._applyBtn):SetInteractable(true)
      ;
      (self._count):SetActive(true)
      ;
      (self._countDesText):SetActive(true)
      if (data.item):GetID() == DataCommon.SpriteEvidence then
        (self._delTimeTxt):SetActive(false)
        ;
        (self._count):SetActive(false)
        ;
        (self._countDesText):SetActive(false)
        local haveSpriteEvidence = (((NekoData.BehaviorManager).BM_Currency):GetSpiritRecoverTimes())[DataCommon.SpriteEvidence]
        ;
        (self._applyBtn):SetInteractable(haveSpriteEvidence == 0)
      end
      -- DECOMPILER ERROR: 8 unprocessed JMP targets
    end
  end
end

SpiritRecoverCell.SpiritTask = function(self)
  -- function num : 0_5 , upvalues : _ENV, GetDelTimeStr
  local time = self._delTime - (ServerGameTimer.GetServerTime)()
  if time > 0 then
    (self._delTimeTxt):SetText(GetDelTimeStr(time))
  else
    local CUpdateLimitedItems = (LuaNetManager.CreateProtocol)("protocol.item.cupdatelimiteditems")
    if CUpdateLimitedItems then
      CUpdateLimitedItems.itemKey = ((self._cellData).item):GetKey()
      CUpdateLimitedItems.itemId = ((self._cellData).item):GetID()
      CUpdateLimitedItems:Send()
    end
    ;
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

SpiritRecoverCell.SetLeftRecoverTimes = function(self)
  -- function num : 0_6 , upvalues : CstringCfg, _ENV, CWordColor
  local str = (CstringCfg:GetRecorder(1114)).msgTextID
  str = (TextManager.GetText)(str)
  local recoveTimes = ((NekoData.BehaviorManager).BM_Currency):GetSpiritRecoverTimes()
  local time = recoveTimes[((self._cellData).item):GetID()] or 0
  if (self._apitemCfg).dailyLimitNum - time > 0 then
    str = (string.gsub)(str, "%$parameter1%$", (CWordColor:GetRecorder(5)).wordcolor)
  else
    str = (string.gsub)(str, "%$parameter1%$", (CWordColor:GetRecorder(6)).wordcolor)
  end
  str = (string.gsub)(str, "%$parameter2%$", (self._apitemCfg).dailyLimitNum - time)
  ;
  (self._limitTxt):SetText(str)
  ;
  (self._limitTxt):SetUserData((self._apitemCfg).dailyLimitNum - time)
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R4 in 'UnsetPending'

  if ((self._cellData).item):GetID() == DataCommon.SoulDropID then
    if time < #(self._souldrApCfg).soulCost then
      (self._apitemCfg).currencynums = ((self._souldrApCfg).soulCost)[time + 1]
    else
      -- DECOMPILER ERROR at PC97: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._apitemCfg).currencynums = ((self._souldrApCfg).soulCost)[#(self._souldrApCfg).soulCost]
    end
    local str = (CstringCfg:GetRecorder(1023)).msgTextID
    str = (TextManager.GetText)(str)
    if (self._apitemCfg).itemnums == -1 then
      str = (string.gsub)(str, "%$parameter1%$", (self._apitemCfg).currencynums)
      str = (string.gsub)(str, "%$parameter2%$", ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull())
    else
      if (self._apitemCfg).itemnums == -2 then
        str = (string.gsub)(str, "%$parameter1%$", (self._apitemCfg).currencynums)
        str = (string.gsub)(str, "%$parameter2%$", (math.ceil)(((NekoData.BehaviorManager).BM_Currency):GetSpiritFull() / 2))
      else
        str = (string.gsub)(str, "%$parameter1%$", (self._apitemCfg).currencynums)
        str = (string.gsub)(str, "%$parameter2%$", (self._apitemCfg).itemnums)
      end
    end
    ;
    (self._describe):SetText(str)
  end
end

SpiritRecoverCell.OnMouseClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local leftTimes = (self._limitTxt):GetUserData()
  if leftTimes and leftTimes <= 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100086)
    return 
  end
  if ((self._cellData).item):IsSoulDrop() and not ((NekoData.BehaviorManager).BM_Currency):IsSoulDropEnough((self._apitemCfg).currencynums) then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(108, nil, function()
    -- function num : 0_7_0 , upvalues : _ENV
    ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(19)
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
, {}, nil, {})
    return 
  end
  if ((self._cellData).item):GetCount() < (self._apitemCfg).currencynums then
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("bag.spiritrecoverconfirmdialog")
  if dialog then
    dialog:Refresh(self._apitemCfg, self._itemName, self._delTime)
  end
end

SpiritRecoverCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_8
  if eventName == "RefreshCell" and ((self._cellData).item):GetKey() == (arg.item):GetKey() then
    self:RefreshCell(arg)
  end
end

SpiritRecoverCell.OnRefreshSpiritRecoverTimes = function(self)
  -- function num : 0_9
  if (self._apitemCfg).dailyLimitNum ~= -1 then
    self:SetLeftRecoverTimes()
  else
    ;
    (self._limitTxt):SetUserData(nil)
  end
end

return SpiritRecoverCell

