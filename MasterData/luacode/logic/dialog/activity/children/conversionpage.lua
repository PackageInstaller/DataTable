local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local CactivityTasks = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local SChildrenDayInfo = LuaNetManager.CreateProtocol("protocol.activity.childrenday.schildrendayinfo")
local CChildrensDayExtraAward = BeanManager.GetTableByName("mission.cchildrensdayextraaward")
local ConversionPage = class("ConversionPage", Dialog)
ConversionPage.AssetBundleName = "ui/layouts.activitychildrensday"
ConversionPage.AssetName = "ActivityChildrensDayItemShop"

local function RefreshAwardInfo(self)
  local data = self._bm:GetAwardsInfo()
  for i = 1, self._awardLength do
    self._awardInfo[i].icon:SetSprite(data[i].item:GetIconAB())
    self._awardInfo[i].processNum:SetText(data[i].neednum)
    self._awardInfo[i].frame:SetSprite(data[i].item:GetPinJiImageAB())
    self._awardInfo[i].count:SetText(data[i].count)
    self._awardInfo[i].grey:SetActive(data[i].state == SChildrenDayInfo.FETCHED)
    self._awardInfo[i].select:SetActive(data[i].state == SChildrenDayInfo.TO_FETCH)
    self._awardInfo[i].mask:SetActive(data[i].state == SChildrenDayInfo.LOCKED)
  end
end

function ConversionPage:Ctor(...)
  ConversionPage.super.Ctor(self, ...)
  self._ItemInfo = {}
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChildrenActivityManagerID)
  self._activityID = CactivityTasks.CHILDREN_DAY
end

local function MoveProcess(self, index)
  local delta = (index / self._awardLength - 0.5) * self._processFrame_width + 200
  self._processFrame:SetPosition(self._processFrame_pos_x, self._processFrame_width_offset_x - delta, self._processFrame_pos_y, self._processFrame_pos_offset_y)
end

local function GoCurrentAward(self)
  local data = self._bm:GetAwardsInfo()
  local haveAvailable = self._bm:HaveAvailable()
  if haveAvailable then
    for k, v in ipairs(data) do
      if v.state == SChildrenDayInfo.TO_FETCH then
        MoveProcess(self, k)
        return
      end
    end
  else
    for k, v in ipairs(data) do
      if v.state == SChildrenDayInfo.LOCKED then
        MoveProcess(self, k)
        return
      end
    end
  end
  MoveProcess(self, #data)
end

function ConversionPage:OnCreate()
  self._staticTxt1 = self:GetChild("Txt")
  self._taskPanel = self:GetChild("FrameTask")
  self._currencyIcon = self:GetChild("Item")
  self._currencyNum = self:GetChild("NowNum")
  self._tipsBtn = self:GetChild("Tips")
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._currencyIcon:Subscribe_PointerClickEvent(self.OnCurrencyIconClicked, self)
  self._processLine = self:GetChild("ItemGroup/Frame/TasklineBack/Taskline")
  self._itemFrame = TableFrame.Create(self._taskPanel, self, false, false, false)
  local str = "ItemGroup/Frame/ActivityChildrensDayCellItem"
  self._awardInfo = {}
  self._curScore = self:GetChild("TextNum")
  self._itemgroup = self:GetChild("ItemGroup/Frame")
  local itemgroupob = self._itemgroup:GetUIObject()
  self._awardLength = itemgroupob.transform.childCount - 1
  self._maxScore = CChildrensDayExtraAward:GetRecorder(self._awardLength).neednum
  for i = 1, self._awardLength do
    self._awardInfo[i] = {}
    local parent = str .. i
    self._awardInfo[i].cell = self:GetChild(parent)
    local a = parent .. "/Panel/ItemCell/_BackGround/Icon"
    self._awardInfo[i].icon = self:GetChild(parent .. "/Panel/ItemCell/_BackGround/Icon")
    self._awardInfo[i].processNum = self:GetChild(parent .. "/Num1")
    self._awardInfo[i].frame = self:GetChild(parent .. "/Panel/ItemCell/_BackGround/Frame")
    self._awardInfo[i].count = self:GetChild(parent .. "/Panel/ItemCell/_Count")
    self._awardInfo[i].grey = self:GetChild(parent .. "/Grey")
    self._awardInfo[i].select = self:GetChild(parent .. "/Select")
    self._awardInfo[i].mask = self:GetChild(parent .. "/Mask")
    local index = i
    self._awardInfo[i].icon:Subscribe_PointerClickEvent(function()
      self:OnAwardCellClicked(index)
    end, self)
  end
  self._timeText = self:GetChild("ActiveTime")
  self._timeText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1795))
  self._processView = self:GetChild("ItemGroup")
  self._processView_width, self._processView_height = self._processView:GetDeltaSize()
  self._processFrame = self:GetChild("ItemGroup/Frame")
  self._processFrame_width, self._processFrame_height = self._processFrame:GetDeltaSize()
  self._processFrame_pos_x, self._processFrame_width_offset_x, self._processFrame_pos_y, self._processFrame_pos_offset_y = self._processFrame:GetPosition()
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_SRefreshChildrenInfo, nil)
  self:SetStaticRes()
