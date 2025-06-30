-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/lover/loverflowerlistdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CSendFlowersDef = (LuaNetManager.GetProtocolDef)("protocol.activity.csendflowers")
local SLoverRedPoint = (LuaNetManager.GetProtocolDef)("protocol.activity.sloverredpoint")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CValentineFlower = (BeanManager.GetTableByName)("activity.cvalentineflower")
local LoverFlowerListDialog = class("LoverFlowerListDialog", Dialog)
LoverFlowerListDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverFlowerListDialog.AssetName = "ActivityValentinesFlower"
local awardNum = 5
local TalkType = {StandBy = 1, SendFlower = 2}
local timeofword = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(88)).Value)
LoverFlowerListDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoverFlowerListDialog, _ENV, CSendFlowersDef
  ((LoverFlowerListDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._currentNum = {}
  self._maxNum = {}
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.LoverActivityManagerID)
  self._contentTimer = {
[CSendFlowersDef.LEFT] = {}
, 
[CSendFlowersDef.RIGTH] = {}
}
  self._isCool = false
end

LoverFlowerListDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : CSendFlowersDef, _ENV, TableFrame, Item, TalkType
  self._topGroup = self:GetChild("TopGroup")
  self._textUI = {
[CSendFlowersDef.LEFT] = {}
, 
[CSendFlowersDef.RIGTH] = {}
}
  self._roleUI = {
[CSendFlowersDef.LEFT] = {}
, 
[CSendFlowersDef.RIGTH] = {}
}
  self._itemUI = {
[CSendFlowersDef.LEFT] = {}
, 
[CSendFlowersDef.RIGTH] = {}
}
  for _,rewardType in ipairs({CSendFlowersDef.LEFT, CSendFlowersDef.RIGTH}) do
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

    ((self._textUI)[rewardType]).panel = self:GetChild("Talk" .. rewardType)
    ;
    (((self._textUI)[rewardType]).panel):SetActive(false)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._textUI)[rewardType]).txt = self:GetChild("Talk" .. rewardType .. "/Text")
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._roleUI)[rewardType]).panel = self:GetChild("Role" .. rewardType)
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._roleUI)[rewardType]).live2d = self:GetChild("Role" .. rewardType .. "/Live2D")
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._roleUI)[rewardType]).photo = self:GetChild("Role" .. rewardType .. "/Photo")
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._itemUI)[rewardType]).img = self:GetChild("Item" .. rewardType)
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._itemUI)[rewardType]).num = self:GetChild("Item" .. rewardType .. "/Num")
  end
  self._frame = {}
  self._leftPanel = self:GetChild("Frame1")
  -- DECOMPILER ERROR at PC118: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._frame)[CSendFlowersDef.LEFT] = (TableFrame.Create)(self._leftPanel, self, false, true, false)
  self._rightPanel = self:GetChild("Frame2")
  -- DECOMPILER ERROR at PC132: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._frame)[CSendFlowersDef.RIGTH] = (TableFrame.Create)(self._rightPanel, self, false, true, false)
  self._closeBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._leftSendFlowerBtn = self:GetChild("SendBtn1")
  self._rightSendFlowerBtn = self:GetChild("SendBtn2")
  self._tipsBtn = self:GetChild("Tips")
  self._leftClick = self:GetChild("Click1")
  self._rightClick = self:GetChild("Click2")
  self._flowerImg = {
[CSendFlowersDef.LEFT] = {}
, 
[CSendFlowersDef.RIGTH] = {}
}
  -- DECOMPILER ERROR at PC179: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._flowerImg)[CSendFlowersDef.LEFT] = self:GetChild("Item1")
  local item = (Item.Create)(DataCommon.LoveFlowers)
  local image = item:GetIcon()
  ;
  ((self._flowerImg)[CSendFlowersDef.LEFT]):SetSprite(image.assetBundle, image.assetName)
  -- DECOMPILER ERROR at PC198: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._flowerImg)[CSendFlowersDef.RIGTH] = self:GetChild("Item2")
  ;
  ((self._flowerImg)[CSendFlowersDef.RIGTH]):SetSprite(image.assetBundle, image.assetName)
  self._moneyFrame = (TableFrame.Create)(self._topGroup, self, false, false, true)
  self._title = self:GetChild("Name")
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1701))
  self._tipText = self:GetChild("Tips/Text")
  ;
  (self._tipText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1724))
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._leftSendFlowerBtn):Subscribe_PointerClickEvent(self.OnLeftSendFlowerBtnClicked, self)
  ;
  (self._rightSendFlowerBtn):Subscribe_PointerClickEvent(self.OnRightSendFlowerBtnClicked, self)
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  ((self._flowerImg)[CSendFlowersDef.LEFT]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, CSendFlowersDef
    self:OnFlowerImgClicked(CSendFlowersDef.LEFT)
  end
, self)
  ;
  ((self._flowerImg)[CSendFlowersDef.RIGTH]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, CSendFlowersDef
    self:OnFlowerImgClicked(CSendFlowersDef.RIGTH)
  end
, self)
  ;
  (self._leftClick):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self, CSendFlowersDef, TalkType
    self:OnRoleTalkClick(CSendFlowersDef.LEFT, TalkType.StandBy)
  end
