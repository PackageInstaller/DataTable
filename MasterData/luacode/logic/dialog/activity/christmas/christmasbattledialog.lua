local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local CHexagonBattleConfig = BeanManager.GetTableByName("dungeonselect.chexagonbattleconfig")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local CChristmasActivityEvent = require("protocols.def.protocol.activity.cchristmasactivityevent")
local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local TableFrame = require("framework.ui.frame.table.tableframe")
local State = {
  Unlock = 1,
  PreconditionsNotMet = 2,
  Lock = 3
}
local ChristmasBattleDialog = class("ChristmasBattleDialog", Dialog)
ChristmasBattleDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasBattleDialog.AssetName = "ActivityChristmasbattle"

function ChristmasBattleDialog:Ctor(...)
  ChristmasBattleDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function ChristmasBattleDialog:OnCreate()
  self._unLock = self:GetChild("Lock")
  self._next = self:GetChild("Next")
  self._lock = self:GetChild("Unlock")
  self._buttonPanelBack = self:GetChild("frame1/Image")
  self._buttonPanel = self:GetChild("frame1")
  self._buttonFrame = TableFrame.Create(self._buttonPanel, self, true, false, true)
  self._goBtn = self:GetChild("Lock/Checkbtn")
  self._autoBtn = self:GetChild("Lock/Autobtn")
  self._levelUpBtn = self:GetChild("Unlock/Checkbtn")
  self._levelUpBtn:Subscribe_PointerClickEvent(self.OnLevelUpBtnClicked, self)
  self._num = self:GetChild("Unlock/Num")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._autoBtn:Subscribe_PointerClickEvent(self.OnAutoBtnClicked, self)
  self._spiritNum = self:GetChild("Lock/LineBack/Num")
  self._leveltxt = self:GetChild("LevelTxt")
  self._levelnum = self:GetChild("Battlelevel/levelnum")
  self._nameText = self:GetChild("Name/text")
  self._ranknum = self:GetChild("Battlelevel/Ranknum")
  self._panel = self:GetChild("frame")
  self._frame = TableFrame.Create(self._panel, self, false)
  self._additionText = self:GetChild("Line/Text")
  self._tips = self:GetChild("Tips")
  self._tips:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  CanvasStaticFunctions.SetCanvasPixelPerfect(self._rootWindow._uiObject, false)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function ChristmasBattleDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  if self._buttonFrame then
    self._buttonFrame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function ChristmasBattleDialog:SetData(data)
  self._functionIDs = data.functionIDs
  self._constructionID = data.constructionID
  self._locked = data.locked
  self._battlesData = {}
  table.sort(self._functionIDs, function(a, b)
    local funectionRecorderA = CInterfaceFunction:GetRecorder(a)
    local funectionRecorderB = CInterfaceFunction:GetRecorder(b)
    return funectionRecorderA.difficulty < funectionRecorderB.difficulty
  end)
  table.sort(self._locked, function(a, b)
    local funectionRecorderA = CInterfaceFunction:GetRecorder(a)
    local funectionRecorderB = CInterfaceFunction:GetRecorder(b)
    return funectionRecorderA.difficulty < funectionRecorderB.difficulty
  end)
  for i, v in ipairs(self._functionIDs) do
    local temp = {
      functionID = v,
      state = State.Unlock,
      index = i
    }
    table.insert(self._battlesData, temp)
  end
  local count = #self._functionIDs
  for i, v in ipairs(self._locked) do
    if not table.contain(self._functionIDs, v) then
      count = count + 1
      local temp = {
        functionID = v,
        state = State.PreconditionsNotMet,
        index = count
      }
      table.insert(self._battlesData, temp)
    else
      for j, k in ipairs(self._battlesData) do
        if k.functionID == v then
          self._battlesData[j].state = State.PreconditionsNotMet
        end
      end
    end
  end
  self._buttonFrame:ReloadAllCell()
  self:OnButtonGroupClick(#self._functionIDs)
end

function ChristmasBattleDialog:OnButtonGroupClick(index)
  self._index = index
  self._buttonFrame:FireEvent("ChangedSelected", index)
  local data = self._battlesData[index]
  self._unLock:SetActive(data.state == State.Unlock)
  self._next:SetActive(data.state == State.PreconditionsNotMet)
  self._lock:SetActive(data.state == State.Lock)
  local funectionRecorder = CInterfaceFunction:GetRecorder(data.functionID)
  if not funectionRecorder then
    LogErrorFormat("ChristmasBattleDialog", "CInterfaceFunction 没有找到配置 functionID = %s ", tostring(data.functionID))
    return
  end
  self._autoBtn:SetInteractable(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):HasFinishBlockBattle(self._constructionID, data.functionID))
  local battleID = funectionRecorder.battleID
  if battleID ~= 0 then
    self._battleRecorder = CHexagonBattleConfig:GetRecorder(battleID)
    self._nameText:SetText(TextManager.GetText(self._battleRecorder.leveltitle))
    if self._battleRecorder.spirit > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID) then
      self._spiritNum:SetText(self._battleRecorder.spirit)
    else
      self._spiritNum:SetText(self._battleRecorder.spirit)
    end
    self._leveltxt:SetText(TextManager.GetText(self._battleRecorder.levelinfo))
    local clientBreakLevel = CRoleLevelCfgTable:GetRecorder(self._battleRecorder.suggestlevel).clientBreakLevel
    local clientLevel = CRoleLevelCfgTable:GetRecorder(self._battleRecorder.suggestlevel).clientLevel
    self._levelnum:SetText(clientLevel)
    self._ranknum:SetText(clientBreakLevel)
    self._additionText:SetText(TextManager.GetText(self._battleRecorder.addition))
    self._itemData = {}
    for i, v in ipairs(self._battleRecorder.firstItems) do
      local temp = {
        tag = "first",
        itemID = v,
        count = self._battleRecorder.firstItemNums[i]
      }
      table.insert(self._itemData, temp)
    end
    for i, v in ipairs(self._battleRecorder.sureDropItems) do
      local temp = {
        tag = "sure",
        itemID = v,
        count = self._battleRecorder.sureDropItemsNums[i]
      }
      table.insert(self._itemData, temp)
    end
    for i, v in ipairs(self._battleRecorder.mayDropItems) do
      local temp = {
        tag = "may",
        itemID = v,
        count = self._battleRecorder.mayDropItemsNums[i]
      }
      table.insert(self._itemData, temp)
    end
    self._frame:ReloadAllCell()
  else
    LogErrorFormat("ChristmasBattleDialog", "functionID %s 没有找到战斗", tostring(data.functionID))
  end
