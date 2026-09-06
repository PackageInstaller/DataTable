local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CSendFlowersDef = LuaNetManager.GetProtocolDef("protocol.activity.csendflowers")
local SLoverRedPoint = LuaNetManager.GetProtocolDef("protocol.activity.sloverredpoint")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CValentineFlower = BeanManager.GetTableByName("activity.cvalentineflower")
local LoverFlowerListDialog = class("LoverFlowerListDialog", Dialog)
LoverFlowerListDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverFlowerListDialog.AssetName = "ActivityValentinesFlower"
local awardNum = 5
local TalkType = {StandBy = 1, SendFlower = 2}
local timeofword = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(88).Value)

function LoverFlowerListDialog:Ctor(...)
  LoverFlowerListDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._currentNum = {}
  self._maxNum = {}
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.LoverActivityManagerID)
  self._contentTimer = {
    [CSendFlowersDef.LEFT] = {},
    [CSendFlowersDef.RIGTH] = {}
  }
  self._isCool = false
end

function LoverFlowerListDialog:OnCreate()
  self._topGroup = self:GetChild("TopGroup")
  self._textUI = {
    [CSendFlowersDef.LEFT] = {},
    [CSendFlowersDef.RIGTH] = {}
  }
  self._roleUI = {
    [CSendFlowersDef.LEFT] = {},
    [CSendFlowersDef.RIGTH] = {}
  }
  self._itemUI = {
    [CSendFlowersDef.LEFT] = {},
    [CSendFlowersDef.RIGTH] = {}
  }
  for _, rewardType in ipairs({
    CSendFlowersDef.LEFT,
    CSendFlowersDef.RIGTH
  }) do
    self._textUI[rewardType].panel = self:GetChild("Talk" .. rewardType)
    self._textUI[rewardType].panel:SetActive(false)
    self._textUI[rewardType].txt = self:GetChild("Talk" .. rewardType .. "/Text")
    self._roleUI[rewardType].panel = self:GetChild("Role" .. rewardType)
    self._roleUI[rewardType].live2d = self:GetChild("Role" .. rewardType .. "/Live2D")
    self._roleUI[rewardType].photo = self:GetChild("Role" .. rewardType .. "/Photo")
    self._itemUI[rewardType].img = self:GetChild("Item" .. rewardType)
    self._itemUI[rewardType].num = self:GetChild("Item" .. rewardType .. "/Num")
  end
  self._frame = {}
  self._leftPanel = self:GetChild("Frame1")
  self._frame[CSendFlowersDef.LEFT] = TableFrame.Create(self._leftPanel, self, false, true, false)
  self._rightPanel = self:GetChild("Frame2")
  self._frame[CSendFlowersDef.RIGTH] = TableFrame.Create(self._rightPanel, self, false, true, false)
  self._closeBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._leftSendFlowerBtn = self:GetChild("SendBtn1")
  self._rightSendFlowerBtn = self:GetChild("SendBtn2")
  self._tipsBtn = self:GetChild("Tips")
  self._leftClick = self:GetChild("Click1")
  self._rightClick = self:GetChild("Click2")
  self._flowerImg = {
    [CSendFlowersDef.LEFT] = {},
    [CSendFlowersDef.RIGTH] = {}
  }
  self._flowerImg[CSendFlowersDef.LEFT] = self:GetChild("Item1")
  local item = Item.Create(DataCommon.LoveFlowers)
  local image = item:GetIcon()
  self._flowerImg[CSendFlowersDef.LEFT]:SetSprite(image.assetBundle, image.assetName)
  self._flowerImg[CSendFlowersDef.RIGTH] = self:GetChild("Item2")
  self._flowerImg[CSendFlowersDef.RIGTH]:SetSprite(image.assetBundle, image.assetName)
  self._moneyFrame = TableFrame.Create(self._topGroup, self, false, false, true)
  self._title = self:GetChild("Name")
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(1701))
  self._tipText = self:GetChild("Tips/Text")
  self._tipText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1724))
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._leftSendFlowerBtn:Subscribe_PointerClickEvent(self.OnLeftSendFlowerBtnClicked, self)
  self._rightSendFlowerBtn:Subscribe_PointerClickEvent(self.OnRightSendFlowerBtnClicked, self)
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._flowerImg[CSendFlowersDef.LEFT]:Subscribe_PointerClickEvent(function()
    self:OnFlowerImgClicked(CSendFlowersDef.LEFT)
  end, self)
  self._flowerImg[CSendFlowersDef.RIGTH]:Subscribe_PointerClickEvent(function()
    self:OnFlowerImgClicked(CSendFlowersDef.RIGTH)
  end, self)
  self._leftClick:Subscribe_PointerClickEvent(function()
    self:OnRoleTalkClick(CSendFlowersDef.LEFT, TalkType.StandBy)
  end, self)
  self._rightClick:Subscribe_PointerClickEvent(function()
    self:OnRoleTalkClick(CSendFlowersDef.RIGTH, TalkType.StandBy)
  end, self)
  LuaNotificationCenter.AddObserver(self, self.OnSSendFlowers, Common.n_SSendFlowers, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMoney, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSReceiveFlowerReward, Common.n_SReceiveFlowerReward, nil)
