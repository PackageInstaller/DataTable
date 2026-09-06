local TableFrame = require("framework.ui.frame.table.tableframe")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local AgCoinAccessDialog = class("AgCoinAccessDialog", Dialog)
local CStringRes = BeanManager.GetTableByName("message.cstringres")
AgCoinAccessDialog.AssetBundleName = "ui/layouts.baseshop"
AgCoinAccessDialog.AssetName = "CoinGet"

function AgCoinAccessDialog:Ctor(...)
  AgCoinAccessDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function AgCoinAccessDialog:OnCreate()
  self._dailyTaskRefreshTime = self:GetChild("Frame/Time1")
  self._timeLimitTaskendTime = self:GetChild("Frame/Time2")
  self._dailyTaskAccessAg = self:GetChild("Frame/Txt1/Num")
  self._dailyTaskAccessTotalAg = self:GetChild("Frame/Txt1/TotalNum")
  self._coinIcon = self:GetChild("Frame/Txt1/Image")
  self._frame = self:GetChild("Frame/Frame")
  self._helperFrame = TableFrame.Create(self._frame, self, true, true, true)
  self._scrollBar = self:GetChild("Scrollbar")
  self._closeBtn = self:GetChild("CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
end

function AgCoinAccessDialog:OnDestroy()
  self._helperFrame:Destroy()
end

function AgCoinAccessDialog:Init()
  local manager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  self._dailyTaskAccessAg:SetText(manager:GetDailyTaskAccessCoin())
  self._dailyTaskAccessTotalAg:SetText(manager:GetDailyTaskTotalAccessCoin())
  local itemcfg = CItemAttrTable:GetRecorder(DataCommon.AgCoinID)
  local iconinfo = CImagePathTable:GetRecorder(itemcfg.icon) or DataCommon.DefaultImageAsset
  self._coinIcon:SetSprite(iconinfo.assetBundle, iconinfo.assetName)
  self._limitTasks = {}
  local tasks = manager:GetLimtTimeTasks()
  for _, info in pairs(tasks) do
    local temp = {}
    temp.taskid = info.taskid
    temp.curValue = info.conditions[1].value
    temp.destValue = info.conditions[1].destValue
    table.insert(self._limitTasks, temp)
  end
  if #self._limitTasks == 0 then
    local temp = {}
    temp.taskid = 50001
    temp.curValue = 150
    temp.destValue = 500
    table.insert(self._limitTasks, temp)
    temp = {}
    temp.taskid = 50002
    temp.curValue = 200
    temp.destValue = 500
    table.insert(self._limitTasks, temp)
    temp = {}
    temp.taskid = 50003
    temp.curValue = 200
    temp.destValue = 500
    table.insert(self._limitTasks, temp)
  end
  self._helperFrame:ReloadAllCell()
  ServerGameTimer.AddTask(0, 1, function()
    self:RefreshTaskLeftTime()
  end, nil)
end

function AgCoinAccessDialog:NumberOfCell(frame)
  if frame == self._helperFrame then
    return #self._limitTasks
  end
end

function AgCoinAccessDialog:CellAtIndex(frame)
  if frame == self._helperFrame then
    return "shop.agcoinaccesstaskcell"
  end
end

function AgCoinAccessDialog:DataAtIndex(frame, index)
  if frame == self._helperFrame then
    return self._limitTasks[index]
  end
end

local function GetLeftTimeStr(lefttime)
  local strId = 1158
  local par = 0
  lefttime = lefttime // 1000
  if lefttime < 60 then
    strId = 1159
    par = lefttime
  elseif lefttime < 3600 then
    strId = 1160
    par = lefttime // 60
  elseif lefttime < 86400 then
    strId = 1159
    par = lefttime // 3600
  else
    strId = 1158
    par = lefttime // 86400
  end
  local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(strId).msgTextID
  str = TextManager.GetText(str)
  str = string.gsub(str, "%$parameter1%$", par)
  return str
end

function AgCoinAccessDialog:RefreshTaskLeftTime()
  local curTime = ServerGameTimer.GetServerTimeForecast()
  local manager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  local dailyTaskRefreshTime = manager:GetDailyTaskRefreshTime()
  local deltatime = dailyTaskRefreshTime - curTime
  self._dailyTaskRefreshTime:SetText(GetLeftTimeStr(deltatime))
  local limiteTaskEndtime = NekoData.BehaviorManager.BM_Activity:GetEndTime(DataCommon.AgCoinActivityID)
  deltatime = limiteTaskEndtime - curTime
  if deltatime <= 0 then
    local str = TextManager.GetText(CStringRes:GetRecorder(1036).msgTextID)
    self._timeLimitTaskendTime:SetText(str)
    return
  end
  self._timeLimitTaskendTime:SetText(GetLeftTimeStr(deltatime))
end

function AgCoinAccessDialog:OnCurPosChange(frame, proportion)
  local width, height = self._frame:GetRectSize()
  local total = self._helperFrame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function AgCoinAccessDialog:OnBackBtnClicked()
  self:Destroy()
end

return AgCoinAccessDialog
