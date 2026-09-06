local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Collection = LuaNetManager.CreateBean("protocol.activity.collection")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local ReturnBattlePassTabCell = class("ReturnBattlePassTabCell", Dialog)
ReturnBattlePassTabCell.AssetBundleName = "ui/layouts.welfare"
ReturnBattlePassTabCell.AssetName = "ReturnBattlePass"

function ReturnBattlePassTabCell:Ctor(...)
  ReturnBattlePassTabCell.super.Ctor(self, ...)
  self._init = false
  self._returnBattlePass = nil
  self._activityTask = nil
  self._taskList = {}
  self._shopMoneyTypeInfo = {
    DataCommon.DiamodID
  }
end

function ReturnBattlePassTabCell:OnCreate()
  self._restTime = self:GetChild("EndTime")
  self._numText = self:GetChild("Level/Num/Txt")
  self._progress = self:GetChild("Level/Loading/BackGround/Progress")
  self._advanceAwardLock = self:GetChild("Advance/Lock")
  self._boughtBtn = self:GetChild("BuyBtn")
  self._unlockBtn = self:GetChild("UnLockBtn")
  self._unlockBtn_txt = self:GetChild("UnLockBtn/Text")
  self._cellArea = self:GetChild("CellFrame")
  self._topGroup = self:GetChild("TopGroup")
  self._cellFrame = TableFrame.Create(self._cellArea, self, false, true)
  self._topGroupFrame = TableFrame.Create(self._topGroup, self, false, false, true)
  self._unlockBtn:Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  self._boughtBtn:Subscribe_PointerClickEvent(self.OnBuyAgcoinLevelBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshTopGroundFrame, Common.n_RefreshCurrency, nil)
  self:GetChild("Normal/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2211))
  self:GetChild("Advance/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2212))
end

function ReturnBattlePassTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
  self._cellFrame:Destroy()
  self._topGroupFrame:Destroy()
end

local function FirstCanGetIndex(self)
  local firstLockIndex
  for i, v in ipairs(self._taskList) do
    if v.common.state == Collection.UN_RECEIVE or v.high.state == Collection.UN_RECEIVE then
      return i
    elseif not firstLockIndex and (v.common.state == Collection.LOCK or v.high.state == Collection.LOCK) then
      firstLockIndex = i
    end
  end
  return firstLockIndex
end

function ReturnBattlePassTabCell:RefreshTabCell(refresh, notChangeSlidePos)
  if not self._init or refresh then
    self._returnBattlePass = NekoData.BehaviorManager.BM_ReturnWelfare:GetReturnBattlePass()
    while self._taskList[#self._taskList] do
      table.remove(self._taskList, #self._taskList)
    end
    for i, v in ipairs(self._returnBattlePass.commonCollection) do
      table.insert(self._taskList, {
        common = v,
        high = self._returnBattlePass.highCollection[i]
      })
    end
    self._numText:SetText(NekoData.BehaviorManager.BM_Message:GetString(2203, {
      self._returnBattlePass.chipNum,
      self._returnBattlePass.needChipNum
    }))
    self._progress:SetFillAmount(self._returnBattlePass.chipNum / self._returnBattlePass.needChipNum)
    local unlockHigh = self._returnBattlePass.highUnlocked == 1
    self._advanceAwardLock:SetActive(not unlockHigh)
    self._unlockBtn:SetInteractable(not unlockHigh)
    if not unlockHigh then
      self._unlockBtn_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2205))
    else
      self._unlockBtn_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2206))
    end
    if not self._activityTask then
      self._activityTask = GameTimer.AddTask(0, 60, function()
        self:RefreshTime()
      end)
    end
    local lastPos = self._cellFrame:GetCurrentPosition()
    local firstCanGetIndex = FirstCanGetIndex(self)
    self._cellFrame:ReloadAllCell()
    if firstCanGetIndex then
      self._cellFrame:MoveLeftToIndex(firstCanGetIndex)
    elseif notChangeSlidePos and lastPos then
      self._cellFrame:MoveToAssignedPos(lastPos)
    end
  end
  self:RefreshTopGroundFrame()
end

function ReturnBattlePassTabCell:RefreshTime()
  local time = self._returnBattlePass.leftTime / 1000
  local day = math.floor(time / 86400)
  local hour = math.floor((time - day * 24 * 60 * 60) / 3600)
  local min = math.floor((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
  local sec = math.floor(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
  local str
  if 0 < day then
    str = NekoData.BehaviorManager.BM_Message:GetString(2209, {day, hour})
  else
    str = NekoData.BehaviorManager.BM_Message:GetString(2210, {hour})
  end
  self._restTime:SetText(str)
end

function ReturnBattlePassTabCell:RefreshTopGroundFrame()
  self._topGroupFrame:ReloadAllCell()
end

function ReturnBattlePassTabCell:NumberOfCell(frame)
  if frame == self._cellFrame then
    return #self._taskList
  else
    return #self._shopMoneyTypeInfo
  end
end

function ReturnBattlePassTabCell:CellAtIndex(frame, index)
  if frame == self._cellFrame then
    if index == #self._taskList then
      return "welfare.returnwelfare.returnbattlepasstasklastcell"
    else
      return "welfare.returnwelfare.returnbattlepasstaskcell"
    end
  else
    return "shop.shoptopgroupcell"
  end
end

function ReturnBattlePassTabCell:DataAtIndex(frame, index)
  if frame == self._cellFrame then
    return self._taskList[index]
  else
    return {
      moneyType = self._shopMoneyTypeInfo[index]
    }
  end
end

function ReturnBattlePassTabCell:OnUnlockBtnClicked()
  if self._returnBattlePass.highUnlocked ~= 1 then
    DialogManager.CreateSingletonDialog("welfare.returnwelfare.returnbattlepassunlockdialog")
  end
end

function ReturnBattlePassTabCell:OnBuyAgcoinLevelBtnClicked()
  local levelPrice = self._returnBattlePass.levelPrice
  local itemID = DataCommon.DiamodID
  local diffNum = self._returnBattlePass.needChipNum - self._returnBattlePass.chipNum
  local showText = string.gsub(TextManager.GetText(CStringRes:GetRecorder(2204).msgTextID), "%$parameter1%$", diffNum)
  local moneyItem = Item.Create(itemID)
  local dialog = DialogManager.CreateSingletonDialog("welfare.returnwelfare.returnbattlepasssecondconfirm")
  dialog:SetData(showText, moneyItem, levelPrice)
end

return ReturnBattlePassTabCell