end

function LoverFlowerListDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._moneyFrame then
    self._moneyFrame:Destroy()
    self._moneyFrame = nil
  end
  if self._voiceId then
    NekoData.BehaviorManager.BM_Voice:StopVoice(self._voiceId)
    self._voiceId = nil
  end
  for _, t in ipairs({
    CSendFlowersDef.LEFT,
    CSendFlowersDef.RIGTH
  }) do
    if self._contentTimer[t] then
      GameTimer.RemoveTask(self._contentTimer[t])
      self._contentTimer[t] = nil
    end
    if self._frame[t] then
      self._frame[t]:Destroy()
      self._frame[t] = nil
    end
  end
end

function LoverFlowerListDialog:SetData(protocol)
  local gottenRewardList = {}
  for rewardType, v in pairs(protocol.flowerProgress) do
    self._currentNum[rewardType] = v.flowerScore
    self._maxNum[rewardType] = v.allFlower
    for _, rewardId in ipairs(v.rewardIds) do
      gottenRewardList[rewardId] = true
    end
  end
  self._rewardList = {
    [CSendFlowersDef.LEFT] = {},
    [CSendFlowersDef.RIGTH] = {}
  }
  local allIds = CValentineFlower:GetAllIds()
  local record
  for _, id in ipairs(allIds) do
    record = CValentineFlower:GetRecorder(id)
    local rewardType = id // 100
    table.insert(self._rewardList[rewardType], {
      id = id,
      item = Item.Create(record.rewardId),
      itemCount = record.rewardNum,
      popularity = record.popularity,
      flowerNum = record.flowerNum,
      gotten = gottenRewardList[id],
      canGet = self._currentNum[rewardType] >= record.flowerNum,
      progress = 0
    })
  end
  local totalProgress
  self._rewardListLen = {
    [CSendFlowersDef.LEFT] = {},
    [CSendFlowersDef.RIGTH] = {}
  }
  self._segmentProgress = {
    [CSendFlowersDef.LEFT] = {},
    [CSendFlowersDef.RIGTH] = {}
  }
  local fullSegmentProgressNum, remainderProgress, count
  for _, t in ipairs({
    CSendFlowersDef.LEFT,
    CSendFlowersDef.RIGTH
  }) do
    table.sort(self._rewardList[t], function(a, b)
      return a.id < b.id
    end)
    self._rewardListLen[t] = #self._rewardList[t]
    totalProgress = self._currentNum[t] / self._maxNum[t]
    self._segmentProgress[t] = 1 / (self._rewardListLen[t] - 1)
    fullSegmentProgressNum = totalProgress // self._segmentProgress[t]
    remainderProgress = totalProgress - fullSegmentProgressNum * self._segmentProgress[t]
    count = 1
    for _, v in ipairs(self._rewardList[t]) do
      if fullSegmentProgressNum >= count then
        v.progress = 1
      elseif count == fullSegmentProgressNum + 1 and count < self._rewardListLen[t] then
        v.progress = remainderProgress / self._segmentProgress[t]
      else
        break
      end
      count = count + 1
    end
    self._rewardList[t][self._rewardListLen[t]].progress = -1
    self._frame[t]:ReloadAllCell()
    self._frame[t]:RefreshUIParticleClipper()
  end
  self:OnRefreshMoney()
end

function LoverFlowerListDialog:NumberOfCell(frame)
  if frame == self._moneyFrame then
    return #self._moneyList
  elseif frame == self._frame[CSendFlowersDef.LEFT] then
    return #self._rewardList[CSendFlowersDef.LEFT]
  elseif frame == self._frame[CSendFlowersDef.RIGTH] then
    return #self._rewardList[CSendFlowersDef.RIGTH]
  end
end

function LoverFlowerListDialog:CellAtIndex(frame, index)
  if frame == self._moneyFrame then
    return "activity.lover.lovermoneynumcell"
  elseif frame == self._frame[CSendFlowersDef.LEFT] then
    return "activity.lover.loverflowerrewardcellleft"
  elseif frame == self._frame[CSendFlowersDef.RIGTH] then
    return "activity.lover.loverflowerrewardcellright"
  end
end

function LoverFlowerListDialog:DataAtIndex(frame, index)
  if frame == self._moneyFrame then
    return self._moneyList[index]
  elseif frame == self._frame[CSendFlowersDef.LEFT] then
    return self._rewardList[CSendFlowersDef.LEFT][index]
  elseif frame == self._frame[CSendFlowersDef.RIGTH] then
    return self._rewardList[CSendFlowersDef.RIGTH][index]
  end
end