end

function ChristmasBattleDialog:OnGoBtnClicked()
  if self._battleRecorder.spirit > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID) then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    NekoData.DataManager.DM_Team:ClearSupportRole()
    local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
    if dialog then
      dialog:SetCopyInfo("Christmas", self._battlesData[self._index].functionID, self._constructionID)
    end
    self:OnBackBtnClicked()
  end
end

function ChristmasBattleDialog:OnAutoBtnClicked()
  if NekoData.BehaviorManager.BM_OfflineSweep:GetTodayLeftNum() <= 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100471)
    return
  end
  if NekoData.BehaviorManager.BM_OfflineSweep:GetStatus() ~= 0 then
    if NekoData.BehaviorManager.BM_OfflineSweep:GetStatus() == 1 then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100474)
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100475)
    end
    return
  end
  if self._battleRecorder.spirit > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID) then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    local dialog = DialogManager.CreateSingletonDialog("mainline.offlinesweepcontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "DispatchChristmas"
      data.id = self._battlesData[self._index].functionID
      data.name = TextManager.GetText(self._battleRecorder.leveltitle)
      data.spirit = self._battleRecorder.spirit
      data.timelength = 1
      dialog:SetInfo(data)
    end
  end
end

function ChristmasBattleDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and not UIManager.RectangleContainsScreenPoint(self._buttonPanelBack._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ChristmasBattleDialog:NumberOfCell(frame)
  if frame == self._buttonFrame then
    return #self._battlesData
  end
  return #self._itemData
end

function ChristmasBattleDialog:CellAtIndex(frame, index)
  if frame == self._buttonFrame then
    return "activity.christmas.christmasbattlebtncell"
  end
  return "activity.christmas.christmasbattleitemcell"
end

function ChristmasBattleDialog:DataAtIndex(frame, index)
  if frame == self._buttonFrame then
    return self._battlesData[index]
  end
  return self._itemData[index]
end

function ChristmasBattleDialog:OnSUpdateChristmasConstruction(notification)
  local protocol = notification.userInfo
  if self._constructionID == protocol.construction.ID then
    local data = {}
    data.functionIDs = protocol.construction.event
    data.constructionID = self._constructionID
    data.locked = protocol.construction.locked
    data.event2lock = protocol.construction.event2lock
    data.constructionLevel = protocol.construction.level
    self:SetData(data)
  end
end

function ChristmasBattleDialog:OnTipsBtnClicked()
  local data = self._battlesData[self._index]
  local funectionRecorder = CInterfaceFunction:GetRecorder(data.functionID)
  if not funectionRecorder then
    LogErrorFormat("ChristmasBattleDialog", "CInterfaceFunction 没有找到配置 functionID = %s ", tostring(data.functionID))
    return
  end
  local battleID = funectionRecorder.battleID
  local dialog = DialogManager.CreateSingletonDialog("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = battleID
    data.type = "Christmas"
    dialog:Init(data)
  end
end

function ChristmasBattleDialog:OnBackBtnClicked()
  self:Destroy()
end

return ChristmasBattleDialog