, self)
  ;
  (self._rightClick):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self, CSendFlowersDef, TalkType
    self:OnRoleTalkClick(CSendFlowersDef.RIGTH, TalkType.StandBy)
  end
, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSSendFlowers, Common.n_SSendFlowers, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMoney, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSReceiveFlowerReward, Common.n_SReceiveFlowerReward, nil)
end

LoverFlowerListDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV, CSendFlowersDef
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._moneyFrame then
    (self._moneyFrame):Destroy()
    self._moneyFrame = nil
  end
  if self._voiceId then
    ((NekoData.BehaviorManager).BM_Voice):StopVoice(self._voiceId)
    self._voiceId = nil
  end
  for _,t in ipairs({CSendFlowersDef.LEFT, CSendFlowersDef.RIGTH}) do
    if (self._contentTimer)[t] then
      (GameTimer.RemoveTask)((self._contentTimer)[t])
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._contentTimer)[t] = nil
    end
    if (self._frame)[t] then
      ((self._frame)[t]):Destroy()
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._frame)[t] = nil
    end
  end
end

LoverFlowerListDialog.SetData = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, CSendFlowersDef, CValentineFlower, Item
  local gottenRewardList = {}
  for rewardType,v in pairs(protocol.flowerProgress) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R8 in 'UnsetPending'

    (self._currentNum)[rewardType] = v.flowerScore
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._maxNum)[rewardType] = v.allFlower
    for _,rewardId in ipairs(v.rewardIds) do
      gottenRewardList[rewardId] = true
    end
  end
  self._rewardList = {
[CSendFlowersDef.LEFT] = {}
, 
[CSendFlowersDef.RIGTH] = {}
}
  local allIds = (CValentineFlower:GetAllIds())
  local record = nil
  for _,id in ipairs(allIds) do
    record = CValentineFlower:GetRecorder(R12_PC39)
    local rewardType = id // 100
    -- DECOMPILER ERROR at PC45: Overwrote pending register: R12 in 'AssignReg'

    ;
    (table.insert)(R12_PC39, {id = id, item = (Item.Create)(record.rewardId), itemCount = record.rewardNum, popularity = record.popularity, flowerNum = record.flowerNum, gotten = gottenRewardList[id], canGet = record.flowerNum <= (self._currentNum)[rewardType], progress = 0})
  end
  local totalProgress = nil
  self._rewardListLen = {
[CSendFlowersDef.LEFT] = {}
, 
[CSendFlowersDef.RIGTH] = {}
}
  self._segmentProgress = {
[CSendFlowersDef.LEFT] = {}
, 
[CSendFlowersDef.RIGTH] = {}
}
  local fullSegmentProgressNum, remainderProgress, count = nil, nil, nil
  -- DECOMPILER ERROR at PC93: Overwrote pending register: R12 in 'AssignReg'

  for R12_PC39,t in ipairs({CSendFlowersDef.LEFT, R12_PC39}) do
    (table.sort)((self._rewardList)[t], function(a, b)
    -- function num : 0_3_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    -- DECOMPILER ERROR at PC107: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (self._rewardListLen)[t] = #(self._rewardList)[t]
    totalProgress = (self._currentNum)[t] / (self._maxNum)[t]
    -- DECOMPILER ERROR at PC118: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (self._segmentProgress)[t] = 1 / ((self._rewardListLen)[t] - 1)
    fullSegmentProgressNum = totalProgress // (self._segmentProgress)[t]
    remainderProgress = totalProgress - fullSegmentProgressNum * (self._segmentProgress)[t]
    count = 1
    for _,v in ipairs((self._rewardList)[t]) do
      if count <= fullSegmentProgressNum then
        v.progress = 1
      elseif count == fullSegmentProgressNum + 1 and count < (self._rewardListLen)[t] then
        v.progress = (remainderProgress) / (self._segmentProgress)[t]
      else
        break
      end
      count = count + 1
    end
    -- DECOMPILER ERROR at PC157: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (((self._rewardList)[t])[(self._rewardListLen)[t]]).progress = -1
    ;
    ((self._frame)[t]):ReloadAllCell()
    ;
    ((self._frame)[t]):RefreshUIParticleClipper()
  end
  self:OnRefreshMoney()
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

LoverFlowerListDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4 , upvalues : CSendFlowersDef
  if frame == self._moneyFrame then
    return #self._moneyList
  else
    if frame == (self._frame)[CSendFlowersDef.LEFT] then
      return #(self._rewardList)[CSendFlowersDef.LEFT]
    else
      if frame == (self._frame)[CSendFlowersDef.RIGTH] then
        return #(self._rewardList)[CSendFlowersDef.RIGTH]
      end
    end
  end
end

LoverFlowerListDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5 , upvalues : CSendFlowersDef
  if frame == self._moneyFrame then
    return "activity.lover.lovermoneynumcell"
  else
    if frame == (self._frame)[CSendFlowersDef.LEFT] then
      return "activity.lover.loverflowerrewardcellleft"
    else
      if frame == (self._frame)[CSendFlowersDef.RIGTH] then
        return "activity.lover.loverflowerrewardcellright"
      end
    end
  end
end

LoverFlowerListDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6 , upvalues : CSendFlowersDef
  if frame == self._moneyFrame then
    return (self._moneyList)[index]
  else
    if frame == (self._frame)[CSendFlowersDef.LEFT] then
      return ((self._rewardList)[CSendFlowersDef.LEFT])[index]
    else
      if frame == (self._frame)[CSendFlowersDef.RIGTH] then
        return ((self._rewardList)[CSendFlowersDef.RIGTH])[index]
      end
    end
  end
end

LoverFlowerListDialog.OnRoleTalkClick = function(self, rewardType, conditionType)
  -- function num : 0_7 , upvalues : CSendFlowersDef, _ENV, timeofword
  local correspondingType = {[CSendFlowersDef.LEFT] = ((self._bm).LineFuncitionType).FlowerLeft, [CSendFlowersDef.RIGTH] = ((self._bm).LineFuncitionType).FlowerRight}
  local str = (TextManager.GetText)((self._bm):GetRandomLine(correspondingType[rewardType], conditionType))
  str = (string.gsub)(str, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username or "")
  ;
  (((self._textUI)[rewardType]).panel):SetActive(true)
  ;
  (((self._textUI)[rewardType]).txt):SetText(str)
  local text = (string.trim)(str)
  if (self._contentTimer)[rewardType] then
    (GameTimer.RemoveTask)((self._contentTimer)[rewardType])
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._contentTimer)[rewardType] = nil
  end
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self._contentTimer)[rewardType] = (GameTimer.AddTask)((utf8.len)(text) * timeofword / 1000, -1, function()
    -- function num : 0_7_0 , upvalues : self, rewardType
    (((self._textUI)[rewardType]).panel):SetActive(false)
  end
)
end

LoverFlowerListDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

LoverFlowerListDialog.OnLeftSendFlowerBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV, CSendFlowersDef
  local haveFlowerNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.LoveFlowers)
  if haveFlowerNum >= 1 then
    self:ClickSendFlowerBtnWithRoleId(CSendFlowersDef.LEFT)
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100453)
  end
end

LoverFlowerListDialog.OnRightSendFlowerBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV, CSendFlowersDef
  local haveFlowerNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.LoveFlowers)
  if haveFlowerNum >= 1 then
    self:ClickSendFlowerBtnWithRoleId(CSendFlowersDef.RIGTH)
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100453)
  end
end

LoverFlowerListDialog.ClickSendFlowerBtnWithRoleId = function(self, rewardType)
  -- function num : 0_11 , upvalues : _ENV
  if self._isCool then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100456)
  else
    local dialog = (DialogManager.CreateSingletonDialog)("activity.lover.loversendflowersecondconfirmdialog")
    if (self._maxNum)[rewardType] > (self._currentNum)[rewardType] then
      do
        dialog:SetData(rewardType, not dialog)
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
end

LoverFlowerListDialog.EnterCD = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self._isCool = true
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  self._task = (ServerGameTimer.AddTask)(5, -1, function()
    -- function num : 0_12_0 , upvalues : self
    self._isCool = false
  end
, nil)
end