function LoverFlowerListDialog:OnRoleTalkClick(rewardType, conditionType)
  local correspondingType = {
    [CSendFlowersDef.LEFT] = self._bm.LineFuncitionType.FlowerLeft,
    [CSendFlowersDef.RIGTH] = self._bm.LineFuncitionType.FlowerRight
  }
  local str = TextManager.GetText(self._bm:GetRandomLine(correspondingType[rewardType], conditionType))
  str = string.gsub(str, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username or "")
  self._textUI[rewardType].panel:SetActive(true)
  self._textUI[rewardType].txt:SetText(str)
  local text = string.trim(str)
  if self._contentTimer[rewardType] then
    GameTimer.RemoveTask(self._contentTimer[rewardType])
    self._contentTimer[rewardType] = nil
  end
  self._contentTimer[rewardType] = GameTimer.AddTask(utf8.len(text) * timeofword / 1000, -1, function()
    self._textUI[rewardType].panel:SetActive(false)
  end)
end

function LoverFlowerListDialog:OnBackBtnClicked()
  self:Destroy()
end

function LoverFlowerListDialog:OnLeftSendFlowerBtnClicked()
  local haveFlowerNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.LoveFlowers)
  if 1 <= haveFlowerNum then
    self:ClickSendFlowerBtnWithRoleId(CSendFlowersDef.LEFT)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100453)
  end
end

function LoverFlowerListDialog:OnRightSendFlowerBtnClicked()
  local haveFlowerNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.LoveFlowers)
  if 1 <= haveFlowerNum then
    self:ClickSendFlowerBtnWithRoleId(CSendFlowersDef.RIGTH)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100453)
  end
end

function LoverFlowerListDialog:ClickSendFlowerBtnWithRoleId(rewardType)
  if self._isCool then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100456)
  else
    local dialog = DialogManager.CreateSingletonDialog("activity.lover.loversendflowersecondconfirmdialog")
    if dialog then
      dialog:SetData(rewardType, self._currentNum[rewardType] >= self._maxNum[rewardType])
    end
  end
end

function LoverFlowerListDialog:EnterCD()
  self._isCool = true
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  self._task = ServerGameTimer.AddTask(5, -1, function()
    self._isCool = false
  end, nil)
end

function LoverFlowerListDialog:OnFlowerImgClicked(imgType)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    local item = Item.Create(DataCommon.LoveFlowers)
    tipsDialog:Init({item = item})
    local width, height = self._flowerImg[imgType]:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._flowerImg[imgType]:GetLocalPointInUiRootPanel())
  end
end

function LoverFlowerListDialog:OnSSendFlowers(notification)
  local rewardType = notification.userInfo.rewardType
  self._currentNum[rewardType] = notification.userInfo.flowerScore
  self:OnRoleTalkClick(rewardType, TalkType.SendFlower)
  local totalProgress = self._currentNum[rewardType] / self._maxNum[rewardType]
  local fullSegmentProgressNum = totalProgress // self._segmentProgress[rewardType]
  local remainderProgress = totalProgress - fullSegmentProgressNum * self._segmentProgress[rewardType]
  local count = 1
  for _, v in ipairs(self._rewardList[rewardType]) do
    if fullSegmentProgressNum >= count then
      v.progress = 1
    elseif count == fullSegmentProgressNum + 1 and count < self._rewardListLen[rewardType] then
      v.progress = remainderProgress / self._segmentProgress[rewardType]
    end
    self._frame[rewardType]:FireEvent("RefreshProgress", {
      id = v.id,
      progress = v.progress
    })
    count = count + 1
    if self._currentNum[rewardType] >= v.flowerNum and not v.canGet then
      v.canGet = true
      self._frame[rewardType]:FireEvent("RewardCanGet", v.id)
      if not self._bm:GetRedPointWithState(SLoverRedPoint.LOVER_FLOWER) then
        self._bm:SetRedPointWithState(SLoverRedPoint.LOVER_FLOWER, true)
        LuaNotificationCenter.PostNotification(Common.n_LoverRefreshRedPoint, nil, self._bm.RedPointKey.Flower)
      end
    end
  end
end

function LoverFlowerListDialog:OnRefreshMoney()
  self._moneyList = {}
  table.insert(self._moneyList, DataCommon.LoveFlowers)
  self._moneyFrame:ReloadAllCell()
end

function LoverFlowerListDialog:OnSReceiveFlowerReward(notification)
  local rewardType = notification.userInfo.rewardType
  local hasCanGet = false
  for _, v in ipairs(self._rewardList[rewardType]) do
    if v.id == notification.userInfo.id then
      v.gotten = true
    elseif v.canGet and not v.gotten then
      hasCanGet = true
    end
  end
  if not hasCanGet then
    self._bm:SetRedPointWithState(SLoverRedPoint.LOVER_FLOWER, false)
    LuaNotificationCenter.PostNotification(Common.n_LoverRefreshRedPoint, nil, self._bm.RedPointKey.Flower)
  end
  self._frame[rewardType]:FireEvent("RewardGotten", notification.userInfo.id)
end

function LoverFlowerListDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return LoverFlowerListDialog