end

function ConversionPage:SetStaticRes()
  self._staticTxt1:SetText(TextManager.GetText(CStringRes:GetRecorder(1632).msgTextID))
  self._currencyItem = Item.Create(DataCommon.Cicada)
  self._currencyIcon:SetSprite(self._currencyItem:GetIcon().assetBundle, self._currencyItem:GetIcon().assetName)
end

function ConversionPage:OnDestroy()
  if self._itemFrame then
    self._itemFrame:Destroy()
  end
  DialogManager.DestroySingletonDialog("activity.children.childrentipsdialog")
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function ConversionPage:Refresh()
  self:RefreshCurrencyData()
  self:RefreshTaskData()
  RefreshAwardInfo(self)
  self._curScore:SetText(NekoData.BehaviorManager.BM_Message:GetString(1802, {
    self._bm:GetScore()
  }))
  self._curStage = 0
  local curScore = self._bm:GetScore()
  local gapRatio = 0
  local nextRecord
  for i, v in ipairs(CChildrensDayExtraAward:GetAllIds()) do
    nextRecord = CChildrensDayExtraAward:GetRecorder(v)
    if curScore >= nextRecord.neednum then
      self._curStage = self._curStage + 1
    else
      break
    end
  end
  local curRecord = CChildrensDayExtraAward:GetRecorder(self._curStage)
  local curRecordScore = 0
  if curRecord then
    curRecordScore = curRecord.neednum
  end
  local gapRatio = (curScore - curRecordScore) / (nextRecord.neednum - curRecordScore)
  local fillAmount = 0
  if self._maxScore == curScore then
    fillAmount = 1
  elseif self._curStage == 0 then
    fillAmount = gapRatio * 0.03
  else
    fillAmount = (gapRatio + self._curStage - 1) * 0.064 + 0.03
  end
  self._processLine:SetFillAmount(fillAmount)
  GoCurrentAward(self)
end

function ConversionPage:RefreshCurrencyData()
  local haveCicadaNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.Cicada)
  self._currencyNum:SetText(NumberManager.GetShowNumber(haveCicadaNum))
end

function ConversionPage:RefreshTaskData()
  for key, _ in pairs(self._ItemInfo) do
    self._ItemInfo[key] = nil
  end
  local conversionItemInfo = self._bm:GetConversionItemInfo()
  if conversionItemInfo then
    for _, value in pairs(conversionItemInfo) do
      table.insert(self._ItemInfo, value)
    end
  end
  self._itemFrame:ReloadAllCell()
end

function ConversionPage:CellAtIndex(frame, index)
  if frame == self._itemFrame then
    return "activity.children.conversionpagecell"
  end
end

function ConversionPage:NumberOfCell(frame, index)
  if frame == self._itemFrame then
    return #self._ItemInfo
  end
end

function ConversionPage:DataAtIndex(frame, index)
  if frame == self._itemFrame then
    return self._ItemInfo[index]
  end
end

function ConversionPage:OnTipsBtnClicked()
  local dialogName = "activity.children.childrentipsdialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData(CStringRes:GetRecorder(1794).msgTextID)
  end
end

function ConversionPage:OnCurrencyIconClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._currencyItem
    })
  end
end

function ConversionPage:OnAwardCellClicked(index)
  local data = self._bm:GetAwardsInfo()
  if data[index].state == SChildrenDayInfo.LOCKED or data[index].state == SChildrenDayInfo.FETCHED then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = data[index].item
      })
    end
  elseif data[index].state == SChildrenDayInfo.TO_FETCH then
    self._bm:SendReceiveReward(index)
  end
end

return ConversionPage