LoverFlowerListDialog.OnFlowerImgClicked = function(self, imgType)
  -- function num : 0_13 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    local item = (Item.Create)(DataCommon.LoveFlowers)
    tipsDialog:Init({item = item})
    local width, height = ((self._flowerImg)[imgType]):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, ((self._flowerImg)[imgType]):GetLocalPointInUiRootPanel())
  end
end

LoverFlowerListDialog.OnSSendFlowers = function(self, notification)
  -- function num : 0_14 , upvalues : TalkType, _ENV, SLoverRedPoint
  local rewardType = (notification.userInfo).rewardType
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._currentNum)[rewardType] = (notification.userInfo).flowerScore
  self:OnRoleTalkClick(rewardType, TalkType.SendFlower)
  local totalProgress = (self._currentNum)[rewardType] / (self._maxNum)[rewardType]
  local fullSegmentProgressNum = totalProgress // (self._segmentProgress)[rewardType]
  local remainderProgress = totalProgress - fullSegmentProgressNum * (self._segmentProgress)[rewardType]
  local count = 1
  for _,v in ipairs((self._rewardList)[rewardType]) do
    if count <= fullSegmentProgressNum then
      v.progress = 1
    else
      if count == fullSegmentProgressNum + 1 and count < (self._rewardListLen)[rewardType] then
        v.progress = remainderProgress / (self._segmentProgress)[rewardType]
      end
    end
    ;
    ((self._frame)[rewardType]):FireEvent("RefreshProgress", {id = v.id, progress = v.progress})
    count = count + 1
    if v.flowerNum <= (self._currentNum)[rewardType] and not v.canGet then
      v.canGet = true
      ;
      ((self._frame)[rewardType]):FireEvent("RewardCanGet", v.id)
      if not (self._bm):GetRedPointWithState(SLoverRedPoint.LOVER_FLOWER) then
        (self._bm):SetRedPointWithState(SLoverRedPoint.LOVER_FLOWER, true)
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_LoverRefreshRedPoint, nil, ((self._bm).RedPointKey).Flower)
      end
    end
  end
end

LoverFlowerListDialog.OnRefreshMoney = function(self)
  -- function num : 0_15 , upvalues : _ENV
  self._moneyList = {}
  ;
  (table.insert)(self._moneyList, DataCommon.LoveFlowers)
  ;
  (self._moneyFrame):ReloadAllCell()
end

LoverFlowerListDialog.OnSReceiveFlowerReward = function(self, notification)
  -- function num : 0_16 , upvalues : _ENV, SLoverRedPoint
  local rewardType = (notification.userInfo).rewardType
  local hasCanGet = false
  for _,v in ipairs((self._rewardList)[rewardType]) do
    if v.id == (notification.userInfo).id then
      v.gotten = true
    else
      if v.canGet and not v.gotten then
        hasCanGet = true
      end
    end
  end
  if not hasCanGet then
    (self._bm):SetRedPointWithState(SLoverRedPoint.LOVER_FLOWER, false)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_LoverRefreshRedPoint, nil, ((self._bm).RedPointKey).Flower)
  end
  ;
  ((self._frame)[rewardType]):FireEvent("RewardGotten", (notification.userInfo).id)
end

LoverFlowerListDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return LoverFlowerListDialog

